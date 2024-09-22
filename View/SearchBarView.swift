//
//  SearchBar.swift
//  stockapp
//
//  Created by Param Desai on 03/04/24.
//

import SwiftUI

struct SearchBar: View {
    //    @ObservedObject var wallet : WalletList
    
    //    @ObservedObject var favorities = FavoritiesList()
    //    @ObservedObject var quoteDataList = QuoteDataList()
    //    @ObservedObject var globalData : GlobalData
    //
    //    init(globalData:GlobalData,portfolio: PortfolioList,favorities:FavoritiesList,quoteDataList:QuoteDataList) {
    //        self.globalData=globalData
    ////        self.wallet = wallet
    ////        self.portfolio = portfolio
    //        self.favorities=favorities
    //        self.quoteDataList=quoteDataList
    //
    ////        print(quoteDataList.fetchData(ticker: "AAPL"))
    //    }
    //    @ObservedObject var globalData : GlobalData
    //    init(globalData: GlobalData) {
    //        self.globalData = globalData
    //    }
    @ObservedObject var wallet: WalletList
    @ObservedObject var portfolio: PortfolioList
    @ObservedObject var quoteData: QuoteDataList
    @ObservedObject var favorities: FavoritiesList
    @ObservedObject var companyProfileData:CompanyProfileList
    @ObservedObject var singlePortfolio:SinglePortfolioList
    @ObservedObject var quoteDataSingle:QuoteDataWithTickerList
    @ObservedObject var localNews:LocalNewsList
    @ObservedObject var peersData:PeerDataList
    @ObservedObject var autocompleteList: AutocompleteList
    @ObservedObject var tickerManager = TickerManager()
    @ObservedObject var insiderSentiment:InsiderSentimentsList
    
    @State var currentDate = Date()
    @State var editButtonClicked = false
    @State private var showAutocompleteResults = false
    @State private var debouncer = Debouncer(delay: 0.5)
    @State private var marketValue: Double = 0.0
    @State var isActive : Bool = false
    //    var portfolio = [(stockName: "AAPL",shares:3,totalPrice:517,change:-0.09,changePercentage: 0.02),(stockName: "NVDA",shares:4,totalPrice:517,change:0.09,changePercentage: 0.02)]
    //    @State private  var favorites = [
    //        (stockName: "AAPL", companyName: "Apple Inc.", price: 172.60, change: 0.09, changePercentage: 0.02),(stockName: "NVDA", companyName: "NVDA Inc.", price: 172.60, change: -0.09, changePercentage: 0.02)
    //       
    //    ]
    var body: some View {
        //        VStack {
        
        NavigationStack{
            ZStack(alignment: .top) {
                VStack{
                    List{
                        Text("\(currentDate.formatted(Date.FormatStyle().month(.wide))) \(currentDate.formatted(Date.FormatStyle().day(.defaultDigits))), \(currentDate.formatted(Date.FormatStyle().year(.defaultDigits)))")
                            .font(.title)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.gray)
                                                    .padding(.all, 3.0)
                            
                            
                        Section("Portfolio") {
                            WalletView(netWorth: marketValue, cashBalance: wallet.wallet)
                            ForEach(portfolio.portfolio) { item in
                                if let quoteDatas = quoteData.qd[item.Title] {
                                    let itemMarketValue = (quoteDatas.c * Double(item.Quantity))
                                    NavigationLink(destination: StockDetailsView(stockName: item.Title,companyProfile:companyProfileData,singlePortfolio:singlePortfolio,quoteData:quoteDataSingle,localNews:localNews,peersData:peersData,favorities:favorities,insiderSentiment:insiderSentiment,wallet:wallet,portfolio:portfolio,quoteDatalist:quoteData,autocompleteList:autocompleteList,tickerManager:tickerManager,rootIsActive: self.$isActive),isActive: self.$isActive) {
                                        PortfolioInfoView(
                                            stockName: item.Title,
                                            shares: item.Quantity,
                                            totalPrice:Double(item.Quantity)*quoteDatas.c,
                                            change: quoteDatas.d,
                                            changePercentage: quoteDatas.dp,
                                            avgCost: (item.Price ?? 0) / Double(item.Quantity),
                                            current: quoteDatas.c
//                                            avgCost:item.Price / item.Quantity
                                            
                                        )
                                        
                                    }.onAppear {
                                        self.marketValue += itemMarketValue
                                    }
                                }else{
                                    Text("\(item.Title) - Data loading...")
                                        .task {
                                            quoteData.fetchData(ticker: item.Title)
                                            
                                        }
                                }
                            }
                            .onMove(perform: portfolio.move)
                        } .onAppear {
                           
                            favorities.isFavorited.isStarred = false
                                Task{
                                    await portfolio.fetchData()
                                    calculateInitialMarketValue()
                                }
                        }
                        
                        
                        Section("Favorities") {
                            //                            if editButtonClicked {
                            //                        List {
                            ForEach(favorities.favorities, id: \.self) { item in
                                if let quoteDatas = quoteData.qd[item.Title] {
                                    NavigationLink(destination:StockDetailsView(stockName: item.Title,companyProfile:companyProfileData,singlePortfolio:singlePortfolio,quoteData:quoteDataSingle,localNews:localNews,peersData:peersData,favorities:favorities,insiderSentiment:insiderSentiment,wallet:wallet,portfolio:portfolio,quoteDatalist:quoteData,autocompleteList:autocompleteList,tickerManager:tickerManager))
                                    {
                                        FavoritiesInfo(
                                            stockName: item.Title,
                                            companyName: item.Company,
                                            price: quoteDatas.c,
                                            change: quoteDatas.d,
                                            changePercentage: quoteDatas.dp
                                        )
                                    }
                                }else{
                                    Text("\(item.Title) - Data loading...")
                                        .task {
                                            quoteData.fetchData(ticker: item.Title)
                                            favorities.isFavorited.isStarred=false
                                        }
                                }
                                
                                
                            } .onMove(perform: favorities.move)
                                .onDelete { offsets in
                                    favorities.remove(atOffsets: offsets)
                                    
                                    //                            }
                                }
                        }.onAppear {
                            favorities.isFavorited.isStarred = false
                                Task{
                                    await portfolio.fetchData()
                                }
                        }
                        
                        HStack {
                            Spacer()
                            Link(destination: URL(string: "https://finnhub.io")!) {
                                Text("Powered By Finnhub.io")
                                    .font(.footnote)
                                    .fontWeight(.ultraLight)
                                    .foregroundColor(Color.gray)
                                    .multilineTextAlignment(.center)
                            }
                            Spacer()
                        }
                    }
                }
                
                if showAutocompleteResults && !tickerManager.ticker.isEmpty {
                    List {
//                        VStack(alignment: .leading) {
                            ForEach(autocompleteList.autocompleteList, id: \.symbol) { result in
                                NavigationLink(destination: StockDetailsView(stockName: result.displaySymbol ?? "N/A", companyProfile: companyProfileData, singlePortfolio: singlePortfolio, quoteData: quoteDataSingle, localNews: localNews, peersData: peersData, favorities: favorities,insiderSentiment:insiderSentiment,wallet:wallet,portfolio:portfolio,quoteDatalist:quoteData,autocompleteList:autocompleteList,tickerManager:tickerManager)) {
                                    VStack(alignment: .leading){
                                        Text(result.displaySymbol ?? ":")
//                                            .padding()
//                                            .frame(maxWidth: .infinity, alignment: .leading)
//                                            .background(Color.white)
                                        Text(result.description ?? ";")
                                    }
                                }
                            }
//                        }
//                        .frame(maxWidth: .infinity)
                    }.padding(.top,0.16)
                    .background(Color.white)
                    .border(Color.gray, width: 1)
                   
                }
            }
            .searchable(text: $tickerManager.ticker, placement: .navigationBarDrawer(displayMode: .always))
            .onChange(of: tickerManager.ticker) { newValue in
                if !newValue.isEmpty {
                    showAutocompleteResults = true
                    debouncer.debounce {
                        Task {
                            await autocompleteList.fetchData(ticker: newValue)
                        }
                    }
                } else {
                    showAutocompleteResults = false
                }
            }
            .navigationTitle("Stocks")
            .toolbar {
                EditButton()
            }
        }
    }
    private func calculateInitialMarketValue() {
           marketValue = 0.0
           for item in portfolio.portfolio {
               if let quoteDatas = quoteData.qd[item.Title] {
                   let itemValue =  (quoteDatas.c * Double(item.Quantity) )
                   marketValue += itemValue
               }
           }
       }
    
}

 

    
