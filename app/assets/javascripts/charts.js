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

function show_top_tweeters_chart(topTweetUserNames, chartData) {
    var chart;
    $(document).ready(function() {
        chart = new Highcharts.Chart({
            chart: {
                renderTo: 'container',
                type: 'bar'
            },
            title: {
                text: 'Top 10 Tweeters by Tweet Sentiment'
            },
            subtitle: {
                text: 'Source: twitter.com'
            },
            xAxis: {
								categories: topTweetUserNames,
                title: {
                    text: 'Top tweeters'
                }
            },
            yAxis: {
                min: 0,
                title: {
                    text: 'Number of tweets',
                    align: 'high'
                },
                labels: {
                    overflow: 'justify'
                }
            },
            tooltip: {
                formatter: function() {
                    return ''+
                        this.series.name +': '+ this.y +' tweets';
                }
            },
            plotOptions: {
                bar: {
                    dataLabels: {
                        enabled: false
                    }
                }
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'top',
                x: -100,
                y: 100,
                floating: true,
                borderWidth: 1,
                backgroundColor: '#FFFFFF',
                shadow: true
            },
            credits: {
                enabled: false
            },
            series: chartData
        });
    });
  
}