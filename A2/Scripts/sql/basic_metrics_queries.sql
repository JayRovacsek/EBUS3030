USE EBUS3030A2;

-- Determine current max varchar used in Item_Description
SELECT MAX(DATALENGTH(Item_Description)) 
FROM Assignment2Data;

-- Verify that no receipt has duplicate ItemIds and all are unique per order
SELECT *
FROM
(
	SELECT [ReceiptItem].[ReceiptId], 
	COUNT([ReceiptItem].[ReceiptId]) AS 'ItemCount',
	COUNT(DISTINCT [ReceiptItem].[ItemId]) AS 'ItemIdCount'
	FROM [ReceiptItem]
	GROUP BY [ReceiptItem].[ReceiptId]) AS SubQuery 
WHERE [SubQuery].[ItemIdCount] != [SubQuery].[ItemCount]

-- Sales count per staff member (Receipt Count)
SELECT COUNT(*) AS 'Sales Count', s.StaffId,s.StaffFirstName,s.StaffSurname
FROM Receipt r
INNER JOIN ReceiptItem ri ON r.ReceiptId = ri.ReceiptId
INNER JOIN Item i ON i.ItemId = ri.ItemId
INNER JOIN Price p ON p.PriceId = ri.PriceId
INNER JOIN Staff s ON s.StaffId = r.ReceiptStaffId
GROUP BY s.StaffId,s.StaffFirstName,s.StaffSurname
ORDER BY 'Sales Count' DESC;

-- Item count per staff member
SELECT SUM(ri.ReceiptItemQuantity) AS 'Item Count', s.StaffId,s.StaffFirstName,s.StaffSurname
FROM Receipt r
INNER JOIN ReceiptItem ri ON r.ReceiptId = ri.ReceiptId
INNER JOIN Staff s ON s.StaffId = r.ReceiptStaffId
GROUP BY s.StaffId,s.StaffFirstName,s.StaffSurname
ORDER BY 'Item Count' DESC;

-- Sales total per staff with discounts applied ($)
SELECT CAST(
		CASE
		WHEN COUNT(ri.[ReceiptItemQuantity]) >= 5
			THEN SUM(p.[Price] * ri.[ReceiptItemQuantity]) * 0.85
		ELSE SUM(p.[Price] * ri.[ReceiptItemQuantity])
		END AS decimal(19,5)) AS 'Sales Totals',
		 s.StaffId,s.StaffFirstName,s.StaffSurname
FROM Receipt r
INNER JOIN ReceiptItem ri ON r.ReceiptId = ri.ReceiptId
INNER JOIN Item i ON i.ItemId = ri.ItemId
INNER JOIN Price p ON p.PriceId = ri.PriceId
INNER JOIN Staff s ON s.StaffId = r.ReceiptStaffId
INNER JOIN Customer c ON c.CustomerId = r.ReceiptCustomerId
GROUP BY s.StaffId,s.StaffFirstName,s.StaffSurname
ORDER BY 'Sales Totals' DESC;

-- Sales average per staff with discounts applied
SELECT (CAST(
		CASE
		WHEN COUNT(ri.[ReceiptItemQuantity]) >= 5
			THEN SUM(p.[Price] * ri.[ReceiptItemQuantity]) * 0.85
		ELSE SUM(p.[Price] * ri.[ReceiptItemQuantity])
		END AS decimal(19,5)) / COUNT(r.ReceiptId)) AS 'Sales Average',
		 s.StaffId,s.StaffFirstName,s.StaffSurname
FROM Receipt r
INNER JOIN ReceiptItem ri ON r.ReceiptId = ri.ReceiptId
INNER JOIN Item i ON i.ItemId = ri.ItemId
INNER JOIN Price p ON p.PriceId = ri.PriceId
INNER JOIN Staff s ON s.StaffId = r.ReceiptStaffId
GROUP BY s.StaffId,s.StaffFirstName,s.StaffSurname
ORDER BY 'Sales Average' DESC;

-- Sales metrics for discounted and standard sales per staff member
SELECT s.StaffId,s.StaffFirstName,s.StaffSurname,
SUM(SubQuery.[Discounted Sales]) AS 'Discounted Sales',
SUM(SubQuery.[Standard Sales]) AS 'Standard Sales'
FROM (
	SELECT CAST(
		CASE
		WHEN COUNT(ri.[ReceiptItemQuantity]) >= 5
			THEN 1
		ELSE 0
		END AS int) AS 'Discounted Sales',
	CAST(
		CASE
		WHEN COUNT(ri.[ReceiptItemQuantity]) >= 5
			THEN 0
		ELSE 1
	END AS int) AS 'Standard Sales',
	r.ReceiptId
	FROM Receipt r
	INNER JOIN ReceiptItem ri ON r.ReceiptId = ri.ReceiptId
	INNER JOIN Item i ON i.ItemId = ri.ItemId
	INNER JOIN Price p ON p.PriceId = ri.PriceId
	GROUP BY r.ReceiptId
) AS SubQuery
INNER JOIN Receipt r ON SubQuery.ReceiptId = r.ReceiptId
INNER JOIN ReceiptItem ri ON r.ReceiptId = ri.ReceiptId
INNER JOIN Staff s ON s.StaffId = r.ReceiptStaffId
GROUP BY s.StaffId,s.StaffFirstName,s.StaffSurname
ORDER BY [Discounted Sales]

-- Sales average per customer with discounts applied
SELECT (CAST(
		CASE
		WHEN COUNT(ri.[ReceiptItemQuantity]) >= 5
			THEN SUM(p.[Price] * ri.[ReceiptItemQuantity]) * 0.85
		ELSE SUM(p.[Price] * ri.[ReceiptItemQuantity])
		END AS decimal(19,5)) / COUNT(r.ReceiptId)) AS 'Sales Average',
		 c.CustomerId,c.CustomerFirstName,c.CustomerSurname
FROM Receipt r
INNER JOIN ReceiptItem ri ON r.ReceiptId = ri.ReceiptId
INNER JOIN Item i ON i.ItemId = ri.ItemId
INNER JOIN Price p ON p.PriceId = ri.PriceId
INNER JOIN Staff s ON s.StaffId = r.ReceiptStaffId
INNER JOIN Customer c ON c.CustomerId = r.ReceiptCustomerId
GROUP BY c.CustomerId,c.CustomerFirstName,c.CustomerSurname
ORDER BY 'Sales Average' DESC;

-- Item Count By Office Location
SELECT SUM(ri.ReceiptItemQuantity) AS 'Item Count', o.OfficeId, o.OfficeLocation
FROM Receipt r
INNER JOIN ReceiptItem ri ON r.ReceiptId = ri.ReceiptId
INNER JOIN Staff s ON s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on s.StaffOfficeId = o.OfficeId
GROUP BY o.OfficeId, o.OfficeLocation
ORDER BY 'Item Count' DESC;