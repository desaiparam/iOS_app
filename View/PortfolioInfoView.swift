//
//  PortfolioInfo.swift
//  stockapp
//
//  Created by Param Desai on 05/04/24.
//

import SwiftUI

struct PortfolioInfoView: View {
    
    var stockName : String
    var shares :Int
    var totalPrice : Double
    var change : Double
    var changePercentage :Double
    var avgCost: Double
    var current:Double
    
    //    var latestQuote: Double
    var priceChangeFromTotalCost: Double {
        let difference = (current - avgCost) * Double(shares)
        if difference < 0.001 || difference > -0.001 {
            return difference
        } else {
            
            return 0.0
        }
    }
    
    
    var totalCostOfStock: Double {
        return avgCost * Double(shares)
    }
    
    
    var priceChangeFromTotalCostPercentage: Double {
        if totalCostOfStock == 0.0 {
            return 0 
        }
        return (priceChangeFromTotalCost / totalCostOfStock) * 100
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("\(stockName)")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Text(String(format: "$%.2f", totalPrice))
            }
            HStack {
                Text("\(shares) shares")
                Spacer()
                Image(systemName: priceChangeFromTotalCostPercentage > 0.001 ? "arrow.up.right" : (priceChangeFromTotalCostPercentage < -0.001 ? "arrow.down.right" : "minus"))
                    .foregroundColor(priceChangeFromTotalCostPercentage > 0.001 ? .green : (priceChangeFromTotalCostPercentage < -0.001 ? .red : .black))
                Text(String(format: "$%.2f (%.2f%%)", priceChangeFromTotalCost, priceChangeFromTotalCostPercentage))
                    .foregroundColor(priceChangeFromTotalCostPercentage > 0.001 ? .green : (priceChangeFromTotalCostPercentage < -0.001 ? .red : .black))
            }
        }
    }
}

//#Preview {
//    PortfolioInfoView(stockName:"AAPL",shares:3,totalPrice:517,change:-0.09,changePercentage: 0.02)
//}
