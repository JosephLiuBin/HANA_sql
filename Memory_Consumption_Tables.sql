SELECT
	OWNER, 
	TABLE_NAME,
	STORE,
	LOADED,
	HOST,
	LPAD(TO_DECIMAL(TOTAL_MEM_MB / 1024, 10, 2), 10) CUR_MEM_GB,
	LPAD(TO_DECIMAL(HOST_USED_MEM_MB / 1024, 10, 2), 10) HOST_USED_MEM_GB,
	LPAD(TO_DECIMAL("TOTAL_MEM_%", 9, 2), 5) "MEM_%",
	LPAD(TO_DECIMAL(SUM("TOTAL_MEM_%") OVER (ORDER BY ROW_NUM), 5, 2), 5) "CUM_%",
	LPAD(TO_DECIMAL(TABLE_MEM_MB / 1024, 10, 2), 10) TAB_MEM_GB,
	LPAD(TO_DECIMAL(INDEX_MEM_MB / 1024, 10, 2), 10) IND_MEM_GB
FROM
(	SELECT
		OWNER,
	    TABLE_NAME,
	    HOST,
        STORE,
	    TABLE_MEM_MB + INDEX_MEM_RS_MB TOTAL_MEM_MB,
	    TABLE_MEM_MB - INDEX_MEM_CS_MB TABLE_MEM_MB,             /* Indexes are contained in CS table size */
	    LOADED,
/*no need to sum all tables
	    (TABLE_MEM_MB +  INDEX_MEM_RS_MB) / SUM(TABLE_MEM_MB + INDEX_MEM_RS_MB) OVER () * 100 "TOTAL_MEM_%",
*/	    
		(TABLE_MEM_MB +  INDEX_MEM_RS_MB) / HOST_USED_MEM_MB * 100 "TOTAL_MEM_%",
	    HOST_USED_MEM_MB,
	    INDEX_MEM_RS_MB + INDEX_MEM_CS_MB INDEX_MEM_MB,    
	    ROW_NUMBER () OVER ( ORDER BY MAP ( ORDER_BY, 
	      'CURRENT_MEM', TABLE_MEM_MB + INDEX_MEM_RS_MB, 
	      'TABLE_MEM',   TABLE_MEM_MB - INDEX_MEM_CS_MB, 
	      'INDEX_MEM',   INDEX_MEM_RS_MB + INDEX_MEM_CS_MB ) 
	      DESC, OWNER,   TABLE_NAME ) ROW_NUM,
		ORDER_BY
	FROM
	(
		SELECT
			T.SCHEMA_NAME OWNER,
			T.TABLE_NAME,
	        TS.HOST,
	        CASE WHEN T.IS_COLUMN_TABLE = 'FALSE' THEN 'ROW' ELSE 'COLUMN' END STORE,
	        T.TABLE_SIZE / 1024 / 1024 TABLE_MEM_MB,
	        HOST_USED_MEM_MB,
	        TS.LOADED,
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
	        BI.ORDER_BY
	    FROM
		( 
			SELECT                                     /* Modification section */
		        'SAPSR3' SCHEMA_NAME,
		        '%' TABLE_NAME,
		        '%' STORE,                             /* ROW, COLUMN, % */
		        'CURRENT_MEM' ORDER_BY                 /* TOTAL_DISK, CURRENT_MEM, MAX_MEM, TABLE_MEM, INDEX_MEM */
	      	FROM
	        	DUMMY
	    ) BI,
	    M_TABLES T,
	    ( 
	    	SELECT 
		        SCHEMA_NAME, 
		        TABLE_NAME, 
		        MAP(MIN(HOST), MAX(HOST), MIN(HOST), 'various') HOST, 
		        MIN(LOADED) LOADED
	        FROM 
	        	M_CS_TABLES 
	        GROUP BY 
		        SCHEMA_NAME, 
		        TABLE_NAME 
	        UNION
	        ( 
	        SELECT 
	            SCHEMA_NAME, 
	            TABLE_NAME, 
	            MAP(MIN(HOST), MAX(HOST), MIN(HOST), 'various') HOST, 
	            'Always Loaded' LOADED
	        FROM 
	            M_RS_TABLES 
	        GROUP BY 
	            SCHEMA_NAME, 
	            TABLE_NAME  
		    )
		) TS,
		(
			SELECT 
				HOST,
				TOTAL_MEMORY_USED_SIZE / 1024 / 1024 AS HOST_USED_MEM_MB
			FROM
				M_SERVICE_MEMORY
			WHERE SERVICE_NAME = 'indexserver'

		) US 
		WHERE 
			T.SCHEMA_NAME LIKE BI.SCHEMA_NAME AND
			T.TABLE_NAME LIKE BI.TABLE_NAME AND
			T.SCHEMA_NAME = TS.SCHEMA_NAME AND
			T.TABLE_NAME = TS.TABLE_NAME AND
			TS.HOST = US.HOST AND
			(	
			BI.STORE = '%' OR
			BI.STORE = 'ROW' AND T.IS_COLUMN_TABLE = 'FALSE' OR
			BI.STORE = 'COLUMN' AND T.IS_COLUMN_TABLE = 'ROW'
			)
			AND 
			T.TABLE_NAME IN 
			('RSSTATMANPARTT', 'RSMONICDP'		/*add table_name here*/
			) 
	)
)
ORDER BY ROW_NUM