//
//  SplashScreen.swift
//  stockapp
//
//  Created by Param Desai on 05/04/24.
//

import SwiftUI

struct SplashScreen: View {
    
    //    @StateObject private var pm = PortfolioListViewModal()
    //    @ObservedObject var wallet : WalletList
    //    @ObservedObject var portfolio : PortfolioList
    //    @ObservedObject var favorities : FavoritiesList
    //    @ObservedObject var quoteDataList : QuoteDataList
    //    //    @ObservedObject var globalData = GlobalData()
    //    @ObservedObject var wallet: WalletList
    //    @ObservedObject var globalData: GlobalData
    //
    @State var isActive = false
    //    //    init(){
    //    //        let globalData = GlobalData()
    //    //        self._wallet=ObservedObject(wrappedValue: WalletList(globalWallet: globalData))
    //    ////        self._portfolio = ObservedObject(wrappedValue: PortfolioList())
    //    ////        self._favorities = ObservedObject(wrappedValue: FavoritiesList())
    //    ////        self._quoteDataList=ObservedObject(wrappedValue: QuoteDataList())
    //    //        self.wallet.fetchData()
    //    ////        self.portfolio.fetchData()
    //    ////        self.favorities.fetchData()
    //    //
    //    //        //            self.quoteData.fetchData(ticker: <#T##String#>)
    //    //    }
    //    init() {
    //        let sharedGlobalData = GlobalData() // Create a shared instance
    //        self.globalData = sharedGlobalData
    //        self.wallet = WalletList(globalWallet: sharedGlobalData)
    //        self.portfolio=PortfolioList(globalPortfolio: sharedGlobalData)
    //        self.favorities=FavoritiesList(globalFavorities: sharedGlobalData)
    //        self.quoteDataList=QuoteDataList(globalQuoteData: sharedGlobalData)
    //        // Use the shared instance
    //        self.wallet.fetchData()
    //        self.portfolio.fetchData()
    //        self.favorities.fetchData()
    //    }
    //    @ObservedObject var walletData: WalletList
    //    @ObservedObject var portfolioData: PortfolioList
    //    @ObservedObject var quoteData: QuoteDataList
    //    @ObservedObject var favoritiesData: FavoritiesList
    //
    @StateObject var walletData = WalletList()
    @StateObject var portfolioData = PortfolioList()
    @StateObject var quoteData = QuoteDataList()
    @StateObject var favoritiesData = FavoritiesList()
    @StateObject var companyProfile = CompanyProfileList()
    @StateObject var singlePortfolio = SinglePortfolioList()
    @StateObject var quoteDataSingle=QuoteDataWithTickerList()
    @StateObject var localNews = LocalNewsList()
    @StateObject var peersData = PeerDataList()
    @StateObject var autocompleteList = AutocompleteList()
    @StateObject var tickerManager = TickerManager()
    @StateObject var insiderSentiment = InsiderSentimentsList()
    var body: some View {
        ZStack {
            
            if (isActive) {
                if favoritiesData.isDataLoaded{
                    ProgressView("Fetching Data...")
                }else{
                    SearchBar(wallet: walletData, portfolio: portfolioData, quoteData: quoteData, favorities: favoritiesData,companyProfileData:companyProfile,singlePortfolio:singlePortfolio,quoteDataSingle:quoteDataSingle,localNews:localNews,peersData:peersData,autocompleteList:autocompleteList,tickerManager:tickerManager,insiderSentiment:insiderSentiment)
//                    NavTry1()
                    //                                Trial()
                    //                WalletListView(walletMoney: self.wallet)
                    
                }
            } else {
                    
                    Image("SplashScreen")
                        .background(Color.gray)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                withAnimation {
                                    isActive = true
                                }
                            }
                        }
                    
                    
                }
            
            
        }.task {
            await walletData.fetchData()
            await portfolioData.fetchData()
            await favoritiesData.fetchData()
            //            ForEach(portfolioData.portfolio){item in
            //                await quoteData.fetchData(ticker: item.Title)
            //            }
        }
    }
}

//#Preview {
//    SplashScreen(portfolioData: portfolioData, quoteData:quoteData , favoritiesData: favoritiesData)
//}
