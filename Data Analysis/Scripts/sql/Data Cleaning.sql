/* Data Cleaning */
Use [EBUS3030]
go

INSERT INTO Receipt([ReceiptId], [ReceiptCustomerId],[ReceiptStaffId]) SELECT DISTINCT([Reciept_Id]),[Customer_ID],[Staff_ID] FROM [Assignment1Data] ORDER BY [Reciept_Id]
go

select * from Assignment1Data where Customer_ID= 'C32' and Staff_ID='S15' and Sale_Date='2017-11-12 00:00:00.0000000';
select * from Assignment1Data where Customer_ID= 'C13' and Staff_ID='S4' and Sale_Date='2017-12-30 00:00:00.0000000';
go

update Assignment1Data set Reciept_Id=51585, Reciept_Transaction_Row_ID=5 where Customer_ID='C32' and Staff_ID='S15' and Sale_Date='2017-11-12 00:00:00.0000000' and Item_ID='14';
go

select * from Assignment1Data where Customer_ID= 'C32' and Staff_ID='S15' and Sale_Date='2017-11-12 00:00:00.0000000';
select * from Assignment1Data where Customer_ID= 'C13' and Staff_ID='S4' and Sale_Date='2017-12-30 00:00:00.0000000';
go
