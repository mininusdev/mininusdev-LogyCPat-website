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
    
    public partial class vwActividadesPuerta
    {
        public long idActividad { get; set; }
        public Nullable<long> idTipoActividad { get; set; }
        public string tipoActividad { get; set; }
        public Nullable<long> idTipoUnidad { get; set; }
        public string tipoUnidad { get; set; }
        public Nullable<long> idModoAsignacion { get; set; }
        public string modoAsignacion { get; set; }
        public Nullable<long> idTarifa { get; set; }
        public string tarifa { get; set; }
        public Nullable<long> idPuerta { get; set; }
        public string puerta { get; set; }
        public string nota { get; set; }
        public string clave { get; set; }
        public Nullable<System.DateTime> fechaActividad { get; set; }
        public Nullable<decimal> costoNormal { get; set; }
        public Nullable<long> idUsuarioRegistro { get; set; }
        public string usuarioRegistro { get; set; }
        public string rutaBoleto { get; set; }
    }
}
