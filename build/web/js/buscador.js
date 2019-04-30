$(document).ready(function() {
	// Evento buscar de onkeyup
	$("#buscar").keyup(function() {
		// iniciamos la tabla en blanco
		if( $(this).val() == "") {
			$("#tabla tbody>tr").hide();
			$("#tabla thead>tr>th[title=mensaje]").hide();             
		}
		else {
			// Mostramos las coincidencias
			$("#tabla tbody>tr").hide();
			//$("#tabla td:contains-ci('" + $(this).val() + "')").parent("tr]").show();
			$("#tabla td[title=titulo]:contains-ci('" + $(this).val() + "')").parent("tr").show();
			$("#tabla thead>tr>th[title=mensaje]").show();
		}
	});
});
// jQuery expression for case-insensitive filter
$.extend($.expr[":"], {
	"contains-ci": function(elem, i, match, array) {
		return (elem.textContent || elem.innerText || $(elem).text() || "").toLowerCase().indexOf((match[3] || "").toLowerCase()) >=0;
	}
});