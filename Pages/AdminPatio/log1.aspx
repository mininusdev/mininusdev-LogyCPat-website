<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="log1.aspx.cs" Inherits="logistica.log1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <style>
        table {
            font-family: Arial;
            font-size: smaller;
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            text-align: left;
            padding: 8px;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2
        }

        th {
            background-color: #4CAF50;
            color: white;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <br />
        <asp:ListView runat="server" ID="lvLogActividades"
            ItemPlaceholderID="itemPlaceHolder"
            OnItemDataBound="lvLogActividades_ItemDataBound">
            <%--Plantilla de diseño de la tabla Html--%>
            <LayoutTemplate>
                <table id="ListViewTable" class="table table-bordered">
                    <%--Cabecera de la tabla Html--%>
                    <thead>
                        <tr>
                            <th scope="col">Tipo</th>
                            <th scope="col">Unidad</th>
                            <th scope="col">Puerta</th>
                            <th scope="col">Nota</th>
                            <th scope="col">Boleto</th>
                            <th scope="col">Fecha</th>
                            <th scope="col">Costo</th>
                            <th scope="col">Usuario</th>
                        </tr>
                    </thead>
                    <%--Cuerpo de la tabla Html--%>
                    <tbody>
                        <%--Control de servidor PlaceHolder, elemento que
                            contendrá la plantilla <ItemTemplate>--%>
                        <asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
                    </tbody>
                </table>
            </LayoutTemplate>
            <%--Plantilla de los elementos dinámicos de la tabla Html
                filas y columnas--%>
            <ItemTemplate>
                <tr>
                    <td runat="server" id="tipoActividad"></td>
                    <td runat="server" id="tipoUnidad"></td>
                    <td runat="server" id="puerta"></td>
                    <td runat="server" id="nota"></td>
                    <td runat="server" id="clave"></td>
                    <td runat="server" id="fecha"></td>
                    <td runat="server" id="costoNormal"></td>
                    <td runat="server" id="usuarioRegistro"></td>
                </tr>
            </ItemTemplate>
        </asp:ListView>
    </form>
</body>
</html>
