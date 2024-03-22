SELECT TOP (1000) [Price Period]
      ,[TOWN]
      ,[Super Petrol]
      ,[Diesel]
      ,[Kerosene]
  FROM [FuelProject].[dbo].[July]


Select *
FROM FuelProject.dbo.july

--Avg fuel prices in July

SELECT AVG(Petrol) AS AVGPetrol,
       AVG(Diesel) AS AVGDiesel,
	   AVG(Kerosene) AS AVGKerosene
FROM FuelProject.dbo.july

--towns with highest price per litre

SELECT Towns, Petrol, Diesel
FROM FuelProject.dbo.july
ORDER BY Petrol DESC