ReadyMade.Charts = function () {
	
	var themes = {
		defaulted: ['#06C', '#222', '#777', '#555','#002646','#999','#bbb','#ccc','#eee']
		, firestarter: ['#750000', '#F90', '#777', '#555','#002646','#999','#bbb','#ccc','#eee']
		, oceanbreeze: ['#2B4E72', '#94BA65', '#2790B0', '#777','#555','#999','#bbb','#ccc','#eee']
		, poppyfields: ['#809B7C', '#FB8359', '#FED086', '#777','#555','#999','#bbb','#ccc','#eee']
		, islandescape: ['#3A89C9', '#F2785E', '#9CC4E4', '#777','#555','#999','#bbb','#ccc','#eee']
		, orangebeam: ['#F90', '#727670', '#AAA','#002646','#999','#bbb','#ccc','#eee']
		, newgrass: ['#82C033', '#222', '#777', '#555','#002646','#999','#bbb','#ccc','#eee']
		, rebelred: ['#F30000', '#222', '#777', '#555','#002646','#999','#bbb','#ccc','#eee']
		, plumcrazy: ['#810F7B', '#222', '#777', '#555','#002646','#999','#bbb','#ccc','#eee']
		, tealoffury: ['#6DBCC7', '#222', '#777', '#555','#002646','#999','#bbb','#ccc','#eee']
		, blackout: ['#CB210E', '#222', '#777', '#555','#002646','#999','#bbb','#ccc','#eee']
		, autumnleaves: ['#5E412F', '#F07818', '#F0A830', '#78C0A8', '#555','#002646','#999','#bbb','#ccc','#eee']
		, cavalry: ['#5D5D2B', '#56441B', '#978A68', '#78C0A8', '#555','#002646','#999','#bbb','#ccc','#eee']
		
	};
	
	var chartType = 'area';
	var chartHeight = '280px';
	var chartColors = [];
	var chartWidth = '';
	
	return { visualize: visualize };
	
	function visualize (config) {
		config.el.each(function() 
		{				
			chartHeight = ($(this).attr ('data-chart-height') != null) ? $(this).attr ('data-chart-height') + 'px' :  chartHeight;
			chartType = ($(this).attr ('data-chart-type') != null) ? $(this).attr ('data-chart-type') : chartType;

			if (themes[config.theme] != null && themes[config.theme] != '') {					
				chartColors = themes[config.theme];
			} else {
				chartColors = themes['defaulted'];
			}					
			
			chartWidth = $(this).parent ().width () * .92;
			
			if(chartType == 'line' || chartType == 'pie') {
				$(this).hide().visualize({
					type: chartType
					, width: chartWidth
					, height: chartHeight			
					, colors: chartColors
					, lineDots: 'double'
					, interaction: true
					, multiHover: 5
					, tooltip: true
					, tooltiphtml: function(data) {
						var html ='';
						for(var i=0; i<data.point.length; i++){
							html += '<p class="chart_tooltip"><strong>'+data.point[i].value+'</strong> '+data.point[i].yLabels[0]+'</p>';
						}	
						return html;
					}
				});
			} else {
				$(this).hide().visualize({
					type: chartType					
					, colors: chartColors
					, width: chartWidth
					, height: chartHeight
				});
			}				
		});
	}
	
}();