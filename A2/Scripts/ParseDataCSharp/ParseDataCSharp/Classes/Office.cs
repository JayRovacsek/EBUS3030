using System;
using System.Collections.Generic;
using System.Text;

namespace ParseDataCSharp.Classes
{
    public class Office
    {
        public int Id { get; set; }
        public Location OfficeLocation { get; set; }
        public string Surname { get; set; }
        public int SalesCount { get; set; }
        public decimal SalesTotal { get; set; }
        public int DiscountedSalesCount { get; set; }
    }

    public enum Location
    {
        Newcastle=1,
        Maitland,
        Cessnock,
        Sydney,
        PortMaquarie,
        Grafton,
        Dubbo,
        Wollongong,
        WaggaWagga,
        BrokenHill
    }
}
