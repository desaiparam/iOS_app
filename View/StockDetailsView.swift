//
//  StockDetails.swift
//  stockapp
//
//  Created by Param Desai on 08/04/24.
//

import SwiftUI

struct StockDetailsView: View {
    var stockName:String
    @ObservedObject var companyProfile:CompanyProfileList
    @ObservedObject var singlePortfolio: SinglePortfolioList
    @ObservedObject var quoteData : QuoteDataWithTickerList
    @ObservedObject var localNews:LocalNewsList
    @ObservedObject var peersData:PeerDataList
    @ObservedObject var favorities:FavoritiesList
    @ObservedObject var insiderSentiment:InsiderSentimentsList
    @ObservedObject var wallet:WalletList
    @ObservedObject var portfolio: PortfolioList
//    @ObservedObject var wallet: WalletList
//    @ObservedObject var portfolio: PortfolioList
    @ObservedObject var quoteDatalist: QuoteDataList
//    @ObservedObject var favorities: FavoritiesList
//    @ObservedObject var companyProfileData:CompanyProfileList
//    @ObservedObject var singlePortfolio:SinglePortfolioList
//    @ObservedObject var quoteDataSingle:QuoteDataWithTickerList
//    @ObservedObject var localNews:LocalNewsList
//    @ObservedObject var peersData:PeerDataList
    @ObservedObject var autocompleteList: AutocompleteList
    @ObservedObject var tickerManager = TickerManager()
//    @ObservedObject var insiderSentiment:InsiderSentimentsList
    
    //    @ObservedObject var globalData : GlobalData
    //    init(stockName: String, globalData: GlobalData) {
    //           self.stockName = stockName
    //           self.globalData = globalData
    //       }
    //
    //    @StateObject var isFavorited = FavoritiesList()
    //    @State private var totalMSPR: Double = 0
    //    @State private var totalChange: Double = 0
    //    @State private var positiveMSPR: Double = 0
    //    @State private var positiveChange: Double = 0
    //    @State private var negativeMSPR: Double = 0
    //    @State private var negativeChange: Double = 0
    //    @ObservedObject var totalMSPRs = totalMSPR
    @State private var isSheetPresented = false
    @State private var showToast = false
    @State private var toastText = ""
    
    var body: some View {
        
        //        VStack{
        //            HStack {
        //        ScrollView {
        NavigationStack{
            ScrollView {
                //                VStack{
                
                if quoteData.isQuoteLoading || companyProfile.isCompanyLoading ||
                    singlePortfolio.isSinglePortfolioLoading||peersData.isPeers||insiderSentiment.isinsiderSentiments||localNews.isLocalNews{
                    Spacer()
                    ProgressView("Fetching Data...")
                        .padding(.top, 300)
                    Spacer()
                    Spacer()
                    ProgressView("Fetching Data")
                        .padding(.top, 500)
                    Spacer()
                }
                else {
                    if let companyProfile = companyProfile.companyProfile {
                        CompanyProfileView(name: companyProfile.name ?? "N/A", ticker: companyProfile.ticker ?? "N/A",img:companyProfile.logo ?? "N/A")
                    }
                    if let quoteDataWithTicker = quoteData.quoteDataWithTicker {
                        QuoteDataView(price: quoteDataWithTicker.c, change: quoteDataWithTicker.d, changePercentage: quoteDataWithTicker.dp)
                    }
                    TabView {
                        HourlyCharts(data:stockName,color: quoteData.quoteDataWithTicker?.d ?? 0.0)
                            .tabItem {
                                Label("Hourly", systemImage: "chart.xyaxis.line")
                               
                            }.padding(.bottom, 30)
                        
                        MainCharts(data:stockName)
                            .tabItem {
                                Label("Historical",systemImage: "clock.fill")
                            }.padding(.bottom, 30)
                    }
                    .frame(minHeight: 475)
                    VStack(alignment: .leading) {
                        Text("Portfolio")
                            .font(.system(size: 24))
                            .padding(.top, 20)
                            .padding(.bottom, 10)
                        HStack{
                            VStack(alignment: .leading) {
                                if let singlePortfolio = singlePortfolio.singlePortfolio {
                                    if let quoteDataWithTicker = quoteData.quoteDataWithTicker {
                                        SinglePortfolioView(shares: singlePortfolio.Quantity!, totalPrice: singlePortfolio.Price!, change: quoteDataWithTicker.d, changePercentage: quoteDataWithTicker.dp,currentPrice:quoteDataWithTicker.c,
                                                            marketValue:Double(singlePortfolio.Quantity!)*quoteDataWithTicker.c)
                                        
                                    }
                                } else {
                                    //                            VStack(alignment: .leading) {
                                    //                                Text("Portfolio")
                                    //                                    .font(.system(size: 24))
                                    //                                    .padding(.top, 20)
                                    //                                    .padding(.bottom, 10)
                                    Text("You have 0 shares of \(stockName)")
                                        .fontWeight(.light)
                                    Text("Start trading!")
                                        .fontWeight(.light)
                                }
                                //                            .padding(.leading)
                                //                            Spacer()
                            }
                            Spacer()
                            
                            VStack {
//                                Spacer()
                                Button(action: {
                                    print("Trade button tapped")
                                    self.isSheetPresented.toggle()
                                }) {
                                    Text("Trade")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .frame(width: 90, height: 25)
                                        .padding()
                                        .background(RoundedRectangle(cornerRadius: 30).fill(Color.green))
                                    //                                    .padding(.horizontal, 10)
                                }
                                .sheet(isPresented: $isSheetPresented) {
                                    TradeSheet(companyName: companyProfile.companyProfile?.name ?? ":",stockName:stockName,quoteData:quoteData,wallet:wallet,singlePortfolio:singlePortfolio,portfolio:portfolio,companyProfile: companyProfile,localNews: localNews, peersData: peersData, favorities: favorities,insiderSentiment:insiderSentiment)
                                    
                                }
                                Spacer()
                            }
                            Spacer()
                        }
                        Spacer()
                    }.padding(.leading)
                    if let quoteDataWithTicker = quoteData.quoteDataWithTicker {
                        StatsView(highPrice: quoteDataWithTicker.h , lowPrice: quoteDataWithTicker.l, openPrice:  quoteDataWithTicker.o, prevClose:  quoteDataWithTicker.pc)
                    }
                    if !peersData.isPeers{
                        PeersView(companyProfile: companyProfile, singlePortfolio: singlePortfolio, quoteData: quoteData, localNews: localNews, peersData: peersData, favorities: favorities,insiderSentiment:insiderSentiment,wallet:wallet,portfolio:portfolio,quoteDatalist:quoteDatalist,autocompleteList:autocompleteList,tickerManager:tickerManager, ipo:companyProfile.companyProfile?.ipo ?? "N/A", industry: companyProfile.companyProfile?.finnhubIndustry ?? "N/A", webpage: companyProfile.companyProfile?.weburl ?? "N/A")
                    }
                }
                if !insiderSentiment.isinsiderSentiments{
                    IndsiderSentimentView(totalMSPR:insiderSentiment.totalMSPR,totalChange:insiderSentiment.totalChange,positiveMSPR:insiderSentiment.positiveMSPR,positiveChange:insiderSentiment.positiveChange,negativeMSPR:insiderSentiment.negativeMSPR,negativeChange:insiderSentiment.negativeChange,symbol:companyProfile.companyProfile?.name ?? "N/A" )
                    //                        .onReceive(insiderSentiment.$insiderSentiments) { _ in
                    //                                       updateValues()
                    //                                   }
                    //                        .onAppear{
                    //                            Task{
                    //                                await insiderSentiment.fetchData(ticker: stockName)
                    //                            }
                    //
                    //                        }
                }
                
                //                if !localNews.isLocalNews {
                //                if quoteData.isQuoteLoading || companyProfile.isCompanyLoading ||
                //                    singlePortfolio.isSinglePortfolioLoading||peersData.isPeers||insiderSentiment.isinsiderSentiments||localNews.isLocalNews{
                
                RecommendationTrends(data:stockName).frame(minHeight:423)
                //                }
                //                }
                CompanyEarnings(data:stockName).frame(minHeight:300)
            
                
                if !localNews.isLocalNews {
                    LocalNewsView(localNews: localNews)
                }
                
                
                
            }
            .onAppear {
                favorities.isFavorited.isStarred = false
                Task {
                    let isStarred = await favorities.checkIsStarred(ticker: stockName)
                    favorities.isFavorited.isStarred = isStarred
                }
            }
            .task {
                await companyProfile.fetchData(ticker: stockName)
                await quoteData.fetchData(ticker: stockName)
                await singlePortfolio.fetchData(ticker: stockName)
                await localNews.fetchData(ticker: stockName)
                await peersData.fetchData(ticker: stockName)
                await insiderSentiment.fetchData(ticker: stockName)
                
                
                
            }
        }.toast(isPresented: self.$showToast) {
            Text("Adding \(stockName) to Favorites")
        }
        //        .overlay(
        //            ToastView(isShowing: $showToast, text: toastText)
        //            //                        .animation(.easeInOut)
        //        )
        .navigationTitle(!quoteData.isQuoteLoading && !companyProfile.isCompanyLoading &&
                         !singlePortfolio.isSinglePortfolioLoading && !peersData.isPeers &&
                         !insiderSentiment.isinsiderSentiments && !localNews.isLocalNews ?
                         (stockName) : "")
        .toolbar {
            if !quoteData.isQuoteLoading && !companyProfile.isCompanyLoading &&
                !singlePortfolio.isSinglePortfolioLoading && !peersData.isPeers &&
                !insiderSentiment.isinsiderSentiments && !localNews.isLocalNews{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Assuming `addFavoritesIfNeeded` function exists in your FavoritiesList class
                        if !favorities.isFavorited.isStarred {
                            favorities.addFavorities(ticker: stockName, company: companyProfile.companyProfile?.name ?? "N/A")
                            // Properly toggle the Boolean property within the StarResponse
                            
                            favorities.isFavorited.isStarred.toggle()
                            //                                                        self.toastText = "Adding \(stockName) to Favorites"
                            self.showToast = true
                        } else {
                            favorities.deleteFavorities(ticker: stockName)
                        }
                    }) {
                        
                        Image(systemName: favorities.isFavorited.isStarred ? "plus.circle.fill" : "plus.circle")
                    }
                }
            }
        }
    }
    //    private func updateValues() {
    //        // Reset values
    //        totalMSPR = 0
    //        totalChange = 0
    //        positiveMSPR = 0
    //        positiveChange = 0
    //        negativeMSPR = 0
    //        negativeChange = 0
    //
    //        // Calculate totals, positive, and negative values
    //        for element in insiderSentiment.insiderSentiments {
    //            totalMSPR += element.mspr
    //            totalChange += Double(element.change)
    //            if element.mspr > 0 {
    //                positiveMSPR += element.mspr
    //            } else {
    //                negativeMSPR += element.mspr
    //            }
    //            if element.change > 0 {
    //                positiveChange += Double(element.change)
    //            } else {
    //                negativeChange += Double(element.change)
    //            }
    //        }
    //    }
}


//}


//
//#Preview {
//    StockDetailsView(stockName:"AAPL")
//}

//        LOCAL NEWS PRINTING
//            ForEach(localNews.localNews){newsItems in
//                Text(newsItems.headline ?? "N/A")
//            }
//                    List(localNews.localNews) { newsItem in
//                        if let imageURL = URL(string: newsItem.image ?? "") {
//                                               AsyncImage(url: imageURL) { image in
//                                                   image
//                                                       .resizable()
//                                                       .scaledToFill()
//                                                       .frame(height: 200)
//                                                       .clipped()
//                                               } placeholder: {
//                                                   ProgressView() // Display a progress view while the image is loading
//                                                       .frame(height: 200)
//                                               }
//                                           } else {
//                                               Text("No image")// Display a placeholder image if the URL is nil
//            //
//                                           }
//                                           Text(newsItem.headline ?? "No headline")
//                                               .font(.headline)
//                    }


//        PEERS DATA PRINTING
//        ScrollView(.horizontal) {
//            HStack(alignment: .center, spacing: 10) {
//                Text("Company Peers:")
//                    .font(.headline)
//
//                ForEach(peersData.peers, id: \.self) { peer in
//                    Text(peer)
//                        .padding(.horizontal, 4)
////                        .background(Color.blue)
////                        .foregroundColor(.white)
////                        .cornerRadius(5)
//                }
//            }
//        }
//                ScrollView(.horizontal) {
//                    HStack(alignment: .center, spacing: 10) {
//                        Text("Company Peers:")
//                            .font(.headline)
//
//                        ForEach(peersData.peers, id: \.self) { peer in
//                            Text(peer)
//                                .padding(.horizontal, 4)
//                            //                        .background(Color.blue)
//                            //                        .foregroundColor(.white)
//                            //                        .cornerRadius(5)
//                        }
//                    }
//                }
//
//                if let singlePortfolio = singlePortfolio.singlePortfolio {
//                    if let quoteDataWithTicker = quoteData.quoteDataWithTicker {
//                        SinglePortfolioView(shares: singlePortfolio.Quantity!, totalPrice: singlePortfolio.Price!, change: quoteDataWithTicker.d, changePercentage: quoteDataWithTicker.dp,currentPrice:quoteDataWithTicker.c)
//                        //                    Text(String((singlePortfolio.Quantity)!))
//                        //                    Text(String((singlePortfolio.Price)!))
//                    }
//                } else {
//                    Text("No data")
//                }
//                if let singlePortfolio = singlePortfolio.singlePortfolio {
//                    if let quoteDataWithTicker = quoteData.quoteDataWithTicker {
//                        SinglePortfolioView(shares: singlePortfolio.Quantity!, totalPrice: singlePortfolio.Price!, change: quoteDataWithTicker.d, changePercentage: quoteDataWithTicker.dp,currentPrice:quoteDataWithTicker.c)
//                        //                    Text(String((singlePortfolio.Quantity)!))
//                        //                    Text(String((singlePortfolio.Price)!))
//                    }
//                } else {
//                    Text("No data")
//                }

//                List(localNews.localNews) { newsItem in
//                                       if let imageURL = URL(string: newsItem.image ?? "") {
//                                                              AsyncImage(url: imageURL) { image in
//                                                                  image
//                                                                      .resizable()
//                                                                      .scaledToFill()
//                                                                      .frame(height: 200)
//                                                                      .clipped()
//                                                              } placeholder: {
//                                                                  ProgressView() /
//                                                                      .frame(height: 200)
//                                                              }
//                                                          } else {
//                                                              Text("No image")
//                           
//                                                          }
//                                                          Text(newsItem.headline ?? "No headline")
//                                                              .font(.headline)
//                                   }
////
//
//struct StockDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        // Initialize any necessary observed objects or other dependencies
//        // For example:
//        let companyProfile = CompanyProfileList()
//        let singlePortfolio = SinglePortfolioList()
//        let quoteData = QuoteDataWithTickerList()
//        let localNews = LocalNewsList()
//        let peersData = PeerDataList()
//        let favorities = FavoritiesList()
//        let insiderSentiment = InsiderSentimentsList()
//        let wallet = WalletList()
//        let portfolio = PortfolioList()
//        
//        // Use those initialized objects as parameters for StockDetailsView
//        StockDetailsView(stockName: "NVDA",
//                         companyProfile: companyProfile,
//                         singlePortfolio: singlePortfolio,
//                         quoteData: quoteData,
//                         localNews: localNews,
//                         peersData: peersData,
//                         favorities: favorities,
//                         insiderSentiment: insiderSentiment,
//                         wallet: wallet,
//                         portfolio: portfolio)
//    }
//}
