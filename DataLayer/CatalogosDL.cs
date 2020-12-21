using logistica.Models;
using NLog;
using System;
using System.Collections.Generic;
using System.Linq;

namespace logistica.DataLayer
{
    public class CatalogosDL
    {
        CDLogisticaAEntities _db = new CDLogisticaAEntities();
        private static Logger _logger = LogManager.GetCurrentClassLogger();

        internal List<CatalogosElementos> ObtenerElementos(long idCatalogo)
        {
            List<CatalogosElementos> _elementos = new List<CatalogosElementos>();

            try
            {
                _elementos = _db.CatalogosElementos.Where(p => p.idCatalogo == idCatalogo && p.esActivo == true && p.esEditable == true)
                               .OrderBy(q => q.ordenVisual)
                               .ToList();
            }
            catch (Exception ee)
            {
                if (ee.InnerException != null)
                    _logger.Error(ee.InnerException.Message);
            }

            return _elementos;
        }

        internal bool ActualizarElemento(CatalogosElementos _elem)
        {
            bool _result = false;

            try
            {
                CatalogosElementos _existe = _db.CatalogosElementos.Where(p => p.idElemento == _elem.idElemento).FirstOrDefault();
                _existe.nombre = _elem.nombre;
                _existe.nombreVisible = _elem.nombreVisible;
                _existe.claveTexto = _elem.claveTexto;
                _existe.descripcion = _elem.descripcion;
                _existe.valorAsociado = _elem.valorAsociado;
                _existe.ordenVisual = _elem.ordenVisual;
                _db.SaveChanges();

                _result = true;
            }
            catch (Exception ee)
            {
                if (ee.InnerException != null)
                    _logger.Error(ee.InnerException.Message);
            }

            return _result;
        }

        internal bool AgregarElemento(CatalogosElementos _elem)
        {
            bool _result = false;

            try
            {
                CatalogosElementos _nuevo = new CatalogosElementos();
                _nuevo.idCatalogo = _elem.idCatalogo;
                _nuevo.nombre = _elem.nombre;
                _nuevo.nombreVisible = _elem.nombreVisible;
                _nuevo.claveTexto = _elem.claveTexto;
                _nuevo.descripcion = _elem.descripcion;
                _nuevo.valorAsociado = _elem.valorAsociado;
                _nuevo.ordenVisual = _elem.ordenVisual;
                _nuevo.fechaRegistro = DateTime.Now;
                _nuevo.esActivo = true;
                _nuevo.esEditable = true;
                _nuevo.esVisible = true;

                _db.CatalogosElementos.Add(_nuevo);
                _db.SaveChanges();

                _result = true;
            }
            catch (Exception ee)
            {
                if (ee.InnerException != null)
                    _logger.Error(ee.InnerException.Message);
            }

            return _result;
        }

        internal bool BorradoFisicoElemento(long _id)
        {
            bool _result = false;

            try
            {
                CatalogosElementos _elim = new CatalogosElementos();
                _elim.idElemento = _id;
                _db.CatalogosElementos.Remove(_elim);

                _result = true;
            }
            catch (Exception ee)
            {
                if (ee.InnerException != null)
                    _logger.Error(ee.InnerException.Message);
            }

            return _result;
        }

        internal bool BorradoLogicoElemento(long _id)
        {
            bool _result = false;

            try
            {
                CatalogosElementos _elem = _db.CatalogosElementos.Where(p => p.idElemento == _id).FirstOrDefault();
                _elem.esActivo = false;
                _elem.esVisible = false;
                _db.SaveChanges();

                _result = true;
            }
            catch (Exception ee)
            {
                if (ee.InnerException != null)
                    _logger.Error(ee.InnerException.Message);
            }

            return _result;
        }
    }
}