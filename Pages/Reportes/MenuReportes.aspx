<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MenuReportes.aspx.cs" Inherits="logistica.Pages.Reportes.MenuReportes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <div class="row" style="min-height: 400px;">

        <div class="col-md-12 order-md-1">
            <ul class="nav nav-tabs">
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#divgeneral">
                        <h4 class="mb-3">GENERAL</h4>
                    </a>
                </li>
            </ul>

            <div class="tab-content">
                <div id="divgeneral" class="tab-pane fade">
                    <br />
                    <div class="row col-md-4">
                        <label for="ddlTipoReporteGral">Tipo de reporte</label>
                        <asp:DropDownList ID="ddlTipoReporteGral" runat="server" class="custom-select d-block w-20" OnSelectedIndexChanged="ddlTipoReporteGral_SelectedIndexChanged" AutoPostBack="true">
                            <asp:ListItem Text="Seleccione..." Value="none" />
                            <asp:ListItem Text="Corte del día" Value="diario" />
                            <asp:ListItem Text="Corte mensual" Value="mensual" />
                        </asp:DropDownList>
                    </div>

                    <asp:UpdatePanel ID="upReporteGral" runat="server">
                        <ContentTemplate>
                            <br />
                            <div class="row col-md-4">
                                <asp:Button ID="btnExportar" runat="server" Text="Exportar a excel" OnClick="btnExportar_Click" CssClass="btn btn-info" />
                            </div>

                            <asp:GridView ID="gvReporte" runat="server" AllowPaging="True" OnPageIndexChanging="gvReporte_PageIndexChanging" PageSize="10"
                                AutoGenerateColumns="true" Visible="true" Width="1024"
                                CssClass="table table-striped">
                                <EmptyDataTemplate>
                                    <asp:Image ID="Image0"
                                        ImageUrl="~/Images/nodata.jpg"
                                        AlternateText="No Image" runat="server"
                                        Visible="false" />Sin datos.
                                </EmptyDataTemplate>

                            </asp:GridView>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddlTipoReporteGral" EventName="SelectedIndexChanged" />
                            <asp:PostBackTrigger ControlID="btnExportar" />
                        </Triggers>
                    </asp:UpdatePanel>

                </div>
            </div>
        </div>

    </div>
</asp:Content>
