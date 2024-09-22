//
//  QuoteDataView.swift
//  stockapp
//
//  Created by Param Desai on 13/04/24.
//

import SwiftUI

struct QuoteDataView: View {
    var price : Double
    var change : Double
    var changePercentage :Double
    var body: some View {
        VStack{
            HStack{
                Text(String(format: "$%.2f", price))
                    .font(.title)
                    .fontWeight(.bold)
//                    .multilineTextAlignment(.center)
                    .multilineTextAlignment(.leading)
                   
                //            Spacer()
                Image(systemName: change >= 0 ? "arrow.up.right" : "arrow.down.right")
                    .foregroundColor(change >= 0 ? Color.green : Color.red)
                Text(String(format: "$%.2f (%.2f%%)", change, changePercentage))
                    .foregroundColor(change >= 0 ? Color.green : Color.red)
                Spacer()
            } .padding([.leading, .bottom], 14.0)
//            Spacer()
        }
       
    }
}
//
#Preview {
    QuoteDataView(price: 176.5, change: 1.51, changePercentage: 0.86)
}
