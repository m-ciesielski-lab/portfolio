use [AdventureWorks]
go

IF EXISTS(SELECT 1 FROM sys.tables WHERE object_id = OBJECT_ID('MaskingTable'))
BEGIN;
    DROP TABLE [MaskingTable];
END;
GO

-- Testing Table
CREATE TABLE [MaskingTable] (
    [LoginID] INTEGER PRIMARY KEY,
    [FirstName] VARCHAR(255),
    [LastName] VARCHAR(255),
    [DateOfBirth] DATE NOT NULL,
    [Email] VARCHAR(255) NULL,
    [Phone] VARCHAR(100) NULL,
    [Address] VARCHAR(255) NULL,
    [PostalCode] VARCHAR(10) NULL,
    [Country] VARCHAR(100) NULL,
    [City] VARCHAR(255) NULL,
    [CreditCardNumber] VARCHAR(255) NULL,
);
GO

INSERT INTO MaskingTable([LoginID],[FirstName],[LastName],[DateOfBirth],[Email],[Phone],[Address],[PostalCode],[Country],[City],[CreditCardNumber]) VALUES
	(48460,'Florence','Lawson','04/01/1981','ut@odio.ca','465-062-642','P.O. Box 629, 9753 Dui. Street','70341','Congo, the Democratic Republic of the','Montemesola','5392 1510 9808 6594'),
	(54646,'Alana','Case','04/16/1990','sed.leo.Cras@idmollis.co.uk','711-340-749','6903 Amet St.','6535','Rwanda','Stavoren','5141 2912 1575 8917'),
	(94167,'Ann','Nunez','12/02/1965','facilisis@lobortisClassaptent.org','576-821-405','P.O. Box 195, 621 Nunc Av.','7753','Slovakia','Coquitlam','5382 2807 6814 5273'),
	(75973,'Kenyon','Clements','01/24/1990','eget.magna@magnisdis.edu','102-162-448','903-4996 Eget St.','Z9355','Guyana','Argyle','5113 8114 6661 7720'),
	(76949,'Acton','Hartman','02/02/1973','aptent@odiovel.edu','841-291-072','P.O. Box 643, 6257 Velit. Ave','83091','Jordan','Penza','5292 2327 2694 2498'),
	(53633,'Adena','Logan','01/30/1999','pede.blandit@Donectempor.ca','463-022-232','595-976 At Street','113945','Viet Nam','Gurgaon','5350 3145 7045 1542'),
	(94376,'Allistair','Oneil','04/30/1997','nisi.magna.sed@tristique.com','396-376-674','Ap #111-5602 Diam Rd.','18066-317','Macao','Gjoa Haven','5184 6656 2311 9390'),
	(89162,'Kim','Gamble','10/04/1966','neque.tellus.imperdiet@elitsedconsequat.edu','793-711-953','8870 Eu Rd.','22931','Moldova','Huntsville','5213 3390 2506 1924'),
	(93671,'Reed','Wheeler','09/30/1974','in.consectetuer.ipsum@eutellus.edu','432-191-373','Ap #584-957 Netus Road','66431','Morocco','Bevilacqua','5122 2660 6504 0536'),
	(20551,'Howard','Garcia','10/02/1974','sociis.natoque.penatibus@nuncid.net','522-868-528','589-232 Pellentesque Road','2732','Trinidad and Tobago','Surazh','5281 5439 2596 5996'),
	(93302,'Edward','Buck','04/16/1982','mauris@Suspendisse.net','855-827-495','344-7575 Convallis, Street','68659','Iran','Boo','5209 4539 7225 7710'),
	(21796,'Uriah','Blackwell','06/29/1971','adipiscing@aliquameuaccumsan.co.uk','981-249-391','Ap #132-2346 Donec Av.','17821','Guatemala','Lusevera','5259 5915 6652 4174'),
	(46932,'Chadwick','Russo','08/23/1994','dolor.Fusce@sapiencursusin.co.uk','375-780-875','249-1107 Quis Av.','1915','Pakistan','Dillingen','5279 6464 3595 5029'),
	(12697,'Hyatt','Mcknight','03/05/1983','amet.ante.Vivamus@telluseu.edu','675-380-468','Ap #744-5811 Mollis. Rd.','511190','Benin','Waalwijk','5541 4598 5937 5902'),
	(73194,'Carlos','Long','01/12/1980','aliquet.magna.a@sapien.edu','335-056-086','192-6390 Vel, St.','044947','France','Kingston-on-Thames','5359 5883 1228 1074'),
	(84061,'Lunea','Browning','09/28/1996','erat@leo.edu','679-979-875','2676 Eget Avenue','31417','Kenya','Lanco','5410 5554 5812 7715'),
	(86222,'Caryn','Owens','05/30/1987','dignissim.magna@Donec.ca','948-766-998','200-4678 Nunc Rd.','86416','Dominica','Molfetta','5337 5173 7166 2228'),
	(52960,'Kasimir','Adkins','07/19/1964','et@ornareInfaucibus.net','503-421-931','Ap #847-4849 Sit St.','70-113','Benin','Troon','5207 5481 4899 6919'),
	(29012,'Neville','Hines','08/23/1985','risus@variusorciin.org','423-121-984','9951 Orci Ave','P29 8CL','Georgia','Longchamps','5271 6000 3252 6426'),
	(59452,'Jamal','Quinn','08/05/1993','Donec.tempus@Aliquamnisl.com','753-059-319','P.O. Box 349, 2254 Rhoncus. Rd.','L77 3IF','Tuvalu','Chambord','5505 3511 5569 8422');


select *
from [dbo].[MaskingTable];

-- Created and granted SELECT permission to user Marcin and Joanna. Queries executed as the MaskingTable view masked data.

DROP USER IF EXISTS Marcin;
CREATE USER Marcin WITHOUT LOGIN
GRANT SELECT ON MaskingTable TO Marcin
GO

DROP USER IF EXISTS Joanna;
CREATE USER Joanna WITHOUT LOGIN
GRANT SELECT ON MaskingTable TO Joanna
GO


--Data masking for column FirstName, Email, Phone, LoginID, DateOfBirth, CreditCardNumber
ALTER TABLE [dbo].[MaskingTable] ALTER COLUMN [FirstName] ADD MASKED WITH (FUNCTION = 'default()')
ALTER TABLE [dbo].[MaskingTable] ALTER COLUMN [Email] ADD MASKED WITH (FUNCTION = 'email()')
ALTER TABLE [dbo].[MaskingTable] ALTER COLUMN [Phone] ADD MASKED WITH (FUNCTION = 'partial(3,"-XXX-XXX",0)')
ALTER TABLE [dbo].[MaskingTable] ALTER COLUMN [LoginID] ADD MASKED WITH (FUNCTION = 'random(100, 200)')
ALTER TABLE [dbo].[MaskingTable] ALTER COLUMN [DateOfBirth] ADD MASKED WITH (FUNCTION = 'default()')
ALTER TABLE [dbo].[MaskingTable] ALTER COLUMN [CreditCardNumber] ADD MASKED WITH (FUNCTION = 'partial(0,"XXX",4)')


EXECUTE AS USER = 'Marcin';
	SELECT * FROM MaskingTable;
REVERT;


--Change data masking for column FirstName. Use partial data masking. So after this we can see only first 3 letters of name. Rest of will be masked be XXX
ALTER TABLE [dbo].[MaskingTable] ALTER COLUMN [FirstName] VARCHAR(255) MASKED WITH (FUNCTION = 'partial(3, "XXX",0)')

EXECUTE AS USER = 'Marcin';
	SELECT * FROM MaskingTable;
REVERT;

EXECUTE AS USER = 'Joanna';
	SELECT * FROM MaskingTable;
REVERT;

-- Delete Masking 
ALTER TABLE [dbo].[MaskingTable] ALTER COLUMN [LoginID] DROP MASKED 
GO

-- Querying for Masked Columns
SELECT c.name, tbl.name as table_name, c.is_masked, c.masking_function  
FROM sys.masked_columns AS c  
JOIN sys.tables AS tbl   
    ON c.object_id = tbl.object_id
WHERE is_masked = 1;  


--Granting permissions to View Unmasked Data
GRANT UNMASK TO Marcin;
GO

EXECUTE AS USER = 'Marcin';
	SELECT * FROM MaskingTable;
REVERT;

EXECUTE AS USER = 'Joanna';
	SELECT * FROM MaskingTable;
REVERT;

--Delete permission
REVOKE UNMASK TO Marcin
GO;