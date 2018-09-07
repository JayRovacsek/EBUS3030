using ExcelDataReader;
using System;
using System.Data;
using System.IO;

namespace ParseDataCSharp
{
    class Program
    {
        static void Main(string[] args)
        {
            System.Text.Encoding.RegisterProvider(System.Text.CodePagesEncodingProvider.Instance);
            var data = GetExcelData();
            foreach(DataTable table in data.Tables)
            {
                foreach(DataRow row in table.Rows)
                {
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
