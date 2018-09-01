/* Whos the best salesman */


/* Find the salesman with most transactions */
SELECT StaffFirstName, StaffId, COUNT(Receipt.ReceiptStaffId) AS TotalOrderQuantity
FROM Staff inner join Receipt on (Receipt.ReceiptStaffId = Staff.StaffId)
group by Receipt.ReceiptStaffId, StaffFirstName, StaffId
order by TotalOrderQuantity desc
go

/* Find number of items sold by a Saleman */
SELECT COUNT(*) as TotalItemsSold , s.StaffId,s.StaffFirstName,s.StaffSurname
FROM Receipt r
INNER JOIN ReceiptItem ri ON r.ReceiptId = ri.ReceiptId
INNER JOIN Item i ON i.ItemId = ri.ItemId
INNER JOIN Price p ON p.PriceId = ri.PriceId
INNER JOIN Staff s ON s.StaffId = r.ReceiptStaffId
INNER JOIN Customer c ON c.CustomerId = r.ReceiptCustomerId
GROUP BY s.StaffId,s.StaffFirstName,s.StaffSurname
Order BY TotalItemsMoved desc