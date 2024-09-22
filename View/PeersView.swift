import SwiftUI

struct PeersView: View {
    @ObservedObject var companyProfile: CompanyProfileList
    @ObservedObject var singlePortfolio: SinglePortfolioList
    @ObservedObject var quoteData: QuoteDataWithTickerList
    @ObservedObject var localNews: LocalNewsList
    @ObservedObject var peersData: PeerDataList
    @ObservedObject var favorities: FavoritiesList
    @ObservedObject var insiderSentiment:InsiderSentimentsList
    @ObservedObject var wallet:WalletList
    @ObservedObject var portfolio: PortfolioList
    @ObservedObject var quoteDatalist: QuoteDataList
    @ObservedObject var autocompleteList: AutocompleteList
    @ObservedObject var tickerManager = TickerManager()

    
    var ipo: String
    var industry: String
    var webpage: String
    
    @State private var selectedPeer: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("About")
          
                .font(.system(size: 24))

                .padding(.top, 20)
                .padding(.horizontal, 14)
                HStack{
                    Text("IPO Start Date:")
                        .font(.headline)
                    
                    Text(ipo)
                        .multilineTextAlignment(.center)
                        .padding(.leading, 26.0)
                   
                    //                }
                }
                .padding([.leading], 14.0)
                
//                Spacer()
                
//                VStack(alignment: .leading) {
                HStack{
                    Text("Industry:")
                        .font(.headline)
                    
                    Text(industry)
                        .multilineTextAlignment(.center)
                        .padding(.leading, 74.0)

                    //                }
                } .padding([.leading], 14.0)
//                Spacer()
                
//                VStack(alignment: .leading) {
                HStack{
                    Text("Webpage:")
                        .font(.headline)
                    Link(webpage, destination: URL(string: webpage)!)
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.center)
                        .padding(.leading, 65.0)

                   
                }.padding([.leading], 14.0)
//                }
//            }
            
            HStack{
                Text("Company Peers:")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 14.0)
                ScrollView(.horizontal) {
                    HStack(alignment: .center, spacing: 10) {
                        ForEach(peersData.peers, id: \.self) { peer in
                            NavigationLink(destination: StockDetailsView(stockName: peer, companyProfile: companyProfile, singlePortfolio: singlePortfolio, quoteData: quoteData, localNews: localNews, peersData: peersData, favorities: favorities, insiderSentiment: insiderSentiment,wallet:wallet,portfolio:portfolio,quoteDatalist:quoteDatalist,autocompleteList:autocompleteList,tickerManager:tickerManager)) {
                                Text("\(peer) ,")
                                    .padding(.horizontal, 4)
                                    .foregroundColor(.blue)
                            }
                            
                            
                        }
                    }
                    .padding(.horizontal, 14)
                }
            }
        }
    }
}

//struct PeersView_Previews: PreviewProvider {
//    static var previews: some View {
//        PeersView(
//            companyProfile: CompanyProfileList(),
//            singlePortfolio: SinglePortfolioList(),
//            quoteData: QuoteDataWithTickerList(),
//            localNews: LocalNewsList(),
//            peersData: PeerDataList(),
//            favorities: FavoritiesList(),
//            insiderSentiment: InsiderSentimentsList(),
//            wallet: WalletList(),
//            portfolio: PortfolioList(),
//            ipo: "1999-01-22",
//            industry: "Semiconductors",
//            webpage: "https://www.nvidia.com/"
//        )
//    }
//}
