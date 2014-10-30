drop procedure DROP_HEW_TRAINEE;
create procedure DROP_HEW_TRAINEE(IN loc nvarchar(20), IN in_num INT)
LANGUAGE SQLSCRIPT SQL security invoker AS
BEGIN
	
    DECLARE i INT default 1;
   	DECLARE userid nvarchar(20) default '';


	WHILE i <= in_num DO
			userid := :loc || :i;
			EXEC 'DROP USER ' || :userid || ' CASCADE';
			i := i + 1;
	END WHILE;
	
END; 
-----------------------------------
call DROP_HEW_TRAINEE('BJ',20);
-----------------------------------
select user_name from USERS where user_name like 'SH%';

drop procedure CREATE_HEW_TRAINEE;
create procedure CREATE_HEW_TRAINEE(IN loc nvarchar(20), IN in_num INT)
LANGUAGE SQLSCRIPT SQL security invoker AS
BEGIN
	
    DECLARE i INT default 1;
	DECLARE userid nvarchar(20) default '';
	userid := :loc ||'0';
	EXEC 'CREATE USER ' || :userid || ' PASSWORD Initial123';
	EXEC 'GRANT HEW_USER_ROLE TO ' || :userid;
	EXEC 'GRANT INTERNAL_ROLE TO ' || :userid;
	
	WHILE i <= in_num DO
			userid := :loc || :i;
			EXEC 'CREATE USER ' || :userid || ' PASSWORD Initial1234';
			EXEC 'GRANT HEW_USER_ROLE TO ' || :userid;			
			i := i + 1;
	END WHILE;
	
END; 
-----------------------------------
call CREATE_HEW_TRAINEE('SH',20);
-----------------------------------

