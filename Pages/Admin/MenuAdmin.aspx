<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MenuAdmin.aspx.cs" Inherits="logistica.Pages.Admin.MenuAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <div class="row" style="min-height: 400px;">

        <div class="col-md-12 order-md-1">
            <ul class="nav nav-tabs">
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#divcatalogos">
                        <h4 class="mb-3">CATALOGOS </h4>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#divtarifas">
                        <h4 class="mb-3">TARIFAS </h4>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#divpatios">
                        <h4 class="mb-3">PATIOS </h4>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#divconfig">
                        <h4 class="mb-3">CONFIGURACION </h4>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#divusuarios">
                        <h4 class="mb-3">USUARIOS </h4>
                    </a>
                </li>
            </ul>

            <div class="tab-content">
                <div id="divcatalogos" class="tab-pane fade">
                    <div class="row">
                        <div class="col-md-4 order-md-1">
                            <br />
                            <div class="row">
                                <label for="ddlCatalogos">Catálogo</label>
                                <asp:DropDownList ID="ddlCatalogos" runat="server" class="custom-select d-block w-100" OnSelectedIndexChanged="ddlCatalogos_SelectedIndexChanged" AutoPostBack="true">
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>

                    <asp:UpdatePanel ID="upCrudGrid" runat="server">
                        <ContentTemplate>
                            <br />
                            <asp:Button ID="btnAdd" Visible="false" OnClick="btnAdd_Click"
                                runat="server" Text="Agregar"
                                CssClass="btn btn-info" />
                            <br />
                            <br />
                            <asp:GridView ID="gvElementosCat" runat="server" OnRowCommand="gvElementosCat_RowCommand"
                                AutoGenerateColumns="false" DataKeyNames="idElemento" Visible="false" Width="1024"
                                CssClass="table table-striped">
                                <EmptyDataTemplate>
                                    <asp:Image ID="Image0"
                                        ImageUrl="~/Images/yellow-warning.gif"
                                        AlternateText="No Image" runat="server"
                                        Visible="false" />Sin datos.
                                </EmptyDataTemplate>
                                <Columns>
                                    <asp:ButtonField CommandName="editRecord"
                                        ControlStyle-CssClass="btn btn-info"
                                        ButtonType="Button" Text="Editar"
                                        HeaderText="" ItemStyle-CssClass="text-center">
                                        <ControlStyle CssClass="btn btn-info"></ControlStyle>
                                    </asp:ButtonField>
                                    <asp:ButtonField CommandName="deleteRecord"
                                        ControlStyle-CssClass="btn btn-info"
                                        ButtonType="Button" Text="Eliminar"
                                        HeaderText="" ItemStyle-CssClass="text-center">
                                        <ControlStyle CssClass="btn btn-info"></ControlStyle>
                                    </asp:ButtonField>

                                    <asp:BoundField DataField="nombre"
                                        SortExpression="nombre" HeaderText="Nombre" />
                                    <asp:BoundField DataField="nombreVisible"
                                        SortExpression="visible" HeaderText="Nom. visible" ItemStyle-Width="300" />
                                    <asp:BoundField DataField="descripcion"
                                        SortExpression="descripcion" HeaderText="Descripción" ItemStyle-Width="500" />
                                    <asp:BoundField DataField="valorAsociado"
                                        SortExpression="valor" HeaderText="Valor asociado" />
                                    <asp:BoundField DataField="claveTexto"
                                        SortExpression="clave" HeaderText="Clave texto" />
                                    <asp:BoundField DataField="ordenVisual"
                                        SortExpression="orden" HeaderText="Orden visual" />
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddlCatalogos" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>

                <div id="divtarifas" class="tab-pane fade">
                    <div class="row">
                        <div class="col-md-4 order-md-1">
                            <br />
                            <div class="row">
                                <label for="ddlTarifas">Tarifas</label>
                                <asp:DropDownList ID="ddlTarifas" runat="server" class="custom-select d-block w-100" OnSelectedIndexChanged="ddlTarifas_SelectedIndexChanged" AutoPostBack="true">
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <br />
                    <div class="row">
                        <div class="col-md-12 order-md-2">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <div class="border border-sucess p-4">
                                        <br />
                                        <div class="row">
                                            <div class="col-md-4 order-md-1">
                                                <label for="tarifaactual">Monto actual</label>
                                                <input type="text" class="form-control" id="tarifaactual" value="" disabled="disabled" runat="server">
                                            </div>
                                            <div class="col-md-4 order-md-2">
                                                <label for="tarifanueva">Nuevo</label>
                                                <input type="text" class="form-control" id="tarifanueva" placeholder="" value="" runat="server">
                                            </div>
                                        </div>
                                        <br />
                                        <asp:Button ID="btnGuardarTarifa" Visible="true" OnClick="btnGuardarTarifa_Click"
                                            runat="server" Text="Guardar cambios"
                                            CssClass="btn btn-info" />
                                        <br />
                                    </div>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="ddlTarifas" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>


                <div id="divpatios" class="tab-pane fade">
                </div>

                <div id="divconfig" class="tab-pane fade">
                    <div class="row">
                        <div class="col-md-4 order-md-1">
                            <br />
                            <div class="row">
                                <label for="ddlParametros">Parámetros</label>
                                <asp:DropDownList ID="ddlParametros" runat="server" class="custom-select d-block w-100" OnSelectedIndexChanged="ddlParametros_SelectedIndexChanged" AutoPostBack="true">
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <br />
                    <div class="row">
                        <div class="col-md-12 order-md-2">
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>
                                    <div class="border border-sucess p-4">
                                        <br />
                                        <div class="row">
                                            <div class="col-md-3 order-md-1">
                                                <label for="tipo">Tipo de dato</label>
                                                <input type="text" class="form-control" id="tipo" value="" disabled="disabled" runat="server">
                                            </div>
                                            <div class="col-md-3 order-md-2">
                                                <label for="descripcion">Descripción</label>
                                                <input type="text" class="form-control" id="descripcion" value="" disabled="disabled" runat="server">
                                            </div>
                                            <div class="col-md-3 order-md-3">
                                                <label for="valoractual">Valor actual</label>
                                                <input type="text" class="form-control" id="valoractual" value="" disabled="disabled" runat="server">
                                            </div>
                                            <div class="col-md-3 order-md-4">
                                                <label for="valornuevo">Nuevo valor</label>
                                                <input type="text" class="form-control" id="valornuevo" placeholder="" value="" runat="server">
                                            </div>
                                        </div>
                                        <br />
                                        <asp:Button ID="btnGuardarParametro" Visible="true" OnClick="btnGuardarParametro_Click"
                                            runat="server" Text="Guardar cambios"
                                            CssClass="btn btn-info" />
                                        <br />
                                    </div>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="ddlParametros" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>

                <div id="divusuarios" class="tab-pane fade">
                    <div class="row">
                        <div class="col-md-4 order-md-1">
                            <br />
                            <div class="row">
                                <label for="ddlUsuarios">Usuarios</label>
                                <asp:DropDownList ID="ddlUsuarios" runat="server" class="custom-select d-block w-100" OnSelectedIndexChanged="ddlUsuarios_SelectedIndexChanged" AutoPostBack="true">
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <br />
                    <div class="row">
                        <div class="col-md-12 order-md-2">
                            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                <ContentTemplate>
                                    <div class="border border-sucess p-4">
                                        <br />
                                        <div class="row">
                                            <div class="col-md-3 order-md-1">
                                                <label for="tipo">Alias</label>
                                                <input type="text" class="form-control" id="usralias" value="" disabled="disabled" runat="server">
                                            </div>
                                            <div class="col-md-3 order-md-2">
                                                <label for="descripcion">Activo</label>
                                                <input type="text" class="form-control" id="usractivo" value="" disabled="disabled" runat="server">
                                            </div>
                                            <div class="col-md-3 order-md-3">
                                                <label for="valoractual">Rol</label>
                                                <input type="text" class="form-control" id="usrrol" value="" disabled="disabled" runat="server">
                                            </div>
                                        </div>
                                        <br />
                                        <asp:Button ID="btnGuardarUsuario" Visible="true" OnClick="btnGuardarUsuario_Click"
                                            runat="server" Text="Guardar cambios"
                                            CssClass="btn btn-info" />
                                        <br />
                                    </div>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="ddlUsuarios" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
            </div>

            <div id="editModal" class="modal hide fade"
                tabindex="-1" role="dialog"
                aria-labelledby="editModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 id="editModalLabel">Editar elemento</h3>
                            <button type="button" class="close"
                                data-dismiss="modal" aria-label="Cerrar">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <asp:UpdatePanel ID="upEdit" runat="server">
                            <ContentTemplate>
                                <div class="modal-body">
                                    <asp:HiddenField ID="HfUpdateID"
                                        runat="server" />
                                    <table class="table">
                                        <tr>
                                            <td>Nombre : </td>
                                            <td>
                                                <asp:TextBox ID="txtNombreUpdate"
                                                    runat="server" Width="100%" />
                                                <asp:RequiredFieldValidator
                                                    ID="valFirstNameUpdate"
                                                    ControlToValidate="txtNombreUpdate"
                                                    EnableClientScript="False" Display="Dynamic"
                                                    Text="<br />*"
                                                    Font-Bold="true" ForeColor="Red"
                                                    runat="server"
                                                    ValidationGroup="ValidationGroupUpdate" />
                                            </td>
                                            <td>
                                        </tr>
                                        <tr>
                                            <td>Nombre visible :</td>
                                            <td>
                                                <asp:TextBox ID="txtNombreVisibleUpdate"
                                                    runat="server" Width="100%" />
                                                <asp:RequiredFieldValidator
                                                    ID="valLastNameUpdate"
                                                    ControlToValidate="txtNombreVisibleUpdate"
                                                    EnableClientScript="False" Display="Dynamic"
                                                    Text="<br />*"
                                                    Font-Bold="true" ForeColor="Red"
                                                    runat="server"
                                                    ValidationGroup="ValidationGroupUpdate" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Descripción :</td>
                                            <td>
                                                <asp:TextBox ID="txtDescripcionUpdate"
                                                    runat="server" Width="100%" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Clave de texto :</td>
                                            <td>
                                                <asp:TextBox ID="txtClaveUpdate"
                                                    runat="server" Width="100%" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Valor asociado :</td>
                                            <td>
                                                <asp:TextBox ID="txtValorUpdate"
                                                    runat="server" Width="100%" />
                                                <asp:CompareValidator runat="server" Operator="DataTypeCheck" Type="Integer"
                                                    ControlToValidate="txtValorUpdate" ErrorMessage="Valor numérico" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Orden visual :</td>
                                            <td>
                                                <asp:TextBox ID="txtOrdenUpdate"
                                                    runat="server" Width="100%" />
                                                <asp:RangeValidator runat="server" Type="Integer"
                                                    MinimumValue="0" MaximumValue="100" ControlToValidate="txtOrdenUpdate"
                                                    ErrorMessage="Valor entre 0 - 100" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="modal-footer">
                                    <asp:Label ID="lblResult"
                                        Visible="false" runat="server"></asp:Label>
                                    <asp:Button ID="btnSave"
                                        runat="server" Text="Guardar" OnClick="btnSave_Click"
                                        CssClass="btn btn-info"
                                        ValidationGroup="ValidationGroupUpdate" />
                                    <button class="btn btn-info"
                                        data-dismiss="modal"
                                        aria-hidden="true">
                                        Cerrar</button>

                                </div>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="gvElementosCat"
                                    EventName="RowCommand" />
                                <asp:AsyncPostBackTrigger ControlID="btnSave"
                                    EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>

            <div id="addModal" class="modal hide fade"
                tabindex="-1" role="dialog"
                aria-labelledby="addModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 id="addModalLabel">Nuevo elemento</h3>
                            <button type="button" class="close"
                                data-dismiss="modal" aria-label="Cerrar">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <asp:UpdatePanel ID="upAdd" runat="server">
                            <ContentTemplate>
                                <div class="modal-body">
                                    <table class="table">
                                        <tr>
                                            <td>Nombre : </td>
                                            <td>
                                                <asp:TextBox ID="txtNombreAdd"
                                                    runat="server" Width="100%" />
                                                <asp:RequiredFieldValidator
                                                    ID="RequiredFieldValidator1"
                                                    ControlToValidate="txtNombreAdd"
                                                    EnableClientScript="False" Display="Dynamic"
                                                    Text="<br />* campo requerido"
                                                    Font-Bold="true" ForeColor="Red"
                                                    runat="server"
                                                    ValidationGroup="ValidationGroupUpdate" />
                                            </td>
                                            <td>
                                        </tr>
                                        <tr>
                                            <td>Nombre visible :</td>
                                            <td>
                                                <asp:TextBox ID="txtNombreVisibleAdd"
                                                    runat="server" Width="100%" />
                                                <asp:RequiredFieldValidator
                                                    ID="RequiredFieldValidator2"
                                                    ControlToValidate="txtNombreVisibleAdd"
                                                    EnableClientScript="False" Display="Dynamic"
                                                    Text="<br />* campo requerido"
                                                    Font-Bold="true" ForeColor="Red"
                                                    runat="server"
                                                    ValidationGroup="ValidationGroupUpdate" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Descripción :</td>
                                            <td>
                                                <asp:TextBox ID="txtDescripcionAdd"
                                                    runat="server" Width="100%" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Clave de texto :</td>
                                            <td>
                                                <asp:TextBox ID="txtClaveAdd"
                                                    runat="server" Width="100%" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Valor asociado :</td>
                                            <td>
                                                <asp:TextBox ID="txtValorAdd"
                                                    runat="server" Width="100%" />
                                                <asp:CompareValidator runat="server" Operator="DataTypeCheck" Type="Integer"
                                                    ControlToValidate="txtValorAdd" ErrorMessage="Valor numérico" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Orden visual :</td>
                                            <td>
                                                <asp:TextBox ID="txtOrdenAdd"
                                                    runat="server" Width="100%" />
                                                <asp:RangeValidator runat="server" Type="Integer"
                                                    MinimumValue="0" MaximumValue="100" ControlToValidate="txtOrdenAdd"
                                                    ErrorMessage="Valor entre 0 - 100" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="modal-footer">
                                    <asp:Button ID="btnAddRecord" runat="server"
                                        Text="Agregar" CssClass="btn btn-info" OnClick="btnAddRecord_Click"
                                        ValidationGroup="ValidationGroupAdd" />
                                    <button class="btn btn-info"
                                        data-dismiss="modal"
                                        aria-hidden="true">
                                        Cerrar</button>

                                </div>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnAddRecord"
                                    EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>

            <div id="deleteModal" class="modal hide fade"
                tabindex="-1" role="dialog"
                aria-labelledby="delModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 id="delModalLabel">Eliminar</h3>
                            <button type="button" class="close"
                                data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <asp:UpdatePanel ID="upDel" runat="server">
                            <ContentTemplate>
                                <div class="modal-body">
                                    ¿Borrar el registro '
                                    <asp:Label ID="lblFirstNameDelete"
                                        runat="server"></asp:Label>'?
                                    <asp:HiddenField ID="HfDeleteID"
                                        runat="server" />
                                </div>

                                <div class="modal-footer">
                                    <asp:Button ID="btnDelete"
                                        runat="server" Text="Eliminar" OnClick="btnDelete_Click"
                                        CssClass="btn btn-info" />
                                    <button class="btn btn-info"
                                        data-dismiss="modal"
                                        aria-hidden="true">
                                        Cancelar</button>
                                </div>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnDelete"
                                    EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>

        </div>


    </div>
    <br />
    <br />
</asp:Content>
