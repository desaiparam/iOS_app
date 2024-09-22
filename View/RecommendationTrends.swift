//
//  RecommendationTrends.swift
//  NewFinalStockApp
//
//  Created by Param Desai on 29/04/24.
//

import SwiftUI
//import WebKit

struct RecommendationTrends: View {
    var data:String
    var body: some View {
//        ScrollView{
            VStack{
                Spacer()
                WebView(htmlString:rtrends())
                ////                .background(Color.white)
            } .padding(.bottom, 30.0)
//        }
        //        Text("Hello ")
    }
    private func rtrends() -> String{
        return """
<!DOCTYPE html>
<html lang="en">

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/export-data.js"></script>
    <script src="https://code.highcharts.com/modules/accessibility.js"></script>

    <title>Document</title>
</head>

<body>
    <div id="container"></div>
    <script>
        var charts;
        var tickervalue = "\(data)";
        fetch(`https://backendproject4.wl.r.appspot.com/recommendationTrends/${tickervalue}`)
            .then(response => response.json())
            .then(chartsData => {
                // Handle received quote data
                charts = chartsData;
                renderChart(charts);
                // Fetch hourly chart data using the received quote data
            })
            .catch(error => console.error('Error:', error));
        function renderChart(data) {
            Highcharts.chart('container', {
                chart: {
                    type: 'column',
                },
                title: {
                    text: 'Recommendation Trends',
                    align: 'center',
                },
                xAxis: {
                    categories: data.map(item => item.period),
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: 'Analysis'
                    },
                    // stackLabels: {
                    //   enabled: true
                    // }
                },
                legend: {
                    align: 'center',
                    verticalAlign: 'bottom', // Change verticalAlign to 'bottom'
                    x: 0,
                    y: 0,
                    floating: false,
                    // backgroundColor: Highcharts.defaultOptions.legend.backgroundColor || 'white',
                    // borderColor: '#CCC',
                    // borderWidth: 1,
                    // shadow: false
                },
                tooltip: {
                    headerFormat: '<b>{point.x}</b><br/>',
                    pointFormat: '{series.name}: {point.y}<br/>Total: {point.stackTotal}'
                },
                plotOptions: {
                    column: {
                        stacking: 'normal',
                        dataLabels: {
                            enabled: true
                        }
                    }
                },
                series: [{
                    name: 'Strong Buy',
                    color: 'rgb(50,120,75)',
                    data: data.map(item => item.strongBuy)
                }, {
                    name: 'Buy',
                    color: 'rgb(35,175,80)',
                    data: data.map(item => item.buy)
                }, {
                    name: 'Hold',
                    color: 'rgb(175,125,40)',
                    data: data.map(item => item.hold)
                }, {
                    name: 'Sell',
                    color: 'rgb(240,80,80)',
                    data: data.map(item => item.sell)
                }, {
                    name: 'Strong Sell',
                    color: 'rgb(235,40,55)',
                    data: data.map(item => item.strongSell)
                }]
            });

        }

    </script>
</body>

</html>

"""
        
    }
}

//#Preview {
//    RecommendationTrends()
//}
