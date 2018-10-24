USE EBUS3030A2;


-- Sales count per staff member (Receipt Count)
SELECT COUNT(*) AS 'Sales Count', s.StaffId,s.StaffFirstName,s.StaffSurname, o.OfficeId, o.OfficeLocation
FROM Receipt r
INNER JOIN ReceiptItem ri ON r.ReceiptId = ri.ReceiptId
INNER JOIN Item i ON i.ItemId = ri.ItemId
INNER JOIN Staff s ON s.StaffId = r.ReceiptStaffId
INNER JOIN Office o  ON o.OfficeId = s.StaffOfficeId
GROUP BY s.StaffId,s.StaffFirstName,s.StaffSurname, o.OfficeId, o.OfficeLocation 
ORDER BY 'Sales Count' DESC;

-- Item count per staff member
SELECT SUM(ri.ReceiptItemQuantity) AS 'Item Count', s.StaffId,s.StaffFirstName,s.StaffSurname, o.OfficeId, o.OfficeLocation
FROM Receipt r
INNER JOIN ReceiptItem ri ON r.ReceiptId = ri.ReceiptId
INNER JOIN Staff s ON s.StaffId = r.ReceiptStaffId
INNER JOIN Office o  ON o.OfficeId = s.StaffOfficeId
GROUP BY s.StaffId,s.StaffFirstName,s.StaffSurname, o.OfficeId, o.OfficeLocation
ORDER BY 'Item Count' DESC;

-- Sales total per staff with discounts applied ($)
SELECT CAST(
		CASE
		WHEN COUNT(ri.[ReceiptItemQuantity]) >= 5
			THEN SUM(ri.[SalePrice] * ri.[ReceiptItemQuantity]) * 0.95
		ELSE SUM(ri.[SalePrice] * ri.[ReceiptItemQuantity])
		END AS decimal(19,5)) AS 'Sales Totals',
		 s.StaffId,s.StaffFirstName,s.StaffSurname, o.OfficeId, o.OfficeLocation
FROM Receipt r
INNER JOIN ReceiptItem ri ON r.ReceiptId = ri.ReceiptId
INNER JOIN Item i ON i.ItemId = ri.ItemId
INNER JOIN Staff s ON s.StaffId = r.ReceiptStaffId
INNER JOIN Customer c ON c.CustomerId = r.ReceiptCustomerId
INNER JOIN Office o ON o.OfficeId = s.StaffOfficeId
GROUP BY s.StaffId,s.StaffFirstName,s.StaffSurname, o.OfficeId, o.OfficeLocation
ORDER BY 'Sales Totals' DESC;

-- Sales average per staff with discounts applied
SELECT (CAST(
		CASE
		WHEN COUNT(ri.[ReceiptItemQuantity]) >= 5
			THEN SUM(ri.[SalePrice] * ri.[ReceiptItemQuantity]) * 0.95
		ELSE SUM(ri.[SalePrice] * ri.[ReceiptItemQuantity])
		END AS decimal(19,5)) / COUNT(r.ReceiptId)) AS 'Sales Average',
		 s.StaffId,s.StaffFirstName,s.StaffSurname,  o.OfficeId, o.OfficeLocation
FROM Receipt r
INNER JOIN ReceiptItem ri ON r.ReceiptId = ri.ReceiptId
INNER JOIN Item i ON i.ItemId = ri.ItemId
INNER JOIN Staff s ON s.StaffId = r.ReceiptStaffId
INNER JOIN Office o ON o.OfficeId = s.StaffOfficeId
GROUP BY s.StaffId,s.StaffFirstName,s.StaffSurname, o.OfficeId, o.OfficeLocation
ORDER BY 'Sales Average' DESC;

-- Sales metrics for discounted and standard sales per staff member
SELECT s.StaffId,s.StaffFirstName,s.StaffSurname,  o.OfficeId, o.OfficeLocation,
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
	GROUP BY r.ReceiptId
) AS SubQuery
INNER JOIN Receipt r ON SubQuery.ReceiptId = r.ReceiptId
INNER JOIN ReceiptItem ri ON r.ReceiptId = ri.ReceiptId
INNER JOIN Staff s ON s.StaffId = r.ReceiptStaffId
INNER JOIN Office o ON o.OfficeId = s.StaffOfficeId
GROUP BY s.StaffId,s.StaffFirstName,s.StaffSurname, o.OfficeId, o.OfficeLocation
ORDER BY [Discounted Sales]

-- Sales average per customer with discounts applied
SELECT (CAST(
		CASE
		WHEN COUNT(ri.[ReceiptItemQuantity]) >= 5
			THEN SUM(ri.[SalePrice] * ri.[ReceiptItemQuantity]) * 0.95
		ELSE SUM(ri.[SalePrice] * ri.[ReceiptItemQuantity])
		END AS decimal(19,5)) / COUNT(r.ReceiptId)) AS 'Sales Average',
		 c.CustomerId,c.CustomerFirstName,c.CustomerSurname
FROM Receipt r
INNER JOIN ReceiptItem ri ON r.ReceiptId = ri.ReceiptId
INNER JOIN Item i ON i.ItemId = ri.ItemId
INNER JOIN Staff s ON s.StaffId = r.ReceiptStaffId
INNER JOIN Customer c ON c.CustomerId = r.ReceiptCustomerId
GROUP BY c.CustomerId,c.CustomerFirstName,c.CustomerSurname
ORDER BY 'Sales Average' DESC;

-- Item Count, total revenue, average revenue per item sold By Office Location no discount
SELECT SUM(ri.ReceiptItemQuantity) AS ItemCount, o.OfficeId, o.OfficeLocation, SUM(ri.[SalePrice] * ri.[ReceiptItemQuantity]) as Revenue, Cast (SUM(ri.[SalePrice] * ri.[ReceiptItemQuantity]) as decimal)/SUM(ri.ReceiptItemQuantity) as AverageRevenue
FROM Receipt r
INNER JOIN ReceiptItem ri ON r.ReceiptId = ri.ReceiptId
INNER JOIN Staff s ON s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on s.StaffOfficeId = o.OfficeId
GROUP BY o.OfficeId, o.OfficeLocation
ORDER BY ItemCount DESC;

--Staff Count per office
select count(Distinct s.StaffId) AS StaffCount, o.OfficeId, o.OfficeLocation 
FROM Staff s
INNER JOIN Office o ON o.OfficeId = s.StaffOfficeId
Group by o.OfficeId, o.OfficeLocation

--3 top and bottom items for office 1
select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeId, o.OfficeLocation
from Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeId = 1
Group by i.ItemId, i.ItemDescription, o.OfficeId, o.OfficeLocation
order by ItemCount asc

--3 top and bottom items for office 2
select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeId, o.OfficeLocation
from Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeId = 2
Group by i.ItemId, i.ItemDescription, o.OfficeId, o.OfficeLocation
order by ItemCount asc

--3 top and bottom items for office 3
select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeId, o.OfficeLocation
from Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeId = 3
Group by i.ItemId, i.ItemDescription, o.OfficeId, o.OfficeLocation
order by ItemCount asc

--3 top and bottom items for office 4
select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeId, o.OfficeLocation
from Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeId = 4
Group by i.ItemId, i.ItemDescription, o.OfficeId, o.OfficeLocation
order by ItemCount asc

--3 top and bottom items for office 5
select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeId, o.OfficeLocation
from Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeId = 5
Group by i.ItemId, i.ItemDescription, o.OfficeId, o.OfficeLocation
order by ItemCount asc

--3 top and bottom items for office 6
select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeId, o.OfficeLocation
from Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeId = 6
Group by i.ItemId, i.ItemDescription, o.OfficeId, o.OfficeLocation
order by ItemCount asc

--3 top and bottom items for office 7
select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeId, o.OfficeLocation
from Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeId = 7
Group by i.ItemId, i.ItemDescription, o.OfficeId, o.OfficeLocation
order by ItemCount asc

--3 top and bottom items for office 8
select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeId, o.OfficeLocation
from Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeId = 8
Group by i.ItemId, i.ItemDescription, o.OfficeId, o.OfficeLocation
order by ItemCount asc

--3 top and bottom items for office 9
select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeId, o.OfficeLocation
from Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeId = 9
Group by i.ItemId, i.ItemDescription, o.OfficeId, o.OfficeLocation
order by ItemCount asc

--3 top and bottom items for office 10
select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeId, o.OfficeLocation
from Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeId = 10
Group by i.ItemId, i.ItemDescription, o.OfficeId, o.OfficeLocation
order by ItemCount asc

--worst perfroming items for the company as whole
select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription
from Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
Group by i.ItemId, i.ItemDescription
order by ItemCount asc

