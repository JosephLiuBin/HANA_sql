SELECT
      TO_CHAR(SERVER_TIMESTAMP, TIME_AGGREGATE_BY) SAMPLE_TIME,
      DETAIL,
      KEY_FIGURE_DESCRIPTION,
      MAX(KEY_FIGURE) KEY_FIGURE,
      ROUND(MAX(KEY_FIGURE) / SUM(MAX(KEY_FIGURE)) OVER (PARTITION BY TO_CHAR(SERVER_TIMESTAMP, TIME_AGGREGATE_BY)) * 100,2) PERCENT
FROM
  ( SELECT
          SERVER_TIMESTAMP,
          DETAIL,
          KEY_FIGURE_DESCRIPTION,
          TIME_AGGREGATE_BY,
          SUM(ROUND(KEY_FIGURE,1)) KEY_FIGURE
    FROM
        ( SELECT  
             D.SERVER_TIMESTAMP,
             MAP(BI.AGGREGATE_BY, 'SCHEMA_NAME', D.SCHEMA_NAME, 'HOST', D.HOST, 'PORT', TO_CHAR(D.PORT), 'AREA', D.AREA, 'DETAIL',
               MAP(BI.OBJECT_LEVEL, 'TABLE', D.DETAIL,D.DETAIL || MAP(D.PART_ID, -1, '', 0, '', ' (P' || D.PART_ID || ')')
                  )
                ) DETAIL,
             MAP(BI.KEY_FIGURE,
               'ALLOCATED', 'Space allocated (GB)',
               'USED',      'Space used (GB)',
               'ROWS',      'Records') KEY_FIGURE_DESCRIPTION,
             MAP(BI.KEY_FIGURE, 
               'ALLOCATED', D.ALLOC_BYTE / 1024 / 1024 / 1024,
               'USED',      D.USED_BYTE / 1024 / 1024 / 1024,
               'ROWS',      D.NUM_ROWS) KEY_FIGURE,
             BI.TIME_AGGREGATE_BY
          FROM
            ( SELECT
                  SCHEMA_NAME,
                  DETAIL,
                  HOST,
                  PORT,
                  AREA,
                  AGGREGATE_BY,
                  BEGIN_TIME,
                  END_TIME,
                  KEY_FIGURE,
                  OBJECT_LEVEL,
                  MAP(TIME_AGGREGATE_BY,
                    'NONE',        'YYYY/MM/DD HH24:MI:SS',
                    'HOUR',        'YYYY/MM/DD HH24',
                    'DAY',         'YYYY/MM/DD (DY)',
                    'HOUR_OF_DAY', 'HH24',
                    TIME_AGGREGATE_BY ) TIME_AGGREGATE_BY,
                  INCLUDE_OVERLAPPING_HEAP_AREAS
             FROM
                ( SELECT                                                      /* Modification section */
                      TO_TIMESTAMP('1000/01/01 01:00:00', 'YYYY/MM/DD HH24:MI:SS') BEGIN_TIME,
                      TO_TIMESTAMP('9999/12/31 23:59:00', 'YYYY/MM/DD HH24:MI:SS') END_TIME,
                      'hana01' HOST,
                      '30003' PORT,
                      '%' SCHEMA_NAME,
                      '%' AREA,                     /* ROW, COLUMN, ONLY_TABLES, HEAP, % */
                      '%' DETAIL,                   /* Name of table or heap area */
                      'AREA' AGGREGATE_BY,        /* SCHEMA_NAME, DETAIL, HOST, PORT, AREA */
                      'USED' KEY_FIGURE,       /* ALLOCATED, USED, MAIN, DELTA, MERGES, ROWS */ 
                      'TABLE' OBJECT_LEVEL,         /* TABLE, PARTITION */
                      ' ' INCLUDE_OVERLAPPING_HEAP_AREAS,     /* Consider heap areas like Pool/malloc/libhdbbasement.so although they overlap with table information */
                      'DAY' TIME_AGGREGATE_BY      /* HOUR, DAY, HOUR_OF_DAY or database time pattern, NONE for no aggregation */
                    FROM
                      DUMMY
               )
           ) BI,
           ( SELECT
               'COLUMN' AREA,
               CT.SERVER_TIMESTAMP,
               CT.SCHEMA_NAME,
               CT.TABLE_NAME DETAIL,
               CT.PART_ID,
               CT.HOST,
               CT.PORT,
               CT.RECORD_COUNT NUM_ROWS,
               CT.MEMORY_SIZE_IN_TOTAL ALLOC_BYTE,
               CT.MEMORY_SIZE_IN_TOTAL USED_BYTE
             FROM
               _SYS_STATISTICS.HOST_COLUMN_TABLES_PART_SIZE CT
             UNION ALL
             ( SELECT
                 'ROW' AREA,
                 RT.SERVER_TIMESTAMP,
                 RT.SCHEMA_NAME,
                 RT.TABLE_NAME DETAIL,
                 0 PART_ID,
                 RT.HOST,
                 RT.PORT,
                 RT.RECORD_COUNT NUM_ROWS,
                 RT.ALLOCATED_FIXED_PART_SIZE + RT.ALLOCATED_VARIABLE_PART_SIZE ALLOC_BYTE,
                 RT.USED_FIXED_PART_SIZE + RT.USED_VARIABLE_PART_SIZE USED_BYTE
               FROM
                 _SYS_STATISTICS.GLOBAL_ROWSTORE_TABLES_SIZE RT
             )
             UNION ALL
             ( SELECT
                 'HEAP',
                 HA.SERVER_TIMESTAMP,
                 ' ' SCHEMA_NAME,
                 HA.CATEGORY,
                 0 PART_ID,
                 HA.HOST,
                 HA.PORT,
                 HA.EXCLUSIVE_ALLOCATED_COUNT NUM_ROWS,
                 HA.EXCLUSIVE_ALLOCATED_SIZE,
                 HA.EXCLUSIVE_SIZE_IN_USE
               FROM
                 _SYS_STATISTICS.HOST_HEAP_ALLOCATORS HA
             )
           ) D
            WHERE
              D.SCHEMA_NAME LIKE BI.SCHEMA_NAME AND
              D.DETAIL LIKE BI.DETAIL AND
              D.HOST LIKE BI.HOST AND
              TO_CHAR(D.PORT) LIKE BI.PORT AND
              D.SERVER_TIMESTAMP BETWEEN BI.BEGIN_TIME AND BI.END_TIME AND
              D.AREA LIKE BI.AREA AND
              ( BI.AREA = 'ONLY_TABLES' AND D.AREA IN ('ROW', 'COLUMN') OR
                'HEAP' NOT LIKE BI.AREA OR
                ( BI.INCLUDE_OVERLAPPING_HEAP_AREAS = 'X' OR
                  D.DETAIL NOT IN 
                  ( 'Pool/AttributeEngine',
                    'Pool/AttributeEngine/Delta',
                    'Pool/AttributeEngine/Delta/BtreeDictionary',
                    'Pool/AttributeEngine/Delta/Cache',
                    'Pool/AttributeEngine/Delta/InternalNodes',
                    'Pool/AttributeEngine/Delta/LeafNodes',
                    'Pool/AttributeEngine/idattribute',
                    'Pool/AttributeEngine-IndexVector-BlockIndex',
                    'Pool/AttributeEngine-IndexVector-BTreeIndex',
                    'Pool/AttributeEngine-IndexVector-Single',
                    'Pool/AttributeEngine-IndexVector-SingleIndex',
                    'Pool/AttributeEngine-IndexVector-Sp-Cluster',
                    'Pool/AttributeEngine-IndexVector-Sp-Indirect',
                    'Pool/AttributeEngine-IndexVector-Sp-Prefix',
                    'Pool/AttributeEngine-IndexVector-Sp-Rle',
                    'Pool/AttributeEngine-IndexVector-Sp-Sparse',
                    'Pool/malloc/libhdbbasement.so', 
                    'Pool/malloc/libhdbcs.so', 
                    'Pool/NameIdMapping/RoDict',
                    'Pool/RowEngine/CpbTree',
                    'StackAllocator'
                  )
                ) 
              )
          )
        WHERE
            KEY_FIGURE > 0
        GROUP BY
            SERVER_TIMESTAMP,
            DETAIL,
            KEY_FIGURE_DESCRIPTION,
            TIME_AGGREGATE_BY
       )
    GROUP BY
      TO_CHAR(SERVER_TIMESTAMP, TIME_AGGREGATE_BY),
      DETAIL,
      KEY_FIGURE_DESCRIPTION


ORDER BY
  SAMPLE_TIME DESC,DETAIL 