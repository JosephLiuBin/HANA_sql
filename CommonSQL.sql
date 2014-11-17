
------INTERNAL_ROLE-------------
CREATE ROLE INTERNAL_ROLE;
GRANT CONTENT_ADMIN,MONITORING TO INTERNAL_ROLE;
GRANT EXPORT,CREATE SCHEMA,TRACE ADMIN TO INTERNAL_ROLE;
grant RESOURCE ADMIN to INTERNAL_ROLE;for hdbcons
grant EXECUTE on SYS.MANAGEMENT_CONSOLE_PROC to INTERNAL_ROLE;For kernel profiler trace
grant select on schema "_SYS_XS" to INTERNAL_ROLE;
Call "_SYS_REPO"."GRANT_ACTIVATED_ROLE"('sap.hana.admin.roles::Monitoring','INTERNAL_ROLE');Memory Overview editor
Call "_SYS_REPO"."GRANT_ACTIVATED_ROLE"('sap.sop.sopfnd.catalogue::SAPSOP_DEBUG','INTERNAL_ROLE');Check SYS view
Call "_SYS_REPO"."GRANT_ACTIVATED_ROLE"('sap.hana.xs.lm.roles::Display','INTERNAL_ROLE');LM Display
Call "_SYS_REPO"."GRANT_ACTIVATED_ROLE"('sap.hba.explorer.roles::Developer','I074463');HANA Live
grant select on schema SYSTEM TO INTERNAL_ROLE WITH GRANT OPTION
grant update on schema _SYS_STATISTICS to INTERNAL_ROLE;
;additional privilege;
grant import to I302273;
grant select on schema SAPB16 to I059567;
grant select on schema <> to _SYS_REPO with grant option;
grant OPTIMIZER ADMIN TO I077521;alter system
------INTERNAL_USER-------------
drop procedure CREATE_INTERNAL_USER;
create procedure CREATE_INTERNAL_USER(IN userid nvarchar(20))
LANGUAGE SQLSCRIPT SQL security invoker 
AS
UserName String;
userExists Integer := 0;
BEGIN
	DECLARE USER_EXIST CONDITION FOR SQL_ERROR_CODE 10001;
	DECLARE EXIT HANDLER FOR USER_EXIST SELECT ::SQL_ERROR_CODE as ERROR_CODE, ::SQL_ERROR_MESSAGE as ERROR_MESSAGE FROM DUMMY;
	UserName := upper(userid);
	SELECT top 1 count(1) into userExists FROM SYS.USERS WHERE USER_NAME = :UserName;
	if :userExists = 0 then 
		EXEC 'CREATE USER ' || :UserName || ' PASSWORD Initial1234';
		EXEC 'GRANT INTERNAL_ROLE TO ' || :UserName;
		EXEC 'ALTER USER ' ||:UserName || ' DISABLE PASSWORD LIFETIME';
	else
		SIGNAL USER_EXIST SET MESSAGE_TEXT = 'User Exists';
	end if;
END; 

drop user TESTCO cascade;
call CREATE_INTERNAL_USER('I015409');

grant  INIFILE ADMIN to TESTCO;
select * from users where user_name = 'I070069';
alter user I310839 password Initial1234;
alter user I310839 force password change

grant  INIFILE ADMIN to I310503;
drop user I302781 cascade;
alter user i076215 force password change;

create user I077125 password Initial1;drop user I072000 CASCADE;
grant INTERNAL_ROLE to I077125;grant BACKUP ADMIN TO I076358
grant XS_TRAIN_DEMO to I077125;
alter user I074463  activate;
alter user I077687  password Initial0;
ALTER USER i074463 RESET CONNECT ATTEMPTS;
alter user I077125  disable password lifetime;
alter user i074463 force password change;

select * from users where user_name = 'I302781';
--Call "_SYS_REPO"."GRANT_ACTIVATED_ROLE"('sap.hana.xs.debugger::Debugger','I042893');
grant execute on _SYS_REPO.GRANT_ACTIVATED_ROLE to I077532;
alter user I077532 password Initial2;
grant select,execute,create any on schema SAPB15 to DBACOCKPIT with grant option;
CALL _SYS_REPO.GRANT_SCHEMA_PRIVILEGE_ON_ACTIVATED_CONTENT ('select', 'SAP_HANA_DEMO', 'I077687'); 
grant execute on SYS.TREXviaDBSLWithParameter to I040460;			--procedure
grant select on _SYS_REPO.ACTIVE_CONTENT_TEXT_CONTENT to I077125 with grant option;	--table
------EXTERNAL_ROLE-------------
CREATE ROLE EXTERNAL_ROLE;
GRANT MODELING TO EXTERNAL_ROLE;
grant select on schema SFLIGHT to EXTERNAL_ROLE;
grant select on schema DW to EXTERNAL_ROLE;
------EXTERNAL_USER-------------
create user i302781 password Initial1;
GRANT EXTERNAL_ROLE to I048298;
alter user ZHIQING force password change;
------SLT:Initial User-------------------
grant execute,insert,update,delete on schema SYS_REPL TO SLT_USER;
grant select on schema SYS_REPL TO SLT_USER with grant option;
grant CREATE SCHEMA,ROLE ADMIN,USER ADMIN TO SLT_USER;
alter user SLT_USER password Sltconnect0
------SLT:Replication User---
create user I043331 password Initial1;
GRANT select on "SYS_REPL"."RS_REPLICATION_COMPONENTS" to SLT_USER;
alter user I043331 force password change;
------SLT:Initial Load Table Definition---
select * from "TES_TES_HD5"."RS_ORDER";
select * from "SYS_REPL"."RS_REPLICATION_COMPONENTS"
INSERT INTO "TES_TES_HD5"."RS_ORDER" VALUES('TES','bjg03test014_TES_00','AUAB',0,'T','','','')
------X509---------
CREATE USER I077532 WITH IDENTITY 'CN=I077532, O=SAP-AG, C=DE' ISSUER 'CN=SSO_CA, O=SAP-AG, C=DE' FOR X509; 
grant sap.hana.xs.admin.roles::RuntimeConfAdministrator  to I077532
------SCHEMA_OWNER--------
select * from "SYS"."SCHEMAS" where schema_name = 'MDSCHEMA';
------TransportUser---------------------
create user I077687 password Initial1;
GRANT INTERNAL_ROLE to I077687;
alter user I077687 force password change;
Call "_SYS_REPO"."GRANT_ACTIVATED_ROLE"('sap.hana.admin.roles::Monitoring','I077687');
Call "_SYS_REPO"."GRANT_ACTIVATED_ROLE"('sap.hana.xs.admin.roles::HTTPDestAdministrator','I077687');
Call "_SYS_REPO"."GRANT_ACTIVATED_ROLE"('sap.hana.xs.admin.roles::RuntimeConfAdministrator','I077687');
--------------------------------------
Call "_SYS_REPO"."GRANT_ACTIVATED_ROLE"('Angel_os.00.data::wsAdmin','I302446');?? Can only grant activated roles,because two::
Call "_SYS_REPO"."GRANT_ACTIVATED_ROLE"('I302446_Angel.00.data::workshopAdmin','I302446');
-------XS_Troubleshoot----------------------
SELECT * FROM M_XS_APPLICATIONS 
select * from "SYS"."SCHEMAS" where schema_name = 'SLT_HD5'
------Package------------------
SELECT * FROM _SYS_REPO.INACTIVE_OBJECT WHERE PACKAGE_ID like 'XSProject%';
Delete FROM _SYS_REPO.INACTIVE_OBJECT WHERE PACKAGE_ID like 'XSProject%';
SELECT * FROM _SYS_REPO.ACTIVE_OBJECT WHERE PACKAGE_ID like 'XSProject%';
Delete FROM _SYS_REPO.ACTIVE_OBJECT WHERE PACKAGE_ID like 'XSProject%';
------Modeling-----------------
grant select on schema <> to _SYS_REPO with grant option;before activation
SELECT * FROM "_SYS_BIC"."GOME_TRAN.ABAP4HANA/AT_TEST"
------Disk Usage--------------------
select * from "SYS"."M_DISKS"
-----Transaction--------------
/*Long-lived cursors – result from below query*/
SELECT P.HOST, P.PORT, C.LOGICAL_CONNECTION_ID, C.CLIENT_HOST, C.CLIENT_PID,
P.STATEMENT_STATUS, P.STATEMENT_STRING, SECONDS_BETWEEN(P.LAST_EXECUTED_TIME, CURRENT_TIMESTAMP) IDLE_TIME, P.START_MVCC_TIMESTAMP 
   FROM M_PREPARED_STATEMENTS P, M_CONNECTIONS C 
WHERE P.HOST = C.HOST AND P.PORT = C.PORT AND P.CONNECTION_ID = C.CONNECTION_ID AND C.CONNECTION_ID > 0 
   AND SECONDS_BETWEEN(P.LAST_EXECUTED_TIME, CURRENT_TIMESTAMP) > 0 
   AND P.STATEMENT_STATUS <> 'NONE'    

/*Long-living serializable tranactions  – result from below query*/
SELECT T.HOST, T.PORT, C.LOGICAL_CONNECTION_ID, C.CLIENT_HOST, C.CLIENT_PID, T.TRANSACTION_ID, T.UPDATE_TRANSACTION_ID, SECONDS_BETWEEN(T.START_TIME, CURRENT_TIMESTAMP) TOTAL_TIME, T.MIN_MVCC_SNAPSHOT_TIMESTAMP 
   FROM M_TRANSACTIONS T, M_CONNECTIONS C
WHERE T.TRANSACTION_STATUS = 'ACTIVE' AND T.TRANSACTION_TYPE = 'USER TRANSACTION' AND T.CONNECTION_ID = C.CONNECTION_ID
   AND T.ISOLATION_LEVEL <> 'READ COMMITTED' AND SECONDS_BETWEEN(T.START_TIME, CURRENT_TIMESTAMP) > 0

/*Long-living uncommitted write transactions  – result from below query*/
SELECT T.HOST, T.PORT, C.LOGICAL_CONNECTION_ID, C.CLIENT_HOST, C.CLIENT_PID, T.TRANSACTION_ID, T.UPDATE_TRANSACTION_ID, SECONDS_BETWEEN(T.START_TIME, CURRENT_TIMESTAMP) TOTAL_TIME, T.MIN_MVCC_SNAPSHOT_TIMESTAMP
   FROM M_TRANSACTIONS T, M_CONNECTIONS C
WHERE T.CONNECTION_ID=C.CONNECTION_ID AND T.TRANSACTION_STATUS='ACTIVE' AND T.TRANSACTION_TYPE='USER TRANSACTION' AND T.UPDATE_TRANSACTION_ID > 0
   AND SECONDS_BETWEEN(T.START_TIME, CURRENT_TIMESTAMP) > 0
------cancle session/thread----
SELECT CONNECTION_ID FROM "SYS"."M_CONNECTIONS" WHERE CREATOR_THREAD_ID=34289;
ALTER SYSTEM CANCEL SESSION '204531';
ALTER SYSTEM DISCONNECT SESSION '204531';
ALTER SYSTEM CANCEL WORK IN SESSION '427800';
select * from "_SYS_STATISTICS"."HOST_LONG_RUNNING_STATEMENTS";
select * from M_connections where client_pid in ('962','16349');
select * from M_CONNECTIONS where host = 'hnbwnode12' and creator_thread_ID = '828' order by connection_ID;
select * from M_TRANSACTIONS where connection_id = '2141292'
select * from "_SYS_STATISTICS"."HOST_LONG_RUNNING_STATEMENTS";
select * from QUERY_PLANS;
select * from m_service_threads where thread_type like '%Backup%'
----Garbage Collection-------
select * from M_MVCC_TABLES;
select * from M_RS_TABLE_VERSION_STATISTICS;
select * from M_TABLE_SNAPSHOTS;
------memory usage check-----
SELECT HOST,ROUND(SUM(MEMORY_SIZE_IN_TOTAL)/1024/1024) AS "Column Tables MB Used" FROM M_CS_TABLES group by HOST order by host;
SELECT HOST,ROUND(SUM(USED_FIXED_PART_SIZE + USED_VARIABLE_PART_SIZE)/1024/1024) AS "Row Tables MB Used" FROM M_RS_TABLES group by HOST order by host;
select host,table_name,round(sum(index_size)/1024/1024/1024,2) as "Row Tables Indexes" from sys.m_rs_indexes where host = 'hana01' group by host,table_name;
SELECT host, round(ALLOCATION_LIMIT/1024/1024) AS "Allocation Limit MB" FROM PUBLIC.M_HOST_RESOURCE_UTILIZATION;
select round((sum(HEAP_MEMORY_ALLOCATED_SIZE) + sum(SHARED_MEMORY_ALLOCATED_SIZE))/1024/1024/1024,2)as "Allocated Memory" from m_service_memory where host = 'hana01' group by host;
-----ROW_TABLE-------------------------
;41 Row Store Size for single table 
select indexserver_actual_role as "SERVER_ROLE", host as "HOST", port as "PORT", service_name as "SERVICE_NAME", 
round(rs_data_size/1024/1024/1024,1) as "RS_DATA_GB", 
round(rs_index_size/1024/1024/1024,1) as "RS_INDEX_GB", 
round((rs_data_size+rs_index_size)/1024/1024/1024,1) as "RS_TABLES_TOTAL_SIZE_GB",
table_name
from
(select indexserver_actual_role, a.host, port,a.table_name, sum(allocated_fixed_part_size+allocated_variable_part_size) as rs_data_size from sys.m_rs_tables a 
left join M_landscape_host_configuration b on a.host = b.host where table_name = 'RSPCLOGS' group by indexserver_actual_role, a.host, port, a.table_name
)
left outer join
(select host as h0, port as p0, sum(index_size) as rs_index_size from sys.m_rs_indexes group by host, port) on (host = h0 and port = p0)
left outer join 
(select  host as h1, port as p1, service_name from M_Services) on (host = h1 and port = p1)
order by host, port;
;ROW TABLE INDEX SIZE
SELECT TABLE_NAME,ROUND(IFNULL(SUM(INDEX_SIZE), 0) / 1024 / 1024 / 1024,2) AS INDEX_MEM_GB FROM M_RS_INDEXES
WHERE HOST = 'bp0h01' and port = '30003' and schema_name = 'SAPSR3' GROUP BY TABLE_NAME ORDER BY INDEX_MEM_GB DESC limit 10;

------COLUMN_TABLES--------------
select * FROM "_SYS_STATISTICS"."HOST_COLUMN_TABLES_PART_SIZE" where host = 'hnbwnode5' and TABLE_NAME = '/BIC/000APG0';
select * from M_DELTA_MERGE_STATISTICS where host = 'hnbwnode5' AND TABLE_NAME = '/BIC/000APG0';
SELECT * FROM M_CS_TABLES WHERE TABLE_NAME = '/BIC/000APG0';
select top 1 * FROM "_SYS_STATISTICS"."HOST_COLUMN_TABLES_PART_SIZE" where host = 'hnbwnode5' and TABLE_NAME = '/BIC/000APG0' order by SERVER_TIMESTAMP DESC;
SELECT TOP 10 * from M_CS_TABLES ORDER BY MEMORY_SIZE_IN_DELTA DESC;
select * from "SYS"."TABLES" where table_name = '/BIC/000APG0';
select * from "SYS"."M_CS_UNLOADS" where table_name = '/BIC/000APG0';
select client_PID from "_SYS_STATISTICS"."HOST_UNCOMMITTED_WRITE_TRANSACTION" where TRANSACTION_ID = '233' and CLIENT_PID = '15267'order by SNAPSHOT_ID DESC;
select * from M_TRANSACTIONS where TRANSACTION_ID = '233' and host = 'hnbwnode5'
select * from M_CONNECTIONS where host = 'hnbwnode5' and connection_ID = '1132509'
-------DELTA_MERGE-----------------------
select * from M_DELTA_MERGE_STATISTICS where host = 'hnbwnode5';merge_history
MERGE DELTA OF A WITH PARAMETERS('SMART_MERGE' = 'ON');
MERGE DELTA OF A PART 1;
MERGE DELTA OF TEST2 WITH PARAMETERS ('FORCED_MERGE' = 'ON');
UPDATE TEST2 WITH PARAMETERS ('OPTIMIZE_COMPRESSION'='YES')

-----HEAP_MEMORY_USAGE----------------
SELECT host,port,category,round(exclusive_size_in_use/1024/1024/1024,1) as size_in_use FROM M_HEAP_MEMORY WHERE HOST = 'hana01' order by size_in_use desc;
--Historical Data for HEAP MEMORY--
SELECT
	to_char(HA.SERVER_TIMESTAMP,'dd.mm.yyyy:hh24:mi:ss') as MyDate,
    HA.CATEGORY,
    HA.HOST,
    HA.PORT,
    ROUND(HA.EXCLUSIVE_SIZE_IN_USE/1024/1024/1024,2) AS EXCLUSIVE_SIZE_IN_USE_GB 
FROM
    _SYS_STATISTICS.HOST_HEAP_ALLOCATORS HA
where category like '%Cpb%' and host = 'bp0h01' and port = '30003'	
order by SERVER_TIMESTAMP desc
--desc;
--M_RS_MEMORY--
select * from sys.m_rs_memory where category = 'CPBTREE' and host = 'bp0h01' and port = '30003'
--RSHDBSTT--Daily Monitor--
SELECT 
	indexserver_actual_role as "SERVER_ROLE", host as "HOST", port as "PORT", service_name as "SERVICE_NAME", 
	round((memory_used/1024/1024/1024),1) as "USED_MEMORY_TOTAL_GB",
	round((memory_used_cs_tables/1024/1024/1024),1) as "USED_MEMORY_CS_TABLES_GB",
	round((memory_allocated_rs_tables/1024/1024/1024),1) as "USED_MEMORY_RS_TABLES_GB",
	round((memory_used_rs_tables/1024/1024/1024),1) as "MEMORY_SIZE_RS_TABLES_NET_GB",
	round((memory_allocated_rs_indexes/1024/1024/1024),1) as "USED_MEMORY_RS_INDEX_GB",
	round(((memory_used-memory_used_cs_tables-memory_allocated_rs_tables)/1024/1024/1024),1) as "ALLOCATED_DYNAMIC_MEMORY_GB"
FROM 
	(select indexserver_actual_role, a.host, port, service_name from sys.m_services a left join M_landscape_host_configuration b on a.host = b.host 
	group by indexserver_actual_role, a.host, port, service_name)
LEFT OUTER JOIN
	(select host as h1, port as p1, sum(memory_size_in_total) as memory_used_cs_tables  from sys.m_cs_tables group by host, port) on (host = h1 and port = p1)
LEFT OUTER JOIN
	(select host as h2, port as p2, sum(allocated_size) as memory_allocated_rs_tables from sys.m_rs_memory group by host, port) on (host = h2 and port = p2) 
LEFT OUTER JOIN
	(select host as h3, port as p3, sum(allocated_size) as memory_used_rs_tables from sys.m_rs_memory where category in ('TABLE','CATALOG')  group by host, port) on (host = h3 and port = p3)
LEFT OUTER JOIN 
	(select host as h4, port as p4, sum(allocated_size) as memory_allocated_rs_indexes from sys.m_rs_memory where category in ('CPBTREE','BTREE') group by host, port) on (host = h4 and port = p4) 	/*faster than sum value in m_rs_indexs*/
LEFT OUTER JOIN 
	(select host as h7,instance_total_memory_used_size as memory_used from sys.m_host_resource_utilization ) on (host = h7) 
WHERE
	service_name = 'indexserver' and host = 'bp0h01'
ORDER BY host, port DESC;




---Export & Import---------------------
EXPORT "SYSTEM"."TDEVC" AS BINARY INTO '/tmp/frank_wang/' WITH REPLACE SCRAMBLE THREADS 10;
select * from  #EXPORT_RESULT;
SELECT * FROM "PUBLIC"."M_EXPORT_BINARY_STATUS";running
select * from #EXPORT_RESULT;session-local
IMPORT "SYSTEM"."*"  from '/tmp/frank_wang/' with RENAME SCHEMA "SYSTEM" TO "I303173" FAIL ON INVALID DATA at location '<host>:3xx03'; change schema
select * from  #IMPORT_RESULT;
SELECT * FROM "PUBLIC"."M_IMPORT_BINARY_STATUS";running
select * from #IMPORT_RESULT;
IMPORT SCAN '/tmp/test_trace/export';
select * from #IMPORT_SCAN_RESULT;
-----
1.ctl文件准备，每一个csv文件要对应一个ctl文件
import data into table "I073019"."CUSTOMER"
from 'STS_CUSTOMER.csv'
record delimited by '\n'
field delimited by ','
optionally enclosed by '"'
error log 'STS_CUSTOMER.err'

2. 将csv文件和ctl文件同时上传到linux某一工作目录下

3. 准备一个脚本，最先是创建table,然后import from ctl 文件最后是做delta merge, 这个脚本可以写多个table, import 多个 
CREATE COLUMN TABLE "I073019". "CUSTOMER" ("ORDERID" INTEGER CS_INT NOT NULL ,
"CUSTOMERID" INTEGER CS_INT,
"EMPLOYEEID" INTEGER CS_INT,
"ORDERDATE" LONGDATE CS_LONGDATE,
"REQUIREDDATE" LONGDATE CS_LONGDATE,
"SHIPPEDDATE" LONGDATE CS_LONGDATE,
"PROMOTION_ID" INTEGER CS_INT,
"PERIODID" INTEGER CS_INT,
"DELIVEREDDATE" LONGDATE CS_LONGDATE,
PRIMARY KEY ("ORDERID" ));
IMPORT FROM '/usr/sap/tmp/STS_CUSTOMER.ctl' ;
UPDATE I073019.CUSTOMER MERGE DELTA INDEX;

-----Statistics Services------------1991615 - Configuration options for the Embedded Statistics Service-------
SELECT * FROM _SYS_STATISTICS.STATISTICS_PROPERTIES where key = 'internal.installation.state';check the state of migration
select * from _SYS_STATISTICS.STATISTICS_SCHEDULE;
update _SYS_STATISTICS.STATISTICS_SCHEDULE set status = 'Idle'
where id = 57; Activate specific check_scheduler
update _SYS_STATISTICS.STATISTICS_SCHEDULE set INTERVALLENGTH=2000 where ID=17﻿;Change the frequency of check 17 to 2,000 seconds:
update _SYS_STATISTICS.STATISTICS_SCHEDULE set STATUS='Inactive' where ID=5034﻿;Deactivate collector 5034:
﻿select DEFAULT_VALUE, CURRENT_VALUE, UNIT from _SYS_STATISTICS.STATISTICS_ALERT_THRESHOLDS where ALERT_ID=17 and SEVERITY=1﻿;Display the current "info" threshold value for check 17:


------INI configuration-------------
ALTER SYSTEM ALTER CONFIGURATION ('daemon.ini', 'host', '<host name>') SET ('xsengine','instances') = '1' WITH RECONFIGURE
ALTER SYSTEM ALTER CONFIGURATION ('daemon.ini', 'host', 'suse2') UNSET ('preprocessor','instances')
alter system alter configuration ('indexserver.ini','SYSTEM') SET ('table_redist','all_moves_physical') = 'true' WITH RECONFIGURE;
-----------------------------------
select * from "_SYS_STATISTICS"."STATISTICS_ALERT_LAST_CHECK_INFORMATION"
select TOP 10 * from m_HEAP_MEMORY ORDER BY INCLUSIVE_SIZE_IN_USE desc;
call GRANT_ACTIVATED_ANALYTICAL_PRIVILEGE ('_SYS_BI_CP_ALL', 'I069650');
grant execute on schema _SYS_BIC to I069650;

grant create any,alter,select,update,insert,delete,drop,execute,index,debug on schema SYS_REPL TO I072065 with grant option;


DELETE FROM "_SYS_XS"."RUNTIME_CONFIGURATION" WHERE PACKAGE_ID = 'Molly';
UPDATE "_SYS_XS"."RUNTIME_CONFIGURATION" SET CONFIGURATION = '{"authentication": [{"method": "Form"},{"method": "Basic"}]}';
SELECT CONFIGURATION FROM "_SYS_XS"."RUNTIME_CONFIGURATION";
SELECT * FROM "_SYS_XS"."RUNTIME_CONFIGURATION";
----Privilege---
select * from "PUBLIC"."PRIVILEGES" order by TYPE;
select * from "PUBLIC"."STRUCTURED_PRIVILEGES";
select * from "PUBLIC"."ROLES";

SELECT GRANTEE,GRANTOR,OBJECT_TYPE,OBJECT_NAME,PRIVILEGE,IS_GRANTABLE FROM "PUBLIC"."GRANTED_PRIVILEGES" WHERE PRIVILEGE LIKE 'INI%';
select * from schemas where schema_name like 'DM%';
SELECT * FROM GRANTED_ROLES WHERE ROLE_NAME = 'sap.hana.xs.lm.roles::Administrator';
CALL _SYS_REPO.REVOKE_ACTIVATED_ROLE ('sap.hana.xs.lm.roles::Administrator','I058712');;
REVOKE INIFILE ADMIN FROM I071762;
select * from GRANTED_ROLES WHERE ROLE_NAME LIKE '%SUPPORT'

SELECT * FROM EFFECTIVE_PRIVILEGES WHERE USER_NAME = '<user>' AND OBJECT_TYPE = 'ANALYTICALPRIVILEGE';

-----Audit Log---
grant AUDIT ADMIN to I310503;
grant AUDIT OPERATOR to I310503
select * from audit_log 
--where section like '%sqltrace%' 
--and statement_string like '%server%'
where file_name = 'global.ini'
and key = 'load_monitor_granularity'
order by timestamp desc;
--Authorization Check---
SELECT * FROM "SYS"."USERS" WHERE 
user_id = 132020
user_name = 'I071979';

select * from "PUBLIC"."OWNERSHIP" 
where object_oid = 136556
order by object_oid ;

select * from SYS.P_PRIVILEGES_ WHERE 
OID = 24;

SELECT
       a.*, user_name
FROM OWNERSHIP a, users
WHERE a.OBJECT_OID IN (132426)
And user_id = 145523

----Index----
select * from sys.M_table_virtual_files where table_name='SFLIGHT' AND SCHEMA_NAME='SFLIGHT';

SELECT * FROM SYS.CS_TABLES_ where table_name='SFLIGHT' AND SCHEMA_NAME='SFLIGHT';

SELECT * FROM SYS.CS_COLUMNS_ where table_OID = 190253;

select LAST_LOAD_TIME from M_CS_ALL_COLUMNS where table_name='SFLIGHT' AND SCHEMA_NAME='SFLIGHT';

select * from tables;
-------------------------
alter user I059562 DEACTIVATE USER NOW;
alter user I059562 ACTIVATE USER NOW;

Call "_SYS_REPO"."GRANT_ACTIVATED_ROLE"('sap.hana.democontent.epm.data::model_admin' ,'I302460');
GRANT INTERNAL_ROLE to i073019;
 
create user I302460 password Initial1;
alter user I302460 force password change;
grant REPO.IMPORT to I302460;
grant execute on SYS.REPOSITORY_REST to I302460;
grant repo.read on ".REPO_PACKAGE_ROOT" to I302460;

grant select on SCHEMA "_SYS_RT" to SAPBWP;
select name, hassystemprivilege(current_user, name) from sys.privileges 
where type = 'SYSTEMPRIVILEGE' 
and name in ('DATA ADMIN','CATALOG READ','BACKUP ADMIN','INIFILE ADMIN','TRACE ADMIN','SERVICE ADMIN','TENANT ADMIN','MONITOR ADMIN','USER ADMIN','ROLE ADMIN','SESSION ADMIN','AUDIT ADMIN','AUDIT OPERATOR','RESOURCE ADMIN')
-------Statistic OOM------------------
truncate table "_SYS_STATISTICS"."HOST_COLUMN_TABLES_PART_SIZE";
truncate table "_SYS_STATISTICS"."HOST_VIRTUAL_FILES";
truncate table "_SYS_STATISTICS"."HOST_TABLE_VIRTUAL_FILES";
truncate table "_SYS_STATISTICS"."HOST_DATA_VOLUME_PAGE_STATISTICS";
truncate table "_SYS_STATISTICS"."HOST_DATA_VOLUME_SUPERBLOCK_STATISTICS";
truncate table "_SYS_STATISTICS"."HOST_VOLUME_FILES";
truncate table "_SYS_STATISTICS"."HOST_VOLUME_IO_PERFORMANCE_STATISTICS";
truncate table "_SYS_STATISTICS"."HOST_VOLUME_IO_STATISTICS";
truncate table "_SYS_STATISTICS"."GLOBAL_PERSISTENCE_STATISTICS";
truncate table "_SYS_STATISTICS"."HOST_DELTA_MERGE_STATISTICS";
truncate table "_SYS_STATISTICS"."GLOBAL_TABLES_SIZE";
truncate table "_SYS_STATISTICS"."GLOBAL_COLUMN_TABLES_SIZE";
------Note193979 Alert: Sync/Async read ratio---------------------
select HOST, PORT, TYPE, PATH, CONFIGURATION, TRIGGER_WRITE_RATIO, TRIGGER_READ_RATIO from SYS.M_VOLUME_IO_TOTAL_STATISTICS


SELECT * FROM M_SAVEPOINTS ORDER BY START_TIME DESC
WHERE VOLUME_ID in
    (select VOLUME_ID from PUBLIC.M_VOLUMES
     where SERVICE_NAME = 
--     'indexserver'
--     'nameserver'
--     'xsengine'
     'statisticsserver')
ORDER BY START_TIME DESC

--COMMIT LATENCY
select HOST, PORT, TYPE,
   round(MAX_IO_BUFFER_SIZE / 1024, 3) "Maximum buffer size in KB",
   TRIGGER_ASYNC_WRITE_COUNT,
   AVG_TRIGGER_ASYNC_WRITE_TIME as "Avg Write Time in Microsecond"
from "PUBLIC"."M_VOLUME_IO_DETAILED_STATISTICS"
where type = 'LOG'
  and VOLUME_ID in
    (select VOLUME_ID from SYS.M_VOLUMES
     where SERVICE_NAME = 'indexserver')
        and  AVG_TRIGGER_ASYNC_WRITE_TIME > 0
-------LOG---------------------------        
;
select host,service_name,state,count(STATE) 
from 
(SELECT S.HOST,V.SERVICE_NAME,S.PARTITION_ID,S.SEGMENT_ID,S.FILE_NAME,S.STATE
	FROM "SYS"."M_LOG_SEGMENTS"  S left outer join SYS.M_VOLUMES V 
		ON S.VOLUME_ID = V.VOLUME_ID
	where 
	--S.HOST = 'hana01'
	--and 
	service_name = 'indexserver'
	ORDER BY S.HOST,V.SERVICE_NAME,S.SEGMENT_ID
)	
group by state,host,service_name;

select * from M_LOG_PARTITIONS
select * from M_LOG_SEGMENTS
SELECT * FROM "PUBLIC"."M_LOG_BUFFERS";

select FILE_NAME,IN_BACKUP,MIN_POSITION,state from M_LOG_SEGMENTS where state != 'Free'  and FILE_NAME LIKE '/hana/log/BP0/mnt00001/hdb00004%' ORDER BY MIN_POSITION

----Backup and recovery------------
;;log_mode
select * from m_log_buffers;
select * from m_inifile_contents where key = 'log_mode';
;;
select * from m_backup_configuration;

;;privilege
grant BACKUP ADMIN TO I308913;
GRANT CATALOG READ TO I308913;

;;INI files
select * 
  from m_inifiles 
 order by 1;

select * 
  from m_inifiles 
 where system_layer = 'TRUE' ;

select * 
  from m_inifiles 
 where host_layer = 'TRUE' ;

select * 
  from m_inifile_contents 
 where layer_name != 'DEFAULT'
   and layer_name in ('SYSTEM','HOST')
 order by 2;
;;backup cancel
SELECT BACKUP_ID FROM "M_BACKUP_CATALOG" WHERE ENTRY_TYPE_NAME = 'complete data backup' AND STATE_NAME = 'running' ORDER BY SYS_START_TIME DESC;
backup cancel  1413342015929;
;;backup catalog
SELECT * FROM "PUBLIC"."M_BACKUP_CATALOG"  where entry_type_name = 'complete data backup' order by BACKUP_ID desc

SELECT top 1 t1.BACKUP_ID
	FROM SYS.M_BACKUP_CATALOG t1
WHERE --t1.state_name = 'successful' AND
	t1.entry_type_name = 'complete data backup'
ORDER BY t1.UTC_START_TIME DESC;

SELECT * FROM "PUBLIC"."M_BACKUP_CATALOG_FILES" where backup_id = 1413688792636 order by BACKUP_ID
SELECT * FROM M_SAVEPOINTS 
WHERE PORT=30203
ORDER BY START_TIME DESC;
select * from M_BACKUP_CONFIGURATION;

;;delete backup catalog
BACKUP CATALOG DELETE BACKUP_ID 1411934423738 COMPLETE;
BACKUP CATALOG DELETE ALL BEFORE BACKUP_ID 1409976001168 COMPLETE;
;;backup sql
BACKUP DATA USING FILE ('COMPLETE');

;;backup_size
select round(sum(SIZE_in_Byte)/1024/1024/1024,2) as ESTIMATED_SIZE_GB from(
select 
	a.service_name,
	a.volume_id,
	sum(b.allocated_page_size) AS SIZE_in_Byte
from M_VOLUMES A
LEFT OUTER JOIN M_CONVERTER_STATISTICS B ON A.volume_id = B.volume_id
group by a.volume_id,
		 a.service_name);

BACKUP CHECK USING FILE ('/usr/sap/HEW/HDB02/backup/data') SIZE 2738706944;
BACKUP CHECK USING FILE ('/usr/sap/HEW/HDB02/backup/data') SIZE 273870694400;

select * from m_converter_statistics; 
SELECT * FROM "PUBLIC"."M_SNAPSHOTS";

;;backup file check
select state_name,round(sum(backup_size)/1024/1024/1024,2)
select host,state_name,count(*)
from ( 	
	select c.backup_id,c.sys_start_time,c.sys_end_time,f.host,c.state_name,f.source_type_name as TYPE,f.backup_size,f.service_type_name as SERVICE,f.external_backup_id as EBID,f.destination_path as PATH
	from M_BACKUP_CATALOG C join M_BACKUP_CATALOG_FILES F
	on c.backup_id = f.backup_id 
	where 
	c.entry_type_name = 'log backup' and --'complete data backup'  and
	SYS_START_TIME > '2014-10-20 20:16' and 
	--SYS_START_TIME < '2014-09-06 14:16'
--and F.host = 'hana01'
--	c.backup_id = 1413688792636 and 
	destination_path like '/backup/log%' and 
	--destination_type_name = 'backint'
	destination_type_name = 'file'
	--c.state_name = 'successful'
	order by SYS_START_TIME desc
	)
group by host,state_name


-----CONNECTIONS-----------------------
select C.HOST, C.CONNECTION_ID,C.CLIENT_PID,PS.STATEMENT_STRING
,C.CURRENT_OPERATOR_NAME
	FROM M_CONNECTIONS C JOIN M_PREPARED_STATEMENTS PS
	 ON C.CONNECTION_ID = PS.CONNECTION_ID AND C.CURRENT_STATEMENT_ID = PS.STATEMENT_ID
	 
	 WHERE C.CONNECTION_STATUS = 'RUNNING' 
	 and C.USER_NAME = 'SAPSR3' 
	 and C.CONNECTION_ID = 422861;
	 
	 
----_SYS_REPO--------------------------
grant select on schema MINGTU_XS to _SYS_REPO with grant option;
grant select on schema MINGTU_XS to I073019 with grant option;
CALL _SYS_REPO.GRANT_SCHEMA_PRIVILEGE_ON_ACTIVATED_CONTENT ('create any', 'MINGTU_XS', 'I073019'); 
CALL _SYS_REPO.GRANT_SCHEMA_PRIVILEGE_ON_ACTIVATED_CONTENT ('select', 'SYS', 'I071762');
CALL _SYS_REPO.GRANT_SCHEMA_PRIVILEGE_ON_ACTIVATED_CONTENT ('update', 'MINGTU_XS', 'I073019');
CALL _SYS_REPO.GRANT_SCHEMA_PRIVILEGE_ON_ACTIVATED_CONTENT ('drop', 'MINGTU_XS', 'I073019');

CALL _SYS_REPO.REVOKE_SCHEMA_PRIVILEGE_ON_ACTIVATED_CONTENT ('select', '"MingTu_XS"', 'I073019'); 
call _SYS_REPO.GRANT_PRIVILEGE_ON_ACTIVATED_CONTENT('select','_SYS_RT."CDS_ARTIFACT"','I077532');
grant select on _SYS_REPO.ACTIVE_CONTENT_TEXT_CONTENT to I059463 with grant option;

select * from "_SYS_REPO"."SCHEMAVERSION" where SCHEMA_TYPE = 'rt';
select * from  _SYS_RT.SEARCH_RULE_SETS;
select * from m_xs_applications;

--select * from SYS.M_FEATURES where COMPONENT_NAME = 'CDS' and FEATURE_NAME = 'COMPILER BUILD ID'

-----------------------------------------------------------------------------
grant EXECUTE on _SYS_REPO.GRANT_PRIVILEGE_ON_ACTIVATED_CONTENT to I073019;
grant EXECUTE on _SYS_REPO.REVOKE_PRIVILEGE_ON_ACTIVATED_CONTENT to I073019;
grant EXECUTE on _SYS_REPO.GRANT_SCHEMA_PRIVILEGE_ON_ACTIVATED_CONTENT to I073019;
grant EXECUTE on _SYS_REPO.REVOKE_SCHEMA_PRIVILEGE_ON_ACTIVATED_CONTENT to I073019;
select * from SCHEMAS where SCHEMA_NAME = 'MingTu_XS';

grant EXECUTE on _SYS_BIC.sapphire.demo.proc::createRandomSales to I302439;
grant EXECUTE on SYS.DEBUG to I302446;

grant EXECUTE on SYS.MANAGEMENT_CONSOLE_PROC to I060402;
---------Missing delta log----------------------------------------------
select cst.schema_name, cst.table_name, cst.part_id, tvf.schema_name,
tvf.table_name,tvf.name from sys.m_cs_tables_ cst
left outer join sys.m_table_virtual_files_ tvf on (cst.table_oid
,cst.part_id) = (tvf.table_oid,tvf.part_id) and tvf.name='$delta$' where
tvf.name is null
 merge delta of "WAHTSCHEMA"."HIVO_CBR_ALL_PREORDERED_RECS"
-------Landscape Redistribution----------------------------------------------------------------

-----Table Placement------------
select * from TABLE_GROUPS;
select * from _SYS_RT.TABLE_PLACEMENT order by MIN_ROWS_FOR_PARTITIONING desc;

-- check quality of distribution by table count, partition count, record count, estimated size per host and port
select 
t.host, t.port, count(distinct t.table_name), count(t.table_name), round(sum(t.record_count),0), round(sum(t.estimated_max_memory_size_in_total),0)
from m_cs_tables t
where schema_name = 'SAPSR3'
group by t.host, t.port
order by t.host, t.port

-- check quality of distribution by table group types
select 
t.host, t.port, g.group_type, count(distinct t.table_name), count(t.table_name), round(sum(t.record_count),0), round(sum(t.estimated_max_memory_size_in_total),0)
from table_groups g
join m_cs_tables t
on g.schema_name = t.schema_name
and g.table_name = t.table_name
where t.schema_name = 'SAPSR3'
group by
t.host, t.port, g.group_type
order by group_type

	-----TABLE_GROUPS------------------------------
select top 10 l.table_name,l.part_id,l.location,g.group_type,g.group_name from M_TABLE_LOCATIONS l join SYS.TABLE_GROUPS g ON L.TABLE_NAME = g.TABLE_NAME and l.schema_name = g.schema_name 
where g.group_type is not null and g.group_name is not null and l.table_name = '/BIC/AZFZJCW0100' order by l.table_name,l.part_id,g.group_name;

	---aggregation 
select top 100 l.location,g.group_type,g.group_name,count(*) from M_TABLE_LOCATIONS l join SYS.TABLE_GROUPS g ON L.TABLE_NAME = g.TABLE_NAME and l.schema_name = g.schema_name 
where g.group_type is not null and g.group_name is not null  group by l.location,g.group_type,g.group_name having count(*) > 1 order by g.group_name desc;
 
	------TABLE_PLACEMENT0----------------------------
select * from _SYS_RT.TABLE_PLACEMENT
	------REORG_PLAN---------
select * from "PUBLIC"."REORG_OVERVIEW" ;
select NEW_HOST,count(*) from "SYS"."REORG_STEPS" WHERE REORG_ID != 1 group by NEW_HOST order by NEW_HOST
select distinct reorg_id from "SYS"."REORG_STEPS";
select * from "PUBLIC"."REORG_OVERVIEW" ;
select * from "SYS"."REORG_STEPS" WHERE REORG_ID = 5 and new_host = 'hana09' order by NEW_HOST
select distinct reorg_id from "SYS"."REORG_STEPS";
select * from SYS.REORG_PLAN

---------BW on HANA-----------------
select a.table_name,a.partition_spec,b.record_count,b.create_time from tables a join m_cs_tables b on a.table_name = b.table_name 
join table_groups c on a.table_name = c.table_name
where a.table_name like '/BI%/B%' and a.partition_spec like 'HASH 1%' and record_count > 40000000 and subtype = 'CHANGE_LOG'
order by 
record_count desc;

---------SQL-BASED_Dynamic Analytic Privilege--------------------------------------------
;Creation of base table to store user-specific filter strings
create user PROCOWNER password Password1234;
connect PROCOWNER password Password1234;
CREATE COLUMN TABLE "PROCOWNER"."AUTHORIZATION_FILTERS"("FILTER" VARCHAR(256), "USER_NAME" VARCHAR(20));
INSERT INTO "PROCOWNER"."AUTHORIZATION_FILTERS" VALUES('CUSTOMID=''00001948''', 'I077532');
--INSERT INTO "PROCOWNER"."AUTHORIZATION_FILTERS" VALUES('CUSTOMID=''00072753''', 'CUSTOMER');
--delete from "PROCOWNER"."AUTHORIZATION_FILTERS" where "FILTER" = '00001948'
select * from "PROCOWNER"."AUTHORIZATION_FILTERS";
--grant select on schema PROCOWNER TO _SYS_REPO with grant option;
--grant select on schema PROCOWNER TO SYSTEM with grant option;
;Creation of database procedure and granting access to _SYS_REPO
--connect PROCOWNER password Password1234;
CREATE PROCEDURE "PROCOWNER"."GET_FILTER_FOR_USER"(OUT OUT_FILTER VARCHAR(256))
LANGUAGE SQLSCRIPT SQL SECURITY DEFINER READS SQL DATA AS
	v_Filter VARCHAR(256);
	CURSOR v_Cursor FOR SELECT "FILTER" FROM "PROCOWNER"."AUTHORIZATION_FILTERS" WHERE "USER_NAME" = SESSION_USER;
BEGIN
	OPEN v_Cursor;
	FETCH v_Cursor INTO v_Filter;
	OUT_FILTER := v_Filter;
	CLOSE v_Cursor;
END;
GRANT EXECUTE ON "PROCOWNER"."GET_FILTER_FOR_USER" TO _SYS_REPO;
;Test User
--create role CUSTOMER;
grant CUSTOMER to I077532;
revoke CUSTOMER FROM I077532;
alter user I077532 password Initial123;
connect I077532 password Initial123;
select * from "_SYS_BIC"."Modeling/AT_TEST";insufficient privilege: Not authorized
connect SYSTEM password ***;
select * from "SFLIGHT"."SBOOK"
select * from "_SYS_BIC"."Modeling/AT_AP";
drop STRUCTURED PRIVILEGE AP_SALES;
CREATE STRUCTURED PRIVILEGE AP_SALES FOR SELECT ON "_SYS_BIC"."Modeling/AT_TEST" CONDITION PROVIDER "PROCOWNER"."GET_FILTER_FOR_USER";
select * from "PUBLIC"."STRUCTURED_PRIVILEGES"
GRANT STRUCTURED PRIVILEGE AP_SALES to I077532;
--REVOKE STRUCTURED PRIVILEGE AP_SALES FROM I077532;
;grant Object Privilege and SQL-P to user
GRANT SELECT ON "_SYS_BIC"."Modeling/AT_TEST" TO I077532;
revoke select on "_SYS_BIC"."Modeling/AT_TEST" from I077532;
;demonstration
connect I077532 password Initial2;
select * from "_SYS_BIC"."Modeling/AT_TEST";shows data where CUSTOMID=''00001948''
------XML-BASED-AP-------------------
connect I077532 password Initial2;
connect SYSTEM password HD5sys00;
select * from "_SYS_BIC"."Modeling/AT_AP";insufficient privilege: Not authorized
connect SYSTEM password ***;
;Creation of base table to store user-specific filter strings
connect PROCOWNER password Password1234;
CREATE COLUMN TABLE "PROCOWNER"."GET_CUSTOMID_FOR_USER"("FILTER" VARCHAR(256), "USER_NAME" VARCHAR(20));
--DROP TABLE "PROCOWNER"."GET_CUSTOMID_FOR_USER"
INSERT INTO "PROCOWNER"."GET_CUSTOMID_FOR_USER" VALUES('00001948', 'I077532');
SELECT * FROM "PROCOWNER"."GET_CUSTOMID_FOR_USER";

call _SYS_REPO.GRANT_ACTIVATED_ANALYTICAL_PRIVILEGE('"Modeling/AP_SALE"','I077532');-do pay attention on "" when you need to use /
GRANT SELECT ON "_SYS_BIC"."Modeling/AT_AP" TO I077532;
connect I077532 password Initial2;
select * from "_SYS_BIC"."Modeling/AT_AP";shows data where CUSTOMID=''00001948''
connect SYSTEM password ***;
select COUNT(*) from "_SYS_BIC"."Modeling/AT_AP" where "CUSTOMID" = '00001948'
----AP_TroubleShoot
select * from ownership ORDER BY OBJECT_OID
where 
--OBJECT_TYPE = 'ANALYTICALPRIVILEGE'
OBJECT_OID = '4155';
select * from "PUBLIC"."STRUCTURED_PRIVILEGES"
SELECT * FROM "_SYS_REPO"."SCHEMAVERSION" where SCHEMA_TYPE = 'rt'
WHERE USER_NAME = 'I077532'
AND OBJECT_TYPE = 'ANALYTICALPRIVILEGE';

select * from "SYS"."EFFECTIVE_ROLES" where user_name= 'I077532' and
role_name='sap.hana.admin.roles::Monitoring';
----ODATA-----
call _SYS_REPO.GRANT_SCHEMA_PRIVILEGE_ON_ACTIVATED_CONTENT('select','HELLO_ODATA','SYSTEM');
select * from "HELLO_ODATA"."yahoo::otable";
select * from "HELLO_ODATA"."yahoo::TIME";
select * from "_SYS_XS"."JOBS";
select * from "_SYS_XS"."JOB_SCHEDULES";
select * from "_SYS_XS"."JOB_LOG";
--delete from "_SYS_XS"."JOB_LOG";
INSERT INTO "SYSTEM"."TIME" VALUES (NOW(), 1);
SELECT * FROM TIME
