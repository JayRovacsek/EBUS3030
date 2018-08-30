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

    -- Auto-generated query to fix error of type: Staff.Id Mismatch
    -- Should resolved error identified by UUID: dcf16fba08c63ecc85556c385204d9524ec359cf
    UPDATE Assignment1Data 
    SET Reciept_Id=(
    SELECT MAX(Reciept_Id)+1 
    FROM Assignment1Data)
    WHERE Reciept_Id=52136
    AND Customer_Id = 'C13' AND Staff_Id = 'S4'
GO


    -- Auto-generated query to fix error of type: Staff.Id Mismatch
    -- Should resolved error identified by UUID: 7d3e70ee6ef8209d1db122d4fceb373e47aa1f8d
    UPDATE Assignment1Data 
    SET Reciept_Id=(
    SELECT MAX(Reciept_Id)+1 
    FROM Assignment1Data)
    WHERE Reciept_Id=52137
    AND Customer_Id = 'C27' AND Staff_Id = 'S4'
GO


    -- Auto-generated query to fix error of type: Staff.Id Mismatch
    -- Should resolved error identified by UUID: 70e3e1589ab2bc49dc3f9304989f0287dce4d6f4
    UPDATE Assignment1Data 
    SET Reciept_Id=(
    SELECT MAX(Reciept_Id)+1 
    FROM Assignment1Data)
    WHERE Reciept_Id=52138
    AND Customer_Id = 'C29' AND Staff_Id = 'S13'
GO


    -- Auto-generated query to fix error of type: Staff.Id Mismatch
    -- Should resolved error identified by UUID: 82ad9513d5ecca56781792616c984ec9c8be5ea6
    UPDATE Assignment1Data 
    SET Reciept_Id=(
    SELECT MAX(Reciept_Id)+1 
    FROM Assignment1Data)
    WHERE Reciept_Id=52139
    AND Customer_Id = 'C31' AND Staff_Id = 'S20'
GO


    -- Auto-generated query to fix error of type: Staff.Id Mismatch
    -- Should resolved error identified by UUID: ed4f4ad220daefe924c57a5a1d2db32c8f85632d
    UPDATE Assignment1Data 
    SET Reciept_Id=(
    SELECT MAX(Reciept_Id)+1 
    FROM Assignment1Data)
    WHERE Reciept_Id=52140
    AND Customer_Id = 'C38' AND Staff_Id = 'S4'
GO


    -- Auto-generated query to fix error of type: Staff.Id Mismatch
    -- Should resolved error identified by UUID: 6adb3e46388368db3dd98d5f2557ed6a7947b39a
    UPDATE Assignment1Data 
    SET Reciept_Id=(
    SELECT MAX(Reciept_Id)+1 
    FROM Assignment1Data)
    WHERE Reciept_Id=52141
    AND Customer_Id = 'C42' AND Staff_Id = 'S7'
GO


    -- Auto-generated query to fix error of type: Staff.Id Mismatch
    -- Should resolved error identified by UUID: 42c42e141d1c95ccaaf09b48e51706584f0c494b
    UPDATE Assignment1Data 
    SET Reciept_Id=(
    SELECT MAX(Reciept_Id)+1 
    FROM Assignment1Data)
    WHERE Reciept_Id=52142
    AND Customer_Id = 'C46' AND Staff_Id = 'S8'
GO


    -- Auto-generated query to fix error of type: Staff.Id Mismatch
    -- Should resolved error identified by UUID: 4b9b1f1978a7bf4e6b2b0b2867b94c499c74b18b
    UPDATE Assignment1Data 
    SET Reciept_Id=(
    SELECT MAX(Reciept_Id)+1 
    FROM Assignment1Data)
    WHERE Reciept_Id=52143
    AND Customer_Id = 'C8' AND Staff_Id = 'S13'
GO


    -- Auto-generated query to fix error of type: Staff.Id Mismatch
    -- Should resolved error identified by UUID: 69ce62117281095107a047d92a64b60142f131e8
    UPDATE Assignment1Data 
    SET Reciept_Id=(
    SELECT MAX(Reciept_Id)+1 
    FROM Assignment1Data)
    WHERE Reciept_Id=52144
    AND Customer_Id = 'C11' AND Staff_Id = 'S10'
GO


    -- Auto-generated query to fix error of type: Staff.Id Mismatch
    -- Should resolved error identified by UUID: 1bf57bb861bae16e944a60cd2639377ab03c057a
    UPDATE Assignment1Data 
    SET Reciept_Id=(
    SELECT MAX(Reciept_Id)+1 
    FROM Assignment1Data)
    WHERE Reciept_Id=52145
    AND Customer_Id = 'C21' AND Staff_Id = 'S8'
GO


    -- Auto-generated query to fix error of type: Staff.Id Mismatch
    -- Should resolved error identified by UUID: ff56d8aa2e22e4811b22bd702cc7f65b627f778d
    UPDATE Assignment1Data 
    SET Reciept_Id=(
    SELECT MAX(Reciept_Id)+1 
    FROM Assignment1Data)
    WHERE Reciept_Id=52146
    AND Customer_Id = 'C38' AND Staff_Id = 'S5'
GO


    -- Auto-generated query to fix error of type: Staff.Id Mismatch
    -- Should resolved error identified by UUID: 8fa388245a23b7634caad69666133819a485eda3
    UPDATE Assignment1Data 
    SET Reciept_Id=(
    SELECT MAX(Reciept_Id)+1 
    FROM Assignment1Data)
    WHERE Reciept_Id=52147
    AND Customer_Id = 'C40' AND Staff_Id = 'S18'
GO


    -- Auto-generated query to fix error of type: Staff.Id Mismatch
    -- Should resolved error identified by UUID: ac84576ce7fc2d4a07b0824bad51491c3ab9756b
    UPDATE Assignment1Data 
    SET Reciept_Id=(
    SELECT MAX(Reciept_Id)+1 
    FROM Assignment1Data)
    WHERE Reciept_Id=52148
    AND Customer_Id = 'C43' AND Staff_Id = 'S16'
GO


    -- Auto-generated query to fix error of type: Staff.Id Mismatch
    -- Should resolved error identified by UUID: b0465a950d1d6b84198a16f393203fd25056328a
    UPDATE Assignment1Data 
    SET Reciept_Id=(
    SELECT MAX(Reciept_Id)+1 
    FROM Assignment1Data)
    WHERE Reciept_Id=52149
    AND Customer_Id = 'C45' AND Staff_Id = 'S11'
GO


    -- Auto-generated query to fix error of type: Staff.Id Mismatch
    -- Should resolved error identified by UUID: 0cb8d75116359eef2823ef5ffd47d8b2919a0d80
    UPDATE Assignment1Data 
    SET Reciept_Id=(
    SELECT MAX(Reciept_Id)+1 
    FROM Assignment1Data)
    WHERE Reciept_Id=52150
    AND Customer_Id = 'C57' AND Staff_Id = 'S7'
GO



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