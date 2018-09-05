#!/usr/bin/env python3.7
import hashlib

# Item class, to imitate item entries in receipt 
class Item:
    def __init__(self,item_id,item_description,item_price,item_quantity):
        self.id = item_id
        self.description = item_description
        self.price = item_price
        self.quantity = item_quantity
        self.sales_count = 0
        self.sales_total = 0
        self.item_count = 0
        self.discounted_sales = 0

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
        self.discounted_sales = 0

# Customer class to emulate customers
class Customer:
    def __init__(self,customer_id,customer_first_name,customer_surname):
        self.id = customer_id
        self.first_name = customer_first_name
        self.surname = customer_surname
        self.sales_count = 0
        self.sales_total = 0
        self.item_count = 0
        self.discounted_sales = 0
        
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
        self.items[item.id] = item
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
    def parse_row(self,row,employees,customers,items):
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
                print("Duplicate employee: {}".format(staff.id))
            else:
                employees.add_employee(staff.id,staff)

            if customer.id in customers.customers.items():
                print("Duplicate customer: {}".format(customer.id))
            else:
                customers.add_customer(customer.id,customer)

            # We itemed your items so you can .items() your items
            if item.id in items.items.items():
                print("Duplicate item: {}".format(item.id))
            else:
                items.add_item(item.id,item)

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
    def add_employee(self,employee_id,employee):
        self.employees[employee_id] = employee

# Customers class to hold all customers
class Customers:
    def __init__(self):
        self.customers = {}

    # Function to add new customer if they currently don't exist
    def add_customer(self,customer_id,customer):
        self.customers[customer_id] = customer

# Items class to hold all items
class Items:
    def __init__(self):
        self.items = {}

    # Function to add new items if they currently don't exist
    def add_item(self,item_id,item):
        self.items[item_id] = item

class Error_Log:
    def __init__(self,trace,error_type,receipt_id,customer_id = None,
                staff_id = None,item_id = None,item_quantity = None,duplicate_item_quantity = None):
        self.trace = trace
        self.receipt_id = receipt_id
        self.error_type = error_type
        self.customer_id = None
        self.staff_id = None
        if customer_id is not None:
            self.customer_id = customer_id
        if staff_id is not None:
            self.staff_id = staff_id
        if item_id is not None:
            self.item_id = item_id
        if item_quantity is not None:
            self.item_quantity = item_quantity
        if duplicate_item_quantity is not None:
            self.duplicate_item_quantity = duplicate_item_quantity
        self.hash = self.generate_hash(trace + error_type + str(receipt_id))

    def generate_hash(self,hashcontent):
        return str(hashlib.sha1(hashcontent.encode(encoding='UTF-8',errors='strict')).hexdigest())

# Logged errors class to avoid logging the same error multiple times
class LoggedErrors:
    def __init__(self):
        self.logged_errors = {}
        self.error_count = 0
    
    # Determine if error related to receipt is already logged
    def add_error(self,receipt_id,trace,error_type,customer_id = None,staff_id = None,item_id = None,item_quantity = None,duplicate_item_quantity = None):
        error_log = Error_Log(trace,error_type,receipt_id,customer_id,staff_id,item_id,item_quantity,duplicate_item_quantity)
        if error_log.hash not in self.logged_errors:
            self.logged_errors[error_log.hash] = error_log