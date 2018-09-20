using ExcelDataReader;
using ParseDataCSharp.Classes;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;

namespace ParseDataCSharp
{
    class Program
    {
        static void Main(string[] args)
        {
            System.Text.Encoding.RegisterProvider(System.Text.CodePagesEncodingProvider.Instance);
            var data = GetExcelData();
            var counter = 0;

            List<Receipt> receipts = new List<Receipt>();
            List<Office> offices = new List<Office>();

            foreach (DataTable table in data.Tables)
            {
                foreach(DataRow row in table.Rows)
                {
                    // Ignore the header of the table
                    if(counter > 0)
                    {
                        Item item = new Item()
                        {
                            Id = (int)row[11],
                            Description = row[12].ToString(),
                            Price = (decimal)row[14],
                            Quantity = (int)row[13]
                        };

                        Office office = new Office()
                        {
                            Id = (int)row[8]
                        };

                        // int oddNumbers = numbers.Count(n => n % 2 == 1);  

                        if (offices.Where(office => office.Id))


                        //var selected = persons.Where(p => p.Appearance
                        //    .Where(a => listOfSearchedIds.Contains(a.Id))
                        //    .Any()).ToList();



                        Receipt receipt = new Receipt()
                        {
                            Id = (int)row[1],
                            Customer = new Customer()
                            {
                                FirstName = row[3].ToString(),
                                Id = (int)row[2],
                                Surname = row[4].ToString()
                            }
                    };

                        Console.WriteLine(row);
                    }
                    counter++;
                    // LINQ expressions here to create classes.
                }
            }
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
