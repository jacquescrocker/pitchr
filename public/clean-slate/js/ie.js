$(function() {
    if (parseInt($.browser.version) < 8) {
        $('table').attr('cellpadding', 0).attr('cellspacing', 0).attr('border', 0);
        
        $('textarea, input, select, button').each(function(){
            updateBorderBox(this);
        });
        
        $('input[type=button], input[type=submit], input[type=reset], button').each(function(){
            fixSize(this);
        });
        
        $('a, button, input').attr('hideFocus', true);
    }
    
    // Enable PIE magic
    $('#wrapper > header, #main-navigation li ul li').each(function(){
        PIE.attach(this);
    });
});

function updateBorderBox(element) {
	element.runtimeStyle.width = "";
	element.runtimeStyle.height = "";
	var csw = element.currentStyle.width;
	var csh = element.currentStyle.height;
	if (csw != "auto") {
		setBorderBoxWidth($(element).width(), element);
	}
	if (csh != "auto") {
		setBorderBoxHeight($(element).height(), element);
	}
}

/* border width getters */
function getBorderWidth(sSide, element) {
	if (element.currentStyle["border" + sSide + "Style"] == "none")
		return 0;
	var n = parseInt(element.currentStyle["border" + sSide + "Width"]);
	return n || 0;
}

function getBorderLeftWidth(element) { return getBorderWidth("Left", element); }
function getBorderRightWidth(element) { return getBorderWidth("Right", element); }
function getBorderTopWidth(element) { return getBorderWidth("Top", element); }
function getBorderBottomWidth(element) { return getBorderWidth("Bottom", element); }
/* end border width getters */

/* padding getters */
function getPadding(sSide, element) {
	var n = parseInt(element.currentStyle["padding" + sSide]);
	return n || 0;
}

function getPaddingLeft(element) { return getPadding("Left", element); }
function getPaddingRight(element) { return getPadding("Right", element); }
function getPaddingTop(element) { return getPadding("Top", element); }
function getPaddingBottom(element) { return getPadding("Bottom", element); }
/* end padding getters */

/* width and height setters */
function setBorderBoxWidth(n, element) {
	element.runtimeStyle.width = Math.max(0, n - getBorderLeftWidth(element) -
		getPaddingLeft(element) - getPaddingRight(element) - getBorderRightWidth(element)) + "px";
}

function setBorderBoxHeight(n, element) {
	element.runtimeStyle.height = Math.max(0, n - getBorderTopWidth(element) -
		getPaddingTop(element) - getPaddingBottom(element) - getBorderBottomWidth(element)) + "px";
}

/* end width and height setters */

function fixSize(element){
	//element.runtimeStyle.width = ($(element).width() - 2 + (getPaddingLeft(element) + getPaddingRight(element))) + 'px'
	element.runtimeStyle.height = ($(element).height() - 2 + (getPaddingTop(element) + getPaddingBottom(element))) + 'px'
}