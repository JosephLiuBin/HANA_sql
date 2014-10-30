#!/bin/bash
mapping=(3 4 5 6 7 8 9 10 11)
BACKUP_DIR=/usr/sap/BP0/SYS/global/hdb/backint/
BACKUP_NAME=COMPLETE_DATA_BACKUP_2014
BACKUP_PREFIX=${BACKUP_NAME}_databackup_
VERIFY_LOG=/tmp/backup_ver_$(date +%Y%m%d%H%M%S).log

function waitall()
{
  local errors=0
  local pid
  while :; do
    #debug "Processes remaining: $*"
    for pid in "$@"; do
      shift
      if kill -0 "$pid" 2>/dev/null; then
        #log $HOSTNAME "$pid is still alive."
        set -- "$@" "$pid"
#      elif wait "$pid"; then
#        log $HOSTNAME "$pid exited with zero exit status."
#      else
#        log $HOSTNAME "$pid exited with non-zero exit status."
#        ((++errors))
      fi
    done
    (("$#" > 0)) || break
    # TODO: how to interrupt this sleep when a child terminates?
    sleep ${WAITALL_DELAY:-0.5}
   done
  #((errors == 0))
  if [ $errors -eq 0 ]; then return 0; fi
  return 1
}

source /usr/sap/BP0/home/.sapenv.sh 

#loop starts here, number of backups issued

#backup via hdbsql here
echo $(date +"[%Y/%m/%d %T %S]")backup ${BACKUP_NAME} >> ${VERIFY_LOG} started 2>&1
hdbsql -n localhost -i 00 -u system -p manager "BACKUP DATA USING FILE ('${BACKUP_NAME}')"
echo $(date +"[%Y/%m/%d %T %S]")backup ${BACKUP_NAME} >> ${VERIFY_LOG} finished  2>&1

rc=0
for j in 0 1 2 3
do
BACKUP_FILE=${BACKUP_DIR}${BACKUP_PREFIX}"$j"_1
echo $(date +"[%Y/%m/%d %T %S]") backupcheck on ${BACKUP_FILE} started
hdbbackupcheck -v ${BACKUP_FILE}
echo $(date +"[%Y/%m/%d %T %S]") backupcheck on ${BACKUP_FILE} finished
if [ $? -ne 0 ]; then
    rc=1
fi
done >> ${VERIFY_LOG} 2>&1

for i in $(seq 1 8)
do
BACKUP_FILE=${BACKUP_DIR}${BACKUP_PREFIX}${mapping[$i-1]}_1 
nohup ssh hana0"$i" "source /usr/sap/BP0/home/.sapenv.sh && "'echo $(date +"[%Y/%m/%d %T %S]")'" backupcheck on ${BACKUP_FILE} started && hdbbackupcheck -v ${BACKUP_FILE} && "'echo $(date +"[%Y/%m/%d %T %S]")'" backupcheck on ${BACKUP_FILE} finished" >> ${VERIFY_LOG} 2>&1 &
CHILDPIDS="${CHILDPIDS} $!"
sleep 1
done

waitall ${CHILDPIDS}
if [ $? -ne 0 ]; then
    rc=1
fi

if [ "$rc" -ne 0 ]; then
    echo "backup verfiication failed" >> ${VERIFY_LOG} # put additional info here
fi

#cleanup here

#loop ends here
