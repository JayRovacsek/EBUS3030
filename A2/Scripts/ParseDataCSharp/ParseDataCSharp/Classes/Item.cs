using System;
using System.Collections.Generic;
using System.Text;

namespace ParseDataCSharp.Classes
{
    public class Item
    {
        public Item(int id, string description, decimal price, int quantity)
        {
            Id = id;
            Description = description;
            Price = price;
            Quantity = quantity;
        }

        public int Id { get; set; }
        public string Description { get; set; }
        public decimal Price { get; set; }
        public int Quantity { get; set; }
    }
}
