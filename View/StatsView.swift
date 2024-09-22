//
//  StatsView.swift
//  NewFinalStockApp
//
//  Created by Param Desai on 28/04/24.
//

import SwiftUI

struct StatsView: View {
    var highPrice : Double
    var lowPrice  : Double
    var openPrice : Double
    var prevClose : Double
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0){
            HStack{
                Text("Stats")
                    .font(.system(size: 24))
//                    .padding(.top, 20)
//                    .padding(.bottom, 10)
                Spacer()
                
            }
            HStack{
                VStack{
                    HStack{
                        Text("High Price:")
                            .font(.headline)
                        Text(" $\(String(format: "%.2f", highPrice))")
                    }
                    HStack{
                        Text("Low Price:")
                            .font(.headline)
                        Text(" $\(String(format: "%.2f", lowPrice))")
                    }
                }
                Spacer()
                VStack{
                    HStack {
                        Text("Open Price:")
                            .font(.headline)
                        Text("$\(String(format: "%.2f", openPrice))")
                    }
                    HStack {
                        Text("Prev Close:")
                            .font(.headline)
                        Text(" $\(String(format: "%.2f", prevClose))")
                    }
                    
                    
                }
            }
//            .padding([.leading], 14.0)


            
//        .padding([.leading], 14.0)
//            .padding(.leading)
            
        }.padding()
    }
}
    
    #Preview {
        StatsView(highPrice: 0.0, lowPrice: 0.0, openPrice: 0.0, prevClose: 0.0)
    }
