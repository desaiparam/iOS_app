//
//  SinglePortfolioView.swift
//  finalnewstockapp
//
//  Created by Param Desai on 14/04/24.
//

import SwiftUI

struct SinglePortfolioView: View {
    var shares :Int
    var totalPrice : Double
    var change : Double
    var changePercentage :Double
    var currentPrice : Double
    var marketValue: Double 
    
//        String(format: "%.2f", marketValue)
//    }
//  
    var priceChangeFromTotalCost: Double {
        let difference = (currentPrice - (totalPrice / Double(shares))) * Double(shares)
//        if difference < 0.001 || difference > -0.001 {
            return difference
//        } else {
            
//            return 0.0
//        }
    }
    

    
    var avgCostPerShare :Double{
        totalPrice / Double(shares)
    }
    var body: some View {
//        VStack(alignment: .leading) {
//            Text("Portfolio")
//                .font(.system(size: 24))
//                .padding(.top, 20)
//                .padding(.bottom, 10)
        
        HStack {
            Text("Shares Owned :")
                .font(.headline)
            Text("\(shares)")
        }
        
//            if shares != 0 {
               
//                let formattedAvgCostPerShare = String(format: "%.2f", avgCostPerShare)
        HStack {
            Text("Avg Cost/Share:")
                .font(.headline)
            Text(" $\(String(format: "%.2f", avgCostPerShare))")
        }

//            }
       
        HStack {
            Text("Change:")
                .font(.headline)
            Text("$\(String(format: "%.2f", priceChangeFromTotalCost))")
                .foregroundColor(priceChangeFromTotalCost > 0.01 ? .green : (priceChangeFromTotalCost < -0.01 ? .red : .gray))
                
        }

        HStack {
            Text("Market Value:")
                .font(.headline)
            Text("$\(String(format: "%.2f", marketValue))")
                .foregroundColor(priceChangeFromTotalCost > 0.01 ? .green : (priceChangeFromTotalCost < -0.01 ? .red : .gray))
        }

//        }
//        .padding(.leading) 
//                
//                Spacer() 
    }
}
#Preview {
    SinglePortfolioView(shares: 21, totalPrice: 170.33, change:0.0, changePercentage: 0.01, currentPrice: 170.33, marketValue: 21)
}
