//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace logistica.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class CatalogosElementosExt
    {
        public long idElementoExt { get; set; }
        public long idCatalogoElemento { get; set; }
        public string campo1 { get; set; }
        public string campo2 { get; set; }
        public string campo3 { get; set; }
        public string campo4 { get; set; }
        public string campo5 { get; set; }
        public string campo6 { get; set; }
        public string campo7 { get; set; }
        public string campo8 { get; set; }
        public string campo9 { get; set; }
        public string campo10 { get; set; }
    
        public virtual CatalogosElementos CatalogosElementos { get; set; }
    }
}
