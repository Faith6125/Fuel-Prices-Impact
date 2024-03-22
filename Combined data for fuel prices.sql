-- Creating a new table to store the combined data from the 3 excel files

CREATE TABLE CombinedFuelData (
    Month VARCHAR(20),
    Town VARCHAR(100),
    Petrol DECIMAL(10, 2),
    Diesel DECIMAL(10, 2)
);
-- Inserting data from May table into CombinedFuelData


INSERT INTO CombinedFuelData (Month, Town, Petrol, Diesel)
SELECT 'May' AS Month, Towns, Petrol, Diesel
FROM FuelProject.dbo.May
   WHERE Petrol is not null

   -- Inserting data from June table into CombinedFuelData

INSERT INTO CombinedFuelData (Month, Town, Petrol, Diesel)
SELECT 'June' AS Month, Towns, Petrol, Diesel
FROM FuelProject.dbo.June
  WHERE Petrol is not null

  -- Inserting data from July table into CombinedFuelData

INSERT INTO CombinedFuelData (Month, Town, Petrol, Diesel)
SELECT 'July' AS Month, Towns, Petrol, Diesel
FROM FuelProject.dbo.july

SELECT*
FROM CombinedFuelData

--avg petrol and diesel for the 3 months combined


SELECT AVG(Petrol) AS Avgpetrol, AVG(Diesel) AS Avgdiesel
FROM CombinedFuelData

--avg fuel prices in each month


SELECT Month, AVG(Petrol) AS Avgpetrol, AVG(Diesel) AS Avgdiesel
FROM CombinedFuelData
GROUP BY Month
ORDER BY Avgpetrol 

--Identifying trends and patterns


SELECT Month, Town, Petrol, Diesel
FROM CombinedFuelData
WHERE Town IN ('Mombasa', 'Nairobi')


--Price Variations by Town
--towns with the highest and lowest average fuel prices 


SELECT
    Town,
    AVG(CASE WHEN Month = 'May' THEN Petrol END) AS Avg_Petrol_May,
    AVG(CASE WHEN Month = 'June' THEN Petrol END) AS Avg_Petrol_June,
    AVG(CASE WHEN Month = 'July' THEN Petrol END) AS Avg_Petrol_July,
    AVG(CASE WHEN Month = 'May' THEN Diesel END) AS Avg_Diesel_May,
    AVG(CASE WHEN Month = 'June' THEN Diesel END) AS Avg_Diesel_June,
    AVG(CASE WHEN Month = 'July' THEN Diesel END) AS Avg_Diesel_July
FROM
    CombinedFuelData
GROUP BY
    Town;


--correlation between petrol and diesel prices


WITH Averages AS (
    SELECT
        Town,
        AVG(Petrol) AS Avg_Petrol,
        AVG(Diesel) AS Avg_Diesel
    FROM
        CombinedFuelData
    GROUP BY
        Town
)
SELECT
    cf.Town,
    CASE
        WHEN SUM(POWER(cf.Petrol - av.Avg_Petrol, 2)) = 0 OR SUM(POWER(cf.Diesel - av.Avg_Diesel, 2)) = 0 THEN NULL
        ELSE
            SUM((cf.Petrol - av.Avg_Petrol) * (cf.Diesel - av.Avg_Diesel)) / 
            (COUNT(*) * SQRT(SUM(POWER(cf.Petrol - av.Avg_Petrol, 2))) * SQRT(SUM(POWER(cf.Diesel - av.Avg_Diesel, 2))))
    END AS Correlation
FROM
    CombinedFuelData cf
JOIN
    Averages av ON cf.Town = av.Town
GROUP BY
    cf.Town;