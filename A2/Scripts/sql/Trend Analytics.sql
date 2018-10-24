-- Trend Analyis item count by seasons (summer)
Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
where r.ReceiptDate between '20170101' and '20170228'
Group by i.ItemId, i.ItemDescription
order by ItemCount desc

-- Trend Analyis item count by seasons (Autumn)
Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
where r.ReceiptDate between '20170301' and '20170531'
Group by i.ItemId, i.ItemDescription
order by ItemCount desc

-- Trend Analyis item count by seasons (Winter)
Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
where r.ReceiptDate between '20170601' and '20170831'
Group by i.ItemId, i.ItemDescription
order by ItemCount desc

-- Trend Analyis item count by seasons (Spring)
Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
where r.ReceiptDate between '20170901' and '20171130'
Group by i.ItemId, i.ItemDescription
order by ItemCount desc

-- Trend Analysis for store 1 by seasons
Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 1 and r.ReceiptDate between '20170101' and '20170228' 
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc

Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 1 and r.ReceiptDate between '20170301' and '20170531'
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc

Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 1 and r.ReceiptDate between '20170601' and '20170831'
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc

Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 1 and r.ReceiptDate between '20170901' and '20171130' 
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc


-- Trend Analysis for store 2 by seasons
Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 2 and r.ReceiptDate between '20170101' and '20170228' 
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc

Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 2 and r.ReceiptDate between '20170301' and '20170531'
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc

Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 2 and r.ReceiptDate between '20170601' and '20170831'
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc

Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 2 and r.ReceiptDate between '20170901' and '20171130' 
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc


-- Trend Analysis for store 3 by seasons
Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 3 and r.ReceiptDate between '20170101' and '20170228' 
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc

Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 3 and r.ReceiptDate between '20170301' and '20170531'
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc

Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 3 and r.ReceiptDate between '20170601' and '20170831'
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc

Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 3 and r.ReceiptDate between '20170901' and '20171130' 
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc


-- Trend Analysis for store 4 by seasons
Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 4 and r.ReceiptDate between '20170101' and '20170228' 
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc

Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 4 and r.ReceiptDate between '20170301' and '20170531'
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc

Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 4 and r.ReceiptDate between '20170601' and '20170831'
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc

Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 4 and r.ReceiptDate between '20170901' and '20171130' 
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc


-- Trend Analysis for store 5 by seasons
Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 5 and r.ReceiptDate between '20170101' and '20170228' 
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc

Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 5 and r.ReceiptDate between '20170301' and '20170531'
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc

Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 5 and r.ReceiptDate between '20170601' and '20170831'
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc

Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 5 and r.ReceiptDate between '20170901' and '20171130' 
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc


-- Trend Analysis for store 6 by seasons
Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 6 and r.ReceiptDate between '20170101' and '20170228' 
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc

Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 6 and r.ReceiptDate between '20170301' and '20170531'
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc

Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 6 and r.ReceiptDate between '20170601' and '20170831'
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc

Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 6 and r.ReceiptDate between '20170901' and '20171130' 
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc


-- Trend Analysis for store 7 by seasons
Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 7 and r.ReceiptDate between '20170101' and '20170228' 
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc

Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 7 and r.ReceiptDate between '20170301' and '20170531'
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc

Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 7 and r.ReceiptDate between '20170601' and '20170831'
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc

Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 7 and r.ReceiptDate between '20170901' and '20171130' 
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc


-- Trend Analysis for store 8 by seasons
Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 8 and r.ReceiptDate between '20170101' and '20170228' 
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc

Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 8 and r.ReceiptDate between '20170301' and '20170531'
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc

Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 8 and r.ReceiptDate between '20170601' and '20170831'
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc

Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 8 and r.ReceiptDate between '20170901' and '20171130' 
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc


-- Trend Analysis for store 9 by seasons
Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 9 and r.ReceiptDate between '20170101' and '20170228' 
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc

Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 9 and r.ReceiptDate between '20170301' and '20170531'
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc

Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 9 and r.ReceiptDate between '20170601' and '20170831'
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc

Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 9 and r.ReceiptDate between '20170901' and '20171130' 
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc


-- Trend Analysis for store 10 by seasons
Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 10 and r.ReceiptDate between '20170101' and '20170228' 
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc

Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 10 and r.ReceiptDate between '20170301' and '20170531'
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc

Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 10 and r.ReceiptDate between '20170601' and '20170831'
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc

Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription, o.OfficeLocation, o.OfficeID
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
INNER JOIN Staff s on s.StaffId = r.ReceiptStaffId
INNER JOIN Office o on o.OfficeId = s.StaffOfficeId
where o.OfficeID = 10 and r.ReceiptDate between '20170901' and '20171130' 
Group by i.ItemId, i.ItemDescription, o.OfficeLocation,  o.OfficeID
order by ItemCount desc


-- (Best Item)
-- Trend Analytics for Item (Mitre Saw) by season (Summer)
Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
where i.ItemId = 7 and r.ReceiptDate between '20170101' and '20170228'
Group by i.ItemId, i.ItemDescription
order by ItemCount desc

-- Trend Analytics for Item (Mitre Saw) by season (Autumn)
Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
where i.ItemId = 7 and r.ReceiptDate between '20170301' and '20170531'
Group by i.ItemId, i.ItemDescription
order by ItemCount desc

-- Trend Analytics for Item (Mitre Saw) by season (Winter)
Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
where i.ItemId = 7 and r.ReceiptDate between '20170601' and '20170831'
Group by i.ItemId, i.ItemDescription
order by ItemCount desc

-- Trend Analytics for Item (Mitre Saw) by season (Spring)
Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
where i.ItemId = 7 and r.ReceiptDate between '20170901' and '20171130'
Group by i.ItemId, i.ItemDescription
order by ItemCount desc


-- (Worst Item)
-- Trend Analytics for Item (Drill bit 6mm) by season (Summer)
Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
where i.ItemId = 23 and r.ReceiptDate between '20170101' and '20170228'
Group by i.ItemId, i.ItemDescription
order by ItemCount desc

-- Trend Analytics for Item (Drill bit 6mm) by season (Autumn)
Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
where i.ItemId = 23 and r.ReceiptDate between '20170301' and '20170531'
Group by i.ItemId, i.ItemDescription
order by ItemCount desc

-- Trend Analytics for Item (Drill bit 6mm) by season (Winter)
Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
where i.ItemId = 23 and r.ReceiptDate between '20170601' and '20170831'
Group by i.ItemId, i.ItemDescription
order by ItemCount desc

-- Trend Analytics for Item (Drill bit 6mm) by season (Spring)
Select SUM(ri.ReceiptItemQuantity) AS ItemCount, i.ItemId, i.ItemDescription
From Receipt r
INNER JOIN ReceiptItem ri ON ri.ReceiptId = r.ReceiptId
INNER JOIN Item i on i.ItemId = ri.ItemId
where i.ItemId = 23 and r.ReceiptDate between '20170901' and '20171130'
Group by i.ItemId, i.ItemDescription
order by ItemCount desc