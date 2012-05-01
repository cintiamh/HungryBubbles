var $j = jQuery.noConflict();

$j(document).ready(function() {
	
	//$j("#game_menu").hide();
	//$j("#game_content").hide();
	//$j("#game_content2").hide();
	//$j("#game_content3").hide();
	hideAll();
	$j("#tutorial").show();
	
	$j(".tutorial").click(function() {
		hideAll();
		$j("#tutorial").show();
    });
	
	$j(".open_menu").click(function() {
		hideAll();
		$j("#game_menu").show();
    });
	
	$j(".level1").click(function() {
		hideAll();
		$j("#game_content").show();
    });
	
	$j(".level2").click(function() {
		hideAll();
		$j("#game_content2").show();
    });
	
	$j(".level3").click(function() {
		hideAll();
		$j("#game_content3").show();
    });
	
});

var hideAll = function() {
	$j("#tutorial").hide();
	$j("#game_menu").hide();
	$j("#game_content").hide();
	$j("#game_content2").hide();
	$j("#game_content3").hide();
}