/* Whos the best salesman */

SELECT COUNT()
From Receipt;
go  


select * from receipt
where ReceiptStaffID = 'S9'



select * from staff order by StaffId asc


SELECT StaffFirstName, StaffId, COUNT(Receipt.ReceiptStaffId) AS TotalOrderQuantity
FROM Staff inner join Receipt on (Receipt.ReceiptStaffId = Staff.StaffId)
group by Receipt.ReceiptStaffId, StaffFirstName, StaffId
order by TotalOrderQuantity desc
go

select * from receipt join receiptItem on (Receipt.ReceiptId = ReceiptItem.ReceiptId)
