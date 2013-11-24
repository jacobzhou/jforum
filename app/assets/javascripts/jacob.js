$(function(){
	$(".add_nested_fields").on('click', function(){
		setTimeout("add_index_to_fields()",500);
	});
	$(".remove_nested_fields").on('click', function(){
		alert(1);
		setTimeout("add_index_to_fields()",500);
	});
});

function add_index_to_fields(){
	$(".simple_form .fields:visible").each(function(index, e){
		index++;
  	$(e).find('label:first').html(index+"、标题"); 
	});
}

