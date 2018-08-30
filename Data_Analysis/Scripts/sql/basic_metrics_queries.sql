-- How many unique receipts are there?
SELECT COUNT(DISTINCT Reciept_Id) FROM Assignment1Data

-- Some basic queries for us to determine potential outlier data:
	-- What is the max of each column where datatype is int?
	SELECT	MAX(Reciept_Id) AS 'Max RecieptId', 
			MAX(Staff_office) AS 'Max Staff_Office', 
			MAX(Reciept_Transaction_Row_ID) AS 'Max Reciept_Transaction_Row_ID', 
			MAX(Item_ID) AS 'Max Item_ID', 
			MAX(Item_Quantity) AS 'Max Item_Quantity', 
			MAX(Item_Price) AS 'Max Item_Price'
	FROM Assignment1Data;

	-- What is the min of each column where datatype is int?
	SELECT	MIN(Reciept_Id) AS 'Min RecieptId', 
			MIN(Staff_office) AS 'Min Staff_Office', 
			MIN(Reciept_Transaction_Row_ID) AS 'Min Reciept_Transaction_Row_ID', 
			MIN(Item_ID) AS 'Min Item_ID', 
			MIN(Item_Quantity) AS 'Min Item_Quantity', 
			MIN(Item_Price) AS 'Min Item_Price'
	FROM Assignment1Data;

-- Unique Staff Id List
SELECT DISTINCT Staff_ID 
FROM Assignment1Data
ORDER BY Staff_ID;

-- Staff Id Count to confirm no broken data
SELECT COUNT(DISTINCT Staff_ID) as 'Unique Staff Count'
FROM Assignment1Data;

-- Determine current max varchar used in Item_Description
SELECT MAX(DATALENGTH(Item_Description)) 
FROM Assignment1Data;