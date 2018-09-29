namespace ParseDataCSharp.Classes
{
    public class Item
    {
        public Item()
        {
        }

        public Item(int id, string description, double price, int quantity)
        {
            Id = id;
            Description = description;
            Price = price;
            Quantity = quantity;
        }

        public int Id { get; set; }
        public string Description { get; set; }
        public double Price { get; set; }
        public int Quantity { get; set; }
    }
}