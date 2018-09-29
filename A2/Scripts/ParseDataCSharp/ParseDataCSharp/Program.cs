using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using ExcelDataReader;
using ParseDataCSharp.Classes;
using ParseDataCSharp.Methods;

namespace ParseDataCSharp
{
    internal class Program
    {
        private static void Main(string[] args)
        {
            // Initialise method helper to cleanup Main()
            var methodHelper = new MethodHelper();

            // Register required encoding provider for ExcelDataReader
            Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);
            // Generate dataset to be parsed
            var dataSet = methodHelper.GetExcelData();
            // Generate tuple of <Dictionary<int, receipt>, Dictionary<int, receipt>, int>
            var parsedData = methodHelper.GenerateReceipts(dataSet);

            // Split generated tuple into distinct objects to work with
            var receipts = parsedData.Item1;
            var invalidReceipts = parsedData.Item2;
            var rowsProcessed = parsedData.Item3;

            // Output a bit of data to let us know how the process went
            Console.WriteLine($@"Parsed total rows: {rowsProcessed}");
            Console.WriteLine($@"Parsed unique receipts: {receipts.Count}");
            Console.WriteLine($@"Found {invalidReceipts.Count} invalid receipts");

            // Catch to allow user to debug if relevant 
            Console.ReadKey();
        }
    }
}