<%@ Page Title="LogyCPat - Inicio" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="logistica._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron" style="background-image: url('/images/prueba.png'); font-size: xx-large; color: dodgerblue; font-weight: bold;">
        <asp:Label ID="Label2" runat="server" Text="LogyCPat ©" Font-Size="XX-Large" ForeColor="#0099ff"></asp:Label>
        <asp:Label ID="Label1" runat="server" Text="Control de Patios" Font-Size="XX-Large" ForeColor="White"></asp:Label>
        <br />
        <br />
        <br />
        <br />
        <a href="https://mx.depositphotos.com/category/concepts.html" style="font-family: Arial, Helvetica, sans-serif; font-size: small; color: #FFFFFF">Imagen cortesía de depositphotos.com</a>
    </div>

    <div class="row">
        <div class="col-md-4">
            <h2>Empiece ahora</h2>
            <p>
                Solamente edite los catálogos base para adaptarlos a su negocio y comience a disfrutar de la versión gratuita de LogyCPat ©.
            </p>
            <p>
                <a class="btn btn-default" href="https://www.youtube.com/channel/UCCnCYcnitRmh8xNhut9GnxA">Visite nuestro canal &raquo;</a>
            </p>
        </div>
        <div class="col-md-4">
            <h2>Foro de ayuda</h2>
            <p>
                Regístrese en nuestro foro de ayuda y obtenga acceso gratuito a documentación de uso de nuestro sistema así como a documentación técnica sobre el mismo.
            </p>
            <p>
                <a class="btn btn-default" href="/Pages/About.aspx">Aprenda más &raquo;</a>
            </p>
        </div>
        <div class="col-md-4">
            <h2>Atención personalizada</h2>
            <p>
                ¿Necesita algo mucho más específico a su negocio? Contáctese con nosotros y atenderemos su solicitud a la brevedad.
            </p>
            <p>
                <a class="btn btn-default" href="/Pages/Contact.aspx">Contacte ahora &raquo;</a>
            </p>
        </div>
    </div>

</asp:Content>
