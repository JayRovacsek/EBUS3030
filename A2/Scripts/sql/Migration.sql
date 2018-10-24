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
Set TotalPrice = r.TotalPrice + (SELECT SUM(SalePrice * ReceiptItemQuantity) FROM ReceiptItem ri WHERE  r.ReceiptID = ri.ReceiptID)
FROM Receipt r
GO

--Adds Discount price to receipt
UPDATE Receipt 
Set DiscountPrice = TotalPrice *.95
WHERE (SELECT SUM(ReceiptItemQuantity) FROM ReceiptItem ri WHERE Receipt.ReceiptID = ri.ReceiptID) >=5
GO





