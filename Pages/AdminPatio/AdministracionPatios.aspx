<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdministracionPatios.aspx.cs" Inherits="logistica.Pages.AdminPatio.AdministracionPatios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="canonical" href="https://d3js.org/d3.v6.min.js">
    <style>
        .fondo {
            position: absolute;
            top: 70px;
            left: 40px;
            z-index: -1;
        }

        .veh1 {
            position: absolute;
            width: 80px;
            top: 80px;
            left: 60px;
            z-index: 1;
        }

        .veh2 {
            position: absolute;
            width: 80px;
            top: 80px;
            left: 200px;
            z-index: 1;
        }

        .veh3 {
            position: absolute;
            width: 80px;
            top: 80px;
            left: 350px;
            z-index: 1;
        }

        .veh4 {
            position: absolute;
            width: 80px;
            top: 80px;
            left: 480px;
            z-index: 1;
        }

        .veh5 {
            position: absolute;
            width: 80px;
            top: 260px;
            left: 60px;
            z-index: 1;
        }

        .veh6 {
            position: absolute;
            width: 80px;
            top: 260px;
            left: 200px;
            z-index: 1;
        }

        .veh7 {
            position: absolute;
            width: 80px;
            top: 260px;
            left: 350px;
            z-index: 1;
        }

        .veh8 {
            position: absolute;
            width: 80px;
            top: 260px;
            left: 480px;
            z-index: 1;
        }
    </style>
    <script type="text/javascript">

        var URLWS = '';

        $(document).ready(function () {

            URLWS = '<%=this._URLWS_%>';
            ValidarDivSesion();
            ValidarDivGenerales();

            var aa = setInterval(function () {
                $('#historicoMensajes').load('/Pages/AdminPatio/log1.aspx'); //actualiza el log
            }, 3000);

            var bb = setInterval(function () {
                var sel = document.getElementById("mapapatio");
                ActualizarMapa(sel.value);
            }, 3000);

            var input = document.getElementById("boletosalida");
            input.addEventListener("keyup", function (event) {
                var existeError = false;

                existeError = existeError || ValidarTarifa();

                if (!existeError) {
                    if (event.keyCode === 13) {
                        event.preventDefault();
                        if (input.value != null && input.value.length > 1) {
                            ProcesarEgreso(input.value);
                        };
                    }
                    else {
                        $("#monto").text("$0.00");
                    };
                };
            });

            CargarCatalogoTipoUnidades();
            CargarOpcionesUbicacion();
            CargarCatalogoPatios();
            CargarCatalogoPuertas();
            CargarCatalogoTarifas();
            CargarCatalogoTipoPago();
            CargarCatalogoStatusCobro();
            CargarListaCamaras();

        });

        function mostrarentradamasiva() {
            document.getElementById('egresomasivo').setAttribute('hidden', 'hidden');
            document.getElementById('ingresomasivo').removeAttribute('hidden');
        };

        function mostrarsalidamasiva() {
            document.getElementById('ingresomasivo').setAttribute('hidden', 'hidden');
            document.getElementById('egresomasivo').removeAttribute('hidden');
        };

        function PatioAdjuntarFotoA() {
            document.getElementById('evidencia1').setAttribute('hidden', 'hidden');
            document.getElementById('ievidencia1').removeAttribute('hidden');
        };

        function PatioAdjuntarFotoB() {
            document.getElementById('evidencia2').setAttribute('hidden', 'hidden');
            document.getElementById('ievidencia2').removeAttribute('hidden');
        };

        function PatioAdjuntarFotoC() {
            document.getElementById('evidencia3').setAttribute('hidden', 'hidden');
            document.getElementById('ievidencia3').removeAttribute('hidden');
        };

        function PatioAdjuntarFotoD() {
            document.getElementById('evidencia4').setAttribute('hidden', 'hidden');
            document.getElementById('ievidencia4').removeAttribute('hidden');
        };

        function PatioAdjuntarFotoE() {
            document.getElementById('evidencia5').setAttribute('hidden', 'hidden');
            document.getElementById('ievidencia5').removeAttribute('hidden');
        };

        function AdjuntarFotoFrente() {
            document.getElementById('bfrente').setAttribute('hidden', 'hidden');
            document.getElementById('ffrente').removeAttribute('hidden');
        };

        function AdjuntarFotoIzquierda() {
            document.getElementById('bizquierda').setAttribute('hidden', 'hidden');
            document.getElementById('fizquierda').removeAttribute('hidden');
        };

        function AdjuntarFotoDerecha() {
            document.getElementById('bderecha').setAttribute('hidden', 'hidden');
            document.getElementById('fderecha').removeAttribute('hidden');
        };

        function AdjuntarFotoAtras() {
            document.getElementById('batras').setAttribute('hidden', 'hidden');
            document.getElementById('fatras').removeAttribute('hidden');
        };

        function adjuntarArchivo(vusuario) {
            var blobFile = document.getElementById('inputfile1').files[0];
            var formData = new FormData();
            formData.append("usuario", vusuario);
            formData.append("adjunto", blobFile);

            $.ajax({
                url: URLWS + "api/actividad/ingreso/adjunto/",
                type: "POST",
                data: formData,
                success: function (response) {
                    console.log('archivo enviado correctamente');
                },
                error: function (jqXHR, textStatus, errorMessage) {
                    console.log('error al enviar archivo al servidor...');
                    console.log(errorMessage);
                }
            });
        }

        function CargarListaCamaras() {

            var select = document.getElementById('camara');

            while (select != null && select.length > 1) {
                select.remove(1);
            }

            if (!navigator.mediaDevices || !navigator.mediaDevices.enumerateDevices) {
                console.log("enumerateDevices() not supported.");
                return;
            }

            // Listado de camaras 

            navigator.mediaDevices.enumerateDevices()
                .then(function (devices) {
                    var nn = 1;

                    for (var device = 0; device < devices.length; device++) {
                        if (devices[device].kind == "videoinput") {
                            opt = document.createElement('option');
                            if (devices[device].deviceId == "") {
                                opt.value = nn;
                            } else {
                                opt.value = devices[device].deviceId;
                            };
                            opt.innerHTML = "Cámara " + nn;
                            select.appendChild(opt);
                            nn++;
                        };
                    };
                })
                .catch(function (err) {
                    console.log(err.name + ": " + err.message);
                });
        };

        function EnviarFotoIngresoServidor(dat, canvashtml) {
            console.log('enviando imagen...');
            var dataURL = canvashtml.toDataURL();

            $.ajax({
                type: "POST",
                url: URLWS + "api/actividad/ingreso/foto/",
                data: {
                    info: dat,
                    imgBase64: dataURL
                },
                success: function (respuesta) {
                    console.log('foto enviada correctamente');
                },
                error: function (error) {
                    console.log('error al enviar foto al servidor...');
                }
            });
        };

        function AsignarUbicacionManual(mostrar) {
            if (mostrar == true) {
                document.getElementById('patio').removeAttribute('disabled');
                document.getElementById('sector').removeAttribute('disabled');
                document.getElementById('nivel').removeAttribute('disabled');
                document.getElementById('cajon').removeAttribute('disabled');
            } else {
                document.getElementById('patio').setAttribute('disabled', 'disabled');
                document.getElementById('sector').setAttribute('disabled', 'disabled');
                document.getElementById('nivel').setAttribute('disabled', 'disabled');
                document.getElementById('cajon').setAttribute('disabled', 'disabled');
            };
        };

        function ValidarDivSesion() {
            if (document.getElementById('ctl09_aUsuario') == null) {
                document.getElementById('errorLogin').removeAttribute('hidden');
            }
            else {
                document.getElementById('errorLogin').setAttribute('hidden', 'hidden');
            };
        };

        function ValidarDivGenerales() {
            if ($('#puerta').val() == "0" || $('#puerta').val() == "" || $('#camara').val() == "0" || $('#camara').val() == "") {
                document.getElementById('errorGral2').removeAttribute('hidden');
            }
            else {
                document.getElementById('errorGral2').setAttribute('hidden', 'hidden');
                document.getElementById('errorGral3').setAttribute('hidden', 'hidden');
            };
        };

        function ValidarTarifa() {
            if ($('#tarifa').val() == "0" || $('#tarifa').val() == "") {
                document.getElementById('errorTarifa').removeAttribute('hidden');
                return true;
            } else {
                document.getElementById('errorTarifa').setAttribute('hidden', 'hidden');
            };
            return false;
        };

        function ValidarIngreso() {
            if ($('#ingreso').val() == "0" || $('#ingreso').val() == "") {
                document.getElementById('errorIngreso').removeAttribute('hidden');
                return true;
            } else {
                document.getElementById('errorIngreso').setAttribute('hidden', 'hidden');
            };
            return false;
        };

        function ValidarUbicacion() {
            if (($('#ubicacion').val() == "0" || $('#ubicacion').val() == "")) {
                document.getElementById('errorUbicacion').removeAttribute('hidden');
                return true;
            } else {
                document.getElementById('errorUbicacion').setAttribute('hidden', 'hidden');
                if ($("#ubicacion option:selected").text() == "No asignar") {
                    AsignarUbicacionManual(false);
                } else {
                    AsignarUbicacionManual(true);
                };
            };
            return false;
        };

        function ValidarCajon() {
            if ($("#ubicacion option:selected").text() == "Manual") {
                if (
                    ($('#patio').val() == "0" || $('#patio').val() == "") ||
                    ($('#sector').val() == "0" || $('#sector').val() == "") ||
                    ($('#nivel').val() == "0" || $('#nivel').val() == "") ||
                    ($('#cajon').val() == "0" || $('#cajon').val() == "")
                ) {
                    document.getElementById('errorUbicacion2').removeAttribute('hidden');
                    return true;
                } else {
                    document.getElementById('errorUbicacion2').setAttribute('hidden', 'hidden');
                };
            };
            return false;
        };

        function CambiarDivPatio() {
            if (document.getElementById('taReubicacion').checked) {
                document.getElementById('divreubicacion').removeAttribute('hidden', 'hidden');
                document.getElementById('divinspeccion').setAttribute('hidden', 'hidden');
                document.getElementById('divlabor').setAttribute('hidden', 'hidden');
            };
            if (document.getElementById('taInspeccion').checked) {
                document.getElementById('divinspeccion').removeAttribute('hidden', 'hidden');
                document.getElementById('divreubicacion').setAttribute('hidden', 'hidden');
                document.getElementById('divlabor').setAttribute('hidden', 'hidden');
            };
            if (document.getElementById('taLabor').checked) {
                document.getElementById('divlabor').removeAttribute('hidden', 'hidden');
                document.getElementById('divinspeccion').setAttribute('hidden', 'hidden');
                document.getElementById('divreubicacion').setAttribute('hidden', 'hidden');
            };
        };

        function CambiarMapa() {
            var input = document.getElementById("mapapatio");

            if (input.value == '1') {
                var divmapa1 = document.getElementById("divmapa1");
                divmapa1.removeAttribute('hidden');
                var divmapa2 = document.getElementById("divmapa2");
                divmapa2.setAttribute('hidden', 'hidden');
            };
            if (input.value == '2') {
                var divmapa1 = document.getElementById("divmapa2");
                divmapa1.removeAttribute('hidden');
                var divmapa2 = document.getElementById("divmapa1");
                divmapa2.setAttribute('hidden', 'hidden');
            };
        };

        function ActualizarMapa(npatio) {

            $.ajax({
                type: 'GET',
                data: npatio,
                url: URLWS + "api/patios/Ocupacion?idpatio=" + npatio,
                success: function (respuesta) {
                    var mapaocupantes = document.getElementById("mapa" + npatio + "ocupantes");
                    if (mapaocupantes != null) {
                        mapaocupantes.innerHTML = respuesta.toString().replaceAll(',', '');
                    };
                },
                error: function (error) {
                    $('#mensajeError').val('Ocurrió un error:' + error);
                }
            });

        };

        function MostarInfo(info) {
            alert(info)
        };

        function ProcesarEgreso(numboleto) {
            var vusuario = document.getElementById('ctl09_aUsuario').innerHTML;
            var vmodo = $('#modo1').val();
            var vpuerta = $('#puerta').val();
            var vcamara = $('#camara').val();
            var vtipopago = $('#tipopago').val();
            var vtarifa = $('#tarifa').val();
            var vstatuscobro = $('#statuscobro').val();
            var vnotasalida = $('#notasalida').val();

            var Req = {
                boleto: numboleto,
                usuario: vusuario,
                modo: vmodo,
                puerta: vpuerta,
                camara: vcamara,
                tipopago: vtipopago,
                tarifa: vtarifa,
                statuscobro: vstatuscobro,
                nota: vnotasalida
            };

            JSON.stringify(Req, null, '\t');

            CerrarBoleto(Req);

        };

        function CerrarBoleto(datos) {
            $.ajax({
                type: 'POST',
                data: datos,
                url: URLWS + "api/actividad/egreso/",
                success: function (respuesta) {
                    // Muestra el monto del boleto
                    if (respuesta.length > 0) {
                        document.querySelector('#monto').innerText = respuesta[0];
                        MostrarUltimaActividadEgreso(respuesta);
                        ResetEgresos();
                    }
                },
                error: function (request, status, error) {
                    document.querySelector('#monto').innerText = '$ 0';
                    alert(request.responseJSON.ExceptionMessage);
                }
            });
        };

        function ProcesarIngreso(id) {

            var existeError = false;

            existeError = existeError || ValidarIngreso();

            existeError = existeError || ValidarUbicacion();

            existeError = existeError || ValidarCajon();

            if (!existeError) {
                var vingreso = $('#ingreso').val();
                var vubicacion = $('#ubicacion').val();
                var vpatio = $('#patio').val();
                var vsector = $('#sector').val();
                var vcajon = $('#cajon').val();
                var vnivel = $('#nivel').val();
                var vnotaentrada = $('#notaentrada').val();
                var vusuario = document.getElementById('ctl09_aUsuario').innerHTML;
                var vmodo = $('#modo1').val();
                var vpuerta = $('#puerta').val();
                var vcamara = $('#camara').val();

                var Req = {
                    ingreso: vingreso, ubicacion: vubicacion, patio: vpatio,
                    sector: vsector, cajon: vcajon, nivel: vnivel, usuario: vusuario, nota: vnotaentrada,
                    modo: vmodo, puerta: vpuerta, camara: vcamara
                };

                JSON.stringify(Req, null, '\t');

                GenerarBoleto(Req, id);

            };

        };

        function GenerarBoleto(datos, div) {
            $.ajax({
                type: 'POST',
                data: datos,
                url: URLWS + "api/actividad/ingreso/",
                success: function (respuesta) {
                    //Toma la instantánea
                    var context = document.getElementById('canvas1').getContext('2d');
                    var context2 = document.getElementById('canvas2').getContext('2d');
                    context.drawImage(video, 0, 0, 210, 160);
                    context2.drawImage(video, 0, 0, 800, 600);
                    // Actualiza el div de última actividad
                    MostrarUltimaActividad(respuesta);
                    // Muestra la imagen del boleto
                    $("#qrboleto").attr("src", "/" + respuesta);
                    // Diálogo para imprimir
                    ImprimirBoleto(div);

                    ResetIngresos();

                    var vboleto = ExtraerNumBoleto(respuesta);

                    var dat = {
                        usuario: datos.usuario, camara: datos.camara, boleto: vboleto
                    };

                    canvashtml = document.getElementById('canvas2');

                    EnviarFotoIngresoServidor(dat, canvashtml);

                    adjuntarArchivo(datos.usuario);

                    AsignarUbicacionManual(true);

                }
                ,
                error: function (error) {
                    document.getElementById('reemitir').removeAttribute('hidden');
                }
            });
        };

        function MostrarUltimaActividad(boleto) {
            document.getElementById('divGral4').setAttribute('hidden', 'hidden');
            document.getElementById('divGral3').removeAttribute('hidden');

            $("#infoBoleto").text("Boleto " + ExtraerNumBoleto(boleto));
            // Actualiza el num de boleto en el diálogo de impresión
            $("#numBoleto").text(ExtraerNumBoleto(boleto));
            $("#infoTipo").text($("#ingreso option:selected").text());

            if ($("#ubicacion option:selected").text() == 'No asignar') {
                $("#infoPatio").text("Patio: no asignado, ");
                $("#infoSector").text("Sector: no asignado, ");
                $("#infoNivel").text("Nivel: no asignado, ");
                $("#infoCajon").text("Cajón: no asignado");
            } else {
                $("#infoPatio").text("Patio: " + $("#patio option:selected").text() + ", ");
                $("#infoSector").text("Sector: " + $("#sector option:selected").text() + ", ");
                $("#infoNivel").text("Nivel: " + $("#nivel option:selected").text() + ", ");
                $("#infoCajon").text("Cajón: " + $("#cajon option:selected").text());
            };
        };

        function MostrarUltimaActividadEgreso(salida) {
            document.getElementById('divGral3').setAttribute('hidden', 'hidden');
            document.getElementById('divGral4').removeAttribute('hidden');

            $("#boletosalida").text("");
            $("#infoBoleto2").text("Boleto " + ExtraerNumBoleto(salida[1]));
            $("#infoIngreso").text(salida[2]);
            $("#infoEgreso").text(salida[3]);
            $("#infoTiempo").text(salida[4]);
            $("#infoMonto").text(salida[0]);
            $("#infoTarifa").text($("#tarifa option:selected").text());
            $("#infoBoletoSalida").text("Boleto " + ExtraerNumBoleto(salida[5]));
        };

        function ResetEgresos() {
            $("#boletosalida").val("");
            $("#tipopago").val("0");
            $("#statuscobro").val("0");
            $("#notasalida").val("");
        };

        function ResetIngresos() {
            $("#ingreso").val("0");
            $("#ubicacion").val("0");
            $("#patio").val("0");
            $("#sector").val("0");
            $("#nivel").val("0");
            $("#cajon").val("0");
            $("#notaentrada").val("");
        };

        function ExtraerNumBoleto(texto) {
            var _ini = ini_numeros(texto);
            var _numBoleto = '';
            for (i = _ini; i < texto.length; i++) {
                if (texto[i] == '.') {
                    break;
                } else {
                    _numBoleto = _numBoleto + texto[i];
                };
            };
            return _numBoleto;
        };

        function ini_numeros(cadena) {
            var numeros = "0123456789";
            for (i = 0; i < cadena.length; i++) {
                if (numeros.indexOf(cadena.charAt(i), 0) != -1) {
                    return i;
                }
            }
            return 0;
        };

        function ImprimirBoleto(divhtml) {
            var div = document.getElementById(divhtml);
            var ventimp = window.open(' ', 'popimpr');
            ventimp.document.write(div.innerHTML);
            ventimp.document.close();
            ventimp.print();
            ventimp.close();
        };

        function ReemitirBoleto(id) {
            ImprimirBoleto(id);
        };

        function MostrarBoleto(ndiv) {
            var div = document.getElementById(ndiv);
            div.removeAttribute('hidden');
        };

        function BuscarUsuario() {
            $.ajax({
                url: URLWS + "api/Account/UserInfo",
                success: function (respuesta) {
                    //$('#usuario').val(respuesta);
                },
                error: function (error) {
                    $('#mensajeError').val('Ocurrió un error');
                }
            });
        };

        function ModoManual() {
            $('#ingreso').removeAttr('disabled');
            $('#ubicacion').removeAttr('disabled');
            $('#patio').removeAttr('disabled');
            $('#sector').removeAttr('disabled');
            $('#cajon').removeAttr('disabled');
            $('#nivel').removeAttr('disabled');
            $('#notaentrada').removeAttr('disabled');

            $('#statuscobro').removeAttr('disabled');
            $('#tarifa').removeAttr('disabled');
            $('#tipopago').removeAttr('disabled');
            $('#status').removeAttr('disabled');
            $('#notasalida').removeAttr('disabled');

            $('#buscar').removeAttr('disabled');
            $('#puerta').removeAttr('disabled');
            $('#camara').removeAttr('disabled');

        };

        function ModoAutomatico() {
            $('#ingreso').attr('disabled', true);
            $('#ubicacion').attr('disabled', true);
            $('#patio').attr('disabled', true);
            $('#sector').attr('disabled', true);
            $('#cajon').attr('disabled', true);
            $('#nivel').attr('disabled', true);
            $('#notaentrada').attr('disabled', true);

            $('#statuscobro').attr('disabled', true);
            $('#tarifa').attr('disabled', true);
            $('#tipopago').attr('disabled', true);
            $('#status').attr('disabled', true);
            $('#notasalida').attr('disabled', true);

            $('#buscar').attr('disabled', true);
            $('#puerta').attr('disabled', true);
            $('#camara').attr('disabled', true);
        };

        function CargarCatalogoTipoUnidades() {
            $.ajax({
                url: URLWS + "api/catalogo/tipounidades/1,ingresos",
                success: function (respuesta) {
                    $('#ingreso').html(respuesta);
                },
                error: function (error) {
                    $('#mensajeError').val('Ocurrió: un error');
                }
            });
        };

        function CargarOpcionesUbicacion() {
            $.ajax({
                url: URLWS + "api/catalogo/ubicaciones/1,ingresos",
                success: function (respuesta) {
                    $('#ubicacion').html(respuesta);
                },
                error: function (error) {
                    $('#mensajeError').val('Ocurrió: un error');
                }
            });
        };

        function CargarCatalogoPatios() {
            $.ajax({
                url: URLWS + "api/catalogo/patios/1,ingresos",
                success: function (respuesta) {
                    $('#patio').html(respuesta);
                    $('#mapapatio').html(respuesta);
                },
                error: function (error) {
                    $('#mensajeError').val('Ocurrió: un error');
                }
            });
        };

        function CargarCatalogoSectores() {
            var niv = document.getElementById('patio');
            $.ajax({
                url: URLWS + "api/catalogo/sectores/1," + niv.value + ",ingresos",
                success: function (respuesta) {
                    $('#sector').html(respuesta);
                },
                error: function (error) {
                    $('#mensajeError').val('Ocurrió: un error');
                }
            });
        };

        function CargarCatalogoNiveles() {
            var niv = document.getElementById('sector');
            $.ajax({
                url: URLWS + "api/catalogo/niveles/1," + niv.value + ",ingresos",
                success: function (respuesta) {
                    $('#nivel').html(respuesta);
                },
                error: function (error) {
                    $('#mensajeError').val('Ocurrió: un error');
                }
            });
        };

        function CargarCatalogoCajones() {
            var niv = document.getElementById('nivel');
            $.ajax({
                url: URLWS + "api/catalogo/cajones/1," + niv.value + ",ingresos",
                success: function (respuesta) {
                    $('#cajon').html(respuesta);
                },
                error: function (error) {
                    $('#mensajeError').val('Ocurrió: un error');
                }
            });
        };

        function CargarCatalogoCamaras() {
            $.ajax({
                url: URLWS + "api/catalogo/camaras/1,ingresos",
                success: function (respuesta) {
                    $('#camara').html(respuesta);
                },
                error: function (error) {
                    $('#mensajeError').val('Ocurrió: un error');
                }
            });
        };

        function CargarCatalogoPuertas() {
            $.ajax({
                url: URLWS + "api/catalogo/puertas/1,ingresos",
                success: function (respuesta) {
                    $('#puerta').html(respuesta);
                },
                error: function (error) {
                    $('#mensajeError').val('Ocurrió: un error');
                }
            });
        };

        function CargarCatalogoTarifas() {
            $.ajax({
                url: URLWS + "api/catalogo/tarifas/1,ingresos",
                success: function (respuesta) {
                    $('#tarifa').html(respuesta);
                },
                error: function (error) {
                    $('#mensajeError').val('Ocurrió: un error');
                }
            });
        };

        function CargarCatalogoTipoPago() {
            $.ajax({
                url: URLWS + "api/catalogo/tipopago/1,ingresos",
                success: function (respuesta) {
                    $('#tipopago').html(respuesta);
                },
                error: function (error) {
                    $('#mensajeError').val('Ocurrió: un error');
                }
            });
        };

        function CargarCatalogoStatusCobro() {
            $.ajax({
                url: URLWS + "api/catalogo/statuscobro/1,ingresos",
                success: function (respuesta) {
                    $('#statuscobro').html(respuesta);
                },
                error: function (error) {
                    $('#mensajeError').innerHTML = "Ocurrió un error. Recargue la pagina.";
                }
            });
        };

        function LimpiarSelectCajones() {
            var select = document.getElementById("cajon");
            while (select.length > 1) {
                select.remove(1);
            }
        };

        function LimpiarSelectNiveles() {
            var select = document.getElementById("nivel");
            while (select.length > 1) {
                select.remove(1);
            }
        };

        function LimpiarSelectSectores() {
            var select = document.getElementById("sector");
            while (select.length > 1) {
                select.remove(1);
            }
        };

    </script>

    <br />

    <div id="errorLogin" class="alert alert-danger alert-dismissible" hidden="hidden">
        Inicie sesión antes de continuar.
    </div>
    <div id="errorGral2" class="alert alert-danger alert-dismissible" hidden="hidden">
        Elija la cámara y puerta a monitorear.
    </div>
    <div id="errorGral3" class="alert alert-danger alert-dismissible" hidden="hidden">
        Elija la puerta a monitorear.
    </div>

    <div class="row">
        <div class="col-md-8 order-md-1">
            <ul class="nav nav-tabs">
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#entradas">
                        <h4 class="mb-3">ENTRADAS</h4>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#actividades">
                        <h4 class="mb-3">PATIO</h4>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#salidas">
                        <h4 class="mb-3">SALIDAS</h4>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#mapas">
                        <h4 class="mb-3">MAPA</h4>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#log">
                        <h4 class="mb-3">HISTORIA</h4>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#masivo">
                        <h4 class="mb-3">MASIVO</h4>
                    </a>
                </li>
            </ul>

            <div class="tab-content">
                <div id="entradas" class="tab-pane fade">
                    <div class="col-md-12 order-md-1">
                        <div class="row">
                            <div class="col-md-4 order-md-1">
                                <br />
                                <div class="row">
                                    <label for="ingreso">Tipo de ingreso</label>
                                    <select class="custom-select d-block w-100" id="ingreso" required="required" onchange="ValidarIngreso()">
                                        <option value="">Seleccione...</option>
                                        <option>Automóvil</option>
                                    </select>
                                    <div id="errorIngreso" class="alert alert-danger alert-dismissible" hidden="hidden">
                                        Elija el tipo de ingreso
                                    </div>
                                </div>

                                <div class="row">
                                    <label for="ubicacion">Asignar ubicación</label>
                                    <select class="custom-select d-block w-100" id="ubicacion" required="" onchange="ValidarUbicacion()">
                                        <option value="">Seleccione...</option>
                                        <option>Manual</option>
                                    </select>
                                    <div id="errorUbicacion" class="alert alert-danger alert-dismissible" hidden="hidden">
                                        Elija la forma de asignación
                                    </div>
                                </div>

                                <div class="row">
                                    <label for="patio">Patio</label>
                                    <select class="custom-select d-block w-100" id="patio" required="" onchange="CargarCatalogoSectores(); LimpiarSelectNiveles(); LimpiarSelectCajones();">
                                        <option value="">Seleccione...</option>
                                    </select>
                                </div>

                                <div class="row">
                                    <label for="sector">Sector</label>
                                    <select class="custom-select d-block w-100" id="sector" required="" onchange="CargarCatalogoNiveles(); LimpiarSelectCajones();">
                                        <option value="">Seleccione...</option>
                                    </select>
                                </div>

                                <div class="row">
                                    <label for="nivel">Nivel</label>
                                    <select class="custom-select d-block w-100" id="nivel" required="" onchange="CargarCatalogoCajones();">
                                        <option value="">Seleccione...</option>
                                    </select>
                                </div>

                                <div class="row">
                                    <label for="cajon">Cajón</label>
                                    <select class="custom-select d-block w-100" id="cajon" required="" onchange="ValidarCajon()">
                                        <option value="">Seleccione...</option>
                                    </select>

                                    <div id="errorUbicacion2" class="alert alert-danger alert-dismissible" hidden="hidden">
                                        Elija el patio/sector/nivel/cajón destino
                                    </div>
                                </div>

                                <div class="row">
                                    <label for="notaentrada">Notas</label>
                                    <input type="text" class="form-control" id="notaentrada" placeholder="" value="">
                                </div>
                            </div>
                            <div class="col-md-1 order-md-2">
                            </div>
                            <div class="col-md-4 order-md-3">
                                <br />
                                <div class="row">
                                    <label for="tipoCarga">Tipo de carga</label>
                                    <select class="custom-select d-block w-100" id="tipoCarga">
                                        <option value="">Seleccione...</option>
                                        <option>Mercancía</option>
                                        <option>Refacciones</option>
                                        <option>Otra</option>
                                    </select>
                                </div>
                                <br />

                                <label for="inputfile1">Adjuntar archivo...</label>
                                <div class="file-upload-wrapper">
                                    <input type="file" id="inputfile1" class="file-upload" data-height="500" />
                                </div>
                                <br />
                                <label for="descripcion">Descripción</label>
                                <textarea id="descripcion" class="form-control" rows="3"></textarea>
                                <br />
                                <label>Adjunte la evidencia fotográfica:</label>
                                <ul class="list-group list-group-horizontal">
                                    <li class="list-group-item">Frente
                                    <button type="button" id="bfrente" class="btn btn-info btn-lg" onclick="AdjuntarFotoFrente()">+</button>
                                        <img src="../../images/ffrente.PNG" id="ffrente" width="60" height="60" hidden="hidden" />
                                    </li>
                                    <li class="list-group-item">L. izq
                                    <button type="button" id="bizquierda" class="btn btn-info btn-lg" onclick="AdjuntarFotoIzquierda()">+</button>
                                        <img src="../../images/fizquierda.PNG" id="fizquierda" width="60" height="60" hidden="hidden" />
                                    </li>
                                    <li class="list-group-item">L. der
                                    <button type="button" id="bderecha" class="btn btn-info btn-lg" onclick="AdjuntarFotoDerecha()">+</button>
                                        <img src="../../images/fderecha.PNG" id="fderecha" width="60" height="60" hidden="hidden" />
                                    </li>
                                    <li class="list-group-item">Atrás
                                    <button type="button" id="batras" class="btn btn-info btn-lg" onclick="AdjuntarFotoAtras()">+</button>
                                        <img src="../../images/fatras.PNG" id="fatras" width="60" height="60" hidden="hidden" />
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <br />
                        <p>
                            <button type="button" id="guardar" class="btn btn-info btn-lg" onclick="alert('Registro guardado')" hidden="hidden">Guardar registro</button>
                            <button type="button" id="emitir" class="btn btn-primary btn-lg" onclick="ProcesarIngreso('BoletoImprimible'); ">Emitir boleto</button>
                            <button type="button" id="reemitir" class="btn btn-primary btn-lg" onclick="ReemitirBoleto('BoletoImprimible'); ">Reimprimir boleto</button>
                        </p>
                        <div id="BoletoImprimible" hidden="hidden">
                            <h1>Boleto
                            <label id="numBoleto"></label>
                            </h1>
                            <img id="qrboleto" src="/images/boleto2.jpg">
                            <br />
                            <h4>Conserve este comprobante y devuelvalo al salir</h4>
                        </div>
                    </div>
                </div>
                <div id="salidas" class="tab-pane fade">
                    <div class="col-md-8 order-md-1">
                        <br />
                        <div class="row">
                            <div class="col-md-4 order-md-1 mb-4">
                                <label for="boletosalida">Boleto/Ticket</label>
                                <input type="text" class="form-control" id="boletosalida" placeholder="Boleto99" value="">
                            </div>
                            <div class="col-md-4 order-md-2">
                                <label for="monto">Monto</label><br />
                                <h2>
                                    <label id="monto">$0.00</label>
                                </h2>
                            </div>
                        </div>
                        <label for="tarifa">Tarifa</label>
                        <select class="custom-select d-block w-100" id="tarifa" required="" onchange="ValidarTarifa()">
                            <option value="">Seleccione...</option>
                            <option>No aplicar</option>
                        </select>
                        <div id="errorTarifa" class="alert alert-danger alert-dismissible" hidden="hidden">
                            Elija la tarifa a aplicar
                        </div>
                        <label for="tipopago">Pago con</label>
                        <select class="custom-select d-block w-100" id="tipopago" required="">
                            <option value="">Seleccione...</option>
                            <option>Efectivo</option>
                            <option>Otro medio-descríbalo en el campo notas</option>
                        </select>
                        <div id="errorTipoPago" class="alert alert-danger alert-dismissible" hidden="hidden">
                            Elija la forma de pago
                        </div>
                        <label for="statuscobro">Status del cobro</label>
                        <select class="custom-select d-block w-100" id="statuscobro" required="">
                            <option value="">Seleccione...</option>
                            <option>Correcto</option>
                            <option>Ocurrió un problema -descríbalo en el campo notas</option>
                        </select>
                        <div id="errorStatusCobro" class="alert alert-danger alert-dismissible" hidden="hidden">
                            Elija el estatus del cobro
                        </div>
                        <label for="notasalida">Notas</label>
                        <input type="text" class="form-control" id="notasalida" placeholder="" value="">
                    </div>
                </div>
                <div id="mapas" class="tab-pane fade">
                    <div class="col-md-8 order-md-1" style="height: 460px">
                        <br />
                        <select class="custom-select d-block w-50" id="mapapatio" onchange="CambiarMapa()">
                            <option value="-1" selected="selected">Seleccione...</option>
                        </select>

                        <div id="divmapa1">
                            <img id="mapa1fondo" src="/images/plano_estacionamiento2.png" alt="Mapa 1" usemap="#workmap" class="fondo" />
                            <map name="workmap">
                                <area shape="rect" coords="10,10,110,180" onclick="alert('cajon R1');" />
                                <area shape="rect" coords="140,10,250,180" />
                                <area shape="rect" coords="280,10,390,180" />
                                <area shape="rect" coords="420,10,530,180" />

                                <area shape="rect" coords="10,200,110,380" />
                                <area shape="rect" coords="140,200,250,380" />
                                <area shape="rect" coords="280,200,390,380" />
                                <area shape="rect" coords="420,200,530,380" />
                            </map>

                            <div id="mapa1ocupantes">
                            </div>
                        </div>

                        <div id="divmapa2" hidden="hidden">
                            <img id="mapa2fondo" src="/images/plano_estacionamiento3.png" alt="Mapa 2" usemap="#workmap2" class="fondo" />
                            <map name="workmap2">
                                <area shape="rect" coords="10,10,110,180" onclick="InfoCajon('patio 2, cajon A')" />
                                <area shape="rect" coords="140,10,250,180" />
                            </map>

                            <div id="mapa2ocupantes">
                            </div>
                        </div>
                    </div>
                </div>
                <div id="actividades" class="tab-pane fade">
                    <div class="col-md-12 order-md-1">
                        <br />
                        <div class="row">
                            <div class="col-md-6 order-md-1">
                                <div class="row">
                                    <div class="col-md-4 order-md-1">
                                        <asp:Label ID="Label2" runat="server" Text="Boleto/VIN/Placa"></asp:Label>
                                    </div>
                                    <div class="col-md-6 order-md-2">
                                        <input type="text" class="form-control" style="max-width: 150px;" id="boletocajon" placeholder="boleto99" maxlength="15" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2 order-md-2">
                            </div>
                            <div class="col-md-4 order-md-3">
                                <input class="form-check-input" type="radio" name="tipoactividad" id="taReubicacion" value="reubicacion" checked="checked" onchange="CambiarDivPatio()">
                                <label for="reubicacion">Reubicación</label><br>
                                <input class="form-check-input" type="radio" name="tipoactividad" id="taInspeccion" value="inspeccion" onchange="CambiarDivPatio()">
                                <label for="inspeccion">Inspección</label><br>
                                <%--<input class="form-check-input" type="radio" name="tipoactividad" id="taLabor" value="labor" onchange="CambiarDivPatio()">
                                <label for="labor">Labor</label><br>--%>
                            </div>
                        </div>
                        <div id="divreubicacion" class="row">
                            <div class="col-md-6 order-md-1">
                                <br />
                                <label style="font-size: large; text-decoration: underline">Ubicación actual</label>
                                <br />
                                <label for="patioactual">Patio</label>
                                <select class="custom-select d-block w-100" id="patioactual" disabled="disabled" onload="CargarOpcionesUbicacion();">
                                    <option value="">Seleccione...</option>
                                    <option selected="selected">Patio 1</option>
                                </select>
                                <label for="sectoractual">Sector</label>
                                <select class="custom-select d-block w-100" id="sectoractual" disabled="disabled">
                                    <option value="">Seleccione...</option>
                                    <option selected="selected">Sector 1</option>
                                </select>
                                <label for="nivelactual">Nivel</label>
                                <select class="custom-select d-block w-100" id="nivelactual" disabled="disabled">
                                    <option value="">Seleccione...</option>
                                    <option selected="selected">Nivel 1</option>
                                </select>
                                <label for="cajonactual">Cajón</label>
                                <select class="custom-select d-block w-100" id="cajonactual" disabled="disabled">
                                    <option value="">Seleccione...</option>
                                    <option selected="selected">Cajón 1</option>
                                </select>
                                <label for="notaactual">Notas</label>
                                <input type="text" class="form-control" id="notaactual" placeholder="" value="Nota" disabled="disabled">
                            </div>
                            <div class="col-md-6 order-md-2">
                                <br />
                                <label style="font-size: large; text-decoration: underline">Nueva ubicación</label>
                                <br />
                                <label for="pationuevo">Patio</label>
                                <select class="custom-select d-block w-100" id="pationuevo" onload="CargarOpcionesUbicacion();">
                                    <option value="">Seleccione...</option>
                                    <option>Patio 1</option>
                                </select>
                                <label for="sectornuevo">Sector</label>
                                <select class="custom-select d-block w-100" id="sectornuevo">
                                    <option value="">Seleccione...</option>
                                    <option>Sector 1</option>
                                </select>
                                <label for="nivelnuevo">Nivel</label>
                                <select class="custom-select d-block w-100" id="nivelnuevo">
                                    <option value="">Seleccione...</option>
                                    <option>Nivel 1</option>
                                </select>
                                <label for="cajonnuevo">Cajón</label>
                                <select class="custom-select d-block w-100" id="cajonnuevo">
                                    <option value="">Seleccione...</option>
                                    <option>Cajón 1</option>
                                </select>
                                <label for="notanuevo">Notas adicionales</label>
                                <input type="text" class="form-control" id="notanuevo" placeholder="" value="">
                            </div>
                        </div>
                        <div id="divinspeccion" class="row" hidden="hidden">
                            <div class="col-md-12 order-md-1">
                                <div class="row">
                                    <label for="adjunto1">Adjuntar documento</label><br />
                                </div>
                                <div class="row">
                                    <div class="file-upload-wrapper">
                                        <input type="file" title="..." id="adjunto1" class="file-upload" data-height="500" />
                                    </div>
                                </div>
                                <br />
                                <div class="row">
                                    <label for="tipoCarga">Descripción</label>
                                    <textarea class="form-control" rows="3"></textarea>
                                </div>
                                <br />
                                <div class="row">
                                    <label>Adjunte la evidencia fotográfica:</label>
                                </div>
                                <div class="row">
                                    <ul class="list-group list-group-horizontal">
                                        <li class="list-group-item">A
                                    <button type="button" id="evidencia1" class="btn btn-info btn-lg" onclick="PatioAdjuntarFotoA()">+</button>
                                            <img src="../../images/daño1.PNG" id="ievidencia1" width="100" height="100" hidden="hidden" />
                                        </li>
                                        <li class="list-group-item">B
                                    <button type="button" id="evidencia2" class="btn btn-info btn-lg" onclick="PatioAdjuntarFotoB()">+</button>
                                            <img src="../../images/daño2.PNG" id="ievidencia2" width="100" height="100" hidden="hidden" />
                                        </li>
                                        <li class="list-group-item">C
                                    <button type="button" id="evidencia3" class="btn btn-info btn-lg" onclick="PatioAdjuntarFotoC()">+</button>
                                            <img src="../../images/daño3.PNG" id="ievidencia3" width="100" height="100" hidden="hidden" />
                                        </li>
                                        <li class="list-group-item">D
                                    <button type="button" id="evidencia4" class="btn btn-info btn-lg" onclick="PatioAdjuntarFotoD()">+</button>
                                            <img src="../../images/daño4.PNG" id="ievidencia4" width="100" height="100" hidden="hidden" />
                                        </li>
                                        <li class="list-group-item">E
                                    <button type="button" id="evidencia5" class="btn btn-info btn-lg" onclick="PatioAdjuntarFotoE()">+</button>
                                            <img src="../../images/daño5.PNG" id="ievidencia5" width="100" height="100" hidden="hidden" />
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div id="divlabor" class="row" hidden="hidden">
                        </div>
                        <br />
                        <br />
                        <button type="button" id="nuevaActividad" class="btn btn-info btn-lg" onclick="alert('Registro guardado')">Guardar registro</button>
                    </div>
                </div>
                <div id="log" class="tab-pane fade">
                    <br />
                    <asp:Label ID="Label1" runat="server" Text="Actividad más reciente:"></asp:Label>
                    <br />
                    <div id="historicoMensajes" class="col-md-8 order-md-1">
                    </div>
                </div>
                <div id="masivo" class="tab-pane fade">
                    <br />
                    <div class="row">
                        <label for="adjunto1">Archivo de entradas a patio</label>
                    </div>
                    <div class="row">
                        <div class="file-upload-wrapper col-md-9 order-md-1">
                            <input type="file" title="..." id="fileentradamasiva" class="file-upload" data-height="500" />
                        </div>
                        <div class="col-md-3 order-md-2">
                            <button type="button" id="procesaringresomasivo" class="btn btn-success btn-sm" onclick="mostrarentradamasiva()">-></button>
                        </div>
                    </div>
                    <br />
                    <div class="row">
                        <label for="adjunto1">Archivo de salida de patio</label>
                    </div>
                    <div class="row">
                        <div class="file-upload-wrapper col-md-9 order-md-1">
                            <input type="file" title="..." id="filesalidamasiva" class="file-upload" data-height="500" />
                        </div>
                        <div class="col-md-3 order-md-2">
                            <button type="button" id="procesaregresomasivo" class="btn btn-success btn-sm" onclick="mostrarsalidamasiva()">-></button>
                        </div>
                    </div>

                    <br />

                    <p>
                        <button type="button" id="confirmarMasivo" class="btn btn-success btn-lg" onclick="alert('Registros guardados')">Confirmar operación</button>
                    </p>

                    <div id="egresomasivo" hidden="hidden">
                        <p>Se realizará el EGRESO de los siguientes registros:</p>
                        <div class="table-responsive pre-scrollable" style="height: 200px;">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Tipo unidad</th>
                                        <th>Placa</th>
                                        <th>Puerta</th>
                                        <th>Tarifa</th>
                                        <th>Cargo a</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td>Sedan</td>
                                        <td>ABC1345</td>
                                        <td>1</td>
                                        <td>A</td>
                                        <td>Transportes Luna SA CV</td>
                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td>Minivan</td>
                                        <td>DEF5678</td>
                                        <td>1</td>
                                        <td>B</td>
                                        <td>Transportes Luna SA CV</td>
                                    </tr>
                                    <tr>
                                        <td>3</td>
                                        <td>Van</td>
                                        <td>AXC1234</td>
                                        <td>1</td>
                                        <td>B</td>
                                        <td>Transportes Luna SA CV</td>
                                    </tr>
                                    <tr>
                                        <td>4</td>
                                        <td>Sedan</td>
                                        <td>ZXXD457</td>
                                        <td>1</td>
                                        <td>A</td>
                                        <td>Transportes Luna SA CV</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div id="ingresomasivo" hidden="hidden">
                        <p>Se realizará el INGRESO de los siguientes registros:</p>
                        <div class="table-responsive pre-scrollable" style="height: 200px;">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Tipo unidad</th>
                                        <th>Placa</th>
                                        <th>Puerta</th>
                                        <th>Cargo a</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td>Moto</td>
                                        <td>ABC1345</td>
                                        <td>1</td>
                                        <td>Rafael y asociados SA CV</td>
                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td>Moto</td>
                                        <td>DEF5678</td>
                                        <td>1</td>
                                        <td>Rafael y asociados SA CV</td>
                                    </tr>
                                    <tr>
                                        <td>3</td>
                                        <td>Moto</td>
                                        <td>AXC1234</td>
                                        <td>1</td>
                                        <td>Rafael y asociados SA CV</td>
                                    </tr>
                                    <tr>
                                        <td>4</td>
                                        <td>Moto</td>
                                        <td>ZXXD457</td>
                                        <td>1</td>
                                        <td>Rafael y asociados SA CV</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>


                </div>
            </div>

            <br />
        </div>

        <div class="col-md-4 order-md-2">
            <h3 class="mb-3">Generales</h3>
            <div id="divGral1" class="row" hidden="hidden">
                <div class="col-md-4 order-md-1 mb-4">
                    Operación:
                </div>
                <div class="col-md-4 order-md-2">
                    <input type="radio" id="modo1" name="modo1" value="manual" checked="checked" onchange="ModoManual();">
                    <label for="modo1">Manual</label>
                </div>
                <div class="col-md-4 order-md-3">
                    <input type="radio" id="modo2" name="modo1" value="auto" onchange="ModoAutomatico();">
                    <label for="modo2">Automática</label>
                </div>

            </div>
            <div id="divGral2" class="row">
                <div class="col-md-6 order-md-1 mb-4">
                    <label for="puerta">Puerta</label>
                    <select class="custom-select d-block w-100" id="puerta" required="" onchange="ValidarDivGenerales()">
                        <option value="">Seleccione...</option>
                        <option>Principal</option>
                    </select>
                </div>
                <div class="col-md-6 order-md-2 mb-4">
                    <div class="invalid-feedback">Cámara a utilizar</div>
                    <label for="camara">Cámara</label>
                    <select class="custom-select d-block w-100" id="camara" required="" onchange="ValidarDivGenerales(); IniciarCapturaVideo();">
                        <option value="">Seleccione...</option>
                    </select>
                </div>
            </div>
            <div id="divCaptura" class="row">
                <!-- Aquí el video embebido de la webcam -->
                <div class="video-wrap">
                    <video id="video" playsinline autoplay></video>
                </div>
                &nbsp;&nbsp;
                        <!-- Botón de captura -->
                <canvas id="canvas1" width="210" height="160" style="border-color: aqua;"></canvas>
                <canvas id="canvas2" width="800" height="600" style="border-color: aqua;" hidden="hidden"></canvas>
            </div>
            <div id="divGral0" class="row">
                <!-- El elemento canvas -->
                <div class="controller">
                    <button id="snap" hidden="hidden">Probar</button>
                </div>
            </div>
            <div id="divGral3" class="row" hidden="hidden">
                <div class="col-md-12 order-md-1 mb-4">
                    <br />
                    <h3 class="mb-3">Última actividad:  ingreso</h3>
                    <br />
                    <h4 class="mb-3" id="infoBoleto">Boleto -</h4>
                    <label>Tipo: </label>
                    <label style="color: blue;" id="infoTipo">-</label>
                    <br />
                    <label>Ubicación: </label>
                    <label style="color: blue;" id="infoPatio">Patio -, </label>
                    <label style="color: blue;" id="infoSector">Sector -, </label>
                    <label style="color: blue;" id="infoNivel">Nivel -, </label>
                    <label style="color: blue;" id="infoCajon">Cajón -</label>
                </div>
            </div>
            <div id="divGral4" class="row" hidden="hidden">
                <div class="col-md-12 order-md-1 mb-4">
                    <br />
                    <h3 class="mb-3">Última actividad:  egreso</h3>
                    <br />
                    <h4 class="mb-3" id="infoBoleto2">Boleto -</h4>
                    <label>Ingreso: </label>
                    <label style="color: blue;" id="infoIngreso">-</label>
                    <br />
                    <label>Egreso: </label>
                    <label style="color: blue;" id="infoEgreso">-</label>
                    <br />
                    <label>Transcurrido: </label>
                    <label style="color: blue;" id="infoTiempo">-</label>
                    <br />
                    <label>Monto: </label>
                    <label style="color: blue;" id="infoMonto">-</label>
                    <label>Tarifa: </label>
                    <label style="color: blue;" id="infoTarifa">-</label>
                    <br />
                    <label>Boleto salida: </label>
                    <label style="color: blue;" id="infoBoletoSalida">-</label>
                </div>
            </div>
        </div>
    </div>


    <script type="text/javascript">
        function IniciarCapturaVideo() {
            var idcamara = document.getElementById('camara').value;

            if (window.stream) {
                window.stream.getTracks().forEach(track => {
                    track.stop();
                });
            };

            if (idcamara != "") {
                var canvas = document.getElementById('canvas1');
                var canvas2 = document.getElementById('canvas2');
                'use strict';
                const video = document.getElementById('video');
                const snap = document.getElementById("snap");
                const errorMsgElement = document.querySelector('span#errorMsg');
                const constraints = {
                    audio: false,
                    video: {
                        deviceId: idcamara, width: 160, height: 120
                    }
                };

                // Acceso a la webcam
                async function init() {
                    try {
                        const stream = await navigator.mediaDevices.getUserMedia(constraints);
                        handleSuccess(stream);
                    } catch (e) {
                        errorMsgElement.innerHTML = `navigator.getUserMedia error:${e.toString()}`;
                    }
                }
                // Correcto!
                function handleSuccess(stream) {
                    window.stream = stream;
                    video.srcObject = stream;
                }
                // Load init
                init();
                // Dibuja la imagen
                if (canvas == null) {
                    canvas = document.getElementById('canvas1');
                };

                //var context = canvas.getContext('2d');
                //var context2 = canvas2.getContext('2d');

            };
        };
    </script>

</asp:Content>

