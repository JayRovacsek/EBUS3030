#!/usr/bin/env python3.7
import os
import sys
import openpyxl
import traceback
from multiprocessing import Pool

# Item class, to imitate item entries in receipt 
class Item:
    def __init__(self,item_id,item_description,item_price,item_quantity):
        self.id = item_id
        self.description = item_description
        self.price = item_price
        self.quantity = item_quantity

# Office class, to imitate office entries in staff
class Office:
    def __init__(self,office_id,office_location):
        self.id = office_id
        self.location = office_location

# Staff class, to emulate staff 
class Staff:
    def __init__(self,staff_id,staff_first_name,staff_surname,office):
        self.id = staff_id
        self.first_name = staff_first_name
        self.surname = staff_surname
        self.office = office
        self.sales_count = 0
        self.sales_total = 0
        self.item_count = 0

# Customer class to emulate customers
class Customer:
    def __init__(self,customer_id,customer_first_name,customer_surname):
        self.id = customer_id
        self.first_name = customer_first_name
        self.surname = customer_surname

# Receipt class to hold data for a sale
class Receipt:
    def __init__(self,receipt_id,customer,staff):
        self.id = receipt_id
        self.customer = customer
        self.staff = staff
        self.items = {}
        self.item_count = 0
        self.total = 0

    # Function to add items to receipt
    def add_item(self,item):
        self.items[self.item_count] = item
        self.item_count += 1

# Sale class to hold one receipt (Kinda redundant)
class Sale:
    def __init__(self,date,receipt):
        self.date = date
        self.receipt = receipt

# Sales class to hold record of all sales
class Sales:
    def __init__(self):
        self.sales = {}
    
    # Parse row function, intended to determine if row is a header row or contains formula
    # awaiting Peter's response re; cells B13777 to B13865.
    def parse_row(self,row,employees):
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
            if staff.id in employees.employees.items():
                print("duplicate employee: {}".format(staff.id))
            else:
                employees.add_employee(staff,staff.id)
        else:
            print("Skipped row, either it was a row header: {} or it was a formula: {}".format(row[0].value,row[1].value))

    # Add items to sale if the receipt already exists
    def add_items_to_sale(self,row,existing_sale_identifier):
        item = Item(row[11].value,row[12].value,row[14].value,row[13].value)
        self.sales[existing_sale_identifier].receipt.add_item(item)
        print("Added items to receipt {} : ID: {}, Desc: {}, Price: {}, Quantity: {}".format(existing_sale_identifier,item.id,item.description,item.price,item.quantity))

# Employees class to hold all staff
class Employees:
    def __init__(self):
        self.employees = {}

    # Function to add new employees if they currently don't exist
    def add_employee(self,employee,employee_id):
        self.employees[employee_id] = employee

# Function to parse all receipts once populated and add to employee totals
def populate_receipt_totals(receipt_id,sale,employees):
    total = 0
    for item_id,item in sale.receipt.items.items():
        total = total + (item.quantity * item.price)
    print("Total calculated for receipt {} is: {}, Items count was: {}".format(receipt_id,total,len(sale.receipt.items.items())))
    employees.employees[sale.receipt.staff.id].sales_count += 1
    employees.employees[sale.receipt.staff.id].sales_total += total
    employees.employees[sale.receipt.staff.id].item_count += len(sale.receipt.items.items())

def generate_results_structures():
    try:
        if not os.path.exists('Results'):
            os.makedirs('Results')

        open('Results/Employee_Results.txt','w+').close()
        open('Results/Location_Results.txt','w+').close()
        open('Results/Item_Results.txt','w+').close()
        open('Results/Customer_Results.txt','w+').close()
        
    except Exception:
        print("An error occurred: {}".format(traceback.format_exc()))

def parse_row(row):
    receipt_id = row[1].value
    if receipt_id in sales.sales:
        print("Found existing receipt {}, adding items instead".format(receipt_id))
        sales.add_items_to_sale(row,receipt_id)
    else:
        sales.parse_row(row,employees)

# Main hook
if __name__ == '__main__':
    # Open excel file stored in child folder
    excel_file = openpyxl.load_workbook('Data/Assignment1Data.xlsx')
    data = excel_file['Asgn1 Data']
    sales = Sales()
    employees = Employees()

    # try:
    #     pool = Pool()
    #     pool.map(parse_row,data.rows)
    # finally:
    #     pool.close()
    #     pool.join()
    # Parse over all rows of file
    for row in data.rows:
        receipt_id = row[1].value
        if receipt_id in sales.sales:
            print("Found existing receipt {}, adding items instead".format(receipt_id))
            sales.add_items_to_sale(row,receipt_id)
        else:
            sales.parse_row(row,employees)
    
    generate_results_structures()

    # Populate employee sale totals, item totals etc etc.
    for receipt_id,sale in sales.sales.items():
       populate_receipt_totals(receipt_id,sale,employees)
    
    # Print results
    output = ""
    for employee_id,employee in employees.employees.items():
        output += "Employee: {}, {} {} \nSales Total={}\nSales Count={}\nTotal Items Sold:{}\n".format(
            employee_id,
            employee.first_name,
            employee.surname,
            employee.sales_total,
            employee.sales_count,
            employee.item_count)
        # print("Employee: {}, {} {} \nSales Total={}\nSales Count={}\nTotal Items Sold:{}\n".format(
        #     employee_id,
        #     employee.first_name,
        #     employee.surname,
        #     employee.sales_total,
        #     employee.sales_count,
        #     employee.item_count))
    with open('Results/Employee_Results.txt','w+') as employee_results:
        employee_results.write(output)