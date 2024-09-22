//
//  CongratulationsSheetSold.swift
//  NewFinalStockApp
//
//  Created by Param Desai on 30/04/24.
//

import SwiftUI

struct CongratulationsSheetSold: View {
    @ObservedObject var quoteData: QuoteDataWithTickerList
    @ObservedObject var wallet:WalletList
    @ObservedObject var singlePortfolio: SinglePortfolioList
    @ObservedObject var portfolio: PortfolioList
    @ObservedObject var companyProfile: CompanyProfileList
//    @ObservedObject var singlePortfolio: SinglePortfolioList
//    @ObservedObject var quoteData: QuoteDataWithTickerList
    @ObservedObject var localNews: LocalNewsList
    @ObservedObject var peersData: PeerDataList
    @ObservedObject var favorities: FavoritiesList
    @ObservedObject var insiderSentiment:InsiderSentimentsList
//    @ObservedObject var wallet:WalletList
//    @ObservedObject var portfolio: PortfolioList
    @ObservedObject var quoteDatalist: QuoteDataList
    @ObservedObject var autocompleteList: AutocompleteList
    @ObservedObject var tickerManager = TickerManager()
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
                    Text("You have successfully sold \(share) share of \(stockName) ")
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(.all, 5.0)
                }else{
                    Text("You have successfully sold \(share) shares of \(stockName) ")
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(.all, 5.0)
                }
                Spacer()
                Button(action: {
                    $presentationMode.wrappedValue.dismiss()
//                    NavigationLink(destination: SearchBar(wallet: wallet, portfolio: portfolio, quoteData: quoteDatalist, favorities: favorities,companyProfileData:companyProfile,singlePortfolio:singlePortfolio,quoteDataSingle:quoteData,localNews:localNews,peersData:peersData,autocompleteList:autocompleteList,tickerManager:tickerManager,insiderSentiment:insiderSentiment))
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
//    CongratulationsSheetSold()
//}
