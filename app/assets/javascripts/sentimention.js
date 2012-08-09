$(document).ready(function() {
	$(':radio').click(function() {
		$.ajax({
			url: '/tweets', 
			type: "POST", 
			data: {'id' : this.name, 'sentiment' : this.value }
		}).done(function() {
			console.log('done');
		});
	});
});