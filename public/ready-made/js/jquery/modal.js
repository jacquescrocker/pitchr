(function($) {
	$.modal = function(config) {
		
		var defaults, options, modal, header, content, footer, close, overlay, width, centerOffset;

		defaults = {			
			title: ''
			, byline: ''
			
			, ajax: ''
			, div: ''	
			
			, slide: false	
			, slideEl: '.slide'	
			
			, btnClass: 'btn small secondary'
			
			, overlay: true
			, overlayClose: true
			
			, beforeOpen: function () {}
			, afterOpen: function () {}
			
			, debug: false
		};
		
		options = $.extend(defaults, config);		
		
		$.modal.forceClose ();
		
		modal = $('<div>', { 'id' : 'modal' });		
		header = $('<div>', { 'id' : 'modal_header' });		
		content = $('<div>', { 'id' : 'modal_content' });			
		overlay = $('<div>', { 'id' : 'modal_overlay'	});		
		close = $('<div>', { 'id' : 'modal_close' , 'html': 'x' });
		
		header.appendTo (modal);
		content.appendTo (modal);
		close.appendTo (modal);
		
		options.beforeOpen (modal);
		
		modal.appendTo ('body').hide ().fadeIn (500);
		
		if (options.overlay) {
			overlay.appendTo ('body');
		}
		
		if (options.overlayClose) {
			overlay.bind ('click', function (e) { $.modal.close (); });
		}
		
		close.bind ('click', function (e) { $.modal.close (); });		
						
		(options.title !== '') ? header.append ('<h3>' + options.title + '</h3>') : '';				
		(options.byline !== '') ? header.append ('<div class="byline">' + options.byline + '</div>') : '';	
		
		if (options.ajax !== '') {
			content.html ('<div id="modal_loader"><img src="../images/mba/ajax-loader.gif" /></div>');
			$.modal.reposition ();
			$.get (options.ajax, function (response) {
				content.html (response);
				handleContent ();
			});
		}						
		
		if (options.div !== '') {
			content.html ($(options.div).html());
			handleContent ();
		}	
		
		function handleContent () {
			$.modal.reposition ();		
			if (options.slide) { handleSlides (); }		
			
			setTimeout (function () {	
				options.afterOpen (modal);
			}, 1000);
		}	
		
		function handleSlides () {
			var slides = modal.find (options.slideEl);				
			slides.hide ().eq (0).show ().addClass ('current_slide');			
			var footer = $('<div>', { id: 'modal_footer' }).appendTo (modal);			
			var prev = $('<button>', { id: 'prev', html: '<u>P</u>revious' }).addClass (options.btnClass).appendTo (footer);
			var display = $('<span>', { id: 'display' }).appendTo (footer);
			var next = $('<button>', { id: 'next', html: '<u>N</u>ext' }).addClass (options.btnClass).appendTo (footer);			
			display.html ('<span class="current_page">1</span> of ' + slides.length);
			prev.attr ('disabled', 'disabled');	
			
			$(document).bind ('keyup.modal', function (e) {
				if (e.keyCode == 78 || e.keyCode == 39) { navigateSlides ('forward', slides); }
				if (e.keyCode == 80 || e.keyCode == 37) { navigateSlides ('backward', slides); }
			});
			
			footer.find ('button').bind ('click', function (e) {
				var direction = ($(this).is ('#next')) ? 'forward' : 'backward';
				navigateSlides (direction, slides);
			});
				
		}
		
		function navigateSlides (direction, slides) {
			var currentSlide, nextSlide, next, prev;
			next = $('#next');
			prev = $('#prev');
			currentSlide = content.find ('.current_slide');					
			nextSlide = (direction == 'forward') ? currentSlide.next (options.slideEl) : currentSlide.prev (options.slideEl);			
			
			if (nextSlide.length > 0) {
				nextSlide.addClass ('current_slide').show ().siblings (options.slideEl).hide ().removeClass ('current_slide');
				$('#display .current_page').text (nextSlide.index () + 1);
				
				(nextSlide.index () === 0) ? prev.attr ('disabled', 'disabled') : prev.removeAttr ('disabled');
				(nextSlide.index () === slides.length - 1) ? next.attr ('disabled', 'disabled') : next.removeAttr ('disabled');		
				
				var contentWidth = nextSlide.outerWidth ();					
				content.width (contentWidth + 30);
				//$.modal.reposition ();	
			}							
		}
		
		$(document).bind ('keyup.modal', function (e) { 
			if (e.keyCode == 27) { $.modal.close (); } 			
		});		
		
	};
	
	$.modal.reposition = function () {
		var width = $('#modal').outerWidth ();		
		var centerOffset = width / 2;	
		var pageScroll = getPageScroll ();	
		$('#modal').css ({ 'left': '50%', 'top': pageScroll[1] + 100, 'margin-left': '-' + centerOffset + 'px' });
	};
	
	$.modal.close = function () {
		$('#modal').fadeOut ('medium', function () { $(this).remove (); });
		$('#modal_overlay').fadeOut ('medium', function () { $(this).remove (); });
		$(document).unbind ('keyup.modal');
	};
	
	$.modal.forceClose = function () {
		$('#modal').remove ();
		$('#modal_overlay').remove ();
		$(document).unbind ('keyup.modal');
	};
	
	$.modal.setTitle = function (title) {
		var h3 = $('#modal_header').find ('h3');		
		if (h3.length > 0) {
			h3.html (title);
		} else {
			$('<h3>', { html: title }).prependTo ('#modal_header');	
		}
	};
	
	$.modal.setByline = function (text) {
		var el = $('#modal_header').find ('.byline');		
		if (el.length > 0) {
			el.html (text);
		} else {
			$('<div>', { 'class': 'byline', html: text }).appendTo ('#modal_header');	
		}
	};
	
	// getPageScroll() by quirksmode.com
		function getPageScroll() {
		    var xScroll, yScroll;
		    if (self.pageYOffset) {
		      yScroll = self.pageYOffset;
		      xScroll = self.pageXOffset;
		    } else if (document.documentElement && document.documentElement.scrollTop) {	 // Explorer 6 Strict
		      yScroll = document.documentElement.scrollTop;
		      xScroll = document.documentElement.scrollLeft;
		    } else if (document.body) {// all other Explorers
		      yScroll = document.body.scrollTop;
		      xScroll = document.body.scrollLeft;
		    }
		    return new Array(xScroll,yScroll);
		  }
})(jQuery);