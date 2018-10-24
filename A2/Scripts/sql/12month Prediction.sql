use EBUS3030A2;

select SUM(ri.ReceiptItemQuantity) AS ItemCount, AVG(ri.ReceiptItemQuantity) AS 'AVG', MIN(ri.ReceiptItemQuantity) AS 'MIN' , MAX(ri.ReceiptItemQuantity) AS 'MAX' , i.ItemId, i.ItemDescription
from Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
Group by i.ItemId, i.ItemDescription
order by ItemCount asc

--sum, avg, min, max per item per month
select SUM(ri.ReceiptItemQuantity) AS ItemCount, AVG(ri.ReceiptItemQuantity) AS 'AVG', MIN(ri.ReceiptItemQuantity) AS 'MIN' , MAX(ri.ReceiptItemQuantity) AS 'MAX' , i.ItemId, i.ItemDescription, r.ReceiptDate
from Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
WHERE ReceiptDate between '2017-01-01' and '2017-01-31'
Group by i.ItemId, i.ItemDescription, r.ReceiptDate
order by ItemCount asc

--sum, avg, min, max per month 1
select SUM(ri.ReceiptItemQuantity) AS ItemCount, AVG(ri.ReceiptItemQuantity) AS 'AVG', MIN(ri.ReceiptItemQuantity) AS 'MIN' , MAX(ri.ReceiptItemQuantity) AS 'MAX' 
from Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
WHERE ReceiptDate between '2017-01-01' and '2017-01-31'
order by ItemCount asc

--sum, avg, min, max per month 2 
select SUM(ri.ReceiptItemQuantity) AS ItemCount, AVG(ri.ReceiptItemQuantity) AS 'AVG', MIN(ri.ReceiptItemQuantity) AS 'MIN' , MAX(ri.ReceiptItemQuantity) AS 'MAX' 
from Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
WHERE ReceiptDate between '2017-02-01' and '2017-02-28'
order by ItemCount asc

--sum, avg, min, max per month 3
select SUM(ri.ReceiptItemQuantity) AS ItemCount, AVG(ri.ReceiptItemQuantity) AS 'AVG', MIN(ri.ReceiptItemQuantity) AS 'MIN' , MAX(ri.ReceiptItemQuantity) AS 'MAX' 
from Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
WHERE ReceiptDate between '2017-03-01' and '2017-03-31'
order by ItemCount asc

--sum, avg, min, max per month 4
select SUM(ri.ReceiptItemQuantity) AS ItemCount, AVG(ri.ReceiptItemQuantity) AS 'AVG', MIN(ri.ReceiptItemQuantity) AS 'MIN' , MAX(ri.ReceiptItemQuantity) AS 'MAX' 
from Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
WHERE ReceiptDate between '2017-04-01' and '2017-04-30'
order by ItemCount asc

--sum, avg, min, max per month 5
select SUM(ri.ReceiptItemQuantity) AS ItemCount, AVG(ri.ReceiptItemQuantity) AS 'AVG', MIN(ri.ReceiptItemQuantity) AS 'MIN' , MAX(ri.ReceiptItemQuantity) AS 'MAX' 
from Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
WHERE ReceiptDate between '2017-05-01' and '2017-05-31'
order by ItemCount asc

--sum, avg, min, max per month 6
select SUM(ri.ReceiptItemQuantity) AS ItemCount, AVG(ri.ReceiptItemQuantity) AS 'AVG', MIN(ri.ReceiptItemQuantity) AS 'MIN' , MAX(ri.ReceiptItemQuantity) AS 'MAX' 
from Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
WHERE ReceiptDate between '2017-06-01' and '2017-06-30'
order by ItemCount asc

--sum, avg, min, max per month 7
select SUM(ri.ReceiptItemQuantity) AS ItemCount, AVG(ri.ReceiptItemQuantity) AS 'AVG', MIN(ri.ReceiptItemQuantity) AS 'MIN' , MAX(ri.ReceiptItemQuantity) AS 'MAX' 
from Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
WHERE ReceiptDate between '2017-07-01' and '2017-07-31'
order by ItemCount asc

--sum, avg, min, max per month 8
select SUM(ri.ReceiptItemQuantity) AS ItemCount, AVG(ri.ReceiptItemQuantity) AS 'AVG', MIN(ri.ReceiptItemQuantity) AS 'MIN' , MAX(ri.ReceiptItemQuantity) AS 'MAX' 
from Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
WHERE ReceiptDate between '2017-08-01' and '2017-08-31'
order by ItemCount asc

--sum, avg, min, max per month 9
select SUM(ri.ReceiptItemQuantity) AS ItemCount, AVG(ri.ReceiptItemQuantity) AS 'AVG', MIN(ri.ReceiptItemQuantity) AS 'MIN' , MAX(ri.ReceiptItemQuantity) AS 'MAX' 
from Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
WHERE ReceiptDate between '2017-09-01' and '2017-09-30'
order by ItemCount asc

--sum, avg, min, max per month 10
select SUM(ri.ReceiptItemQuantity) AS ItemCount, AVG(ri.ReceiptItemQuantity) AS 'AVG', MIN(ri.ReceiptItemQuantity) AS 'MIN' , MAX(ri.ReceiptItemQuantity) AS 'MAX' 
from Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
WHERE ReceiptDate between '2017-10-01' and '2017-10-31'
order by ItemCount asc

--sum, avg, min, max per month 11
select SUM(ri.ReceiptItemQuantity) AS ItemCount, AVG(ri.ReceiptItemQuantity) AS 'AVG', MIN(ri.ReceiptItemQuantity) AS 'MIN' , MAX(ri.ReceiptItemQuantity) AS 'MAX' 
from Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
WHERE ReceiptDate between '2017-11-01' and '2017-11-30'
order by ItemCount asc

--sum, avg, min, max per month 12
select SUM(ri.ReceiptItemQuantity) AS ItemCount, AVG(ri.ReceiptItemQuantity) AS 'AVG', MIN(ri.ReceiptItemQuantity) AS 'MIN' , MAX(ri.ReceiptItemQuantity) AS 'MAX' 
from Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
WHERE ReceiptDate between '2017-12-01' and '2017-12-31'
order by ItemCount asc



select * from Receipt order by receiptDate asc

