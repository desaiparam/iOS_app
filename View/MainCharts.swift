//
//  MainCharts.swift
//  NewFinalStockApp
//
//  Created by Param Desai on 17/04/24.
//

import SwiftUI

struct MainCharts: View {
    var data:String
    var body: some View {
        VStack{
            WebView(htmlString:mainCharts())
                .background(Color.white)
        }
    }
    private func mainCharts() -> String{
        return """
<!DOCTYPE html>
<html lang="en">

<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.highcharts.com/stock/highstock.js"></script>
    <script src="https://code.highcharts.com/stock/modules/drag-panes.js"></script>
    <script src="https://code.highcharts.com/stock/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/stock/indicators/indicators.js"></script>
    <script src="https://code.highcharts.com/stock/indicators/volume-by-price.js"></script>

</head>

<body>
  
        <div id="container"></div>

    <script>
        var charts;
        var tickervalue = "\(data)";
        fetch(`https://backendproject4.wl.r.appspot.com/charts/${tickervalue}`)
            .then(response => response.json())
            .then(chartsData => {
                // Handle received quote data
                charts = chartsData;
                renderChart(charts);
                // Fetch hourly chart data using the received quote data
            })
            .catch(error => console.error('Error:', error));

        function renderChart(data) {
            const ohlc = data.results.map((item) => [
                item.t,
                item.o,
                item.h,
                item.l,
                item.c,
            ]);
            console.log(ohlc);
            const volume = data.results.map((item) => [item.t, item.v]);
            Highcharts.stockChart('container', {
                rangeSelector: {
                    selected: 2,
                },
                title: {
                    text: tickervalue + ' ' + `Historical`,
                },
                subtitle: {
                    text: "With SMA and Volume by Price technical indicators",
                },
                yAxis: [
                    {
                        startOnTick: false,
                        endOnTick: false,
                        labels: {
                            align: "right",
                            x: -3,
                        },
                        title: {
                            text: "OHLC",
                        },
                        height: "60%",
                        lineWidth: 2,
                        resize: {
                            enabled: true,
                        },
                    },
                    {
                        labels: {
                            align: "right",
                            x: -3,
                        },
                        title: {
                            text: "Volume",
                        },
                        top: "65%",
                        height: "35%",
                        offset: 0,
                        lineWidth: 2,
                    },
                ],
                tooltip: {
                    split: true,
                },
                // plotOptions: {
                //   series: {
                //     dataGrouping: {
                //       units: [
                //         ["week", [1]],
                //         ["month", [1, 2, 3, 4, 6]],
                //       ],
                //     },
                //   },
                // },
                series: [
                    {
                        type: "candlestick",
                        name: tickervalue,
                        id: tickervalue,
                        zIndex: 2,
                        data: ohlc
                    },
                    {
                        color: "blue",
                        type: "column",
                        name: "Volume",
                        id: "volume",
                        data: volume,
                        yAxis: 1,
                    },
                    {
                        type: "vbp",
                        linkedTo: tickervalue,
                        params: {
                            volumeSeriesID: "volume",
                        },
                        dataLabels: {
                            enabled: false,
                        },
                        zoneLines: {
                            enabled: false,
                        },
                    },
                    {
                        color: 'orange',
                        type: "sma",
                        linkedTo: tickervalue,
                        zIndex: 1,
                        marker: {
                            enabled: false,
                        },
                    },
                ],
            });
        }


    </script>

</body>

</html>
"""
    }
}

//#Preview {
//    MainCharts(data:"AAPL")
//}
