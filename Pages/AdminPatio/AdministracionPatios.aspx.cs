using logistica.DataLayer;
using System;

namespace logistica.Pages.AdminPatio
{
    public partial class AdministracionPatios : System.Web.UI.Page
    {
        public string _URLWS_ = string.Empty;

        protected void Page_Init(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Context.User.Identity.Name))
                Response.Redirect("~/Account/Login");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                _URLWS_ = ParametrosDL.ObtenerParametroURLWS();

                //if (!ParametrosDL.ObtenerParametroCapturarFotoEntrada())
                //    camara.Disabled = true;
            }
        }

    }
}