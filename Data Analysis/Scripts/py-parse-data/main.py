#!/usr/bin/env python3.7
import classes as Classes
import os
import sys
import openpyxl
import traceback

# Function to parse all receipts once populated and add to employee totals
def populate_receipt_totals(sales,employees,customers,items):
    for receipt_id,sale in sales.sales.items():
        total = 0
        for item_id,item in sale.receipt.items.items():
            total = total + (item.quantity * item.price)
            employees.employees[sale.receipt.staff.id].item_count += item.quantity

        if(len(sale.receipt.items.items()) > 4):
            print("Total was adjusted from {} to {} due to business rules related to number\nof items in a sale.".format(total,total * 0.85))
            total *= 0.85
            employees.employees[sale.receipt.staff.id].discounted_sales += 1

        print("Total calculated for receipt {} is: {}, Items count was: {}".format(receipt_id,total,len(sale.receipt.items.items())))
        employees.employees[sale.receipt.staff.id].sales_count += 1
        employees.employees[sale.receipt.staff.id].sales_total += total

    populate_customer_totals(sales,customers)
    populate_item_totals(sales,items)
    generate_employee_report(employees)

# Function to parse all receipts once populated and add to customer totals
def populate_item_totals(sales,items):
    for receipt_id,sale in sales.sales.items():
        total = 0
        for item_id,item in sale.receipt.items.items():
            total = total + (item.quantity * item.price)
            items.items[sale.receipt.items[item_id].id].item_count += item.quantity

        if(len(sale.receipt.items.items()) > 4):
            total *= 0.85
            items.items[sale.receipt.items[item_id].id].discounted_sales += 1

        items.items[sale.receipt.items[item_id].id].sales_count += 1
        items.items[sale.receipt.items[item_id].id].sales_total += total

    generate_items_report(items)

# Function to parse all receipts once populated and add to customer totals
def populate_customer_totals(sales,customers):
    for receipt_id,sale in sales.sales.items():
        total = 0
        for item_id,item in sale.receipt.items.items():
            total = total + (item.quantity * item.price)
            customers.customers[sale.receipt.customer.id].item_count += item.quantity

        if(len(sale.receipt.items.items()) > 4):
            total *= 0.85
            customers.customers[sale.receipt.customer.id].discounted_sales += 1

        customers.customers[sale.receipt.customer.id].sales_count += 1
        customers.customers[sale.receipt.customer.id].sales_total += total

    generate_customer_report(customers)
        
# Generation of required output files
def generate_results_structures():
    try:
        if not os.path.exists('Results'):
            os.makedirs('Results')

        open('Results/Employee_Results.txt','w+').close()
        open('Results/Item_Results.txt','w+').close()
        open('Results/Customer_Results.txt','w+').close()
        
    except Exception:
        print("An error occurred: {}".format(traceback.format_exc()))

# Main branch of code to parse rows in excel file
def parse_rows(rows,logged_errors):
    for row in rows:
        receipt_id = row[1].value
        if receipt_id in sales.sales:
            staff_id = row[5].value
            if sales.sales[receipt_id].receipt.staff.id != staff_id:
                print("Error in data row; {} is not the same as {}".format(sales.sales[receipt_id].receipt.staff.id, staff_id))
                logged_errors.add_error(receipt_id,"Error in data row id: {}; {} is not the same as {}".format(receipt_id, sales.sales[receipt_id].receipt.staff.id, staff_id))
            else:
                print("Found existing receipt {}, adding items instead".format(receipt_id))
                sales.add_items_to_sale(row,receipt_id)
        else:
            sales.parse_row(row,employees,customers,items)

# Clear the current errors.txt file 
def clear_error_log():
    open('Results/Errors.txt','w+').close()

# Function to generate employee report and output to disk
def generate_employee_report(employees):
    # Print results
    employee_output = ""
    header = "Results for Employee analysis:"
    for employee_id,employee in employees.employees.items():
        employee_output += """Employee: {}, {} {} \n
        Metrics: ###########################
        Sales Count = {}
        Total Discounted Sales: {}
        Discounted Sales Ratio: {}
        Total Items Sold: {}\n
        Financials: ########################
        Sales Total = ${}
        Average Sale Value: ${}
        Average Item Sold Value: ${}
        \n""".format(
            employee_id,
            employee.first_name,
            employee.surname,
            employee.sales_count,
            employee.discounted_sales,
            employee.discounted_sales / employee.sales_count,
            employee.item_count,
            employee.sales_total,
            employee.sales_total / employee.sales_count,
            employee.sales_total / employee.item_count)
    write_report_results('Employee_Results',header,employee_output)

# Function to generate employee report and output to disk
def generate_customer_report(customers):
    # Print results
    customer_output = ""
    header = "Results for Customer analysis:"
    for customer_id,customer in customers.customers.items():
        customer_output += """Customer: {}, {} {} \n
        Metrics: ###########################
        Sales Count = {}
        Total Discounted Sales: {}
        Discounted Sales Ratio: {}
        Total Items Sold: {}\n
        Financials: ########################
        Sales Total = ${}
        Average Sale Value: ${}
        Average Item Sold Value: ${}
        \n""".format(
            customer_id,
            customer.first_name,
            customer.surname,
            customer.sales_count,
            customer.discounted_sales,
            customer.discounted_sales / customer.sales_count,
            customer.item_count,
            customer.sales_total,
            customer.sales_total / customer.sales_count,
            customer.sales_total / customer.item_count)
    write_report_results('Customer_Results',header,customer_output)

def generate_items_report(items):
    # Print results
    items_output = ""
    header = "Results for Item analysis:"
    for item_id,item in items.items.items():
        items_output += """Item: {}\n
        Metrics: ###########################
        Sales Count = {}
        Total Discounted Sales: {}
        Discounted Sales Ratio: {}
        Total Items Sold: {}\n
        Financials: ########################
        Sales Total = ${}
        Average Sale Value: ${}
        Average Item Sold Value: ${}
        \n""".format(
            item_id,
            item.sales_count,
            item.discounted_sales,
            item.discounted_sales / item.sales_count,
            item.item_count,
            item.sales_total,
            item.sales_total / item.sales_count,
            item.sales_total / item.item_count)
    write_report_results('Item_Results',header,items_output)

# Generalised function to write a report to disk
def write_report_results(report_name,header,report_body):
    with open('Results/{}.txt'.format(report_name),'w+') as report:
        report.write(header + 2*'\n')
        report.write(report_body)

# Main hook
if __name__ == '__main__':
    # Open excel file stored in child folder
    excel_file = openpyxl.load_workbook('Data/Assignment1Data.xlsx')
    data = excel_file['Asgn1 Data']
    sales = Classes.Sales()
    employees = Classes.Employees()
    customers = Classes.Customers()
    items = Classes.Items()
    logged_errors = Classes.LoggedErrors()

    clear_error_log()

    # Main branch of code to parse excel file.
    parse_rows(data.rows,logged_errors)
    
    # If results folder and required text files don't exist, create them
    generate_results_structures()

    # Iterate over sales and employees to generate reports
    populate_receipt_totals(sales,employees,customers,items)