var pop_val;

$(document).ready(function(){
	$("#submit").click(function(){
		pop_val = $("#population").val();
		$("#result").text(pop_val);
		calculatePlates(pop_val);
	});
});

function calculatePlates(pop) {
	
}