/*
** Name: 12month Prediction.sql
** Date: 22/10/2018
** Description: Predictive analytics for the next 12 months.
 */

USE EBUS3030A2;
GO


--Avg per month
SELECT SUM(ri.ReceiptItemQuantity)/12 as Average 
FROM Receipt r
  INNER JOIN ReceiptItem ri
         ON ri.ReceiptId = r.ReceiptId
  INNER JOIN Item i
         ON i.ItemId = ri.ItemId
WHERE ReceiptDate BETWEEN '2017-01-01' AND '2017-12-31'
ORDER BY Average ASC;



--sum, avg, min, max per item per month grouped on date 
SELECT SUM(ri.ReceiptItemQuantity) AS ItemCount
    , AVG(ri.ReceiptItemQuantity) AS 'AVG'
    , MIN(ri.ReceiptItemQuantity) AS 'MIN'
    , MAX(ri.ReceiptItemQuantity) AS 'MAX'
    , i.ItemId
    , i.ItemDescription
    , r.ReceiptDate
FROM Receipt r
  INNER JOIN ReceiptItem ri
         ON ri.ReceiptId = r.ReceiptId
  INNER JOIN Item i
         ON i.ItemId = ri.ItemId
WHERE ReceiptDate BETWEEN '2017-01-01' AND '2017-01-31'
GROUP BY i.ItemId
    , i.ItemDescription
    , r.ReceiptDate
ORDER BY ItemCount ASC;


--sum, avg, min, max per month 1
SELECT SUM(ri.ReceiptItemQuantity) AS ItemCount
    , AVG(ri.ReceiptItemQuantity) AS 'AVG'
    , MIN(ri.ReceiptItemQuantity) AS 'MIN'
    , MAX(ri.ReceiptItemQuantity) AS 'MAX'
	, o.OfficeId
	, o.OfficeLocation
FROM Receipt r
  INNER JOIN ReceiptItem ri
         ON ri.ReceiptId = r.ReceiptId
  INNER JOIN Item i
         ON i.ItemId = ri.ItemId
  INNER JOIN Staff s
		 ON s.StaffId = r.ReceiptStaffId
  INNER JOIN Office o
		 ON o.OfficeId = s.StaffOfficeId
WHERE ReceiptDate BETWEEN '2017-01-01' AND '2017-01-31'
Group By o.OfficeId, o.OfficeLocation
ORDER BY ItemCount ASC;


--sum, avg, min, max per month 2
SELECT SUM(ri.ReceiptItemQuantity) AS ItemCount
    , AVG(ri.ReceiptItemQuantity) AS 'AVG'
    , MIN(ri.ReceiptItemQuantity) AS 'MIN'
    , MAX(ri.ReceiptItemQuantity) AS 'MAX'
	, o.OfficeId
	, o.OfficeLocation
FROM Receipt r
  INNER JOIN ReceiptItem ri
         ON ri.ReceiptId = r.ReceiptId
  INNER JOIN Item i
         ON i.ItemId = ri.ItemId
  INNER JOIN Staff s
		 ON s.StaffId = r.ReceiptStaffId
  INNER JOIN Office o
		 ON o.OfficeId = s.StaffOfficeId
WHERE ReceiptDate BETWEEN '2017-02-01' AND '2017-02-28'
Group By o.OfficeId, o.OfficeLocation
ORDER BY ItemCount ASC;

--sum, avg, min, max per month 3
SELECT SUM(ri.ReceiptItemQuantity) AS ItemCount
    , AVG(ri.ReceiptItemQuantity) AS 'AVG'
    , MIN(ri.ReceiptItemQuantity) AS 'MIN'
    , MAX(ri.ReceiptItemQuantity) AS 'MAX'
	, o.OfficeId
	, o.OfficeLocation
FROM Receipt r
  INNER JOIN ReceiptItem ri
         ON ri.ReceiptId = r.ReceiptId
  INNER JOIN Item i
         ON i.ItemId = ri.ItemId
  INNER JOIN Staff s
		 ON s.StaffId = r.ReceiptStaffId
  INNER JOIN Office o
		 ON o.OfficeId = s.StaffOfficeId
WHERE ReceiptDate BETWEEN '2017-03-01' AND '2017-03-31'
Group By o.OfficeId, o.OfficeLocation
ORDER BY ItemCount ASC;


--sum, avg, min, max per month 4
SELECT SUM(ri.ReceiptItemQuantity) AS ItemCount
    , AVG(ri.ReceiptItemQuantity) AS 'AVG'
    , MIN(ri.ReceiptItemQuantity) AS 'MIN'
    , MAX(ri.ReceiptItemQuantity) AS 'MAX'
	, o.OfficeId
	, o.OfficeLocation
FROM Receipt r
  INNER JOIN ReceiptItem ri
         ON ri.ReceiptId = r.ReceiptId
  INNER JOIN Item i
         ON i.ItemId = ri.ItemId
  INNER JOIN Staff s
		 ON s.StaffId = r.ReceiptStaffId
  INNER JOIN Office o
		 ON o.OfficeId = s.StaffOfficeId
WHERE ReceiptDate BETWEEN '2017-04-01' AND '2017-04-30'
Group By o.OfficeId, o.OfficeLocation
ORDER BY ItemCount ASC;


--sum, avg, min, max per month 5
SELECT SUM(ri.ReceiptItemQuantity) AS ItemCount
    , AVG(ri.ReceiptItemQuantity) AS 'AVG'
    , MIN(ri.ReceiptItemQuantity) AS 'MIN'
    , MAX(ri.ReceiptItemQuantity) AS 'MAX'
	, o.OfficeId
	, o.OfficeLocation
FROM Receipt r
  INNER JOIN ReceiptItem ri
         ON ri.ReceiptId = r.ReceiptId
  INNER JOIN Item i
         ON i.ItemId = ri.ItemId
  INNER JOIN Staff s
		 ON s.StaffId = r.ReceiptStaffId
  INNER JOIN Office o
		 ON o.OfficeId = s.StaffOfficeId
WHERE ReceiptDate BETWEEN '2017-05-01' AND '2017-05-31'
Group By o.OfficeId, o.OfficeLocation
ORDER BY ItemCount ASC;


--sum, avg, min, max per month 6
SELECT SUM(ri.ReceiptItemQuantity) AS ItemCount
    , AVG(ri.ReceiptItemQuantity) AS 'AVG'
    , MIN(ri.ReceiptItemQuantity) AS 'MIN'
    , MAX(ri.ReceiptItemQuantity) AS 'MAX'
	, o.OfficeId
	, o.OfficeLocation
FROM Receipt r
  INNER JOIN ReceiptItem ri
         ON ri.ReceiptId = r.ReceiptId
  INNER JOIN Item i
         ON i.ItemId = ri.ItemId
  INNER JOIN Staff s
		 ON s.StaffId = r.ReceiptStaffId
  INNER JOIN Office o
		 ON o.OfficeId = s.StaffOfficeId
WHERE ReceiptDate BETWEEN '2017-06-01' AND '2017-06-30'
Group By o.OfficeId, o.OfficeLocation
ORDER BY ItemCount ASC;


--sum, avg, min, max per month 7
SELECT SUM(ri.ReceiptItemQuantity) AS ItemCount
    , AVG(ri.ReceiptItemQuantity) AS 'AVG'
    , MIN(ri.ReceiptItemQuantity) AS 'MIN'
    , MAX(ri.ReceiptItemQuantity) AS 'MAX'
	, o.OfficeId
	, o.OfficeLocation
FROM Receipt r
  INNER JOIN ReceiptItem ri
         ON ri.ReceiptId = r.ReceiptId
  INNER JOIN Item i
         ON i.ItemId = ri.ItemId
  INNER JOIN Staff s
		 ON s.StaffId = r.ReceiptStaffId
  INNER JOIN Office o
		 ON o.OfficeId = s.StaffOfficeId
WHERE ReceiptDate BETWEEN '2017-07-01' AND '2017-07-31'
Group By o.OfficeId, o.OfficeLocation
ORDER BY ItemCount ASC;


--sum, avg, min, max per month 8
SELECT SUM(ri.ReceiptItemQuantity) AS ItemCount
    , AVG(ri.ReceiptItemQuantity) AS 'AVG'
    , MIN(ri.ReceiptItemQuantity) AS 'MIN'
    , MAX(ri.ReceiptItemQuantity) AS 'MAX'
	, o.OfficeId
	, o.OfficeLocation
FROM Receipt r
  INNER JOIN ReceiptItem ri
         ON ri.ReceiptId = r.ReceiptId
  INNER JOIN Item i
         ON i.ItemId = ri.ItemId
  INNER JOIN Staff s
		 ON s.StaffId = r.ReceiptStaffId
  INNER JOIN Office o
		 ON o.OfficeId = s.StaffOfficeId
WHERE ReceiptDate BETWEEN '2017-08-01' AND '2017-08-31'
Group By o.OfficeId, o.OfficeLocation
ORDER BY ItemCount ASC;


--sum, avg, min, max per month 9
SELECT SUM(ri.ReceiptItemQuantity) AS ItemCount
    , AVG(ri.ReceiptItemQuantity) AS 'AVG'
    , MIN(ri.ReceiptItemQuantity) AS 'MIN'
    , MAX(ri.ReceiptItemQuantity) AS 'MAX'
	, o.OfficeId
	, o.OfficeLocation
FROM Receipt r
  INNER JOIN ReceiptItem ri
         ON ri.ReceiptId = r.ReceiptId
  INNER JOIN Item i
         ON i.ItemId = ri.ItemId
  INNER JOIN Staff s
		 ON s.StaffId = r.ReceiptStaffId
  INNER JOIN Office o
		 ON o.OfficeId = s.StaffOfficeId
WHERE ReceiptDate BETWEEN '2017-09-01' AND '2017-09-30'
Group By o.OfficeId, o.OfficeLocation
ORDER BY ItemCount ASC;

--sum, avg, min, max per month 10
SELECT SUM(ri.ReceiptItemQuantity) AS ItemCount
    , AVG(ri.ReceiptItemQuantity) AS 'AVG'
    , MIN(ri.ReceiptItemQuantity) AS 'MIN'
    , MAX(ri.ReceiptItemQuantity) AS 'MAX'
	, o.OfficeId
	, o.OfficeLocation
FROM Receipt r
  INNER JOIN ReceiptItem ri
         ON ri.ReceiptId = r.ReceiptId
  INNER JOIN Item i
         ON i.ItemId = ri.ItemId
  INNER JOIN Staff s
		 ON s.StaffId = r.ReceiptStaffId
  INNER JOIN Office o
		 ON o.OfficeId = s.StaffOfficeId
WHERE ReceiptDate BETWEEN '2017-10-01' AND '2017-10-31'
Group By o.OfficeId, o.OfficeLocation
ORDER BY ItemCount ASC;

--sum, avg, min, max per month 11
SELECT SUM(ri.ReceiptItemQuantity) AS ItemCount
    , AVG(ri.ReceiptItemQuantity) AS 'AVG'
    , MIN(ri.ReceiptItemQuantity) AS 'MIN'
    , MAX(ri.ReceiptItemQuantity) AS 'MAX'
	, o.OfficeId
	, o.OfficeLocation
FROM Receipt r
  INNER JOIN ReceiptItem ri
         ON ri.ReceiptId = r.ReceiptId
  INNER JOIN Item i
         ON i.ItemId = ri.ItemId
  INNER JOIN Staff s
		 ON s.StaffId = r.ReceiptStaffId
  INNER JOIN Office o
		 ON o.OfficeId = s.StaffOfficeId
WHERE ReceiptDate BETWEEN '2017-11-01' AND '2017-11-30'
Group By o.OfficeId, o.OfficeLocation
ORDER BY ItemCount ASC;

--sum, avg, min, max per month 12
SELECT SUM(ri.ReceiptItemQuantity) AS ItemCount
    , AVG(ri.ReceiptItemQuantity) AS 'AVG'
    , MIN(ri.ReceiptItemQuantity) AS 'MIN'
    , MAX(ri.ReceiptItemQuantity) AS 'MAX'
	, o.OfficeId
	, o.OfficeLocation
FROM Receipt r
  INNER JOIN ReceiptItem ri
         ON ri.ReceiptId = r.ReceiptId
  INNER JOIN Item i
         ON i.ItemId = ri.ItemId
  INNER JOIN Staff s
		 ON s.StaffId = r.ReceiptStaffId
  INNER JOIN Office o
		 ON o.OfficeId = s.StaffOfficeId
WHERE ReceiptDate BETWEEN '2017-12-01' AND '2017-12-31'
Group By o.OfficeId, o.OfficeLocation
ORDER BY ItemCount ASC;






select * from Receipt order by receiptDate asc

