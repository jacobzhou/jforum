$(function(){
	$(".add_nested_fields").click(function(){
		setTimeout("add_index_to_fields()",1000);
	});
	$(".remove_nested_fields").click(function(){
		setTimeout("add_index_to_fields()",1000);
	});
});

function add_index_to_fields(){
	$(".simple_form  .fields").each(function(index, e){
  	$(e).find('label:first').html(index+"、标题"); 
	});
}

