function show_pie_chart(chartData) {
	var chart;
	var colors = Highcharts.getOptions().colors;
	$(document).ready(function() {
		chart = new Highcharts.Chart({
			chart: {
				renderTo: 'container',
				plotBackgroundColor: null,
				plotBorderWidth: null,
				plotShadow: false
			},
			title: {
				text: 'Sentiment distribution of tweets that mention "thoughtworks"'
			},
			tooltip: {
				formatter: function() {
					return '<b>'+ this.point.name +'</b>: '+ this.percentage +' %';
				}
			},
			plotOptions: {
				pie: {
					allowPointSelect: true,
					cursor: 'pointer',
					dataLabels: {
						enabled: false
					},
					showInLegend: true
				}
			},
			series: [{
				type: 'pie',
				name: 'Sentiment Distribution',
				data: chartData,
			}]
		});
	});
}

function show_trend_chart(dates, chartData) {
	var chart;
	$(document).ready(function() {
		chart = new Highcharts.Chart({
			chart: {
				renderTo: 'container',
				type: 'line',
				marginRight: 130,
				marginBottom: 25
			},
			title: {
				text: 'Daily Social Sentiment',
				x: -20 //center
			},
			xAxis: {
				categories: dates
			},
			yAxis: {
				title: {
					text: 'Tweets'
				},
				plotLines: [{
					value: 0,
					width: 1,
					color: '#808080'
					}]
				},
				tooltip: {
					formatter: function() {
						return '<b>'+ this.series.name +'</b><br/>'+
						this.x +': '+ this.y +'°C';
					}
				},
				legend: {
					layout: 'vertical',
					align: 'right',
					verticalAlign: 'top',
					x: -10,
					y: 100,
					borderWidth: 0
				},
				series: chartData
			});
		});
}