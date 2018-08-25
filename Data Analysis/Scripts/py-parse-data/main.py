#!/usr/bin/env python3.7
import openpyxl

class Item:
    def __init__(self,item_id,item_description,item_price,item_quantity):
        self.id = item_id
        self.description = item_description
        self.price = item_price
        self.quantity = item_quantity

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
        self.id = receipt_id
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
    
    def parse_row(self,row):
        if row[0].value != 'Sale Date' and isinstance(row[1].value,int):
            item = Item(row[11].value,row[12].value,row[14].value,row[13].value)
            customer = Customer(row[2].value,row[3].value,row[4].value)
            office = Office(row[8].value,row[9].value)
            staff = Staff(row[5].value,row[6].value,row[7].value,office)
            receipt = Receipt(row[1].value,customer,staff)
            receipt.add_item(item)
            sale = Sale(row[0].value,receipt)
            self.sales[sale.receipt.id] = sale
            print("Added sale: {}".format(sale.receipt.id))
        else:
            print("Skipped row, either it was a row header: {} or it was a formula: {}".format(row[0].value,row[1].value))

    def add_items_to_sale(self,row,existing_sale_identifier):
        item = Item(row[11].value,row[12].value,row[14].value,row[13].value)
        self.sales[existing_sale_identifier].receipt.add_item(item)
        print("Added items to receipt {} : ID: {}, Desc: {}, Price: {}, Quantity: {}".format(existing_sale_identifier,item.id,item.description,item.price,item.quantity))

if __name__ == '__main__':
    excel_file = openpyxl.load_workbook('Data/Assignment1Data.xlsx')
    data = excel_file['Asgn1 Data']
    sales = Sales()
    for row in data.rows:
        receipt_id = row[1].value
        if receipt_id in sales.sales:
            print("Found existing receipt {}, adding items instead".format(receipt_id))
            sales.add_items_to_sale(row,receipt_id)
        else:
            sales.parse_row(row)
        