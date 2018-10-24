using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using ExcelDataReader;
using ParseDataCSharp.Classes;

namespace ParseDataCSharp.Methods
{
    public class MethodHelper
    {
        /// <summary>
        ///     Parses excel file located in the \bin\Debug\netcoreapp2.1\Data folder,
        ///     as this isn't included in source control you may need to create the file and folders.
        ///     Pathing is as follows:
        ///     EBUS3030\A2\Scripts\ParseDataCSharp\ParseDataCSharp\bin\Debug\netcoreapp2.1\Data\Assignment2Data.xlsx
        /// </summary>
        /// <returns></returns>
        public DataSet GetExcelData()
        {
            using (var stream = File.Open(@"Data\\Assignment2Data.xlsx", FileMode.Open, FileAccess.Read))
            {
                using (var reader = ExcelReaderFactory.CreateReader(stream))
                {
                    return reader.AsDataSet();
                }
            }
        }

        /// <summary>
        ///     Parses a string for a respective enum value with a given type.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="value"></param>
        /// <returns></returns>
        private T ParseEnum<T>(string value)
        {
            return (T)Enum.Parse(typeof(T), Regex.Replace(value, @"\s+", ""), true);
        }

        private Dictionary<int, Receipt> AddToReceipts(Dictionary<int, Receipt> receipts, Receipt receipt)
        {
            if (receipts.ContainsKey(receipt.Id))
            {
                receipts.Add(receipts.Keys.LastOrDefault() + 1, receipt);
            }
            else
            {
                receipts.Add(receipt.Id, receipt);
            }

            return receipts;
        }

        /// <summary>
        ///     Parses a dataset to generate a dictionary of both valid and invalid receipts,
        ///     also returns a count of total rows parsed to ensure all rows have been iterated over.
        /// </summary>
        /// <param name="dataSet"></param>
        /// <returns></returns>
        public Tuple<Dictionary<int, Receipt>, Dictionary<int, Receipt>, int> GenerateReceipts(DataSet dataSet)
        {
            var receipts = new Dictionary<int, Receipt>();
            var invalidReceipts = new Dictionary<int, Receipt>();
            var counter = 0;

            // Iterate over each sheet in the dataset, in our case it's only one anyway.
            foreach (DataTable table in dataSet.Tables)
                // Iterate over each row in the dataset, it seems this iterates until it finds row with no values in any column.
                foreach (DataRow row in table.Rows)
                {
                    // Ignore the header of the table
                    if (counter > 0)
                    {
                        // Generation of receipt from dataset, ignoring transaction row id as it is not 
                        // relevant and we are consolidating the duplicate items into total quantities anyway. 
                        var receipt = new Receipt
                        {
                            Id = Convert.ToInt32(row[1]),
                            Customer = new Customer
                            {
                                FirstName = row[3].ToString(),
                                Id = row[2].ToString(),
                                Surname = row[4].ToString()
                            },
                            Staff = new Staff
                            {
                                OfficeId = Convert.ToInt32(row[8]),
                                Id = row[5].ToString(),
                                FirstName = row[6].ToString(),
                                Surname = row[7].ToString()
                            },
                            SaleDate = (DateTime)row[0],
                            Items = new Dictionary<int, Item>
                        {
                            {
                                Convert.ToInt32(row[11]), new Item
                                {
                                    Id = Convert.ToInt32(row[11]),
                                    Description = row[12].ToString(),
                                    Price = (double) row[14],
                                    Quantity = Convert.ToInt32(row[13])
                                }
                            }
                        },
                            Office = new Office
                            {
                                Id = Convert.ToInt32(row[8]),
                                OfficeLocation = ParseEnum<Location>(row[9].ToString())
                            }
                        };

                        // Check if receipts either is empty or doesn't have a receipt 
                        // with the same receipt id already, if so add the receipt to 
                        // receipts.
                        if (receipts.Count == 0 || !receipts.ContainsKey(receipt.Id))
                        {
                            AddToReceipts(receipts, receipt);
                            Console.WriteLine($@"Added new receipt: {receipt.Id}");
                        }
                        // 
                        else if (receipts.ContainsKey(receipt.Id))
                        {
                            var existingReceipt = receipts[receipt.Id];

                            // Be warned; below is a fucking mess.

                            // Check all staff properties match the existing receipt properties.
                            if (existingReceipt.Staff.Id != receipt.Staff.Id
                                || existingReceipt.Staff.FirstName != receipt.Staff.FirstName
                                || existingReceipt.Staff.Surname != receipt.Staff.Surname)
                            {
                                AddToReceipts(invalidReceipts, receipt);
                                Console.WriteLine($"Staff Id mismatch on receipt: {existingReceipt.Id}, " +
                                                  $"Staff Ids: {existingReceipt.Staff.Id} and {receipt.Staff.Id}, " +
                                                  $"Staff Names: {existingReceipt.Staff.FirstName} and {receipt.Staff.FirstName}, " +
                                                  $"Staff Surnames: {existingReceipt.Staff.Surname} and {receipt.Staff.Surname}, ");
                                continue;
                            }

                            // Check all office properties match the existing receipt properties.
                            if (existingReceipt.Office.Id != receipt.Office.Id
                                || existingReceipt.Office.OfficeLocation != receipt.Office.OfficeLocation)
                            {
                                AddToReceipts(invalidReceipts, receipt);
                                Console.WriteLine($"Office Id mismatch on receipt: {existingReceipt.Id}, " +
                                              $"Office Ids: {existingReceipt.Office.Id} and {receipt.Office.Id}, " +
                                              $"Office Locations: {existingReceipt.Office.OfficeLocation} and {receipt.Office.OfficeLocation}");
                                continue;
                            }

                            // Check all date properties match the existing receipt properties.
                            if (existingReceipt.SaleDate != receipt.SaleDate)
                            {
                                AddToReceipts(invalidReceipts, receipt);
                                Console.WriteLine($"Sale date mismatch on receipt: {existingReceipt.Id}, " +
                                                  $"Dates: {existingReceipt.SaleDate} and {receipt.SaleDate}");
                                continue;
                            }

                            // Check all customer properties match the existing receipt properties.
                            if (existingReceipt.Customer.Id != receipt.Customer.Id
                                || existingReceipt.Customer.FirstName != receipt.Customer.FirstName
                                || existingReceipt.Customer.Surname != receipt.Customer.Surname)
                            {
                                AddToReceipts(invalidReceipts, receipt);
                                Console.WriteLine($"Customer mismatch on receipt: {existingReceipt.Id}, " +
                                                  $"Customers Ids: {existingReceipt.Customer.Id} and {receipt.Customer.Id}, " +
                                                  $"Customers Names: {existingReceipt.Customer.FirstName} and {receipt.Customer.FirstName}, " +
                                                  $"Customers Surnames: {existingReceipt.Customer.Surname} and {receipt.Customer.Surname}, ");
                                continue;
                            }

                            // If not item mismatches exist, we need to determine if the item 
                            // exists in both the compared receipts.
                            var key = receipt.Items.First().Key;
                            var value = receipt.Items.First().Value;

                            // Check if the item exists in the existing receipt already.
                            if (existingReceipt.Items.ContainsKey(receipt.Items.First().Key))
                            {
                                var quantity = receipt.Items.First().Value.Quantity;
                                Console.WriteLine($"Item exists in current receipt with Id: {key}, " +
                                                  $"updated item quantity from: {existingReceipt.Items[key].Quantity} " +
                                                  $"to new quantity: {existingReceipt.Items[key].Quantity + quantity}");

                                // Update quantity on item in existing receipt.
                                existingReceipt.Items[key].Quantity += quantity;
                                receipts[existingReceipt.Id] = existingReceipt;
                            }
                            else
                            {
                                // Update the receipt with the new item added.
                                existingReceipt.Items.Add(key, value);
                                Console.WriteLine($@"Added item with Id: {value.Id} to existing receipt: {receipt.Id}");
                            }
                        }
                    }
                    counter++;
                }

            return new Tuple<Dictionary<int, Receipt>, Dictionary<int, Receipt>, int>(receipts, invalidReceipts,
                counter);
        }

        public void CreateFile(string filename, string contents)
        {
            try
            {
                if (File.Exists(filename))
                {
                    File.Delete(filename);
                }

                using(var fileStream = File.Create(filename))
                {
                    // Add some text to file
                    Byte[] title = new UTF8Encoding(true).GetBytes(contents);
                    fileStream.Write(title, 0, title.Length);
                }

            }
            catch(Exception exception)
            {
                Console.WriteLine($"An exception occured: {exception.Message}");
            }
        }

        public string GenerateSQL(Dictionary<int, Receipt> receipts)
        {
            var output = new StringBuilder();

            Parallel.ForEach(receipts, receipt =>
            {
                var itemTotalPrices = new Dictionary<int, double>();

                Parallel.ForEach(receipt.Value.Items, item =>
                {
                    var totalItemPrice = item.Value.Price * item.Value.Quantity;
                    itemTotalPrices.Add(item.Key, totalItemPrice);
                });

                var total = itemTotalPrices.Sum(x => x.Value);
                var discountTotal = (itemTotalPrices.Count >= 5) ? total * 0.95 : 0;

                var sql = new StringBuilder($@"

    INSERT INTO [Receipt] 
    VALUES( {receipt.Value.SaleDate},
            {receipt.Key},
            '{receipt.Value.Customer.Id}',
            '{receipt.Value.Staff.Id}',
            {total},
            {discountTotal});");

                foreach(var item in itemTotalPrices)
                {
                    sql.Append($@"
    
    INSERT INTO [ReceiptItem]
    VALUES( {receipt.Key},
            {item.Key},
            {receipt.Value.Items.Select(x => x.Value).Where(y => y.Id == item.Key).FirstOrDefault().Quantity},
            {receipt.Value.Items.Select(x => x.Value).Where(y => y.Id == item.Key).FirstOrDefault().Price});");
                }

                output.Append(sql);
            });

            return output.ToString();
        }
    }
}