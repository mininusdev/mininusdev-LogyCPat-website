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
    
    public partial class ActividadPatio
    {
        public long idActividad { get; set; }
        public Nullable<long> idTipoActividad { get; set; }
        public Nullable<long> idTipoUnidad { get; set; }
        public Nullable<long> idOperador { get; set; }
        public Nullable<long> idTransportista { get; set; }
        public Nullable<long> idUnidad { get; set; }
        public long idPatio { get; set; }
        public long idSector { get; set; }
        public long idNivel { get; set; }
        public long idCajon { get; set; }
        public string codigoQR { get; set; }
        public string codigoBarras { get; set; }
        public string descripcion { get; set; }
        public string valor1 { get; set; }
        public string valor2 { get; set; }
        public string valor3 { get; set; }
        public string valor4 { get; set; }
        public string valor5 { get; set; }
        public Nullable<long> clave1 { get; set; }
        public Nullable<long> clave2 { get; set; }
        public Nullable<long> clave3 { get; set; }
        public Nullable<long> clave4 { get; set; }
        public Nullable<long> clave5 { get; set; }
        public Nullable<double> dato1 { get; set; }
        public Nullable<double> dato2 { get; set; }
        public Nullable<System.DateTime> fecha1 { get; set; }
        public Nullable<System.DateTime> fecha2 { get; set; }
        public Nullable<System.DateTime> fecha3 { get; set; }
        public Nullable<bool> bolExtendido { get; set; }
        public bool esVisible { get; set; }
        public long idEstatus { get; set; }
        public System.DateTime fechaRegistro { get; set; }
        public Nullable<System.DateTime> fechaModificacion { get; set; }
        public Nullable<long> idUsuarioRegistro { get; set; }
        public Nullable<long> idUsuarioModificacion { get; set; }
    }
}