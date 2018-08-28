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


