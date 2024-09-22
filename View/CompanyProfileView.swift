//
//  CompanyProfileView.swift
//  stockapp
//
//  Created by Param Desai on 13/04/24.
//

import SwiftUI
import Kingfisher

struct CompanyProfileView: View {
    var name :String
    var ticker :String
    var img:String
    var body: some View {
        VStack(spacing: 0){
            //            HStack{
            //                Text(String(ticker))
            //                    .font(.title)
            //                    .fontWeight(.bold)
            //                    .multilineTextAlignment(.center)
            //                    .padding([.top], 0.0)
            //                Spacer()
            //            } .padding([.leading], 14.0)
            HStack{
                Text(String(name))
                    .font(.subheadline)
                    .fontWeight(.thin)
                    .foregroundColor(Color.gray)
                Spacer()
                KFImage(URL(string: img))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } .padding([.leading, .trailing], 14.0)
            Spacer()
        }
    }
}

//#Preview {
//    CompanyProfileView(name: "AAPL", ticker: "AAPL INC")
//}
