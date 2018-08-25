#!/usr/bin/env python3.7
import openpyxl

class Item:
    def __init__(self,item_id,item_description,item_price):
        self.id = item_id
        self.description = item_description
        self.price = item_price

class Office:
    def __init__(self,office_id,office_location):
        self.id = office_id
        self.location = office_location

class Staff:
    def __init__(self,staff_id,staff_first_name,staff_surname,office):
        self.id = staff_id
        self.first_name = staff_first_name
        self.surname = staff_surname
        self.office = office

class Customer:
    def __init__(self,customer_id,customer_first_name,customer_surname):
        self.id = customer_id
        self.first_name = customer_first_name
        self.surname = customer_surname

class Receipt:
    def __init__(self,receipt_id,customer,staff):
        self.id = id
        self.customer = customer
        self.staff = staff
        self.items = {}
        self.item_count = 0

    def add_item(self,item):
        self.items[self.item_count] = item

class Sale:
    def __init__(self,date,receipt):
        self.date = date
        self.receipt = receipt

class Sales:
    def __init__(self):
        self.sales = {}
    
    def add_sale(self,row):
        customer = Customer(row[2].value,row[3].value,row[4].value)
        office = Office(row[8].value,row[9].value)
        staff = Staff(row[5].value,row[6].value,row[7].value,office)
        receipt = Receipt(row[1].value,customer,staff)
        sale = Sale(row[0].value,receipt)
        self.sales[sale.receipt.id] = sale
        print("Added sale: {}".format(sale))

    # sale_vars = vars(sale)
    # print(', '.join("%s: %s" % item for item in sale_vars.items()))
    # print("Customer name: {} {}\nCustomer Id: {}".format(customer.first_name,customer.surname,customer.id))

if __name__ == '__main__':
    excel_file = openpyxl.load_workbook('Data/Assignment1Data.xlsx')
    data = excel_file['Asgn1 Data']
    sales = Sales()
    for row in data.rows:
        receipt_id = row[1].value
        if receipt_id in sales.sales:
            print("found existing receipt {}".format(sales.sales[receipt_id]))
        else:
            sales.add_sale(row)
        