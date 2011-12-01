(function($) {
	$.msgBar = function(config) {
		
		var defaults, options, bar, icon, close;

		defaults = {
			type: ''
			, title: ''
			, text: ''
			, lifetime: 0
			, closeTrigger: true
		};
		
		options = $.extend(defaults, config);
		
		bar = $('<div>', { 
			'class' : 'msgBar ' + options.type
			, 'text': options.text
		});
		
		icon = $('<div>', {
			'class': 'icon'
		}).appendTo (bar);
		
		if (options.closeTrigger) {
			close = $('<div>', {
				'class': 'close'
				, 'text': 'x'
				, 'click': closeBar
			}).appendTo (bar);
		}		
				
		if (options.lifetime > 0) {
			setTimeout (function () {
				closeBar ();
			}, options.lifetime);
		}
		
		function closeBar () {
			bar.slideUp ('medium', function () {
				$(this).remove ();
			})
		}
		
		return bar;
	}
})(jQuery);