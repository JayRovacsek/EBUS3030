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

        public Receipt(int id, IQueryable<IEnumerable<Item>> items, int officeId, Customer customer, Staff staff)
        {
            Id = id;
            Items = items;
            OfficeId = officeId;
            Customer = customer;
            Staff = staff;
        }

        public int Id { get; set; }
        public IQueryable<IEnumerable<Item>> Items { get; set; }
        public int OfficeId { get; set; }
        public Customer Customer { get; set; }
        public Staff Staff { get; set; }
    }
}
