SELECT
/* 

[NAME]

- HANA_SQL_SQLCache

[DESCRIPTION]

- List of top SQL statements (e.g. based on elapsed time, executions or records)

[DETAILS AND RESTRICTIONS]


[VALID FOR]

- Revisions:              all
- Statistics server type: all

[SQL COMMAND VERSION]

- 2014/03/17:  1.0 (initial version)
- 2014/07/21:  1.1 (consolidated command for evaluating current and historic SQL plan cache)

[INVOLVED TABLES]

- M_SQL_PLAN_CACHE
- HOST_SQL_PLAN_CACHE

[INPUT PARAMETERS]

- BEGIN_TIME

  Begin time

  TO_TIMESTAMP('2014/06/05 14:05:00', 'YYYY/MM/DD HH24:MI:SS') --> Set begin time to 5th of June 2014, 14:05 
  ADD_DAYS(CURRENT_TIMESTAMP, -2)                              --> Set begin time to two days before current time 

- END_TIME

  End time

  TO_TIMESTAMP('2014/06/08 14:05:00', 'YYYY/MM/DD HH24:MI:SS') --> Set end time to 8th of June 2014, 14:05 
  CURRENT_TIMESTAMP                                            --> Set end time to current time 

- HOST

  Host name

  'saphana01'     --> Specic host saphana01
  'saphana%'      --> All hosts starting with saphana
  '%'             --> All hosts

- SQL_PATTERN

  Pattern for SQL text (case insensitive)

  'INSERT%'         --> SQL statements starting with INSERT
  '%DBTABLOG%'      --> SQL statements containing DBTABLOG
  '%'               --> All SQL statements

- DATA_SOURCE

  Source of analysis data

  'CURRENT'       --> Data from memory information (M_ tables)
  'HISTORY'       --> Data from persisted history information (HOST_ tables)

- AGGREGATE_BY

  Aggregation criteria (possible values can be found in comment)

  'HASH'           --> Aggregation by statement hash
  'HOST, PLAN_ID'  --> Aggregation by host and SQL plan ID
  'NONE'           --> No aggregation

- ORDER_BY

  Sort order (available values are provided in comment)

  'ELAPSED'       --> Sorting by elapsed time
  'EXECUTIONS'    --> Sorting by number of executions

- RESULT_ROWS

  Number of records to be returned by the query

  100             --> Return a maximum number of 100 records
  -1              --> Return all records

-[OUTPUT PARAMETERS]

- STATEMENT_HASH:    Hash value of SQL statement
- HOST:              Host of statement execution ('various' if several hosts executed the command)
- STORE:             ROW for row store tables, COLUMN for column store tables
- EXECUTIONS:        Number of executions
- RECORDS:           Number of records
- REC_PER_EXEC:      Number of records per execution (ms)
- CURSOR_MS:         Cursor execution time (ms), includes network and client activities
- CUR_PER_EXEC_MS:   Cursor execution time per execution (ms)
- ELAPSED_MS:        Elapsed time (ms)
- ELA_PER_EXEC_MS:   Elapsed time per execution (ms)
- OPEN_MS:           Open time (ms), often contains the actual data collection
- OPEN_PER_EXEC_MS:  Open time per execution (ms)
- FETCH_MS:          Fetch time (ms), can sometimes contain times related to the actual data collection (row store, late materialization)
- FETCH_MS_PER_EXEC: Fetch time per execution (ms)
- LOCK_WAIT_MS:      Lock wait time (ms)
- LOCK_PER_EXEC_MS:  Lock wait time per execution (ms)

[EXAMPLE OUTPUT]

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|STATEMENT_HASH                  |HOST   |TABLE_TYPES|EXECUTIONS|RECORDS   |REC_PER_EXEC|CURSOR_MS |CUR_PER_EXEC_MS|ELAPSED_MS|ELA_PER_EXEC_MS|OPEN_MS   |OPEN_PER_EXEC_MS|FETCH_MS  |FETCH_PER_EXEC_MS|LOCK_WAIT_MS|LOCK_PER_EXEC_MS|
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|905dbaa93a672b087c6f226bc283431d|saphana|ROW        |      5756|         0|        0.00|  46781804|        8127.48|  46781499|        8127.43|       182|          182.17|  46781098|          8127.36|           0|            0.00|
|73fd22e11d2a116696a0976d447725ed|saphana|NULL       |      2878|      2878|        1.00|  23432993|        8142.11|  23432849|        8142.06|  23432779|     23432779.48|        30|             0.01|           0|            0.00|
|67300b9fa874852496035d12131e8eda|saphana|COLUMN     |      2878|         0|        0.00|  23372620|        8121.13|  23372431|        8121.06|  23372163|     23372163.42|        21|             0.00|           0|            0.00|
|ff8603d773911e231aa87ecf956338e4|various|COLUMN     |     22896|  82376093|     3597.83|  15282643|         667.48|  15119139|         660.33|  14935143|     14935142.96|    169555|             7.40|           0|            0.00|
|b887b4d7ec612fbaf942cb664cb44a94|saphana|ROW        |       720|       720|        1.00|  13055876|       18133.16|  13055822|       18133.08|  13055779|     13055779.04|        21|             0.02|           0|            0.00|
|71991dbf589bc4bccb542e45e0843140|saphana|ROW        |       720|     55440|       77.00|  12810819|       17792.80|  12810320|       17792.11|  12809656|     12809655.66|       153|             0.21|           0|            0.00|
|d4353cc2f1efbad813ad7106cecfc9bf|saphana|ROW        |       720|      1440|        2.00|  12324677|       17117.60|  12324631|       17117.54|  12324437|     12324437.47|        15|             0.02|           0|            0.00|
|51fbc84c81236491c0e30ec6394a54c0|saphana|ROW, COLUMN|       720|  26106405|    36258.89|  12830797|       17820.55|  12317890|       17108.18|  12145193|     12145193.26|    172434|           239.49|           0|            0.00|
|f6d34a3b244677718557cbc092794bf7|saphana|ROW        |       720|    215974|      299.96|  11455868|       15910.92|  11454956|       15909.66|  11454119|     11454118.82|       444|             0.61|           0|            0.00|
|062a118a73583797125c01e2871f7d4c|saphana|ROW        |      2878|     23024|        8.00|  10323850|        3587.16|  10323578|        3587.06|   9987578|      9987577.69|    208825|            72.55|           0|            0.00|
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

*/

  HOST,
  PORT,
  STATEMENT_HASH,
  STORE,
  LPAD(EXECUTIONS, 10) EXECUTIONS,
  LPAD(RECORDS, 10) RECORDS,
  LPAD(TO_DECIMAL(REC_PER_EXEC, 10, 2), 12) REC_PER_EXEC,
  LPAD(ROUND(ELAPSED_MS), 10) ELAPSED_MS,
  LPAD(TO_DECIMAL(ELA_PER_EXEC_MS, 10, 2), 15) ELA_PER_EXEC_MS,
  LPAD(TO_DECIMAL(LOCK_PER_EXEC_MS, 10, 2), 16) LOCK_PER_EXEC_MS,
  LPAD(ROUND(CURSOR_MS), 10) CURSOR_MS,
  LPAD(TO_DECIMAL(CUR_PER_EXEC_MS, 10, 2), 15) CUR_PER_EXEC_MS,
  LPAD(ROUND(OPEN_MS), 10) OPEN_MS,
  LPAD(TO_DECIMAL(OPEN_PER_EXEC_MS, 10, 2), 16) OPEN_PER_EXEC_MS,
  LPAD(ROUND(FETCH_MS), 10) FETCH_MS,
  LPAD(TO_DECIMAL(FETCH_PER_EXEC_MS, 10, 2), 17) FETCH_PER_EXEC_MS,
  LPAD(ROUND(LOCK_WAIT_MS), 12) LOCK_WAIT_MS
FROM
( SELECT
    HOST,
    PORT,
    STATEMENT_HASH,
    STORE,
    EXECUTIONS,
    RECORDS,
    REC_PER_EXEC,
    CURSOR_MS,
    CUR_PER_EXEC_MS,
    ELAPSED_MS,
    ELA_PER_EXEC_MS,
    OPEN_MS,
    OPEN_PER_EXEC_MS,
    FETCH_MS,
    FETCH_PER_EXEC_MS,
    LOCK_WAIT_MS,
    LOCK_PER_EXEC_MS,
    RESULT_ROWS,
    ROW_NUMBER () OVER (ORDER BY ORDER_VALUE DESC) ROW_NUM     /*Modification Part*/   /*ASC doesn't help*/
  FROM
  ( SELECT
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'HOST')    != 0 THEN HOST             ELSE MAP(BI_HOST, '%', 'any', BI_HOST) END HOST,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'PORT')    != 0 THEN TO_CHAR(PORT)    ELSE MAP(BI_PORT, '%', 'any', BI_PORT) END PORT,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'HASH')    != 0 THEN STATEMENT_HASH   ELSE 'any'                             END STATEMENT_HASH,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'PLAN_ID') != 0 THEN TO_CHAR(PLAN_ID) ELSE 'any'                             END PLAN_ID,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'STORE')   != 0 THEN STORE            ELSE 'any'                             END STORE,
      SUM(EXECUTIONS) EXECUTIONS,
      SUM(RECORDS) RECORDS,
      MAP(SUM(EXECUTIONS), 0, 0, SUM(RECORDS) / SUM(EXECUTIONS)) REC_PER_EXEC,
      SUM(CURSOR_MS) CURSOR_MS,
      MAP(SUM(EXECUTIONS), 0, 0, SUM(CURSOR_MS) / SUM(EXECUTIONS)) CUR_PER_EXEC_MS,
      SUM(ELAPSED_MS) ELAPSED_MS,
      MAP(SUM(EXECUTIONS), 0, 0, SUM(ELAPSED_MS) / SUM(EXECUTIONS)) ELA_PER_EXEC_MS,
      SUM(OPEN_MS) OPEN_MS,
      MAP(SUM(EXECUTIONS), 0, 0, SUM(OPEN_MS) / SUM(EXECUTIONS)) OPEN_PER_EXEC_MS,
      SUM(FETCH_MS) FETCH_MS,
      MAP(SUM(EXECUTIONS), 0, 0, SUM(FETCH_MS) / SUM(EXECUTIONS)) FETCH_PER_EXEC_MS,
      SUM(LOCK_WAIT_MS) LOCK_WAIT_MS,
      MAP(SUM(EXECUTIONS), 0, 0, SUM(LOCK_WAIT_MS) / SUM(EXECUTIONS)) LOCK_PER_EXEC_MS,
      ORDER_BY,
      RESULT_ROWS,
      CASE ORDER_BY
        WHEN 'ELAPSED'          THEN SUM(ELAPSED_MS)
        WHEN 'ELAPSED_PER_EXEC' THEN MAP(SUM(EXECUTIONS), 0, 0, SUM(ELAPSED_MS) / SUM(EXECUTIONS))
        WHEN 'CURSOR'           THEN SUM(CURSOR_MS)
        WHEN 'OPEN'             THEN SUM(OPEN_MS)
        WHEN 'FETCH'            THEN SUM(FETCH_MS)
        WHEN 'LOCK'             THEN SUM(LOCK_WAIT_MS)
        WHEN 'EXECUTIONS'       THEN SUM(EXECUTIONS)
        WHEN 'RECORDS'          THEN SUM(RECORDS)
      END ORDER_VALUE
    FROM
    ( SELECT
        HOST,
        PORT,
        STATEMENT_HASH,
        PLAN_ID,
        STORE,
        EXECUTION_COUNT - MAP(NEW_EXECUTION, ' ', IFNULL(LAG(EXECUTION_COUNT, 1) OVER (PARTITION BY STATEMENT_HASH, HOST ORDER BY SNAPSHOT_ID), 0), 0) EXECUTIONS,
        TOTAL_RESULT_RECORD_COUNT  - MAP(NEW_EXECUTION, ' ', IFNULL(LAG(TOTAL_RESULT_RECORD_COUNT, 1) OVER (PARTITION BY STATEMENT_HASH, HOST ORDER BY SNAPSHOT_ID), 0), 0) RECORDS,
        (TOTAL_CURSOR_DURATION - MAP(NEW_EXECUTION, ' ', IFNULL(LAG(TOTAL_CURSOR_DURATION, 1) OVER (PARTITION BY STATEMENT_HASH, HOST ORDER BY SNAPSHOT_ID), 0), 0)) / 1000 CURSOR_MS,
        (TOTAL_EXECUTION_TIME - MAP(NEW_EXECUTION, ' ', IFNULL(LAG(TOTAL_EXECUTION_TIME, 1) OVER (PARTITION BY STATEMENT_HASH, HOST ORDER BY SNAPSHOT_ID), 0), 0)) / 1000 ELAPSED_MS,
        (TOTAL_EXECUTION_OPEN_TIME - MAP(NEW_EXECUTION, ' ', IFNULL(LAG(TOTAL_EXECUTION_OPEN_TIME, 1) OVER (PARTITION BY STATEMENT_HASH, HOST ORDER BY SNAPSHOT_ID), 0), 0)) / 1000 OPEN_MS,
        (TOTAL_EXECUTION_FETCH_TIME - MAP(NEW_EXECUTION, ' ', IFNULL(LAG(TOTAL_EXECUTION_FETCH_TIME, 1) OVER (PARTITION BY STATEMENT_HASH, HOST ORDER BY SNAPSHOT_ID), 0), 0)) / 1000 FETCH_MS,
        (TOTAL_LOCK_WAIT_DURATION - MAP(NEW_EXECUTION, ' ', IFNULL(LAG(TOTAL_LOCK_WAIT_DURATION, 1) OVER (PARTITION BY STATEMENT_HASH, HOST ORDER BY SNAPSHOT_ID), 0), 0)) / 1000 LOCK_WAIT_MS,
        AGGREGATE_BY,
        ORDER_BY,
        RESULT_ROWS,
        BI_HOST,
        BI_PORT
      FROM
      ( SELECT
          C.*,
          CASE WHEN C.DATA_SOURCE = 'CURRENT' THEN 'X' ELSE 
            CASE WHEN C.LAST_EXECUTION_TIMESTAMP > LAG(C.SERVER_TIMESTAMP, 1) OVER (PARTITION BY C.STATEMENT_HASH, C.HOST ORDER BY C.SNAPSHOT_ID) THEN 'X' ELSE ' ' END 
          END NEW_EXECUTION,
          BI.AGGREGATE_BY,
          BI.ORDER_BY,
          BI.RESULT_ROWS,
          BI.HOST BI_HOST,
          BI.PORT BI_PORT
        FROM
        ( SELECT
            BEGIN_TIME,
            END_TIME,
            TIMESTAMP_TYPE,
            HOST,
            PORT,
            SQL_PATTERN,
            DATA_SOURCE,
            AGGREGATE_BY,
            ORDER_BY,
            RESULT_ROWS
          FROM
          ( SELECT                                                      /* Modification section */
              TO_TIMESTAMP('1000/05/16 11:00:00', 'YYYY/MM/DD HH24:MI:SS') BEGIN_TIME,
              TO_TIMESTAMP('9999/12/31 23:00:00', 'YYYY/MM/DD HH24:MI:SS') END_TIME,
              'PREP' TIMESTAMP_TYPE,                       /* SERVER, EXEC, PREP */
              '%' HOST,
              '30003' PORT,
              '%JOIN "/BI0/SREQUID"%' SQL_PATTERN,
              'HISTORY' DATA_SOURCE,   /* CURRENT, HISTORY */
              'HOST, HASH, STORE' AGGREGATE_BY,       /* HOST, PORT, HASH, PLAN_ID, STORE or comma separated list, NONE for no aggregation */
              'ELAPSED_PER_EXEC' ORDER_BY,      /* ELAPSED,ELAPSED_PER_EXEC, CURSOR, OPEN, FETCH, LOCK, EXECUTIONS, RECORDS */
              50 RESULT_ROWS
            FROM
              DUMMY
          )
        ) BI,
        ( SELECT
            HOST,
            PORT,
            'CURRENT' DATA_SOURCE,
            NULL SNAPSHOT_ID,
            STATEMENT_HASH,
            PLAN_ID,
            TO_CHAR(STATEMENT_STRING) STATEMENT_STRING,
            TABLE_TYPES STORE,
            EXECUTION_COUNT,
            TOTAL_RESULT_RECORD_COUNT,
            TOTAL_CURSOR_DURATION,
            TOTAL_EXECUTION_TIME,
            TOTAL_EXECUTION_OPEN_TIME,
            TOTAL_EXECUTION_FETCH_TIME,
            TOTAL_LOCK_WAIT_DURATION,
            LAST_PREPARATION_TIMESTAMP,
            LAST_EXECUTION_TIMESTAMP,
            CURRENT_TIMESTAMP SERVER_TIMESTAMP
          FROM
            M_SQL_PLAN_CACHE
          UNION ALL
          SELECT
            HOST,
            PORT,
            'HISTORY' DATA_SOURCE,
            SNAPSHOT_ID,
            STATEMENT_HASH,
            PLAN_ID,
            TO_CHAR(STATEMENT_STRING) STATEMENT_STRING,
            TABLE_TYPES STORE,
            EXECUTION_COUNT,
            TOTAL_RESULT_RECORD_COUNT,
            TOTAL_CURSOR_DURATION,
            TOTAL_EXECUTION_TIME,
            TOTAL_EXECUTION_OPEN_TIME,
            TOTAL_EXECUTION_FETCH_TIME,
            TOTAL_LOCK_WAIT_DURATION,
            LAST_PREPARATION_TIMESTAMP,
            LAST_EXECUTION_TIMESTAMP,
            SERVER_TIMESTAMP
          FROM
            _SYS_STATISTICS.HOST_SQL_PLAN_CACHE
        ) C
        WHERE
          C.HOST LIKE BI.HOST AND
          TO_CHAR(C.PORT) LIKE BI.PORT AND
          ( BI.TIMESTAMP_TYPE = 'SERVER' AND C.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME AND BI.END_TIME OR
            BI.TIMESTAMP_TYPE = 'EXEC'   AND C.LAST_EXECUTION_TIMESTAMP BETWEEN BI.BEGIN_TIME AND BI.END_TIME OR
            BI.TIMESTAMP_TYPE = 'PREP'   AND C.LAST_PREPARATION_TIMESTAMP BETWEEN BI.BEGIN_TIME AND BI.END_TIME ) AND
          UPPER(C.STATEMENT_STRING) LIKE UPPER(BI.SQL_PATTERN) AND
          C.DATA_SOURCE = BI.DATA_SOURCE 
      )
      
    )
    WHERE RECORDS > 0 AND EXECUTIONS > 0    /*Modification Part*/
    GROUP BY
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'HOST')    != 0 THEN HOST             ELSE MAP(BI_HOST, '%', 'any', BI_HOST) END,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'PORT')    != 0 THEN TO_CHAR(PORT)    ELSE MAP(BI_PORT, '%', 'any', BI_PORT) END,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'HASH')    != 0 THEN STATEMENT_HASH   ELSE 'any' END,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'PLAN_ID') != 0 THEN TO_CHAR(PLAN_ID) ELSE 'any' END,
      CASE WHEN AGGREGATE_BY = 'NONE' OR INSTR(AGGREGATE_BY, 'STORE')   != 0 THEN STORE            ELSE 'any' END,
      ORDER_BY,
      RESULT_ROWS
  )
)
WHERE
  ( RESULT_ROWS = -1 OR ROW_NUM <= RESULT_ROWS )
ORDER BY
  ROW_NUM
