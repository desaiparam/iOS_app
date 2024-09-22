//
//  CongratulationsSheet.swift
//  NewFinalStockApp
//
//  Created by Param Desai on 30/04/24.
//

import SwiftUI

struct CongratulationsSheetBought: View {
    @Binding var presentationMode:PresentationMode
    var share:String
    var stockName:String
    
    var body: some View {
        ZStack {
            Color.green.edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Text("Congratulations!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                if let shares = Double(share), shares==1{
                    Text("You have successfully bought \(share) share of \(stockName) ")
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(.all, 5.0)
                }else{
                    Text("You have successfully bought \(share) shares of \(stockName) ")
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(.all, 5.0)
                }
                Spacer()
                Button(action: {
                    $presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Done")
                        .font(.headline)
                        .foregroundColor(.green)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 30).fill(Color.white))
                        .padding(.horizontal)
                }
            }
        }
    }
}

//#Preview {
//    CongratulationsSheetBought(share:"3", stockName: "AAPL")
//}
