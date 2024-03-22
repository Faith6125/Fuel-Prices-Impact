SELECT TOP (1000) [15th June 2023- 14th July 2023]
      ,[F2]
      ,[F3]
      ,[F4]
      ,[F5]
  FROM [FuelProject].[dbo].[June]

   SELECT *
  FROM FuelProject.dbo.June
  WHERE Petrol is not null

  --Avg fuel prices in june

 SELECT AVG(Petrol) AS AVGPetrol,
       AVG(Diesel) AS AVGDiesel,
	   AVG(Kerosene) AS AVGKerosene
FROM FuelProject.dbo.June
   WHERE Petrol is not null

     --towns with highest price per litre

SELECT Towns, Petrol, Diesel
FROM FuelProject.dbo.June
WHERE Petrol is not null
ORDER BY Petrol DESC
