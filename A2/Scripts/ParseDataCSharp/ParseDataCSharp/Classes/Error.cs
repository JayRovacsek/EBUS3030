using System;
using System.Collections.Generic;
using System.Text;

namespace ParseDataCSharp.Classes
{
    public class Error
    {
        public Error()
        {
        }

        public Error(int id, string trace, int receiptId, ErrorType errorType, string customerId, string staffId, int itemQuantity, int duplicateItemQuantity)
        {
            Id = id;
            Trace = trace;
            ReceiptId = receiptId;
            ErrorType = errorType;
            CustomerId = customerId;
            StaffId = staffId;
            ItemQuantity = itemQuantity;
            DuplicateItemQuantity = duplicateItemQuantity;
        }

        public int Id { get; set; }
        public string Trace { get; set; }
        public int ReceiptId { get; set; }
        public ErrorType  ErrorType { get; set; }
        public string CustomerId { get; set; }
        public string StaffId { get; set; }
        public int ItemQuantity { get; set; }
        public int DuplicateItemQuantity { get; set; }
    }

    public enum ErrorType
    {
        StaffMismatch,
        CustomerMismatch,
        ItemDuplicate
    }
}
