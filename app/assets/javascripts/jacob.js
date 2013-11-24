$(function(){
	$(".add_nested_fields").click(function(){
		add_index_to_fields();
	});
	$(".remove_nested_fields").click(function(){
		add_index_to_fields();
	});
});

function add_index_to_fields(){
	$(".simple_form  .fields").each(function(index, e){
  	$(e).find('label:first').html(index+"、"+$(e).find('label:first').html()); 
	});
}

