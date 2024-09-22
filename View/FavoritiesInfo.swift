//
//  Favorities.swift
//  stockapp
//
//  Created by Param Desai on 05/04/24.
//

import SwiftUI

struct FavoritiesInfo: View {
    var stockName : String
    var companyName : String
    var price : Double
    var change : Double
    var changePercentage :Double
    var body: some View {
        VStack{
            HStack{
                Text("\(stockName)")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                 Text(String(format: "$%.2f",price))
            }
            HStack{
                Text("\(companyName)")
                Spacer()
                Image(systemName: change >= 0 ? "arrow.up.right" : "arrow.down.right")
                    .foregroundColor(change >= 0 ? Color.green : Color.red)
                Text(String(format: "$%.2f (%.2f%%)", change, changePercentage))
                    .foregroundColor(change >= 0 ? Color.green : Color.red)
            }
        }
    }
    
}

//#Preview {
//    FavoritiesInfo(stockName: "AAPL",companyName: "AAPL Inc",price: 172.60,change:0.09,changePercentage: 0.02)
//}
