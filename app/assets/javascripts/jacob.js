$(function(){
	// $(".add_nested_fields").on('click', function(){
	// 	setTimeout("add_index_to_fields()", 300);
	// });

	// $(".survey_qtype").on('change', 'select', function(){
	// });
	// $(".edui-default").removeAttr("style")
	$(document).on('change', '.qtype', function(){
		$(this).parent().next().find('input').attr('disabled', true);
    if ($(this).val() == '0' || $(this).val() == '2' || $(this).val() == '5'){
      $(this).parent().next().find('input').removeAttr('disabled');
    }
	});
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
// 自动适应高度textarea
function textarea_auto_height(textarea){
  textarea.style.height = "1px";
  textarea.style.height = (25+textarea.scrollHeight)+"px";
}

