SELECT 
	C.BACKUP_ID,
	C.SYS_START_TIME,
	C.SYS_END_TIME,
	F.HOST,
	F.BACKUP_SIZE,
	F.SERVICE_TYPE_NAME AS SERVICE_NAME
FROM 
	(SELECT	
		BACKUP_ID,
		SYS_START_TIME,
		SYS_END_TIME,
		STATE_NAME,
		ENTRY_TYPE_NAME
	FROM M_BACKUP_CATALOG 
	) C
	JOIN 
	(SELECT 
		BACKUP_ID,
		HOST,
		BACKUP_SIZE,
		SERVICE_TYPE_NAME
	FROM 
		M_BACKUP_CATALOG_FILES 
	) F
	ON C.BACKUP_ID = F.BACKUP_ID 
WHERE 
	C.ENTRY_TYPE_NAME = 'complete data backup' AND 
	C.STATE_NAME = 'successful' 
ORDER BY SYS_START_TIME DESC,HOST
LIMIT 10