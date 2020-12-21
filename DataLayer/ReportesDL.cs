using logistica.Models;
using NLog;
using System;
using System.Collections.Generic;
using System.Linq;

namespace logistica.DataLayer
{
    public class ReportesDL
    {

        private static Logger _logger = LogManager.GetCurrentClassLogger();

        internal static List<spPuertas_ObtenerReporteGeneral_Result> GenerarReporte(string selectedValue)
        {
            List<spPuertas_ObtenerReporteGeneral_Result> _elementos = new List<spPuertas_ObtenerReporteGeneral_Result>();
            CDLogisticaAEntities _db = new CDLogisticaAEntities();

            try
            {
                _elementos = _db.spPuertas_ObtenerReporteGeneral(selectedValue).ToList();
            }
            catch (Exception ee)
            {
                if (ee.InnerException != null)
                    _logger.Error(ee.InnerException.Message);
            }

            return _elementos;
        }
    }
}