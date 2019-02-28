/*DataTable Init*/

"use strict"; 

$(document).ready(function() {
	"use strict";
	
	$('#datable_1').DataTable({
        columnDefs: [ {
            targets: [ 0 ],
            orderData: [ 0, 1 ]
        },{
            targets: [ 4 ],
            orderData: [ 0, 1 ]
        } ]
    });
    $('#datable_2').DataTable({ "lengthChange": false});
	$('#datable_3').DataTable();
} );