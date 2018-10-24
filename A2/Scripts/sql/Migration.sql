USE EBUS3030A2;

/*
DROP TABLE customer
DROP TABLE item
DROP TABLE office
DROP TABLE receipt
DROP TABLE receiptitem
DROP TABLE staff
*/

-- Create Item table from supplied data.
INSERT INTO Item (ItemId,ItemDescription,ShelfPrice)
SELECT DISTINCT [Item_ID],[Item_Description], [Item_Price]
FROM [Assignment2Data]
ORDER BY [Item_ID];
GO

-- Create Office table from supplied data
INSERT INTO Office (OfficeId, OfficeLocation)
SELECT DISTINCT([Staff_office]),[Office_Location]
FROM [Assignment2Data]
ORDER BY [Staff_office]
GO

-- Create Staff table from supplied data
INSERT INTO Staff ([StaffId], [StaffFirstName],[StaffSurname],[StaffOfficeId])
SELECT DISTINCT([Staff_ID]),[Staff_First_Name],[Staff_Surname],[Staff_office]
FROM [Assignment2Data]
ORDER BY [Staff_office]
GO

-- Create Customer table from supplied data
INSERT INTO Customer ([CustomerId], [CustomerFirstName],[CustomerSurname])
SELECT DISTINCT([Customer_ID]),[Customer_First_Name],[Customer_Surname]
FROM [Assignment2Data]
ORDER BY [Customer_ID]
GO

-- Create Receipt table from supplied data
INSERT INTO Receipt([ReceiptId], [ReceiptCustomerId],[ReceiptStaffId], [ReceiptDate])
SELECT DISTINCT([Reciept_Id]),[Customer_ID],[Staff_ID], [Sale_Date]
FROM [Assignment2Data]
ORDER BY [Reciept_Id]
GO

-- Insert into ReceiptItem from supplied data
INSERT INTO ReceiptItem([ReceiptId], [ItemId],[ReceiptItemQuantity],[SalePrice])
SELECT DISTINCT([Reciept_Id]),[Item_ID],[Item_Quantity],[Item_Price]
FROM [Assignment2Data]
ORDER BY [Reciept_Id]
GO

--adds total price to Receipt
UPDATE Receipt
Set Receipt.TotalPrice = (
SELECT SUM(ri.[SalePrice] * ri.[ReceiptItemQuantity]) AS 'Total'
From Receipt r 
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
Where 
);
GO

--Adds discounted price to receipt
UPDATE Receipt
Set Receipt.DiscountPrice = (
SELECT CAST(
		CASE
		WHEN COUNT(ri.[ReceiptItemQuantity]) >= 5
			THEN SUM(ri.[SalePrice] * ri.[ReceiptItemQuantity]) * 0.95
		END AS decimal(19,5)) AS [SalesTotals]
FROM Receipt r
INNER JOIN ReceiptItem ri ON r.ReceiptId = ri.ReceiptId
);
GO

select * from Receipt
select * from ReceiptItem where ReceiptId = 120002