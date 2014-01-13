jQuery(document).ready(function($) {
	$(".group-select").click(function(e) {
		e.preventDefault();

		var is_selected = ($(this).data("select") == 0) ? false : true;
		var group_users = $(this).data("groupUsers");

		// set to all users (for select all / unselect all)
		if (!group_users) {
			group_users = "";
		}

		// make sure that it is a string. Otherwise, it will fail
		// if there is only 1 user id
		group_users = new String(group_users);

		// iterate the users
		$(group_users.split(",")).each(function() {
			var input_id = "holiday_user_checkbox_" + this;
			if (is_selected)
				$("#" + input_id).attr("checked", "checked");
			else
				$("#" + input_id).removeAttr("checked");
		});

		return false;
	});

	$("a.collapsible").click(function(e) {
		e.preventDefault();

		$(this)
			.toggleClass("collapsed")
			.prev(".collapsible")
				.toggleClass("collapsed");

		return false;
	});
});
