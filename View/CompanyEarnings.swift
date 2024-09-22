//
//  CompanyEarnings.swift
//  NewFinalStockApp
//
//  Created by Param Desai on 30/04/24.
//

import SwiftUI

struct CompanyEarnings: View {
        var data:String
        var body: some View {
            //        VStack{
            WebView(htmlString:ce())
            ////                .background(Color.white)
            //        }
            //        Text("Hello ")
        }
        private func ce() -> String{
            return """
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
      fetch("https://backendproject4.wl.r.appspot.com/CompanyEarning/\(data)")
        .then((response) => response.json())
        .then((chartsData) => {
          charts = chartsData;
          renderChart(charts);
        })
        .catch((error) => console.error("Error:", error));

      function renderChart(data) {
        console.log(data);
        const XAxisData = data.map((data) => {
          return `${data.period}<br/>Surprise: ${
            data.surprise !== null ? data.surprise : 0
          }`;
        });
        console.log(XAxisData);
        const Actual = data.map((data) =>
          data.actual !== null ? data.actual : 0
        );
        console.log(Actual);
        const Estimate = data.map((data) =>
          data.estimate !== null ? data.estimate : 0
        );
        console.log(Estimate);
        Highcharts.chart("container", {
          chart: {
            type: "spline",
            menuOptions: {
              enableFullscreen: false,
            },
          },
          title: {
            text: "Historical EPS Surprises",
          },
          xAxis: {
            categories: XAxisData,
          },
          yAxis: {
            title: {
              text: "Quarterly EPS",
            },
          },
          plotOptions: {
            line: {
              dataLabels: {
                enabled: false,
              },
              enableMouseTracking: true,
              marker: {
                enabled: true,
              },
            },
          },
          tooltip: {
            shared: true,
          },
          series: [
            {
              name: "Actual",
              data: Actual,
            },
            {
              name: "Estimate",
              data: Estimate,
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
//    CompanyEarnings()
//}
