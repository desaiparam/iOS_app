//
//  Portfolio.swift
//  stockapp
//
//  Created by Param Desai on 05/04/24.
//

import SwiftUI

struct WalletView: View {
    
    var netWorth:Double
    var cashBalance:Double
    var body: some View {
        VStack{
            HStack{
                VStack{
                    Text("Net Worth")
//                    ForEach(walletMoney.wallet) { post in
                        
                    Text(String(format: "%.2f", totalNetWorth())).fontWeight(.bold)
                            
                }
//                }
                
                
                
                Spacer()
                VStack{
                    Text("Cash Balance")
//                    ForEach(walletMoney.wallet) { post in
                        
                        Text(String(format: "%.2f",cashBalance)) .fontWeight(.bold)
//                    }
                }
                
                
                
            }
            
        }
    }
    func totalNetWorth() -> Double {
        return self.netWorth + self.cashBalance
    }

}

//#Preview {
//    WalletView()
//}
