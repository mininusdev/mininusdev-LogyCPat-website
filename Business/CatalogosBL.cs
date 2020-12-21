using logistica.DataLayer;
using logistica.Models;
using System;
using System.Collections.Generic;

namespace logistica.Business
{
    public class CatalogosBL
    {
        CatalogosDL _cat = new CatalogosDL();

        internal List<CatalogosElementos> ObtenerElementos(long idCatalogo)
        {
            return _cat.ObtenerElementos(idCatalogo);
        }

        internal bool EliminarElemento(long id)
        {
            return _cat.BorradoLogicoElemento(id);
        }

        internal bool ActualizarElemento(CatalogosElementos elemento)
        {
            return _cat.ActualizarElemento(elemento);
        }

        internal bool AgregarElemento(CatalogosElementos elemento)
        {
            return _cat.AgregarElemento(elemento);
        }
    }
}