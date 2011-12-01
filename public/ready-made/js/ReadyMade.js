var ReadyMade = {};

ReadyMade = function ()
{
	var defaults = {};	
	var options = {};

	return { init: init };
	
	function init (config)
	{						
		options = $.extend (defaults, config);
		
		ReadyMade.Nav.init ();
				
		ReadyMade.Charts.visualize ({ el: $('table.stats'), theme: options.theme });
		
		if ($.fn.dataTable) { $('.datatable').dataTable ({ "sPaginationType": "full_numbers" }); };
		
		if ($.fn.placeholder) { $('input, textarea').placeholder (); }		
	}	
}();