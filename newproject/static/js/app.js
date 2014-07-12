
$('document').ready(function(){
	$('.apple1').popover({
		html: true,
		content: function(){
			return $('#testing').html();
		}
	})
})