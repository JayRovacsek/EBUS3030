/*
** Name: basic_metrics_queries.sql
** Date: 22/10/2018
** Description: querying the database to find information regarding products and sales.
 */

USE EBUS3030A2;

-- Sales Total for all receipts
SELECT SUM(SubQuery.Sales)
FROM (
SELECT CAST(
		CASE
		WHEN r.DiscountPrice > 0
			THEN r.DiscountPrice
		ELSE r.TotalPrice
		END AS decimal(19,5)
		) AS 'Sales'
 FROM Receipt r) AS SubQuery

-- Sales count per staff member (Receipt Count)
SELECT COUNT(*) AS 'Sales Count'
		, s.StaffId
		, s.StaffFirstName
		, s.StaffSurname
		, o.OfficeId
		, o.OfficeLocation
FROM Receipt r
	INNER JOIN ReceiptItem ri
				 ON r.ReceiptId = ri.ReceiptId
	INNER JOIN Item i
				 ON i.ItemId = ri.ItemId
	INNER JOIN Staff s
				 ON s.StaffId = r.ReceiptStaffId
	INNER JOIN Office o
				 ON o.OfficeId = s.StaffOfficeId
GROUP BY s.StaffId
		, s.StaffFirstName
		, s.StaffSurname
		, o.OfficeId
		, o.OfficeLocation
ORDER BY 'Sales Count' DESC;


-- Item count per staff member
SELECT SUM(ri.ReceiptItemQuantity) AS 'Item Count'
		, s.StaffId
		, s.StaffFirstName
		, s.StaffSurname
		, o.OfficeId
		, o.OfficeLocation
FROM Receipt r
	INNER JOIN ReceiptItem ri
					 ON r.ReceiptId = ri.ReceiptId
	INNER JOIN Staff s
					 ON s.StaffId = r.ReceiptStaffId
	INNER JOIN Office o
					 ON o.OfficeId = s.StaffOfficeId
GROUP BY s.StaffId
		, s.StaffFirstName
		, s.StaffSurname
		, o.OfficeId
		, o.OfficeLocation
ORDER BY 'Item Count' DESC;


-- Sales total per staff with discounts applied ($)
SELECT CAST(
		CASE
		WHEN COUNT(ri.[ReceiptItemQuantity]) >= 5
			THEN SUM(ri.[SalePrice] * ri.[ReceiptItemQuantity]) * 0.95
		ELSE SUM(ri.[SalePrice] * ri.[ReceiptItemQuantity])
		END AS decimal(19,5)) AS 'Sales Totals'
		, s.StaffId
		, s.StaffFirstName
		, s.StaffSurname
		, o.OfficeId
		, o.OfficeLocation
FROM Receipt r
	INNER JOIN ReceiptItem ri
				 ON r.ReceiptId = ri.ReceiptId
	INNER JOIN Item i
				 ON i.ItemId = ri.ItemId
	INNER JOIN Staff s
				 ON s.StaffId = r.ReceiptStaffId
	INNER JOIN Customer c
				 ON c.CustomerId = r.ReceiptCustomerId
	INNER JOIN Office o
				 ON o.OfficeId = s.StaffOfficeId
GROUP BY s.StaffId
		, s.StaffFirstName
		, s.StaffSurname
		, o.OfficeId
		, o.OfficeLocation
ORDER BY 'Sales Totals' DESC;


-- Sales average per staff with discounts applied
SELECT (CAST(
		CASE
		WHEN COUNT(ri.[ReceiptItemQuantity]) >= 5
			THEN SUM(ri.[SalePrice] * ri.[ReceiptItemQuantity]) * 0.95
		ELSE SUM(ri.[SalePrice] * ri.[ReceiptItemQuantity])
		END AS decimal(19,5)) / COUNT(r.ReceiptId)) AS 'Sales Average'
		, s.StaffId
		, s.StaffFirstName
		, s.StaffSurname
		, o.OfficeId
		, o.OfficeLocation
	FROM Receipt r
	INNER JOIN ReceiptItem ri
					 ON r.ReceiptId = ri.ReceiptId
	INNER JOIN Item i
					 ON i.ItemId = ri.ItemId
	INNER JOIN Staff s
					 ON s.StaffId = r.ReceiptStaffId
	INNER JOIN Office o
					 ON o.OfficeId = s.StaffOfficeId
GROUP BY s.StaffId
		, s.StaffFirstName
		, s.StaffSurname
		, o.OfficeId
		, o.OfficeLocation
ORDER BY 'Sales Average' DESC;


-- Sales metrics for discounted and standard sales per staff member
SELECT s.StaffId
		, s.StaffFirstName
		, s.StaffSurname
		, o.OfficeId
		, o.OfficeLocation
		, SUM(SubQuery.[Discounted Sales]) AS 'Discounted Sales'
		, SUM(SubQuery.[Standard Sales]) AS 'Standard Sales'
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
		INNER JOIN ReceiptItem ri
					 ON r.ReceiptId = ri.ReceiptId
		INNER JOIN Item i
					 ON i.ItemId = ri.ItemId
	GROUP BY r.ReceiptId
) AS SubQuery
	INNER JOIN Receipt r
				 ON SubQuery.ReceiptId = r.ReceiptId
	INNER JOIN ReceiptItem ri
				 ON r.ReceiptId = ri.ReceiptId
	INNER JOIN Staff s
				 ON s.StaffId = r.ReceiptStaffId
	INNER JOIN Office o
				 ON o.OfficeId = s.StaffOfficeId
GROUP BY s.StaffId
		, s.StaffFirstName
		, s.StaffSurname
		, o.OfficeId
		, o.OfficeLocation
ORDER BY [Discounted Sales];


-- Sales average per customer with discounts applied
SELECT (CAST(
		CASE
		WHEN COUNT(ri.[ReceiptItemQuantity]) >= 5
			THEN SUM(ri.[SalePrice] * ri.[ReceiptItemQuantity]) * 0.95
		ELSE SUM(ri.[SalePrice] * ri.[ReceiptItemQuantity])
		END AS decimal(19,5)) / COUNT(r.ReceiptId)) AS 'Sales Average'
		, c.CustomerId
		, c.CustomerFirstName
		, c.CustomerSurname
FROM Receipt r
	INNER JOIN ReceiptItem ri
				 ON r.ReceiptId = ri.ReceiptId
	INNER JOIN Item i
				 ON i.ItemId = ri.ItemId
	INNER JOIN Staff s
				 ON s.StaffId = r.ReceiptStaffId
	INNER JOIN Customer c
				 ON c.CustomerId = r.ReceiptCustomerId
GROUP BY c.CustomerId
		, c.CustomerFirstName
		, c.CustomerSurname
ORDER BY 'Sales Average' DESC;


-- Item Count, total revenue, average revenue per item sold By Office Location no discount
SELECT SUM(ri.ReceiptItemQuantity) AS ItemCount
		, o.OfficeId
		, o.OfficeLocation
		, SUM(ri.[SalePrice] * ri.[ReceiptItemQuantity]) AS Revenue
		, Cast (SUM(ri.[SalePrice] * ri.[ReceiptItemQuantity]) as decimal)/SUM(ri.ReceiptItemQuantity) as AverageRevenue
FROM Receipt r
	INNER JOIN ReceiptItem ri
				 ON r.ReceiptId = ri.ReceiptId
	INNER JOIN Staff s
				 ON s.StaffId = r.ReceiptStaffId
	INNER JOIN Office o
				 ON s.StaffOfficeId = o.OfficeId
GROUP BY o.OfficeId
		, o.OfficeLocation
ORDER BY ItemCount DESC;


--Staff Count per office
SELECT count(Distinct s.StaffId) AS StaffCount
		, o.OfficeId
		, o.OfficeLocation
FROM Staff s
	INNER JOIN Office o
				 ON o.OfficeId = s.StaffOfficeId
GROUP BY o.OfficeId
		, o.OfficeLocation;

--3 top and bottom items for office 1
SELECT SUM(ri.ReceiptItemQuantity) AS ItemCount
		, i.ItemId
		, i.ItemDescription
		, o.OfficeId
		, o.OfficeLocation
FROM Receipt r
	INNER JOIN ReceiptItem ri
				 ON ri.ReceiptId = r.ReceiptId
	INNER JOIN Item i
				 on i.ItemId = ri.ItemId
	INNER JOIN Staff s
				 on s.StaffId = r.ReceiptStaffId
	INNER JOIN Office o
				 on o.OfficeId = s.StaffOfficeId
WHERE o.OfficeId = 1
GROUP BY i.ItemId
		, i.ItemDescription
		, o.OfficeId
		, o.OfficeLocation
ORDER BY ItemCount ASC;


--3 top and bottom items for office 2
SELECT SUM(ri.ReceiptItemQuantity) AS ItemCount
		, i.ItemId
		, i.ItemDescription
		, o.OfficeId
		, o.OfficeLocation
FROM Receipt r
	INNER JOIN ReceiptItem ri
				 ON ri.ReceiptId = r.ReceiptId
	INNER JOIN Item i
				 on i.ItemId = ri.ItemId
	INNER JOIN Staff s
				 on s.StaffId = r.ReceiptStaffId
	INNER JOIN Office o
				 on o.OfficeId = s.StaffOfficeId
WHERE o.OfficeId = 2
GROUP BY i.ItemId
		, i.ItemDescription
		, o.OfficeId
		, o.OfficeLocation
ORDER BY ItemCount ASC;


--3 top and bottom items for office 3
SELECT SUM(ri.ReceiptItemQuantity) AS ItemCount
		, i.ItemId
		, i.ItemDescription
		, o.OfficeId,
			 o.OfficeLocation
FROM Receipt r
	INNER JOIN ReceiptItem ri
				 ON ri.ReceiptId = r.ReceiptId
	INNER JOIN Item i
				 on i.ItemId = ri.ItemId
	INNER JOIN Staff s
				 on s.StaffId = r.ReceiptStaffId
	INNER JOIN Office o
				 on o.OfficeId = s.StaffOfficeId
WHERE o.OfficeId = 3
GROUP BY i.ItemId, i.ItemDescription, o.OfficeId, o.OfficeLocation
ORDER BY ItemCount asc;


--3 top and bottom items for office 4
SELECT SUM(ri.ReceiptItemQuantity) AS ItemCount
		, i.ItemId
		, i.ItemDescription
		, o.OfficeId
		, o.OfficeLocation
FROM Receipt r
	INNER JOIN ReceiptItem ri
				 ON ri.ReceiptId = r.ReceiptId
	INNER JOIN Item i
				 on i.ItemId = ri.ItemId
	INNER JOIN Staff s
				 on s.StaffId = r.ReceiptStaffId
	INNER JOIN Office o
				 on o.OfficeId = s.StaffOfficeId
WHERE o.OfficeId = 4
GROUP BY i.ItemId, i.ItemDescription, o.OfficeId, o.OfficeLocation
ORDER BY ItemCount ASC;


--3 top and bottom items for office 5
SELECT SUM(ri.ReceiptItemQuantity) AS ItemCount
		, i.ItemId
		, i.ItemDescription
		, o.OfficeId
		, o.OfficeLocation
FROM Receipt r
	INNER JOIN ReceiptItem ri
				 ON ri.ReceiptId = r.ReceiptId
	INNER JOIN Item i
				 on i.ItemId = ri.ItemId
	INNER JOIN Staff s
				 on s.StaffId = r.ReceiptStaffId
	INNER JOIN Office o
				 on o.OfficeId = s.StaffOfficeId
WHERE o.OfficeId = 5
GROUP BY i.ItemId, i.ItemDescription, o.OfficeId, o.OfficeLocation
ORDER BY ItemCount ASC;


--3 top and bottom items for office 6
SELECT SUM(ri.ReceiptItemQuantity) AS ItemCount
		, i.ItemId
		, i.ItemDescription
		, o.OfficeId
		, o.OfficeLocation
FROM Receipt r
	INNER JOIN ReceiptItem ri
				 ON ri.ReceiptId = r.ReceiptId
	INNER JOIN Item i
				 on i.ItemId = ri.ItemId
	INNER JOIN Staff s
				 on s.StaffId = r.ReceiptStaffId
	INNER JOIN Office o
				 on o.OfficeId = s.StaffOfficeId
WHERE o.OfficeId = 6
GROUP BY i.ItemId, i.ItemDescription, o.OfficeId, o.OfficeLocation
ORDER BY ItemCount ASC;


--3 top and bottom items for office 7
SELECT SUM(ri.ReceiptItemQuantity) AS ItemCount
		, i.ItemId
		, i.ItemDescription
		, o.OfficeId
		, o.OfficeLocation
FROM Receipt r
	INNER JOIN ReceiptItem ri
				 ON ri.ReceiptId = r.ReceiptId
	INNER JOIN Item i
				 on i.ItemId = ri.ItemId
	INNER JOIN Staff s
				 on s.StaffId = r.ReceiptStaffId
	INNER JOIN Office o
				 on o.OfficeId = s.StaffOfficeId
WHERE o.OfficeId = 7
GROUP BY i.ItemId
		, i.ItemDescription
		, o.OfficeId
		, o.OfficeLocation
ORDER BY ItemCount ASC;


--3 top and bottom items for office 8
SELECT SUM(ri.ReceiptItemQuantity) AS ItemCount
		, i.ItemId
		, i.ItemDescription
		, o.OfficeId
		, o.OfficeLocation
FROM Receipt r
	INNER JOIN ReceiptItem ri
				 ON ri.ReceiptId = r.ReceiptId
	INNER JOIN Item i
				 on i.ItemId = ri.ItemId
	INNER JOIN Staff s
				 on s.StaffId = r.ReceiptStaffId
	INNER JOIN Office o
				 on o.OfficeId = s.StaffOfficeId
WHERE o.OfficeId = 8
GROUP BY i.ItemId
		, i.ItemDescription
		, o.OfficeId
		, o.OfficeLocation
ORDER BY ItemCount ASC;


--3 top and bottom items for office 9
SELECT SUM(ri.ReceiptItemQuantity) AS ItemCount
		, i.ItemId
		, i.ItemDescription
		, o.OfficeId
		, o.OfficeLocation
FROM Receipt r
	INNER JOIN ReceiptItem ri
				 ON ri.ReceiptId = r.ReceiptId
	INNER JOIN Item i
				 on i.ItemId = ri.ItemId
	INNER JOIN Staff s
				 on s.StaffId = r.ReceiptStaffId
	INNER JOIN Office o
				 on o.OfficeId = s.StaffOfficeId
WHERE o.OfficeId = 9
GROUP BY i.ItemId
		, i.ItemDescription
		, o.OfficeId
		, o.OfficeLocation
ORDER BY ItemCount ASC;


--3 top and bottom items for office 10
SELECT SUM(ri.ReceiptItemQuantity) AS ItemCount
		, i.ItemId
		, i.ItemDescription
		, o.OfficeId
		, o.OfficeLocation
FROM Receipt r
	INNER JOIN ReceiptItem ri
				 ON ri.ReceiptId = r.ReceiptId
	INNER JOIN Item i
				 on i.ItemId = ri.ItemId
	INNER JOIN Staff s
				 on s.StaffId = r.ReceiptStaffId
	INNER JOIN Office o
				 on o.OfficeId = s.StaffOfficeId
WHERE o.OfficeId = 10
GROUP BY i.ItemId
		, i.ItemDescription
		, o.OfficeId
		, o.OfficeLocation
ORDER BY ItemCount ASC;


--worst perfroming items for the company as whole
SELECT SUM(ri.ReceiptItemQuantity) AS ItemCount
		, i.ItemId
		, i.ItemDescription
FROM Receipt r
	INNER JOIN ReceiptItem ri
				 ON ri.ReceiptId = r.ReceiptId
	INNER JOIN Item i
				 ON i.ItemId = ri.ItemId
GROUP BY i.ItemId, i.ItemDescription
ORDER BY ItemCount ASC;

-- Staff Count Per Store
SELECT COUNT(*) AS 'Staff Count', o.[OfficeLocation]
FROM Staff s
INNER JOIN Office o ON o.OfficeId = s.StaffOfficeId
GROUP BY o.[OfficeLocation]

-- Customer Count Per Store
SELECT COUNT(*) AS 'Customer Count', o.[OfficeLocation]
FROM Customer c
INNER JOIN Receipt r ON r.ReceiptCustomerId = c.CustomerId
INNER JOIN Staff s ON s.StaffId = r.ReceiptStaffId
INNER JOIN Office o ON o.OfficeId = s.StaffOfficeId
GROUP BY o.[OfficeLocation]