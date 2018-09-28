using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ParseDataCSharp.Classes
{
    public class Receipt
    {
        public Receipt()
        {
        }

        public Receipt(int id, Dictionary<int,Item> items, int officeId, Customer customer, Staff staff)
        {
            Id = id;
            Items = items;
            OfficeId = officeId;
            Customer = customer;
            Staff = staff;
        }

        public int Id { get; set; }
        public Dictionary<int,Item> Items { get; set; }
        public int OfficeId { get; set; }
        public Customer Customer { get; set; }
        public Staff Staff { get; set; }
        public DateTime SaleDate { get; set; }
    }
}
