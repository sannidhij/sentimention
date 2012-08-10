$(document).ready(function() {
	$(':radio').click(function() {
		var tweet_id = this.name;
		var sentiment = this.value;
		$.ajax({
			url: '/tweets', 
			type: "POST", 
			data: {'id' : this.name, 'sentiment' : this.value }
		}).done(function() {
			var div = $('#' + tweet_id + ' .tweet').removeAttr("class");
			div.addClass("tweet " + sentiment );
			$(this).load();
		});
	});
});