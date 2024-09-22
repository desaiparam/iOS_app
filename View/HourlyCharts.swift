//
//  HourlyCharts.swift
//  newstockapp
//
//  Created by Param Desai on 13/04/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let htmlString: String
    func makeUIView(context: Context) -> WKWebView{
        return WKWebView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.loadHTMLString(htmlString, baseURL: nil)
    }
}


//struct LineChartsSeriesDataList:Codable{
//    let t:Int64
//    let c:Double
//}
//struct HourlyCharts: View {
//    @ObservedObject var hourlyChartsData = HourlyChartsList()
//    var date : Int64
//    var ticker :String
//    var body: some View {
//        VStack{
//            WebView(htmlFileName: "index", data:hourlyChartsData.hourcharts?.results ?? [])
//        }.task {
//            await hourlyChartsData.fetchData(ticker: ticker, chartsDate: date)
//        }
//
//    }

struct HourlyCharts: View {
//    var data:[HourlyChartsData]
    var data:String
    var color:Double
    var body: some View {
//        VStack{
            WebView(htmlString:lineCharts())
                .background(Color.white)
//                .padding(1)
//        }
    }
    func convertSwiftArrayToJSArray<T: Encodable>(array: [T]) -> String {
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(array)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        } catch {
            print("Error converting array to JSON: \(error.localizedDescription)")
        }
        return "[]"
    }
    //    private func lineCharts() -> String{
    //
    //        var lineSeriesData = [LineChartsSeriesDataList]()
    //        //        print(lineSeriesData)
    //        for line in data {
    //            lineSeriesData.append(LineChartsSeriesDataList(t:line.t, c: line.c))
    //        }
    //        //        print(lineSeriesData)
    //        let seriesJson = convertSwiftArrayToJSArray(array: lineSeriesData)
    //        print("seriesJson",seriesJson)
    //        return """
    //        <!DOCTYPE html>
    //        <html lang="en">
    //        <head>
//                <script src="https://code.highcharts.com/highcharts.js"></script>
//               <script src="https://code.highcharts.com/modules/series-label.js"></script>
//             <script src="https://code.highcharts.com/modules/exporting.js"></script>
//               <script src="https://code.highcharts.com/modules/export-data.js"></script>
//              <script src="https://code.highcharts.com/modules/accessibility.js"></script>
    //        </head>
    //        <body>
    //            <div id="container" ></div>
    //            <script>
    //                document.addEventListener('DOMContentLoaded', function () {
    //                    var seriesData = \(seriesJson); // Inject the JSON string directly into JavaScript
    //
    //                    Highcharts.chart('container', {
    //                        chart: {
    //                            backgroundColor: '#F8F8F8',
    //                        },
    //        title: {
    //        text: 'Hourly Price Variation',
    //        style: {
    //          color: '#888a8d',
    //        }
    //        },
    //                        xAxis: {
    //                            type: 'datetime',
    //                            dateTimeLabelFormats: {
    //                                hour: '%H:%M',
    //                            }
    //                        },
    //                        yAxis: {
    //                            opposite: true,
    //                            title: '',
    //                        },
    //                        series: [{
    //          animation: true,
    //        color: 'black',
    //                      name: '',
    //        data: seriesData.map(item => [item.t, item.c]),
    //                            type: 'line',
    //                            marker: false,
    //                            showInLegend: false,
    //                            tooltip: {
    //                                valueDecimals: 2
    //                            }
    //                        }]
    //                    });
    //                });
    //            </script>
    //        </body>
    //        </html>
    //        """
    //
    //
    //    }
    //}
    //
    
    private func lineCharts() -> String{
        return """
<!DOCTYPE html>
<html lang="en">

<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/series-label.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/export-data.js"></script>
    <script src="https://code.highcharts.com/modules/accessibility.js"></script>
</head>

<body>

  <div id="container"></div>


    <script>
var colorchange =\(color) < 0 ? 'red' : \(color) > 0 ? 'green' : 'black'
        var lineCharts;
        var tickervalue = "\(data)";
        fetch(`https://backendproject4.wl.r.appspot.com/hourlycharts/${tickervalue}`)
            .then(response => response.json())
            .then(lineChartsData => {
                // Handle received quote data
                lineCharts = lineChartsData;
                renderChart(lineCharts);
                // Fetch hourly chart data using the received quote data
            })
            .catch(error => console.error('Error:', error));

        function renderChart(data) {
            Highcharts.chart('container', {
                title: {
                    text: tickervalue + ' ' + 'Hourly Price Variation',
                    style: {
                        color: '#888a8d',
                    }
                },
                xAxis: {
                    type: 'datetime',
                    dateTimeLabelFormats: {
                        hour: '%H:%M', // day of the week, day of the month, month, hour:minute
                    }
                },
                yAxis: {
                    opposite: true,
                    title: '',
                },
                // tooltip: {
                //   xDateFormat: '%H:%M', // Same format for the tooltip
                // },
                series: [{
                   color: colorchange,
                    name: tickervalue,
                    data: data.results.map(item => [item.t, item.c]),
                    type: 'line',
                    marker: false,
                    showInLegend: false,
                    label: {
                        enabled: false // Add this line to disable the series label
                    },
                    tooltip: {
                        valueDecimals: 2
                    }

                }]
            });
        }
    </script>
</body>

</html>
"""
    }
}
