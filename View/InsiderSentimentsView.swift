//
//  InsiderSentimentsView.swift
//  NewFinalStockApp
//
//  Created by Param Desai on 29/04/24.
//

import SwiftUI

struct IndsiderSentimentView: View {
    
//    @State private var totalMSPR: Double = 0
//    @State private var totalChange: Double = 0
//    @State private var positiveMSPR: Double = 0
//    @State private var positiveChange: Double = 0
//    @State private var negativeMSPR: Double = 0
//    @State private var negativeChange: Double = 0
    
   var totalMSPR: Double = 0
     var totalChange: Double = 0
     var positiveMSPR: Double = 0
    var positiveChange: Double = 0
    var negativeMSPR: Double = 0
   var negativeChange: Double = 0
    var symbol:String
//    @ObservedObject var insiderSentiment:InsiderSentimentsList
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Insights")
          
                .font(.system(size: 24))

                .padding(.top, 20)
                .padding(.horizontal, 14)

            // Table view
//            VStack(alignment: .center, spacing: 8) {
            
                HStack{
                    Spacer()
                       Text("Indsider Sentiment")
                           .font(.title)
                           .multilineTextAlignment(.center)
                    Spacer()
                
            }
            HStack {
                VStack(alignment: .leading) {
                    Text(symbol)
                        .font(.headline)
                    Divider().padding(.top, 4)
                }
                .padding(.leading, 14.0)
                
                
//                Spacer()
                
                VStack(alignment: .leading) {
                    Text("MSPR")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                    Divider().padding(.top, 4)
                }
                .padding(.leading, 14.0)
                
//                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Change")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                    Divider().padding(.top, 4)
                } .padding(.leading, 14.0)
            }

            
            HStack {
                VStack(alignment: .leading) {
                    Text("Total")
                        .font(.headline)
                    Divider().padding(.top, 4)
                } .padding(.leading, 2.0)
                
//                Spacer()
                
                VStack(alignment: .leading) {
                    Text(String(format: "%.2f", totalMSPR))
                        .font(.subheadline)
                    Divider().padding(.top, 4)
                } .padding(.leading, 14.0)
                
//                Spacer()
                
                VStack(alignment: .leading) {
                    Text(String(format: "%.2f", totalChange))
                        .font(.subheadline)
                    Divider().padding(.top, 4)
                } .padding(.leading, 14.0)
            }
            .padding([.horizontal], 14.0)
            
            
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Postive")
                        .font(.headline)
                    Divider().padding(.top, 4)
                } .padding(.leading, 2.0)
//                Spacer()
                VStack(alignment: .leading) {
                    Text(String(format: "%.2f", positiveMSPR))
                        .font(.subheadline)
                    Divider().padding(.top, 4)
                } .padding(.leading, 14.0)
                   
//                Spacer()
                VStack(alignment: .leading) {
                    Text(String(format: "%.2f", positiveChange))
                        .font(.subheadline)
                    Divider().padding(.top, 4)
                } .padding(.leading, 14.0)

            }.padding([.horizontal], 14.0)
            
            

            HStack {
                
                VStack(alignment: .leading) {
                    Text("Negative")
                        .font(.headline)
                    Divider().padding(.top, 4)
                } .padding(.leading, 2.0)
                
//                Spacer()
                VStack(alignment: .leading) {
                    Text(String(format: "%.2f", negativeMSPR))
                        .font(.subheadline)
                    Divider().padding(.top, 4)
                    //                    .multilineTextAlignment(.leading)
                    //                    .lineLimit(0)
                } .padding(.leading, 14.0)
                
//                Spacer()
                VStack(alignment: .leading) {
                    Text(String(format: "%.2f", negativeChange))
                        .font(.subheadline)
                        
                        
                    Divider().padding(.top, 4)
                } .padding(.leading, 14.0)

            }
            .padding([.horizontal], 14.0)
//            }
//            .padding()
        }
        .padding(.bottom, 30.0)
//        .onReceive(insiderSentiment.$insiderSentiments) { _ in
//                   updateValues()
//               }
//               .onAppear {
//                   updateValues()
//               }
        Spacer()
           }

//           private func updateValues() {
//
//               totalMSPR = 0
//               totalChange = 0
//               positiveMSPR = 0
//               positiveChange = 0
//               negativeMSPR = 0
//               negativeChange = 0
//
//
//               for element in insiderSentiment.insiderSentiments {
//                   totalMSPR += element.mspr
//                   totalChange += Double(element.change)
//                   if element.mspr > 0 {
//                       positiveMSPR += element.mspr
//                   } else {
//                       negativeMSPR += element.mspr
//                   }
//                   if element.change > 0 {
//                       positiveChange += Double(element.change)
//                   } else {
//                       negativeChange += Double(element.change)
//                   }
//               }
//           }
    
//        .onAppear {
//            // Calculate totals, positive, and negative values
//            for element in insiderSentiment.insiderSentiments{
//                totalMSPR += element.mspr
//                totalChange += Double(element.change)
//                if element.mspr > 0 {
//                    positiveMSPR += element.mspr
//                } else {
//                    negativeMSPR += element.mspr
//                }
//                if element.change > 0 {
//                    positiveChange += Double(element.change)
//                } else {
//                    negativeChange += Double(element.change)
//                }
//            }
//        }
    
}

struct IndsiderSentimentView_Previews: PreviewProvider {
    static var previews: some View {
        IndsiderSentimentView(symbol: "AAPL")
    }
}

