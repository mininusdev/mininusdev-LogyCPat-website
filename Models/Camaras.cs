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
    
    public partial class Camaras
    {
        public long idCamara { get; set; }
        public string nombre { get; set; }
        public string nombreVisible { get; set; }
        public string descripcion { get; set; }
        public string claveTexto { get; set; }
        public Nullable<int> ordenVisual { get; set; }
        public string config1 { get; set; }
        public string config2 { get; set; }
        public string config3 { get; set; }
        public Nullable<long> clave1 { get; set; }
        public Nullable<long> clave2 { get; set; }
        public Nullable<long> clave3 { get; set; }
        public Nullable<long> clave4 { get; set; }
        public Nullable<long> clave5 { get; set; }
        public Nullable<long> clave6 { get; set; }
        public Nullable<long> clave7 { get; set; }
        public Nullable<long> clave8 { get; set; }
        public Nullable<long> clave9 { get; set; }
        public bool esActivo { get; set; }
        public bool esVisible { get; set; }
        public Nullable<long> idEstatus { get; set; }
        public System.DateTime fechaRegistro { get; set; }
        public Nullable<System.DateTime> fechaModificacion { get; set; }
        public Nullable<long> idUsuarioRegistro { get; set; }
        public Nullable<long> idUsuarioModificacion { get; set; }
    }
}
