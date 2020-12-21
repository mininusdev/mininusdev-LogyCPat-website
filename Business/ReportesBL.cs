using logistica.DataLayer;
using logistica.Models;
using System.Collections.Generic;

namespace logistica.Business
{
    public class ReportesBL
    {
        internal List<spPuertas_ObtenerReporteGeneral_Result> GenerarReporte(string selectedValue)
        {
            return ReportesDL.GenerarReporte(selectedValue);
        }
    }
}