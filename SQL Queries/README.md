# Dynamic Data Masking in SQL Server :thumbsup:

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

## Basic syntax

```
Alter table [Table Name] Alter Column [Column Name] 
ADD MASKED WITH (FUNCTION=’[masking function]’)
```
