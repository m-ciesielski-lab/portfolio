# Dynamic Data Masking in SQL Server  :lock:

## Resources  :point_down:

**OFFICIAL DOCUMANTATION**: https://docs.microsoft.com/en-us/sql/relational-databases/security/dynamic-data-masking?view=sql-server-ver15

* https://pl.seequality.net/sql-server-2016-dynamic-data-masking/
* https://www.sqlshack.com/understanding-dynamic-data-masking-in-sql-server/
* https://www.sqlshack.com/using-dynamic-data-masking-in-sql-server-2016-to-protect-sensitive-data/
* https://www.codeproject.com/Articles/1084808/Dynamic-Data-Masking-in-SQL-Server
* https://clausvisby.com/pl/1691-beginner8217s-guide-to-dynamic-data-masking-in-sql-server.html
* https://www.tech-recipes.com/rx/69378/beginners-guide-to-dynamic-data-masking-in-sql-server/
* https://solutioncenter.apexsql.com/how-to-mask-sql-server-data-using-dynamic-data-masking/
* https://docs.rackspace.com/blog/dynamic-data-masking-in-sql-server-2016/
* https://www.red-gate.com/simple-talk/sql/sql-development/encrypting-sql-server-dynamic-data-masking/
* https://www.youtube.com/watch?v=sK6iDIKjoUc
* https://www.youtube.com/watch?v=wqjzrL7rbdw

Test data: https://www.generatedata.com

## Testing data

![Type date](https://i.imgur.com/ljMUpUj.jpg)

## Create Users as Marcin and Joanna
```sql
DROP USER IF EXISTS Marcin;
CREATE USER Marcin WITHOUT LOGIN
GRANT SELECT ON MaskingTable TO Marcin
GO

DROP USER IF EXISTS Joanna;
CREATE USER Joanna WITHOUT LOGIN
GRANT SELECT ON MaskingTable TO Joanna
GO
```
![Type date](https://i.imgur.com/OIcfytH.jpg)


## Basic syntax
```
ALTER TABLE [Table Name] ALTER COLUMN [Column Name] 
ADD MASKED WITH (FUNCTION = '[masking function]')
```

### Default data masking 
```
(FUNCTION ='default()')

Example:
ALTER TABLE [dbo].[MaskingTable] ALTER COLUMN [FirstName] ADD MASKED WITH (FUNCTION = 'default()')
```
![Type date](https://i.imgur.com/yEeCXXQ.jpg)

### Default data masking for date and time data types
```
(FUNCTION ='default()')

Example:
ALTER TABLE [dbo].[MaskingTable] ALTER COLUMN [DateOfBirth] ADD MASKED WITH (FUNCTION = 'default()')
```
![Type date](https://i.imgur.com/MAALXlk.jpg)

### Email data masking 
```
(FUNCTION = 'email()')

Example:
ALTER TABLE [dbo].[MaskingTable] ALTER COLUMN [Email] ADD MASKED WITH (FUNCTION = 'email()')
```
![Type date](https://i.imgur.com/3K8XMKc.jpg)

### Partial data masking 
```
(FUNCTION = 'partial(prefix,[padding],suffix)')

Example:
ALTER TABLE [dbo].[MaskingTable] ALTER COLUMN [Phone] ADD MASKED WITH (FUNCTION = 'partial(3,"-XXX-XXX",0)')
```
![Type date](https://i.imgur.com/H82rjfw.jpg)

### Random data masking 
```
(FUNCTION = 'random([start range], [end range])') 

Example:
ALTER TABLE [dbo].[MaskingTable] ALTER COLUMN [LoginID] ADD MASKED WITH (FUNCTION = 'random(100, 200)')
```
![Type date](https://i.imgur.com/1fLjkcI.jpg)


### Dropping Mask
```
ALTER TABLE [Table Name] ALTER COLUMN [Column Name] DROP MASKED

Example:
ALTER TABLE [dbo].[MaskingTable] ALTER COLUMN [Email] DROP MASKED 
```

### :round_pushpin: Querying for Masked Columns
```
SELECT c.name, tbl.name as table_name, c.is_masked, c.masking_function  
FROM sys.masked_columns AS c  
JOIN sys.tables AS tbl   
    ON c.object_id = tbl.object_id
WHERE is_masked = 1; 
```
![Type date](https://i.imgur.com/0dQhDgg.jpg)

### Permissions to View Unmasked Data

```
GRANT UNMASK TO Marcin;
GO

EXECUTE AS USER = 'Marcin';
	SELECT * FROM MaskingTable;
REVERT;

EXECUTE AS USER = 'Joanna';
	SELECT * FROM MaskingTable;
REVERT;
```

Results:

![Type date](https://i.imgur.com/9OF89Kt.jpeg)



