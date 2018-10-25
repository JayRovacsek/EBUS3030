namespace ParseDataCSharp.Classes
{
    public class Office
    {
        public int Id { get; set; }
        public Location OfficeLocation { get; set; }
        public int SalesCount { get; set; } = 0;
        public decimal SalesTotal { get; set; } = 0;
        public int DiscountedSalesCount { get; set; } = 0;
    }

    public enum Location
    {
        Newcastle = 1,
        Maitland,
        Cessnock,
        Sydney,
        PortMacquarie,
        Grafton,
        Dubbo,
        Wollongong,
        WaggaWagga,
        BrokenHill
    }
}