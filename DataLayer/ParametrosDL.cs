using logistica.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace logistica.DataLayer
{
    public class ParametrosDL
    {
        public static string ObtenerParametroURLWS()
        {
            try
            {
                CDLogisticaAEntities _db = new CDLogisticaAEntities();

                var _params = _db.Parametros.Where(p => p.nomParametro.Trim().ToUpper().Equals("WS_URL")).FirstOrDefault();

                return _params.valor1.Trim();
            }
            catch (Exception ee)
            {
                return "http://localhost/WSLogistica/";
            }
        }

        public static bool ObtenerParametroCapturarFotoEntrada()
        {
            bool resp = false;

            try
            {
                CDLogisticaAEntities _db = new CDLogisticaAEntities();

                var _params = _db.Parametros.Where(p => p.nomParametro.Trim().ToUpper().Equals("GENERAL_ENTRADAS_CAPTURAR_FOTO")).FirstOrDefault();

                if (_params != null)
                {
                    bool.TryParse(_params.valor1.Trim(), out resp);
                }
            }
            catch (Exception ee)
            {
            }

            return resp;
        }
    }
}