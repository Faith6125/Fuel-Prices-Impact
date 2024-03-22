SELECT TOP (1000) [F1]
      ,[15th December 2022 –14th January 2023]
      ,[MAXIMUM PUMP PRICES]
      ,[F4]
      ,[F5]
  FROM [FuelProject].[dbo].[May]

   SELECT *
  FROM FuelProject.dbo.May
  WHERE Petrol is not null

  --Avg fuel prices in May

  SELECT AVG(Petrol) AS AVGPetrol,
       AVG(Diesel) AS AVGDiesel,
	   AVG(Kerosene) AS AVGKerosene
FROM FuelProject.dbo.May
   WHERE Petrol is not null

   --towns with highest price per litre

SELECT Towns, Petrol, Diesel
FROM FuelProject.dbo.May
WHERE Petrol is not null
ORDER BY Petrol DESC
 