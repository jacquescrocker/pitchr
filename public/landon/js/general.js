// JavaScript Effects
$(document).ready(function(){
	
	// Contact area
	$("#contact-area").css('height', '0px');
	$("a.contact").toggle( 
				function () { 
 					$("#contact-area").animate({height: "285px"}, {queue:false, duration: 900, easing: 'jswing'}).slideDown() 
                }, 
                function () { 
					$("#contact-area").animate({height: "0px"}, {queue:false, duration: 900, easing: 'jswing'})  
	}); 
	
	// Input value toggle
	var active_color = '#848484'; // Colour of user provided text
  var inactive_color = '#848484'; // Colour of default text	
	$("input.default-value").css("color", inactive_color);
  var default_values = new Array();
  $("input.default-value").focus(function() {
    if (!default_values[this.id]) {
      default_values[this.id] = this.value;
    }
    if (this.value == default_values[this.id]) {
      this.value = '';
      this.style.color = active_color;
    }
    $(this).blur(function() {
      if (this.value == '') {
        this.style.color = inactive_color;
        this.value = default_values[this.id];
      }
    });
  });	
	
	// Tab pages
	$(".tab-content").hide(); //Hide all content
	$("#nav ul li:first").addClass("active").show(); //Activate first tab
	$(".tab-content:first").show(); //Show first tab content

	// On Click Event
	$("#nav ul li").click(function() {

		$("#nav ul li").removeClass("active"); //Remove any "active" class
		$(this).addClass("active"); //Add "active" class to selected tab
		$(".tab-content").hide(); //Hide all tab content

		var activeTab = $(this).find("a").attr("href"); //Find the href attribute value to identify the active tab + content
		$(activeTab).fadeIn(); //Fade in the active ID content
		return false;
	});
	
	// Flickr Feed with FancyBox
	$('#flickr-feed').jflickrfeed({
		limit: 10,
		qstrings: {
			id: '52617155@N08'
		},
		itemTemplate: '<li>'+
						'<a rel="product-gallery" class="fancybox-image" href="{{image}}">' +
							'<img src="{{image_s}}" alt="{{title}}" />' +
						'</a>' +
					  '</li>'
	}, function(data) {
		$("a.fancybox-image").fancybox({
		'titlePosition' : 'outside',
		'transitionIn'	:	'fade',
		'transitionOut'	:	'fade',
		'overlayColor' : '#000',
		'overlayOpacity' : 0.7
    });
    
    // Flickr Opacity
    $(function() {
      $("#flickr-feed img").css("opacity","1");
      $("#flickr-feed img").hover(function () {
        $(this).stop().animate({
            opacity: 0.85
        }, 'fast');
      },
      function () {
      $(this).stop().animate({
          opacity: 1
        }, 'normal');
      });
    });
	});
	
	// Back to top
	$('a[href=#top]').click(function(){
        $('html, body').animate({scrollTop:0}, 'slow');
        return false;
  });
    
	var $gridSections = $(".pricing-column");	
	$gridSections.hover
	(
		function()
		{
			$gridSections.removeClass("selected");
		}
	);
  
	$(function() {
    $("#logo").css("opacity","0.85");
    $("#logo").hover(function () {
      $(this).stop().animate({
          opacity: 1
      }, 'fast');
    },
    function () {
    $(this).stop().animate({
        opacity: 0.85
      }, 'normal');
    });
  });
		
});

// Featured Slider
$(document).ready(function(){	
  $("#featured-slider").easySlider({
    auto: true, 
    continuous: true,
    pause: 10000
  });
});	

// Featured Carousel
$(document).ready(function() {
  var interval;
  $('#featured-carousel')
          .roundabout({
              shape: 'lazySusan',
              easing: 'swing',
              minOpacity: 1,
              minScale: 0.7,
              duration: 500,
              clickToFocus: true
              })
    .hover(
      function() {  clearInterval(interval); },
      function() {  interval = startAutoPlay(); }
    );
  interval = startAutoPlay();
});
function startAutoPlay() {
  return setInterval(function() {
    $('#roundabout').roundabout_animateToNextChild();
  }, 3000);
}