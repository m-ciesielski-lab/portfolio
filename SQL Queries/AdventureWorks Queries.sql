USE [AdventureWorks]
GO

-- Pokaż wszystkie zamówienia z grudnia 2013 roku
SELECT * 
FROM Sales.SalesOrderHeader
WHERE [OrderDate] BETWEEN '20131201' AND '20131231';

--Pokaż adresy email wszystkich pracowników działu Sprzedaży
select HRD.Name, HRD.GroupName, PP.FirstName, PP.LastName, PEA.EmailAddress
from [Person].[Person] AS PP
INNER JOIN [Person].[EmailAddress] AS PEA
ON PP.BusinessEntityID=PEA.BusinessEntityID
INNER JOIN [HumanResources].[EmployeeDepartmentHistory] AS HRE
ON PEA.BusinessEntityID=HRE.BusinessEntityID
INNER JOIN [HumanResources].[Department] AS HRD
ON HRE.DepartmentID=HRD.DepartmentID
WHERE HRD.Name ='Sales'

--Pokaż 25 pierwszych pracowników których imię rozpoczyna się od litery Z
SELECT	top 25 FirstName as Imię, LastName as Nazwisko
FROM	[Person].[Person]
WHERE	FirstName LIKE 'Z%';

--Pokaż spis pracowników
SELECT	P.FirstName, P.LastName, HRE.JobTitle
FROM	[Person].[Person] as P
INNER JOIN [HumanResources].[Employee] as HRE
ON		P.[BusinessEntityID] = HRE.[BusinessEntityID];

--Pokaż stanowisko managerów w firmie
SELECT	P.FirstName, P.LastName, HRE.JobTitle
FROM	[Person].[Person] as P
INNER JOIN [HumanResources].[Employee] as HRE
ON		P.[BusinessEntityID] = HRE.[BusinessEntityID]
WHERE HRE.JobTitle LIKE '%Manager%';

--Policz ilu jest managerów w firmie
SELECT	COUNT(*)
FROM	[Person].[Person] as P
INNER JOIN [HumanResources].[Employee] as HRE
ON		P.[BusinessEntityID] = HRE.[BusinessEntityID]
WHERE HRE.JobTitle LIKE '%Manager%';

-- Pokaż najmłodszego managera w firmie
SELECT	TOP 1 P.FirstName, P.LastName, HRE.Gender, HRE.JobTitle, HRE.BirthDate
FROM	[Person].[Person] as P
INNER JOIN [HumanResources].[Employee] as HRE
ON		P.[BusinessEntityID] = HRE.[BusinessEntityID]
WHERE HRE.JobTitle LIKE '%Manager%'
ORDER BY HRE.BirthDate DESC;

--Pokaż domowy numer telefonu pracownika Amanda Adams
SELECT	P.FirstName, P.LastName,PP.PhoneNumber,PNT.Name
FROM	[Person].[Person] AS P
INNER JOIN	[Person].[PersonPhone] as PP
ON	P.BusinessEntityID=PP.BusinessEntityID
INNER JOIN	[Person].[PhoneNumberType] AS PNT
ON	PP.PhoneNumberTypeID=PNT.PhoneNumberTypeID
WHERE	PNT.Name = 'Home' AND P.FirstName ='Amanda' AND P.LastName = 'Adams';

-- Pokaż ile zostało złożonych zamówień na produkt o numerze ID 870 (butelka wody)
select	S.ProductID, P.[Name], COUNT([OrderQty]) AS [Orders]
FROM Sales.SalesOrderDetail AS S
INNER JOIN [Sales].[SpecialOffer] AS SO
ON SO.[SpecialOfferID] = S.SpecialOfferID
INNER JOIN [Production].[Product] AS p ON P.[ProductID] = S.ProductID
where P.ProductID = 870
GROUP BY S.ProductID, p.[Name];

-- Pokaż zamówienia w podziale na zastosowane zniżki (wynik zaokrąglij)
select	S.ProductID, P.[Name], SO.[Description], SO.DiscountPct, COUNT([OrderQty]) AS [Orders], CONVERT(int,ROUND(SUM(LineTotal),0)) AS SubTotal
FROM Sales.SalesOrderDetail AS S
INNER JOIN [Sales].[SpecialOffer] AS SO
ON SO.[SpecialOfferID] = S.SpecialOfferID
INNER JOIN [Production].[Product] AS p ON P.[ProductID] = S.ProductID
where P.ProductID = 870
GROUP BY S.ProductID, p.[Name], SO.[Description], SO.DiscountPct
ORDER BY [Orders] DESC;