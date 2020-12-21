using System;
using System.Web;
using System.Web.Configuration;
using System.Web.Optimization;
using System.Web.Routing;

namespace logistica
{
    public class Global : HttpApplication
    {
        public static string _nomSitio = string.Empty;
        string _rutaFisicaApp = string.Empty;

        void Application_Start(object sender, EventArgs e)
        {
            // Código que se ejecuta al iniciar la aplicación
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            _rutaFisicaApp = Server.MapPath(".");

            if (WebConfigurationManager.AppSettings["AMBIENTE"].ToString() != null)
            {
                switch (WebConfigurationManager.AppSettings["AMBIENTE"].ToString().ToUpper())
                {
                    case "DEV":
                        _nomSitio = string.Empty;
                        break;
                    case "QA":
                        _nomSitio = System.Web.Hosting.HostingEnvironment.ApplicationHost.GetSiteName().Replace('\\', '/') + "/";
                        break;
                    case "PROD":
                        _nomSitio = System.Web.Hosting.HostingEnvironment.ApplicationHost.GetSiteName().Replace('\\', '/') + "/";
                        break;
                    default:
                        _nomSitio = string.Empty;
                        break;
                }
            }
        }
    }
}