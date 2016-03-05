-- refazer indices

DECLARE @name varchar(256), @id int,
@campo varchar(10)
 	
DECLARE TABELA SCROLL CURSOR FOR
	  	SELECT name
			FROM sysobjects
			WHERE xtype = 'U' AND name like '%010' 

	OPEN TABELA

	FETCH FIRST FROM TABELA INTO  @name 

	WHILE @@FETCH_STATUS = 0
		BEGIN

		EXEC('SELECT COUNT(*) FROM '+ @name)
		IF @@ROWCOUNT >0
		BEGIN	
			DBCC DBREINDEX (@name, '', 0)
		END

		FETCH NEXT FROM TABELA INTO @name

		END

	CLOSE TABELA
	DEALLOCATE TABELA



