jQuery(document).ready(function($) {
	$(".color-picker").each(function() {
		var self = $(this);
		var preview_obj = $("#" + self.data("preview"));

		self.ColorPicker({
			onSubmit: function(hsb, hex, rgb, el) {
				$(el).val("#" + hex);
				$(el).ColorPickerHide();
			},
			onBeforeShow: function () {
				$(this).ColorPickerSetColor(this.value);
			},
			onChange: function (hsb, hex, rgb) {
				preview_obj.css("backgroundColor", "#" + hex);
			}
		})
		.bind('keyup', function(){
			$(this).ColorPickerSetColor(this.value);
		});
	})
});
