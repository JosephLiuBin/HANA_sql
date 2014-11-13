SELECT
/* 

[NAME]

- HANA_Tables_LargestTables

[DESCRIPTION]

- Overview of largest tables (including indexes and LOBs)

[DETAILS AND RESTRICTIONS]


[VALID FOR]

- Revisions:              all
- Statistics server type: all

[SQL COMMAND VERSION]

- 2014/03/06:  1.0 (initial version)
- 2014/05/01:  1.1 (L and MAX_MEM_GB output columns included)

[INVOLVED TABLES]

- M_CS_ALL_COLUMNS and others

[INPUT PARAMETERS]

- SCHEMA_NAME

  Schema name or pattern

  'SAPSR3'        --> Specific schema SAPSR3
  'SAP%'          --> All schemata starting with 'SAP'
  '%'             --> All schemata

- TABLE_NAME           

  Table name or pattern

  'T000'          --> Specific table T000
  'T%'            --> All tables starting with 'T'
  '%'             --> All tables

- STORE

  Restriction to row and / or column store

  'ROW'           --> Only row store information
  'COLUMN'        --> Only column store information
  '%'             --> No store restriction

- ONLY_BASIS_TABLES

  Possibility to restrict output to basis tables from SAP Note 706478 

  'X'             --> Display only tables mentioned in SAP Note 706478
  ' '             --> No restriction to basis tables

- ORDER_BY

  Sort criteria (available values are provided in comment)

  'TOTAL_DISK'    --> Sorting by total size on disk
  'CURRENT_MEM'   --> Sorting by total size in memory
  'MAX_MEM',      --> Sorting by maximum total size in memory
  'TABLE_MEM'     --> Sorting by table size in memory
  'INDEX_MEM'     --> Sorting by index size in memory

- RESULT_ROWS

  Number of records to be returned by the query

  100             --> Return a maximum number of 100 records
  -1              --> Return all records

[OUTPUT PARAMETERS]

- OWNER:       Name of the table owner
- TABLE_NAME:  Name of the table
- S:           Table store ('R' for row store, 'C' for column store)
- L:           Load state ('Y' -> loaded, 'P' -> partially loaded, 'N' -> not loaded)
- HOST:        Host name ('various' in case of partitions on multiple hosts)
- B:           'X' if table belongs to the class of basis tables described in SAP Note 706478

- U:           'X' if at least one unique index exists for the table
- POS:         Position of table in top list
- COLS:        Number of table columns
- RECORDS:     Number of table records
- DISK_GB:     Total size on disk (in GB, table + indexes + LOB segments)
- MAX_MEM_GB:  Total potential maximum size in memory (in GB, table + indexes + LOB segments)
- CUR_MEM_GB:  Total current size in memory (in GB, table + indexes + LOB segments)
- MEM_%:       Total current size in memory (in % of overall memory size)
- CUM_%:       Cumulated total current size in memory percentage of the largest tables
- PART.:       Number of table partitions ("0" if table is not partitioned)
- TAB_MEM_GB:  Table size in memory (in GB)
- IND.:        Number of indexes on the table
- IND_MEM_GB:  Total size of all table indexes in memory (in GB)
- LOBS:        Type and number of LOB columns of the table ('M' for in memory LOBs, ?H' for hybrid LOBs)
- LOB_GB:      Total size of all table LOB segments (in GB)

[EXAMPLE OUTPUT]

----------------------------------------------------------------------------------------------------------------------------------------------------------
|OWNER |TABLE_NAME      |S|HOST    |B|U|POS|COLS|RECORDS     |SUM_DISK_GB|SUM_MEM_GB|SUM_MEM_ |CUM_MEM_ |PART |TAB_MEM_GB|IND |IND_MEM_GB|LOBS|LOB_GB    |
----------------------------------------------------------------------------------------------------------------------------------------------------------
|SAPSR3|/BIC/AZOCEUO0500|C|various | |X|  1|  16|   877829360|      63.90|     76.15|     4.47|     4.47|    8|      8.12|   3|     68.02|   0|      0.00|
|SAPSR3|/BIC/AZOCZZO0400|C|various | |X|  2|  33|   965035392|      63.45|     70.10|     4.11|     8.58|    8|     19.11|   2|     50.98|   0|      0.00|
|SAPSR3|RSMONMESS       |R|erslha33|X|X|  3|  19|   170801504|      27.92|     54.21|     3.18|    11.77|    1|     27.92|   6|     26.29|   0|      0.00|
|SAPSR3|/BIC/AZFIGLO1300|C|various | |X|  4|  60|   652633189|      47.20|     53.23|     3.12|    14.89|    8|     22.53|   2|     30.69|   0|      0.00|
|SAPSR3|/BIC/AZSCXXO4400|C|various | |X|  5|  26|  1251448665|      47.78|     53.04|     3.11|    18.01|    8|     18.14|   1|     34.89|   0|      0.00|
|SAPSR3|/BIC/AZOCEUO0800|C|various | |X|  6|  17|   911830438|      37.86|     52.42|     3.07|    21.08|    8|      7.37|   4|     45.05|   0|      0.00|
|SAPSR3|/BIC/AZOCZZO2000|C|various | |X|  7|  34|  1200422292|      46.50|     50.08|     2.94|    24.02|    8|     23.36|   1|     26.72|   0|      0.00|
|SAPSR3|RSWR_DATA       |R|erslha33|X|X|  8|  10|       20471|      36.88|     36.88|     2.16|    26.19|    1|     36.88|   1|      0.00|  M2|      0.00|
|SAPSR3|RSRWBSTORE      |C|erslha33|X|X|  9|   5|    14483956|      36.18|     36.20|     2.12|    28.32|    1|     36.02|   1|      0.17|   0|      0.00|
|SAPSR3|/BIC/AZMIEUO0200|C|various | |X| 10|  52|   403915330|      28.58|     33.05|     1.94|    30.26|    8|     12.95|   2|     20.10|   0|      0.00|
|SAPSR3|/BIC/AZSCXXO2900|C|various | |X| 11| 275|   183029330|      30.82|     29.26|     1.71|    31.97|    6|     20.46|   2|      8.79|   0|      0.00|
|SAPSR3|/BIC/AZSCXXO4700|C|various | |X| 12|  42|   648103462|      27.38|     28.83|     1.69|    33.67|    8|     12.52|   1|     16.31|   0|      0.00|
|SAPSR3|/BIC/FZRREUC16B |C|erslha35| | | 13| 122|   258261262|      26.43|     24.99|     1.46|    35.14|    4|     24.99|   0|      0.00|   0|      0.00|
|SAPSR3|/BIC/AZOCEUO9000|C|various | |X| 14|  16|   251896248|      20.53|     23.71|     1.39|    36.53|    6|      2.84|   3|     20.87|   0|      0.00|
|SAPSR3|RSBMNODES       |R|erslha33|X|X| 15|  12|   130344869|      13.67|     20.25|     1.18|    37.72|    1|     13.67|   2|      6.58|   0|      0.00|
|SAPSR3|/BIC/AZSCXXO1400|C|various | |X| 16| 279|   164509638|      18.49|     19.82|     1.16|    38.88|    6|     10.76|   5|      9.05|   0|      0.00|
|SAPSR3|/BIC/AZOCEUO0300|C|various | |X| 17|  27|   577787981|      17.95|     19.60|     1.15|    40.03|    8|      6.23|   1|     13.36|   0|      0.00|
|SAPSR3|EDI40           |R|erslha33|X|X| 18|   7|     5733625|      18.26|     18.40|     1.08|    41.11|    1|     18.26|   1|      0.14|   0|      0.00|
|SAPSR3|/BIC/FZOCZZC20  |C|various | | | 19|  34|  1427403108|      18.97|     17.80|     1.04|    42.16|   32|     17.76|   0|      0.03|   0|      0.00|
|SAPSR3|/BIC/AZSCXXO2600|C|various | |X| 20| 306|    95251083|      16.65|     16.97|     0.99|    43.15|    3|     10.13|   3|      6.83|   0|      0.00|
|SAPSR3|/BIC/AZSCXXO0800|C|various | |X| 21| 266|   120598787|      18.76|     15.62|     0.91|    44.07|    6|     12.05|   6|      3.57|   0|      0.00|
|SAPSR3|/BIC/AZSPXXO0200|C|various | |X| 22|  48|   270975902|      12.63|     15.30|     0.89|    44.97|    8|      6.91|   2|      8.38|   0|      0.00|
|SAPSR3|/BIC/AZOCZZO5000|C|various | |X| 23|  33|   215732874|      14.16|     14.92|     0.87|    45.85|    6|      4.52|   2|     10.39|   0|      0.00|
|SAPSR3|/BIC/AZSPXXO0300|C|various | |X| 24|  56|   275036362|      13.09|     14.77|     0.86|    46.71|    8|      7.65|   3|      7.11|   0|      0.00|
|SAPSR3|/BIC/AZOCEUO0600|C|various | |X| 25|  16|   663581081|      12.29|     14.34|     0.84|    47.56|    8|      4.75|   1|      9.59|   0|      0.00|
|SAPSR3|/BIC/AZOCZZO0700|C|various | |X| 26|  41|   350819182|      15.00|     14.32|     0.84|    48.40|    8|      3.66|   2|     10.65|   0|      0.00|
|SAPSR3|/BIC/FZRREUC16D |C|erslha40| | | 27| 122|   146620284|      15.39|     14.06|     0.82|    49.22|    4|     14.06|   0|      0.00|   0|      0.00|
|SAPSR3|/BIC/AZMDEUO0800|C|various | |X| 28| 246|   151145647|      15.39|     14.00|     0.82|    50.05|    6|     10.63|   1|      3.36|   0|      0.00|
|SAPSR3|/BIC/AZMIEUO1300|C|various | |X| 29|  16|   406548712|      11.52|     13.35|     0.78|    50.83|    8|      6.82|   1|      6.52|   0|      0.00|
|SAPSR3|/BIC/AZRREUO0100|C|various | |X| 30| 167|   202422848|      15.36|     13.24|     0.77|    51.61|    6|      7.82|   1|      5.42|   0|      0.00|
----------------------------------------------------------------------------------------------------------------------------------------------------------

*/

  OWNER,
  TABLE_NAME,
  S,                                        /* 'C' --> column store, 'R' --> row store */
  LOADED L,                                 /* 'Y' --> fully loaded, 'P' --> partially loaded, 'N' --> not loaded */
  HOST,
  B,                                        /* 'X' if table belongs to list of basis tables (SAP Note 706478) */
  U,                                        /* 'X' if unique index exists for table */
  LPAD(ROW_NUM, 3) POS,
  LPAD(COLS, 4) COLS,
  LPAD(RECORDS, 12) RECORDS,
  LPAD(TO_DECIMAL(TOTAL_DISK_MB / 1024, 10, 2), 7) DISK_GB,
  LPAD(TO_DECIMAL(MAX_TOTAL_MEM_MB / 1024, 10, 2), 10) MAX_MEM_GB,
  LPAD(TO_DECIMAL(TOTAL_MEM_MB / 1024, 10, 2), 10) CUR_MEM_GB,
  LPAD(TO_DECIMAL("TOTAL_MEM_%", 9, 2), 5) "MEM_%",
  LPAD(TO_DECIMAL(SUM("TOTAL_MEM_%") OVER (ORDER BY ROW_NUM), 5, 2), 5) "CUM_%",
  LPAD(PARTITIONS, 5) "PART.",
  LPAD(TO_DECIMAL(TABLE_MEM_MB / 1024, 10, 2), 10) TAB_MEM_GB,
  LPAD(INDEXES, 4) "IND.",
  LPAD(TO_DECIMAL(INDEX_MEM_MB / 1024, 10, 2), 10) IND_MEM_GB,
  LPAD(LOBS, 4) LOBS,
  LPAD(TO_DECIMAL(LOB_MB / 1024, 10, 2), 6) LOB_GB
FROM
( SELECT
    OWNER,
    TABLE_NAME,
    HOST,
    B,
    CASE WHEN UNIQUE_INDEXES = 0 THEN ' ' ELSE 'X' END U,
    MAP(STORE, 'COLUMN', 'C', 'ROW', 'R') S,
    COLS,
    RECORDS,
    TABLE_MEM_MB + INDEX_MEM_RS_MB TOTAL_MEM_MB,
    IFNULL(MAX_MEM_MB, TABLE_MEM_MB + INDEX_MEM_RS_MB) MAX_TOTAL_MEM_MB,
    TABLE_MEM_MB - INDEX_MEM_CS_MB TABLE_MEM_MB,             /* Indexes are contained in CS table size */
    LOADED,
    TOTAL_DISK_MB,
    (TABLE_MEM_MB +  INDEX_MEM_RS_MB) / SUM(TABLE_MEM_MB + 
      INDEX_MEM_RS_MB) OVER () * 100 "TOTAL_MEM_%",
    PARTITIONS,
    INDEXES,
    INDEX_MEM_RS_MB + INDEX_MEM_CS_MB INDEX_MEM_MB,
    LOBS,
    LOB_MB,
    ROW_NUMBER () OVER ( ORDER BY MAP ( ORDER_BY, 
      'TOTAL_DISK',  TOTAL_DISK_MB, 
      'CURRENT_MEM', TABLE_MEM_MB + INDEX_MEM_RS_MB, 
      'MAX_MEM',     IFNULL(MAX_MEM_MB, TABLE_MEM_MB + INDEX_MEM_RS_MB),
      'TABLE_MEM',   TABLE_MEM_MB - INDEX_MEM_CS_MB, 
      'INDEX_MEM',   INDEX_MEM_RS_MB + INDEX_MEM_CS_MB ) 
      DESC, OWNER,   TABLE_NAME ) ROW_NUM,
    RESULT_ROWS,
    ORDER_BY
  FROM
  ( SELECT
      T.SCHEMA_NAME OWNER,
      T.TABLE_NAME,
      TS.HOST,
      CASE WHEN T.TABLE_NAME IN
      ( 'BALHDR', 'BALHDRP', 'BALM', 'BALMP', 'BALDAT', 'BALC', 
        'BAL_INDX', 'EDIDS', 'EDIDC', 'EDIDOC', 'EDI30C', 'EDI40', 'EDID4',
        'IDOCREL', 'SRRELROLES', 'SWFGPROLEINST', 'SWP_HEADER', 'SWP_NODEWI', 'SWPNODE',
        'SWPNODELOG', 'SWPSTEPLOG', 'SWW_CONT', 'SWW_CONTOB', 'SWW_WI2OBJ', 'SWWCNTP0',
        'SWWCNTPADD', 'SWWEI', 'SWWLOGHIST', 'SWWLOGPARA', 'SWWWIDEADL', 'SWWWIHEAD', 
        'SWWWIRET', 'SWZAI', 'SWZAIENTRY', 'SWZAIRET', 'SWWUSERWI',                  
        'BDCP', 'BDCPS', 'BDCP2', 'DBTABLOG', 'DBTABPRT', 
        'ARFCSSTATE', 'ARFCSDATA', 'ARFCRSTATE', 'TRFCQDATA',
        'TRFCQIN', 'TRFCQOUT', 'TRFCQSTATE', 'SDBAH', 'SDBAD', 'DBMSGORA', 'DDLOG',
        'APQD', 'TST01', 'TST03', 'TSPEVJOB', 'TXMILOGRAW', 'TSPEVDEV', 
        'SNAP', 'SMO8FTCFG', 'SMO8FTSTP', 'SMO8_TMSG', 'SMO8_TMDAT', 
        'SMO8_DLIST', 'SMW3_BDOC', 'SMW3_BDOC1', 'SMW3_BDOC2', 
        'SMW3_BDOC4', 'SMW3_BDOC5', 'SMW3_BDOC6', 'SMW3_BDOC7', 'SMW3_BDOCQ', 'SMWT_TRC',
        'TPRI_PAR', 'RSBMLOGPAR', 'RSBMLOGPAR_DTP', 'RSBMNODES', 'RSBMONMESS',
        'RSBMONMESS_DTP', 'RSBMREQ_DTP', 'RSCRTDONE', 'RSDELDONE', 'RSHIEDONE',
        'RSLDTDONE', 'RSMONFACT', 'RSMONICTAB', 'RSMONIPTAB', 'RSMONMESS', 'RSMONRQTAB', 'RSREQDONE',
        'RSRULEDONE', 'RSSELDONE', 'RSTCPDONE', 'RSUICDONE',
        'VBDATA', 'VBMOD', 'VBHDR', 'VBERROR',
        'VDCHGPTR', 'JBDCPHDR2', 'JBDCPPOS2', 'SWELOG', 'SWELTS', 'SWFREVTLOG',
        'ARDB_STAT0', 'ARDB_STAT1', 'ARDB_STAT2', 'QRFCTRACE', 'QRFCLOG',
        'DDPRS', 'TBTCO', 'TBTCP', 'TBTCS', 'MDMFDBEVENT', 'MDMFDBID', 'MDMFDBPR',
        'RSRWBSTORE', 'RSRWBINDEX', '/SAPAPO/LISMAP', '/SAPAPO/LISLOG', 
        'CCMLOG', 'CCMLOGD', 'CCMSESSION', 'CCMOBJLST', 'CCMOBJKEYS',
        'SXMSPMAST', 'SXMSPMAST2', 'SXMSPHIST', 'RSBATCHDATA',
        'SXMSPHIST2', 'SXMSPFRAWH', 'SXMSPFRAWD', 'SXMSCLUR', 'SXMSCLUR2', 'SXMSCLUP',
        'SXMSCLUP2', 'SWFRXIHDR', 'SWFRXICNT', 'SWFRXIPRC', 
        'XI_AF_MSG', 'XI_AF_MSG_AUDIT', 'BC_MSG', 'BC_MSG_AUDIT',
        'SMW0REL', 'SRRELROLES', 'COIX_DATA40', 'T811E', 'T811ED', 
        'T811ED2', 'RSDDSTATAGGR', 'RSDDSTATAGGRDEF', 'RSDDSTATCOND', 'RSDDSTATDTP',
        'RSDDSTATDELE', 'RSDDSTATDM', 'RSDDSTATEVDATA', 'RSDDSTATHEADER',
        'RSDDSTATINFO', 'RSDDSTATLOGGING', 'RSERRORHEAD', 'RSERRORLOG',
        'DFKKDOUBTD_W', 'DFKKDOUBTD_RET_W', 'RSBERRORLOG', 'INDX',
        'SOOD', 'SOOS', 'SOC3', 'SOFFCONT1', 'BCST_SR', 'BCST_CAM',
        'SICFRECORDER', 'CRM_ICI_TRACES', 'RSPCINSTANCE',
        'GVD_BGPROCESS', 'GVD_BUFF_POOL_ST', 'GVD_LATCH_MISSES', 
        'GVD_ENQUEUE_STAT', 'GVD_FILESTAT', 'GVD_INSTANCE',    
        'GVD_PGASTAT', 'GVD_PGA_TARGET_A', 'GVD_PGA_TARGET_H',
        'GVD_SERVERLIST', 'GVD_SESSION_EVT', 'GVD_SESSION_WAIT',
        'GVD_SESSION', 'GVD_PROCESS', 'GVD_PX_SESSION',  
        'GVD_WPTOTALINFO', 'GVD_ROWCACHE', 'GVD_SEGMENT_STAT',
        'GVD_SESSTAT', 'GVD_SGACURRRESIZ', 'GVD_SGADYNFREE',  
        'GVD_SGA', 'GVD_SGARESIZEOPS', 'GVD_SESS_IO',     
        'GVD_SGASTAT', 'GVD_SGADYNCOMP', 'GVD_SEGSTAT',     
        'GVD_SPPARAMETER', 'GVD_SHAR_P_ADV', 'GVD_SQLAREA',     
        'GVD_SQL', 'GVD_SQLTEXT', 'GVD_SQL_WA_ACTIV',
        'GVD_SQL_WA_HISTO', 'GVD_SQL_WORKAREA', 'GVD_SYSSTAT',     
        'GVD_SYSTEM_EVENT', 'GVD_DATABASE', 'GVD_CURR_BLKSRV', 
        'GVD_DATAGUARD_ST', 'GVD_DATAFILE', 'GVD_LOCKED_OBJEC',
        'GVD_LOCK_ACTIVTY', 'GVD_DB_CACHE_ADV', 'GVD_LATCHHOLDER', 
        'GVD_LATCHCHILDS', 'GVD_LATCH', 'GVD_LATCHNAME',   
        'GVD_LATCH_PARENT', 'GVD_LIBRARYCACHE', 'GVD_LOCK',        
        'GVD_MANGD_STANBY', 'GVD_OBJECT_DEPEN', 'GVD_PARAMETER',   
        'GVD_LOGFILE', 'GVD_PARAMETER2', 'GVD_TEMPFILE',    
        'GVD_UNDOSTAT', 'GVD_WAITSTAT', 'ORA_SNAPSHOT',
        '/TXINTF/TRACE', 'RSECLOG', 'RSECUSERAUTH_CL', 'RSWR_DATA',
        'RSECVAL_CL', 'RSECHIE_CL', 'RSECTXT_CL', 'RSECSESSION_CL',
        'UPC_STATISTIC', 'UPC_STATISTIC2', 'UPC_STATISTIC3',
        'RSTT_CALLSTACK', 'RSZWOBJ', 'RSIXWWW', 'RSZWBOOKMARK', 'RSZWVIEW', 
        'RSZWITEM', 'RSR_CACHE_DATA_B', 'RSR_CACHE_DATA_C',
        'RSR_CACHE_FFB', 'RSR_CACHE_QUERY', 'RSR_CACHE_STATS',
        'RSR_CACHE_VARSHB', 'WRI$_OPTSTAT_HISTGRM_HISTORY',
        'WRI$_OPTSTAT_HISTHEAD_HISTORY', 'WRI$_OPTSTAT_IND_HISTORY',
        'WRI$_OPTSTAT_TAB_HISTORY', 'WRH$_ACTIVE_SESSION_HISTORY',
        'RSODSACTUPDTYPE', 'TRFC_I_SDATA', 'TRFC_I_UNIT', 'TRFC_I_DEST', 
        'TRFC_I_UNIT_LOCK', 'TRFC_I_EXE_STATE', 'TRFC_I_ERR_STATE',
        'DYNPSOURCE', 'DYNPLOAD', 'D010TAB', 'REPOSRC', 'REPOLOAD',
        'RSOTLOGOHISTORY', 'SQLMD', '/SDF/ZQLMD', 'RSSTATMANREQMDEL',
        'RSSTATMANREQMAP', 'RSICPROT', 'RSPCPROCESSLOG',
        'DSVASRESULTSGEN', 'DSVASRESULTSSEL', 'DSVASRESULTSCHK', 
        'DSVASRESULTSATTR', 'DSVASREPODOCS', 'DSVASSESSADMIN', 'DOKCLU',
        'ORA_SQLC_HEAD', 'ORA_SQLC_DATA',
        'SWN_NOTIF', 'SWN_NOTIFTSTMP', 'SWN_SENDLOG'
      ) OR
        ( T.TABLE_NAME LIKE 'GLOBAL%' AND T.SCHEMA_NAME = '_SYS_STATISTICS' ) OR
        ( T.TABLE_NAME LIKE 'HOST%' AND T.SCHEMA_NAME = '_SYS_STATISTICS' ) OR
        T.TABLE_NAME LIKE '/BI0/0%' OR
        T.TABLE_NAME LIKE '/BIC/B%' THEN 'X' ELSE ' ' END B,
      ( SELECT COUNT(*) FROM INDEXES I WHERE I.SCHEMA_NAME = T.SCHEMA_NAME AND I.TABLE_NAME = T.TABLE_NAME AND I.INDEX_TYPE LIKE '%UNIQUE%' ) UNIQUE_INDEXES,
      CASE WHEN T.IS_COLUMN_TABLE = 'FALSE' THEN 'ROW' ELSE 'COLUMN' END STORE,
      ( SELECT COUNT(*) FROM TABLE_COLUMNS C WHERE C.SCHEMA_NAME = T.SCHEMA_NAME AND C.TABLE_NAME = T.TABLE_NAME ) COLS,
      T.RECORD_COUNT RECORDS,
      T.TABLE_SIZE / 1024 / 1024 TABLE_MEM_MB,
      TS.LOADED,
      TS.MAX_MEM_MB,
      TP.DISK_SIZE / 1024 / 1024 TOTAL_DISK_MB,
      ( SELECT GREATEST(COUNT(*), 1) FROM M_CS_PARTITIONS P WHERE P.SCHEMA_NAME = T.SCHEMA_NAME AND P.TABLE_NAME = T.TABLE_NAME ) PARTITIONS,
      ( SELECT COUNT(*) FROM INDEXES I WHERE I.SCHEMA_NAME = T.SCHEMA_NAME AND I.TABLE_NAME = T.TABLE_NAME ) INDEXES,
      ( SELECT IFNULL(SUM(INDEX_SIZE), 0) / 1024 / 1024 FROM M_RS_INDEXES I WHERE I.SCHEMA_NAME = T.SCHEMA_NAME AND I.TABLE_NAME = T.TABLE_NAME ) INDEX_MEM_RS_MB,
      ( SELECT 
          IFNULL(SUM
          ( CASE INTERNAL_ATTRIBUTE_TYPE
              WHEN 'TREX_UDIV'         THEN 0                             /* technical necessity, completely treated as "table" */
              WHEN 'ROWID'             THEN 0                             /* technical necessity, completely treated as "table" */
              WHEN 'TREX_EXTERNAL_KEY' THEN MEMORY_SIZE_IN_TOTAL          /* both concat attribute and index on it treated as "index" */
              WHEN 'CONCAT_ATTRIBUTE'  THEN MEMORY_SIZE_IN_TOTAL          /* both concat attribute and index on it treated as "index" */
              ELSE MAIN_MEMORY_SIZE_IN_INDEX + DELTA_MEMORY_SIZE_IN_INDEX /* index structures on single columns treated as "index" */
            END
          ), 0) / 1024 / 1024
        FROM 
          M_CS_ALL_COLUMNS C 
        WHERE 
          C.SCHEMA_NAME = T.SCHEMA_NAME AND 
          C.TABLE_NAME = T.TABLE_NAME
      ) INDEX_MEM_CS_MB,
      ( SELECT IFNULL(MAX(MAP(CS_DATA_TYPE_NAME, 'ST_MEMORY_LOB', 'M', 'LOB', 'H', 'ST_DISK_LOB', 'D', 'U')), '') || COUNT(*)
          FROM TABLE_COLUMNS C 
        WHERE C.SCHEMA_NAME = T.SCHEMA_NAME AND C.TABLE_NAME = T.TABLE_NAME AND DATA_TYPE_NAME IN ( 'BLOB', 'CLOB', 'NCLOB', 'TEXT' ) ) LOBS,
      ( SELECT IFNULL(SUM(BINARY_SIZE), 0) / 1024 / 1024 FROM M_TABLE_LOB_FILES L WHERE L.SCHEMA_NAME = T.SCHEMA_NAME AND L.TABLE_NAME = T.TABLE_NAME ) LOB_MB,
      BI.ONLY_BASIS_TABLES,
      BI.RESULT_ROWS,
      BI.ORDER_BY
    FROM
    ( SELECT                                       /* Modification section */
        'SAPSR3' SCHEMA_NAME,
        '%' TABLE_NAME,
        'ROW' STORE,                             /* ROW, COLUMN, % */
        'bp0h01' HOST,
        ' ' ONLY_BASIS_TABLES,
        50 RESULT_ROWS,
        'INDEX_MEM' ORDER_BY                    /* TOTAL_DISK, CURRENT_MEM, MAX_MEM, TABLE_MEM, INDEX_MEM */
      FROM
        DUMMY
    ) BI,
      M_TABLES T,
      ( SELECT 
          SCHEMA_NAME, 
          TABLE_NAME, 
          MAP(MIN(HOST), MAX(HOST), MIN(HOST), 'various') HOST, 
          MAP(MIN(LOADED), 'NO', 'N', 'FULL', 'Y', 'PARTIALLY', 'P') LOADED,
          SUM(ESTIMATED_MAX_MEMORY_SIZE_IN_TOTAL) / 1024 / 1024 MAX_MEM_MB
        FROM 
          M_CS_TABLES 
        GROUP BY 
          SCHEMA_NAME, 
          TABLE_NAME 
        UNION
        ( SELECT 
            SCHEMA_NAME, 
            TABLE_NAME, 
            MAP(MIN(HOST), MAX(HOST), MIN(HOST), 'various') HOST, 
            'Y' LOADED,
            NULL MAX_MEM_MB
          FROM 
            M_RS_TABLES 
          GROUP BY 
            SCHEMA_NAME, 
            TABLE_NAME 
        )
      ) TS,
      M_TABLE_PERSISTENCE_STATISTICS TP
    WHERE
      T.SCHEMA_NAME LIKE BI.SCHEMA_NAME AND
      T.TABLE_NAME LIKE BI.TABLE_NAME AND
      T.SCHEMA_NAME = TP.SCHEMA_NAME AND
      T.TABLE_NAME = TP.TABLE_NAME AND
      T.SCHEMA_NAME = TS.SCHEMA_NAME AND
      T.TABLE_NAME = TS.TABLE_NAME AND
      BI.HOST = TS.HOST AND 
      ( BI.STORE = '%' OR
        BI.STORE = 'ROW' AND T.IS_COLUMN_TABLE = 'FALSE' OR
        BI.STORE = 'COLUMN' AND T.IS_COLUMN_TABLE = 'ROW'
      )
  )
  WHERE
    ( ONLY_BASIS_TABLES = ' ' OR B = 'X' )
)
WHERE
  ( RESULT_ROWS = -1 OR ROW_NUM <= RESULT_ROWS )
ORDER BY
  ROW_NUM

