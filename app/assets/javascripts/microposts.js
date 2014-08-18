function updateCountdown() {
  var max_length = 140; // max message length
  var remaining_length = max_length - jQuery('#micropost_content').val().length;
  jQuery('.countdown').text(remaining_length + ' characters remaining');
  
  if (remaining_length < 0) {
		$('.countdown').css("color", "red");
	} 
	else {
		$('.countdown').css("color", "black");
	}
}

jQuery(document).ready(function($) {
    updateCountdown();
    $('#micropost_content').change(updateCountdown);
    $('#micropost_content').keyup(updateCountdown);
});
