/*M_SERVICE_MEMORY seldom use column:CODE_SIZE,SHARED_MEMORY_USED_SIZE*/
(
SELECT
	HOST,
	SERVICE_NAME, 
	ROUND(PHYSICAL_MEMORY_SIZE/1024,0) AS PM_SERVICE_KB,	/*VmRSS in /proc/%p/status*/ /*SUM=DB_RESIDENT IN HANA STUDIO*/
	ROUND(TOTAL_MEMORY_USED_SIZE/1024,0) AS TU_SERVICE_KB,
	ROUND(STACK_SIZE/1024,0) AS STACK_KB,
	ROUND(HEAP_MEMORY_ALLOCATED_SIZE,0) AS HEAP_AB_B,	/*AB in IPMM*/
	ROUND(SHARED_MEMORY_ALLOCATED_SIZE/1024,0) AS SHARED_AB_KB,
	ROUND(HEAP_MEMORY_USED_SIZE/1024,0) AS HEAP_U_KB,
	ALLOCATION_LIMIT,
	EFFECTIVE_ALLOCATION_LIMIT
FROM SYS.M_SERVICE_MEMORY
WHERE HOST = 'hana01'
)
/*m_host_resource_utilization*/
(
SELECT 
	HOST,
	ROUND((USED_PHYSICAL_MEMORY + FREE_PHYSICAL_MEMORY)/1024/1024,0) AS PM_OS_MB,
	ROUND(INSTANCE_TOTAL_MEMORY_USED_SIZE/1024/1024,0) AS TU_HANA_MB,	/*≈HEAP_U+SHARED_AB+INSTANCE_CODE*/
	ROUND(INSTANCE_TOTAL_MEMORY_ALLOCATED_SIZE/1024/1024,0) AS TAB_HANA_MB,
	INSTANCE_SHARED_MEMORY_ALLOCATED_SIZE AS INSTANCE_SHARED_AB,	/*SHARED_MEMORY in IPMM*/
	ROUND(INSTANCE_CODE_SIZE/1024/1024,0) AS INSTANCE_CODE_SIZE_MB,
	ROUND(ALLOCATION_LIMIT/1024/1024,0) AS ALLOCATION_LIMIT_MB	/*global_allocation_limit*/
FROM SYS.M_HOST_RESOURCE_UTILIZATION
WHERE HOST = 'hana01'
)

/*total_resident in hana studio*/
(
SELECT T1.HOST, ROUND((T1.USED_PHYSICAL_MEMORY + T2.SHARED_MEMORY_ALLOCATED_SIZE)/1024/1024/1024,0) as "Total Resident_GB"
FROM M_HOST_RESOURCE_UTILIZATION AS T1
JOIN (SELECT M_SERVICE_MEMORY.HOST, SUM(M_SERVICE_MEMORY.SHARED_MEMORY_ALLOCATED_SIZE) AS SHARED_MEMORY_ALLOCATED_SIZE
         FROM SYS.M_SERVICE_MEMORY 
         GROUP BY M_SERVICE_MEMORY.HOST) AS T2
ON T2.HOST = T1.HOST
WHERE T1.HOST = 'hana01'
)

/*hitorical heap memory usage*/
 SELECT
    HA.SERVER_TIMESTAMP,
    HA.CATEGORY,
    HA.HOST,
    HA.PORT,
    HA.EXCLUSIVE_ALLOCATED_COUNT NUM_ROWS,
    HA.EXCLUSIVE_ALLOCATED_SIZE,
    HA.EXCLUSIVE_SIZE_IN_USE
  FROM
    _SYS_STATISTICS.HOST_HEAP_ALLOCATORS HA
where category like '%ersion' and host = 'bp0h01' and port = '30003'
 order by SERVER_TIMESTAMP desc

/*OS command*/
cat `ps h -U bt0adm -o "/proc/%p/status" | tr -d ' '` | awk '/VmSize/ {v+=$2} /VmPeak/ {vp+=$2} /VmRSS/{r+=$2;} /VmHWM/ {rp+=$2} END {printf("Virtual Size = %.2f GB (peak = %.2f), Resident size = %.2f GB (peak = %.2f)\n", v/1024/1024, vp/1024/1024, r/1024/1024, rp/1024/1024)}';

free -m|awk 'NR==1';for i in {1..9};do ssh hana0$i 'free -m|awk "NR==2"';done;

cat /proc/54995/status |tr -d ' ' |awk '/VmRSS/ {v+=$2} END {printf("VmRSS= %.2f GB \n",v/1024/1024)}';

/*hdbcons*/
hdbcons mm ipmm;
mm list Pool/RowEngine -s
