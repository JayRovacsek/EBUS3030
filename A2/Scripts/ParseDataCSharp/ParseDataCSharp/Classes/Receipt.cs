using System;
using System.Collections.Generic;
using System.Text;

namespace ParseDataCSharp.Classes
{
    public class Receipt
    {
        public Receipt(int id, IEnumerable<Item> items, int officeId, Customer customer, Staff staff)
        {
            Id = id;
            Items = items;
            OfficeId = officeId;
            Customer = customer;
            Staff = staff;
        }

        public int Id { get; set; }
        public IEnumerable<Item> Items { get; set; }
        public int OfficeId { get; set; }
        public Customer Customer { get; set; }
        public Staff Staff { get; set; }
    }
}
