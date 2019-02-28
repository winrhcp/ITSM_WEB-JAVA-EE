$(document).ready(function() {
	$(".btn.btn-primary.btn-sm.view").click(function (){
		/*	var edit_earno = $(this).attr('id');*/
				
			// now get the values from the table
			var v1 = $(this).find('.v1').html();
			var v2 = $(this).find('.v2').html();
			var v3 = $(this).find('.v3').html();
			var v4 = $(this).find('.v4').html();
			var v5 = $(this).find('.v5').html();
			var v6 = $(this).find('.v6').html();
			var v7 = $(this).find('.v7').html();
			var v8 = $(this).find('.v8').html();
			var v9 = $(this).find('.v9').html();
			var v10 = $(this).find('.v10').html();
			var v11 = $(this).find('.v11').html();
			var v12 = $(this).find('.v12').html();
			var v13 = $(this).find('.v13').html();

			// and set them in the modal:
			$('p#v1').text(v1);
			$('p#v2').text(v2);
			$('p#v3').text(v3);
			$('p#v4').text(v4);
			$('p#v5').text(v5);
			$('p#v6').text(v6);
			$('p#v7').text(v7);
			$('#v8').text(v8);
			$('#v9').text(v9);
			$('#v10').text(v10);
			$('#v11').text(v11);
			$('p#v12').text(v12);
			$('p#v13').text(v13);
	});
	
	$(".btn.btn-warning.btn-sm.edit").click(function (){
		var edit_earno = $(this).attr('id');
		$("#edit_row").val(edit_earno);
	    // now get the values from the table
	    var e1 = $(this).find('.e1').html();
	    var e2 = $(this).find('.e2').html();
	    var e3 = $(this).find('.e3').html();
	    var e4 = $(this).find('.e4').html();
	    var e5 = $(this).find('.e5').html();
	    var e6 = $(this).find('.e6').html();
	    var e7 = $(this).find('.e7').html();
	    var e8 = $(this).find('.e8').html();
	    var e9 = $(this).find('.e9').html();

	    var e12 = $(this).find('.e12').html();
	    var e13 = $(this).find('.e13').html();
	    var e14 = $(this).find('.e14').html();

	    // and set them in the modal:
	    $('#ear').val(e1);
	    
	    $('#date').val(e3);
	    $('#cus').val(e4);
	    $('#loc').val(e5);
	    $('#contact').val(e6);
	    $('#tel').val(e7);
	    $('#incident').val(e8);
	    $('#solu').val(e9);

	    $('#p_code').val(e12);
	    $('#incidentno').val(e13);
	});
	
	$(".btn.btn-danger.btn-sm.del").click(function (){
		var delete_earno = $(this).attr('id');
 		$("#delete_row").val(delete_earno);
	});
	
});