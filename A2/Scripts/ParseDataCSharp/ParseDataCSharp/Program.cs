using ExcelDataReader;
using ParseDataCSharp.Classes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;

namespace ParseDataCSharp
{
    class Program
    {
        static void Main(string[] args)
        {
            System.Text.Encoding.RegisterProvider(System.Text.CodePagesEncodingProvider.Instance);
            var data = GetExcelData();
            var counter = 0;

            var receipts = new Dictionary<int, Receipt>();
            var invalidReceipts = new Dictionary<int, Receipt>();
            var offices = new List<Office>();

            foreach (DataTable table in data.Tables)
            {
                foreach (DataRow row in table.Rows)
                {
                    // Ignore the header of the table
                    if (counter > 0)
                    {
                        var item = new Item()
                        {
                            Id = Convert.ToInt32(row[11]),
                            Description = row[12].ToString(),
                            Price = (double)row[14],
                            Quantity = Convert.ToInt32(row[13])
                        };

                        var office = new Office()
                        {
                            Id = Convert.ToInt32(row[8]),
                            OfficeLocation = ParseEnum<Location>(row[9].ToString())
                        };

                        if (offices.Count == 0 || !offices.Exists(o => o.OfficeLocation == office.OfficeLocation))
                        {
                            offices.Add(office);
                            Console.WriteLine($@"Added office: {office.OfficeLocation}");
                        }

                        var receipt = new Receipt()
                        {
                            Id = Convert.ToInt32(row[1]),
                            Customer = new Customer()
                            {
                                FirstName = row[3].ToString(),
                                Id = row[2].ToString(),
                                Surname = row[4].ToString()
                            },
                            Staff = new Staff()
                            {
                                OfficeId = office.Id,
                                Id = row[5].ToString(),
                                FirstName = row[6].ToString(),
                                Surname = row[7].ToString()
                            },
                            SaleDate = (DateTime)row[0],
                            Items = new Dictionary<int, Item>
                            {
                                { item.Id, item }
                            },
                            Office = office
                        };

                        if (receipts.Count == 0 || !receipts.ContainsKey(receipt.Id))
                        {
                            receipts.Add(receipt.Id, receipt);
                            Console.WriteLine($@"Added new receipt: {receipt.Id}");
                        }
                        else if (receipts.ContainsKey(receipt.Id))
                        {
                            var logged = false;
                            var existingReceipt = receipts[receipt.Id];

                            // Be warned; below is a fucking mess.

                            if ((existingReceipt.Staff.Id != receipt.Staff.Id
                                || existingReceipt.Staff.FirstName != receipt.Staff.FirstName
                                || existingReceipt.Staff.Surname != receipt.Staff.Surname)
                                && !logged)
                            {
                                invalidReceipts.Add(receipt.Id, receipt);
                                logged = true;
                                Console.WriteLine($"Staff Id mismatch on receipt: {existingReceipt.Id}, " +
                                    $"Staff Ids: {existingReceipt.Staff.Id} and {receipt.Staff.Id}, " +
                                    $"Staff Names: {existingReceipt.Staff.FirstName} and {receipt.Staff.FirstName}, " +
                                    $"Staff Surnames: {existingReceipt.Staff.Surname} and {receipt.Staff.Surname}, ");
                            }

                            if ((existingReceipt.Office.Id != receipt.Office.Id
                                || existingReceipt.Office.OfficeLocation != receipt.Office.OfficeLocation)
                                && !logged)
                            {
                                invalidReceipts.Add(receipt.Id, receipt);
                                logged = true;
                                Console.WriteLine($"Office Id mismatch on receipt: {existingReceipt.Id}, " +
                                    $"Office Ids: {existingReceipt.Office.Id} and {receipt.Office.Id}, " +
                                    $"Office Locations: {existingReceipt.Office.OfficeLocation} and {receipt.Office.OfficeLocation}");
                            }

                            if (existingReceipt.SaleDate != receipt.SaleDate && !logged)
                            {
                                invalidReceipts.Add(receipt.Id, receipt);
                                logged = true;
                                Console.WriteLine($"Sale date mismatch on receipt: {existingReceipt.Id}, " +
                                    $"Dates: {existingReceipt.SaleDate} and {receipt.SaleDate}");
                            }

                            if ((existingReceipt.Customer.Id != receipt.Customer.Id 
                                || existingReceipt.Customer.FirstName != receipt.Customer.FirstName
                                || existingReceipt.Customer.Surname != receipt.Customer.Surname)
                                && !logged)
                            {
                                invalidReceipts.Add(receipt.Id, receipt);
                                logged = true;
                                Console.WriteLine($"Customer mismatch on receipt: {existingReceipt.Id}, " +
                                    $"Customers Ids: {existingReceipt.Customer.Id} and {receipt.Customer.Id}, " +
                                    $"Customers Names: {existingReceipt.Customer.FirstName} and {receipt.Customer.FirstName}, " +
                                    $"Customers Surnames: {existingReceipt.Customer.Surname} and {receipt.Customer.Surname}, ");
                            }

                            if (existingReceipt.Items.ContainsKey(item.Id) && !logged)
                            {
                                Console.WriteLine($"Item exists in current receipt with Id: {item.Id}, " +
                                    $"updated item quantity from: {existingReceipt.Items[item.Id].Quantity} " +
                                    $"to new quantity: {existingReceipt.Items[item.Id].Quantity + item.Quantity}");

                                existingReceipt.Items[item.Id].Quantity += item.Quantity;
                            }
                            else if (!logged)
                            {
                                existingReceipt.Items.Add(item.Id, item);
                                Console.WriteLine($@"Added item with Id: {item.Id} to existing receipt: {receipt.Id}");
                            }
                            receipts[existingReceipt.Id] = existingReceipt;
                        }
                    }
                    counter++;
                    // LINQ expressions here to evaluate invalid entries.
                }
            }

            var errors = DetermineErrors(receipts);

            Console.WriteLine($@"Parsed total rows: {counter}");
            Console.WriteLine($@"Parsed unique receipts: {receipts.Count}");
            Console.ReadKey();
        }

        private static List<Error> DetermineErrors(Dictionary<int, Receipt> receipts)
        {
            //var staffMismatchErrors = receipts.Where(
            //    x => x.Value.).
            return null;
        }

        public static T ParseEnum<T>(string value)
        {
            return (T)Enum.Parse(typeof(T), Regex.Replace(value, @"\s+", ""), true);
        }

        public static DataSet GetExcelData()
        {
            using (var stream = File.Open(@"Data\\Assignment2Data.xlsx", FileMode.Open, FileAccess.Read))
            {
                using (var reader = ExcelReaderFactory.CreateReader(stream))
                {
                    return reader.AsDataSet();
                }
            }
        }
    }
}
