$(function(){
	// $(".add_nested_fields").on('click', function(){
	// 	setTimeout("add_index_to_fields()", 300);
	// });

	// $(".survey_qtype").on('change', 'select', function(){
	// });
	// $(".edui-default").removeAttr("style")
	$(".qtype").change(function(){
		$(this).parent().next().find('input').attr('disabled', true)
	})
});

// function add_index_to_fields(){
// 	$(".simple_form .fields:visible").each(function(index, e){
// 		index++;
//   	$(e).find('label:first').html(index+"、标题"); 
// 	});
// 	$(".remove_nested_fields").on('click', function(){
// 		setTimeout("add_index_to_fields()", 300);
// 	});
// }


