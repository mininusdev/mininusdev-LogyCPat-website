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
    
    public partial class LOG_bitacoraGeneral
    {
        public long idBitacora { get; set; }
        public System.DateTime fechaRegistro { get; set; }
        public string tabla_SP_vista { get; set; }
        public string operacion { get; set; }
        public Nullable<long> IdRegistroAfectado { get; set; }
        public Nullable<long> IdUsuario { get; set; }
        public string txtDetalle1 { get; set; }
        public string txtDetalle2 { get; set; }
    }
}
