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

            var receipts = new Dictionary<int, List<Receipt>>();
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
                                OfficeId = office.Id
                            },
                            SaleDate = (DateTime)row[0]
                        };

                        if (receipts.Count == 0 || !receipts.ContainsKey(receipt.Id))
                        {
                            var listReceipt = new List<Receipt>(new Receipt[] { receipt });
                            receipts.Add(receipt.Id, listReceipt);
                            Console.WriteLine($@"Added new receipt: {receipt.Id}");
                        }
                        else if (receipts.ContainsKey(receipt.Id))
                        {
                            receipts[receipt.Id].Add(receipt);
                            Console.WriteLine($@"Added to existing receipt: {receipt.Id}");
                        }
                    }
                    counter++;
                    // LINQ expressions here to evaluate invalid entries.
                }
            }
            Console.WriteLine($@"Parsed total rows: {counter}");
            Console.WriteLine($@"Parsed receipts: {receipts.Count}");
            Console.ReadKey();
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
