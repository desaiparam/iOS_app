//
//  ToastView.swift
//  NewFinalStockApp
//
//  Created by Param Desai on 30/04/24.
//

import SwiftUI

struct ToastView: View {
    @Binding var isShowing: Bool
    var text: String

    var body: some View {
        if isShowing {
            ZStack(alignment: .bottom) {
                
//                VStack {
                    //                Spacer()
                    Text(text)
                        .padding(.horizontal, 60)
                        .padding(.vertical, 30)
                        .background(Color.gray)
                        .foregroundColor(Color.white)
                        .cornerRadius(30)
                    //                                .shadow(radius: 10)
                        .frame(maxWidth: .infinity, maxHeight: .infinity) 
                        .opacity(self.isShowing ? 1 : 0)
                        .transition(.slide)
                    //                Spacer()
                    //                                .animation(.easeOut(duration: 0.5))
//                }
            }
//                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.isShowing = false
                }
            }
        } else {
            EmptyView()
        }
    }
}
