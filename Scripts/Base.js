/// Clase base para el manejo de llamadas a servidor


var ObtieneEmisores = function (Opc) {

    $("#SelectorEmisores option").remove();

    Ajax({
        url: "/API/EmisionWeb/ObtieneEmisores",
        data: { Opcion: Opc },
        success: function (D) {
            var RFCs = JSON.parse(D.TABLA)

            if ($("#SelectorEmisores option").length > 0) {
                var selector = $("#SelectorEmisores");
                $('.selectpicker').selectpicker('refresh');
            }

            for (var i = 0; i < RFCs.length; i++)
                $('#SelectorEmisores').append('<option value="' + RFCs[i].RfcEmisor + '">' + RFCs[i].RazonSocial + ' - ' + RFCs[i].RfcEmisor + '</option>');

            $('#SelectorEmisores').selectpicker(
                {
                    allSelectedText: true
                    , noneSelectedText: 'Sin empresas seleccionadas'
                    , selectAllText: 'Selecciona todo'
                    , deselectAllText: 'Quitar selección'
                    , container: 'body',
                });

            $("#SelectorEmisores option:selected").val('default');
            $("#SelectorEmisores").selectpicker("refresh");

            $('#SelectorEmisores').selectpicker('selectAll');

        }
    });


}
