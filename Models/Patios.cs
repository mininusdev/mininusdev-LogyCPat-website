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
    
    public partial class Patios
    {
        public long idPatio { get; set; }
        public string nombre { get; set; }
        public string nombreVisible { get; set; }
        public string descripcion { get; set; }
        public System.DateTime fechaRegistro { get; set; }
        public long usuarioRegistro { get; set; }
        public Nullable<System.DateTime> fechaModificacion { get; set; }
        public Nullable<long> usuarioModificacion { get; set; }
        public bool esVisible { get; set; }
        public long idEstatus { get; set; }
        public string claveTexto { get; set; }
        public Nullable<long> valorAsociado { get; set; }
        public Nullable<long> idPropietario { get; set; }
        public Nullable<long> idArrendador { get; set; }
        public Nullable<int> ordenVisual { get; set; }
        public bool esActivo { get; set; }
    }
}