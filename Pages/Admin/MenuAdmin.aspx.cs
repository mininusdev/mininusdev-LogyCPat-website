using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using logistica.Business;
using logistica.DataLayer;
using logistica.Models;
using logistica.Utilerias;
using Newtonsoft.Json;
using RestSharp;
using RestSharp.Extensions;

namespace logistica.Pages.Admin
{
    public partial class MenuAdmin : System.Web.UI.Page
    {
        List<CatalogosElementos> listaElementos;

        protected void Page_Init(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Context.User.Identity.Name))
                Response.Redirect("~/Account/Login");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                CargarListaCatalogos();
                CargarListaTarifas();
                CargarListaParametros();
                CargarListaUsuarios();
            }
        }

        public bool CargarListaTarifas()
        {
            bool result = false;

            try
            {
                RestClient client = new RestClient(ParametrosDL.ObtenerParametroURLWS());

                RestRequest request = new RestRequest("api/catalogos/elementos/TARIFAS,admin", DataFormat.Json);

                var res = client.Get<string>(request);

                switch (res.ResponseStatus)
                {
                    case ResponseStatus.Completed:
                        if (res != null && !string.IsNullOrEmpty(res.Content))
                        {
                            JsonSerializerSettings settings = new JsonSerializerSettings { Converters = new JsonConverter[] { new JsonGenericDictionaryOrArrayConverter() } };
                            List<KeyValuePair<long, string>> lista = JsonConvert.DeserializeObject<List<KeyValuePair<long, string>>>(res.Content, settings);

                            if (lista.Count > 0)
                            {
                                ddlTarifas.Items.Clear();

                                foreach (var elemento in lista)
                                {
                                    ListItem _n = new ListItem(elemento.Value, elemento.Key.ToString());
                                    ddlTarifas.Items.Add(_n);
                                }
                            }
                        }
                        result = true;

                        break;
                    case ResponseStatus.Error:
                        result = false;
                        break;
                }
            }
            catch (Exception ee)
            {

            }

            return result;
        }

        public bool CargarListaCatalogos()
        {
            bool result = false;

            try
            {
                RestClient client = new RestClient(ParametrosDL.ObtenerParametroURLWS());

                RestRequest request = new RestRequest("api/catalogos/1,admin", DataFormat.Json);

                var res = client.Get<string>(request);

                switch (res.ResponseStatus)
                {
                    case ResponseStatus.Completed:
                        if (res != null && !string.IsNullOrEmpty(res.Content))
                        {
                            JsonSerializerSettings settings = new JsonSerializerSettings { Converters = new JsonConverter[] { new JsonGenericDictionaryOrArrayConverter() } };
                            List<KeyValuePair<long, string>> lista = JsonConvert.DeserializeObject<List<KeyValuePair<long, string>>>(res.Content, settings);

                            if (lista.Count > 0)
                            {
                                ddlCatalogos.Items.Clear();

                                foreach (var elemento in lista)
                                {
                                    ListItem _n = new ListItem(elemento.Value, elemento.Key.ToString());
                                    ddlCatalogos.Items.Add(_n);
                                }
                            }
                        }
                        result = true;

                        break;
                    case ResponseStatus.Error:
                        result = false;
                        break;
                }
            }
            catch (Exception ee)
            {

            }

            return result;
        }

        public bool CargarListaParametros()
        {
            bool result = false;

            try
            {
                RestClient client = new RestClient(ParametrosDL.ObtenerParametroURLWS());

                RestRequest request = new RestRequest("api/parametros/1,admin", DataFormat.Json);

                var res = client.Get<string>(request);

                switch (res.ResponseStatus)
                {
                    case ResponseStatus.Completed:
                        if (res != null && !string.IsNullOrEmpty(res.Content))
                        {
                            JsonSerializerSettings settings = new JsonSerializerSettings { Converters = new JsonConverter[] { new JsonGenericDictionaryOrArrayConverter() } };
                            List<KeyValuePair<long, string>> lista = JsonConvert.DeserializeObject<List<KeyValuePair<long, string>>>(res.Content, settings);

                            if (lista.Count > 0)
                            {
                                ddlParametros.Items.Clear();

                                foreach (var elemento in lista)
                                {
                                    ListItem _n = new ListItem(elemento.Value, elemento.Key.ToString());
                                    ddlParametros.Items.Add(_n);
                                }
                            }
                        }
                        result = true;

                        break;
                    case ResponseStatus.Error:
                        result = false;
                        break;
                }
            }
            catch (Exception ee)
            {

            }

            return result;
        }

        public bool CargarListaUsuarios()
        {
            bool result = false;

            try
            {
                RestClient client = new RestClient(ParametrosDL.ObtenerParametroURLWS());

                RestRequest request = new RestRequest("api/usuarios/roles/1,admin", DataFormat.Json);

                var res = client.Get<string>(request);

                switch (res.ResponseStatus)
                {
                    case ResponseStatus.Completed:
                        if (res != null && !string.IsNullOrEmpty(res.Content))
                        {
                            JsonSerializerSettings settings = new JsonSerializerSettings { Converters = new JsonConverter[] { new JsonGenericDictionaryOrArrayConverter() } };
                            Dictionary<string, string> lista = JsonConvert.DeserializeObject<Dictionary<string, string>>(res.Content, settings);

                            if (lista.Count > 0)
                            {
                                ddlUsuarios.Items.Clear();

                                foreach (var elemento in lista)
                                {
                                    ListItem _n = new ListItem(elemento.Value, elemento.Key);
                                    ddlUsuarios.Items.Add(_n);
                                }
                            }
                        }
                        result = true;

                        break;
                    case ResponseStatus.Error:
                        result = false;
                        break;
                }
            }
            catch (Exception ee)
            {

            }

            return result;
        }

        public bool CargarListaElementos(string IdCatalogo)
        {
            bool result = false;

            try
            {
                long _id = 0;
                long.TryParse(IdCatalogo, out _id);

                CatalogosBL _cat = new CatalogosBL();
                listaElementos = _cat.ObtenerElementos(_id);
                gvElementosCat.DataSource = listaElementos;
                gvElementosCat.DataBind();

            }
            catch (Exception ee)
            { }
            return result;
        }

        public bool EliminarElemento(string IdElemento)
        {
            bool result = false;

            try
            {
                long _id = 0;
                long.TryParse(IdElemento, out _id);

                CatalogosBL _cat = new CatalogosBL();
                result = _cat.EliminarElemento(_id);
            }
            catch (Exception ee)
            { }

            return result;
        }

        public bool ActualizarElemento(CatalogosElementos elemento)
        {
            bool result = false;

            try
            {
                CatalogosBL _cat = new CatalogosBL();
                result = _cat.ActualizarElemento(elemento);
            }
            catch (Exception ee)
            { }

            return result;
        }

        public bool AgregarElemento(CatalogosElementos elemento)
        {
            bool result = false;

            try
            {
                CatalogosBL _cat = new CatalogosBL();
                result = _cat.AgregarElemento(elemento);
            }
            catch (Exception ee)
            { }

            return result;
        }

        protected void ddlCatalogos_SelectedIndexChanged(object sender, EventArgs e)
        {
            CargarListaElementos(ddlCatalogos.SelectedItem.Value);
            if (ddlCatalogos.SelectedIndex > 0)
            {
                btnAdd.Visible = true;
                gvElementosCat.Visible = true;
            }
            else
            {
                btnAdd.Visible = false;
                gvElementosCat.Visible = false;
            }
        }

        protected void gvElementosCat_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            // Find the row index
            int index = Convert.ToInt32(e.CommandArgument);

            // Get the ContactId and object class
            long idElemento = Convert.ToInt64(gvElementosCat.DataKeys[index].Value.ToString());

            if (listaElementos == null)
                CargarListaElementos(ddlCatalogos.SelectedItem.Value);

            var elemento = listaElementos.Where(i => i.idElemento == idElemento).First();

            if (e.CommandName.Equals("editRecord"))
            {
                HfUpdateID.Value = elemento.idElemento.ToString();
                txtNombreUpdate.Text = elemento.nombre;
                txtNombreVisibleUpdate.Text = elemento.nombreVisible;
                txtDescripcionUpdate.Text = elemento.descripcion;
                txtValorUpdate.Text = elemento.valorAsociado.ToString();
                txtClaveUpdate.Text = elemento.claveTexto;
                txtOrdenUpdate.Text = elemento.ordenVisual.ToString();
                lblResult.Visible = false;
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("$('#editModal').modal('show');");
                sb.Append(@"</script>");
                ScriptManager.RegisterClientScriptBlock
                    (this, this.GetType(), "EditModalScript", sb.ToString(), false);
            }
            if (e.CommandName.Equals("deleteRecord"))
            {
                HfDeleteID.Value = elemento.idElemento.ToString();
                lblFirstNameDelete.Text = elemento.nombre + " - " + elemento.nombreVisible;
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("$('#deleteModal').modal('show');");
                sb.Append(@"</script>");
                ScriptManager.RegisterClientScriptBlock
                     (this, this.GetType(), "DeleteModalScript", sb.ToString(), false);
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                if (!EliminarElemento(HfDeleteID.Value))
                    throw new Exception("No se consiguió eliminar el elemento indicado. Intente nuevamente.");
            }
            catch (Exception ex)
            {

            }

            CargarListaElementos(ddlCatalogos.SelectedItem.Value);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                CatalogosElementos objInfo = new CatalogosElementos();
                objInfo.idElemento = Convert.ToInt64(HfUpdateID.Value);
                objInfo.nombre = txtNombreUpdate.Text;
                objInfo.nombreVisible = txtNombreVisibleUpdate.Text;
                objInfo.descripcion = txtDescripcionUpdate.Text;
                objInfo.claveTexto = txtClaveUpdate.Text;
                if (!string.IsNullOrEmpty(txtValorAdd.Text))
                    objInfo.valorAsociado = long.Parse(txtValorAdd.Text);
                if (!string.IsNullOrEmpty(txtOrdenAdd.Text))
                    objInfo.ordenVisual = int.Parse(txtOrdenAdd.Text);

                if (!ActualizarElemento(objInfo))
                    throw new Exception("No se consiguió actualizar el elemento. Intente nuevamente.");

            }
            catch (Exception ex)
            {

            }

            CargarListaElementos(ddlCatalogos.SelectedItem.Value);
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append(@"<script type='text/javascript'>");
            sb.Append("$('#addModal').modal('show');");
            sb.Append(@"</script>");
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                       "AddShowModalScript", sb.ToString(), false);
        }

        protected void btnAddRecord_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {

                try
                {
                    CatalogosElementos objInfo = new CatalogosElementos();
                    objInfo.idCatalogo = long.Parse(ddlCatalogos.SelectedItem.Value);
                    objInfo.nombre = txtNombreAdd.Text;
                    objInfo.nombreVisible = txtNombreVisibleAdd.Text;
                    objInfo.descripcion = txtDescripcionAdd.Text;
                    objInfo.claveTexto = txtClaveAdd.Text;
                    if (!string.IsNullOrEmpty(txtValorAdd.Text))
                        objInfo.valorAsociado = long.Parse(txtValorAdd.Text);
                    if (!string.IsNullOrEmpty(txtOrdenAdd.Text))
                        objInfo.ordenVisual = int.Parse(txtOrdenAdd.Text);

                    if (!AgregarElemento(objInfo))
                        throw new Exception("No se consiguió agregar el elemento. Intente nuevamente.");

                }
                catch (Exception ex)
                {

                }

                CargarListaElementos(ddlCatalogos.SelectedItem.Value);
            }
        }

        protected void ddlTarifas_SelectedIndexChanged(object sender, EventArgs e)
        {

            tarifanueva.Value = "";

            ObtenerValorTarifa();

        }

        protected void ObtenerValorTarifa()
        {
            try
            {
                RestClient client = new RestClient(ParametrosDL.ObtenerParametroURLWS());

                RestRequest request = new RestRequest("api/catalogo/tarifas/valor/1,admin," + ddlTarifas.SelectedValue, DataFormat.Json);

                var res = client.Get<string>(request);

                switch (res.ResponseStatus)
                {
                    case ResponseStatus.Completed:
                        if (res != null && !string.IsNullOrEmpty(res.Content))
                        {
                            string lista = JsonConvert.DeserializeObject<string>(res.Content);
                            tarifaactual.Value = lista.Trim();
                            tarifanueva.Value = "";
                        }

                        break;
                    case ResponseStatus.Error:
                        tarifaactual.Value = "";
                        break;
                }
            }
            catch (Exception ee)
            {

            }
        }

        protected void btnGuardarTarifa_Click(object sender, EventArgs e)
        {
            try
            {
                string _usr = Context.User.Identity.Name;
                string _resource = string.Empty;

                RestClient client = new RestClient(ParametrosDL.ObtenerParametroURLWS());
                _resource = "api/catalogo/tarifas/valor/" + _usr.UrlEncode() + ",1,admin," + ddlTarifas.SelectedValue + "," + tarifanueva.Value.UrlEncode() + "/";

                RestRequest request = new RestRequest(_resource, DataFormat.Json);

                var res = client.Post<string>(request);

                switch (res.ResponseStatus)
                {
                    case ResponseStatus.Completed:
                        if (res != null && !string.IsNullOrEmpty(res.Content))
                        {
                            string lista = JsonConvert.DeserializeObject<string>(res.Content);
                            ObtenerValorTarifa();
                        }

                        break;
                    case ResponseStatus.Error:
                        break;
                }
            }
            catch (Exception ee)
            {

            }
        }

        protected void ddlParametros_SelectedIndexChanged(object sender, EventArgs e)
        {

            valornuevo.Value = "";

            ObtenerValorParametro();

        }

        protected void ObtenerValorParametro()
        {
            try
            {
                RestClient client = new RestClient(ParametrosDL.ObtenerParametroURLWS());

                RestRequest request = new RestRequest("api/parametros/valor/1,admin," + ddlParametros.SelectedValue, DataFormat.Json);

                var res = client.Get<string>(request);

                switch (res.ResponseStatus)
                {
                    case ResponseStatus.Completed:
                        if (res != null && !string.IsNullOrEmpty(res.Content))
                        {
                            var param = JsonConvert.DeserializeObject<Dictionary<string, string>>(res.Content);

                            if (param != null)
                            {
                                tipo.Value = param["m_Item1"];
                                descripcion.Value = param["m_Item2"];
                                valoractual.Value = param["m_Item3"];
                            }

                            valornuevo.Value = "";
                        }

                        break;
                    case ResponseStatus.Error:
                        tipo.Value = "";
                        descripcion.Value = "";
                        valoractual.Value = "";
                        break;
                }
            }
            catch (Exception ee)
            {

            }
        }

        protected void btnGuardarParametro_Click(object sender, EventArgs e)
        {
            try
            {
                string _usr = Context.User.Identity.Name;
                string _resource = string.Empty;

                RestClient client = new RestClient(ParametrosDL.ObtenerParametroURLWS());
                _resource = "api/parametros/valor/" + _usr.UrlEncode() + ",1,admin," + ddlParametros.SelectedValue + "," + valornuevo.Value.UrlEncode() + "/";

                RestRequest request = new RestRequest(_resource, DataFormat.Json);

                var res = client.Post<string>(request);

                switch (res.ResponseStatus)
                {
                    case ResponseStatus.Completed:
                        if (res != null && !string.IsNullOrEmpty(res.Content))
                        {
                            string lista = JsonConvert.DeserializeObject<string>(res.Content);
                            ObtenerValorParametro();
                        }

                        break;
                    case ResponseStatus.Error:
                        break;
                }
            }
            catch (Exception ee)
            {

            }
        }

        protected void ddlUsuarios_SelectedIndexChanged(object sender, EventArgs e)
        {
            //valornuevo.Value = "";

            ObtenerValoresUsuario();
        }

        protected void ObtenerValoresUsuario()
        {
            try
            {
                RestClient client = new RestClient(ParametrosDL.ObtenerParametroURLWS());

                RestRequest request = new RestRequest("api/usuarios/1,admin," + ddlParametros.SelectedValue, DataFormat.Json);

                var res = client.Get<string>(request);

                switch (res.ResponseStatus)
                {
                    case ResponseStatus.Completed:
                        if (res != null && !string.IsNullOrEmpty(res.Content))
                        {
                            var param = JsonConvert.DeserializeObject<Dictionary<string, string>>(res.Content);

                            if (param != null)
                            {
                                tipo.Value = param["0"];
                                descripcion.Value = param["m_Item2"];
                                valoractual.Value = param["m_Item3"];
                            }

                            valornuevo.Value = "";
                        }

                        break;
                    case ResponseStatus.Error:
                        tipo.Value = "";
                        descripcion.Value = "";
                        valoractual.Value = "";
                        break;
                }
            }
            catch (Exception ee)
            {

            }
        }

        protected void btnGuardarUsuario_Click(object sender, EventArgs e)
        {

        }
    }
}