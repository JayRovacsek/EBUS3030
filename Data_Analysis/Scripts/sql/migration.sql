USE EBUS3030;

/*
drop table customer
drop table item
drop table office
drop table receipt
drop table receiptitem
drop table staff
*/
-- Create Item table from supplied data.
INSERT INTO Item (ItemId,ItemDescription,ItemPrice)
SELECT DISTINCT([Item_ID]),[Item_Description],[Item_Price]
FROM [Assignment1Data]
ORDER BY [Item_ID];

-- Create Office table from supplied data
INSERT INTO Office (OfficeId, OfficeLocation)
SELECT DISTINCT([Staff_office]),[Office_Location]
FROM [Assignment1Data]
ORDER BY [Staff_office]

-- Create Staff table from supplied data
INSERT INTO Staff ([StaffId], [StaffFirstName],[StaffSurname],[StaffOfficeId])
SELECT DISTINCT([Staff_ID]),[Staff_First_Name],[Staff_Surname],[Staff_office]
FROM [Assignment1Data]
ORDER BY [Staff_office]

-- Create Customer table from supplied data
INSERT INTO Customer ([CustomerId], [CustomerFirstName],[CustomerSurname])
SELECT DISTINCT([Customer_ID]),[Customer_First_Name],[Customer_Surname]
FROM [Assignment1Data]
ORDER BY [Customer_ID]

-- Create Receipt table from supplied data
INSERT INTO Receipt([ReceiptId], [ReceiptCustomerId],[ReceiptStaffId])
SELECT DISTINCT([Reciept_Id]),[Customer_ID],[Staff_ID]
FROM [Assignment1Data]
ORDER BY [Reciept_Id]

-- Nicer method to clean record 51585
UPDATE Assignment1Data 
SET Reciept_Id=51585, 
Reciept_Transaction_Row_ID=(
    SELECT MAX(Reciept_Transaction_Row_ID)+1 
    FROM Assignment1Data
    WHERE Reciept_Id=51585)
WHERE Customer_ID='C32' 
AND Staff_ID='S15' 
AND Sale_Date='2017-11-12 00:00:00.0000000' 
AND Item_ID='14';
GO

-- Almost working cleaning of records 52137 - 52150
WITH CTE AS
(
	SELECT ROW_NUMBER() OVER (ORDER BY Reciept_Id) AS RowNumber,
			Reciept_Id,
			Customer_ID,
			Staff_ID
	FROM  Assignment1Data
	where Reciept_Id between 52137 and 52150
	group by Reciept_Id, Customer_ID,Staff_ID 
 )
SELECT * FROM Assignment1Data
--UPDATE Assignment1Data
--SET Reciept_Id=(SELECT MAX(Reciept_Id)+(1*(SELECT RowNumber FROM CTE))) FROM Assignment1Data
WHERE Reciept_Id = (SELECT Reciept_Id FROM CTE where (RowNumber % 2 = 0)
AND Customer_ID = (SELECT Customer_ID FROM CTE where (RowNumber % 2 = 0)))

-- Working CTE query for the broken records in 52137 - 52150
WITH CTE AS
(
	SELECT ROW_NUMBER() OVER (ORDER BY Reciept_Id) AS RowNumber,
			Reciept_Id,
			Customer_ID,
			Staff_ID
	FROM  Assignment1Data
	where Reciept_Id between 52137 and 52150
	group by Reciept_Id, Customer_ID,Staff_ID 
 )
SELECT Reciept_Id,Customer_ID,Staff_ID FROM CTE where (RowNumber % 2 = 0)

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

-- Cleaned up syntax dataclean script;
Use [EBUS3030]
GO

INSERT INTO Receipt([ReceiptId], [ReceiptCustomerId],[ReceiptStaffId]) 
SELECT DISTINCT([Reciept_Id]),[Customer_ID],[Staff_ID] 
FROM [Assignment1Data] 
ORDER BY [Reciept_Id]
GO

UPDATE Assignment1Data 
SET Reciept_Id=51585, 
Reciept_Transaction_Row_ID=(
    SELECT MAX(Reciept_Transaction_Row_ID)+1 
    FROM Assignment1Data
    WHERE Reciept_Id=51585)
WHERE Customer_ID='C32' 
AND Staff_ID='S15' 
AND Sale_Date='2017-11-12 00:00:00.0000000' 
AND Item_ID='14';
GO