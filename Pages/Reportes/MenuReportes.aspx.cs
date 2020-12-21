using logistica.Business;
using logistica.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace logistica.Pages.Reportes
{
    public partial class MenuReportes : System.Web.UI.Page
    {

        protected void Page_Init(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Context.User.Identity.Name))
                Response.Redirect("~/Account/Login");
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected List<spPuertas_ObtenerReporteGeneral_Result> CargarDatos()
        {
            ReportesBL _reportes = new ReportesBL();
            return _reportes.GenerarReporte(ddlTipoReporteGral.SelectedValue);
        }

        protected void ddlTipoReporteGral_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                gvReporte.DataSource = CargarDatos();
                gvReporte.DataBind();
                if (ddlTipoReporteGral.SelectedIndex > 0)
                    btnExportar.Visible = true;
                else
                    btnExportar.Visible = false;
            }
            catch (Exception ee)
            {
            }
        }

        protected void btnExportar_Click(object sender, EventArgs e)
        {
            try
            {
                GridView genGridView = new GridView();
                genGridView.AutoGenerateColumns = true;
                genGridView.AllowPaging = false;
                genGridView.DataSource = CargarDatos();
                genGridView.DataBind();

                Response.Clear();
                Response.Buffer = true;
                Response.ClearContent();
                Response.ClearHeaders();
                Response.Charset = "";
                string FileName = "LogyCPat_Reporte_" + ddlTipoReporteGral.SelectedValue + "_" + DateTime.Now + ".xls";
                StringWriter strwritter = new StringWriter();
                HtmlTextWriter htmltextwrtter = new HtmlTextWriter(strwritter);
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.ContentType = "application/vnd.ms-excel";
                Response.AddHeader("Content-Disposition", "attachment;filename=" + FileName);

                genGridView.GridLines = GridLines.Both;
                genGridView.HeaderStyle.Font.Bold = true;
                genGridView.RenderControl(htmltextwrtter);
                Response.Write(strwritter.ToString());

                HttpContext.Current.Response.Flush();
                HttpContext.Current.Response.SuppressContent = true;
                HttpContext.Current.ApplicationInstance.CompleteRequest();

            }
            catch (Exception ee)
            { }
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            //required to avoid the run time error "  
            //Control 'GridView1' of type 'Grid View' must be placed inside a form tag with runat=server."  
        }

        protected void gvReporte_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvReporte.DataSource = CargarDatos();
            gvReporte.PageIndex = e.NewPageIndex;
            gvReporte.DataBind();
        }

    }
}