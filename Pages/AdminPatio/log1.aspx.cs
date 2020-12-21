using logistica.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace logistica
{
    public partial class log1 : System.Web.UI.Page
    {
        private CDLogisticaAEntities db;
        List<vwActividadesPuerta> _actividades;

        public log1()
        {
            db = new CDLogisticaAEntities();
            _actividades = new List<vwActividadesPuerta>();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            _actividades = db.vwActividadesPuerta.OrderByDescending(p => p.fechaActividad).Take(10).ToList();
        }

        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);
            lvLogActividades.DataSource = _actividades;
            lvLogActividades.DataBind();
        }

        protected void lvLogActividades_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                vwActividadesPuerta _actividad = (vwActividadesPuerta)e.Item.DataItem;
                ((HtmlTableCell)e.Item.FindControl("tipoActividad")).InnerText = _actividad.tipoActividad;
                ((HtmlTableCell)e.Item.FindControl("tipoUnidad")).InnerText = _actividad.tipoUnidad;
                ((HtmlTableCell)e.Item.FindControl("puerta")).InnerText = _actividad.puerta;
                ((HtmlTableCell)e.Item.FindControl("nota")).InnerText = _actividad.nota;
                ((HtmlTableCell)e.Item.FindControl("clave")).InnerText = _actividad.clave;
                ((HtmlTableCell)e.Item.FindControl("fecha")).InnerText = _actividad.fechaActividad.ToString();
                ((HtmlTableCell)e.Item.FindControl("costoNormal")).InnerText = _actividad.costoNormal.ToString();
                ((HtmlTableCell)e.Item.FindControl("usuarioRegistro")).InnerText = _actividad.usuarioRegistro;
            }
        }

    }
}