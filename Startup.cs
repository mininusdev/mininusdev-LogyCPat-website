using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(logistica.Startup))]
namespace logistica
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
