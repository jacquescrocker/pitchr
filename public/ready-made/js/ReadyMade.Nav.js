ReadyMade.Nav = function () {
	
	return { init: init };
	
	function init () {
		$('.dropdown').find ('.item').append ('<div class="arrow"></div>').live ('click', open);
		$('.menu').append ('<span class="menu-top"></span>');
		
		$(document).mouseup(function(e) {
			if($(e.target).parents(".menu").length==0 && !$(e.target).is ('.menu')) {
				forceClose ();			
			}
		});	
	}
	
	function open (e) {
		e.preventDefault ();
		var $this = $(this).parent ();
		var $menu = $this.find ('.menu');				
		var docWidth = $(document).width ();
		var menuTotal = $this.offset ().left + $menu.outerWidth ();
		
		if (menuTotal > docWidth) {
			$menu.addClass ('right');
		} else {
			$menu.removeClass ('right');
		}
		
		$this.addClass ('hovered active');
		$menu.show ();
		
		$('.dropdown .item').live ('mouseenter', enter);
	}
	
	function enter (e)
	{
		e.preventDefault ();
		if (!$(this).parent ().is ('.active')) {
			kindaClose ();
			$(this).parent ().addClass ('hovered active').find ('.menu').show ();
		}
	}
	
	function kindaClose () {
		$('.menu').hide ();
		$('.nav.hovered').removeClass ('hovered active');		
	}
	
	function forceClose () {			
		kindaClose ();
		$('.dropdown .item').die ('mouseenter');
	}	
}();