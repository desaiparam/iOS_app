import SwiftUI

struct TradeSheet: View {
    @Environment(\.presentationMode) var presentationMode
    var companyName: String
    var stockName:String
    @ObservedObject var quoteData: QuoteDataWithTickerList
    @ObservedObject var wallet:WalletList
    @ObservedObject var singlePortfolio: SinglePortfolioList
    @ObservedObject var portfolio: PortfolioList
    
    
//    @ObservedObject var quoteData: QuoteDataWithTickerList
//    @ObservedObject var wallet:WalletList
//    @ObservedObject var singlePortfolio: SinglePortfolioList
//    @ObservedObject var portfolio: PortfolioList
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
    @State private var numberOfShares: String = ""
    @State private var showToast = false
    @State private var toastText = ""
    
    @State private var isSheetPresentedCongrtatulation = false
    @State private var isSheetPresentedCongrtatulationSold = false
//    @State private var upadtedWallet:Double=0.0
  
    
    var body: some View {
       
        VStack(alignment: .leading){
            HStack {
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "multiply")
                        .foregroundColor(Color.black)
            }
//                .padding(.horizontal,30)
            }
               
                HStack{
                    Spacer()
                    Text("Trade \(companyName) shares")
                        .multilineTextAlignment(.center)
                    //                    .padding(.leading, 40.0)
                  
//                        .padding(.top, 50.0)
                    Spacer()
                    
                    
                }
                //            .padding(.bottom, 260.0)
                
                Spacer()
                //            Text("\(calculateWalletBought())")
               
            HStack {
                TextField("0", text: $numberOfShares)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.system(size: 120, weight: .regular))
                    .keyboardType(.numberPad)
                    .keyboardType(.decimalPad)
                //                    .font(.system(size: 20))
                //                    .padding(.vertical, 10)
                VStack{
                    if numberOfShares.isEmpty || (Double(numberOfShares) ?? 0) <= 1 {
                        Text("Share")
                            .font(.system(size: 60))
                        //                            .padding(.trailing, 14.0)
                        
                        //                        Text("$\(quoteData.quoteDataWithTicker?.c ?? 0.0, specifier: "%.2f")/share = $\(calculateTotal(), specifier: "%.2f")")
                        
                    } else {
                        Text("Shares")
                            .font(.system(size: 60))
                        //                            .padding(.trailing, 14.0)
                        
                        //                        Text("$\(quoteData.quoteDataWithTicker?.c ?? 0.0, specifier: "%.2f")/shares = $\(calculateTotal(), specifier: "%.2f")")
                    }
                }
            }
                
                HStack{
                    Spacer()
                    if numberOfShares.isEmpty || (Double(numberOfShares) ?? 0) <= 1 {
                        Text("x $\(quoteData.quoteDataWithTicker?.c ?? 0.0, specifier: "%.2f")/share = $\(calculateTotal(), specifier: "%.2f")")
                            .multilineTextAlignment(.trailing)
//                            .padding(.trailing, 14.0)
                    }else{
                        Text("x $\(quoteData.quoteDataWithTicker?.c ?? 0.0, specifier: "%.2f")/shares = $\(calculateTotal(), specifier: "%.2f")")
                            .multilineTextAlignment(.trailing)
//                            .padding(.trailing, 14.0)
                    }
                }
            
                //            .padding()
                
                Spacer()
                
                // Total Price Display
                HStack {
                    Spacer()
                    Text("$\(String(format: "%.2f", wallet.wallet)) available to buy \(stockName)")
                        .font(.subheadline)
                        .fontWeight(.light)
                        .foregroundColor(Color.gray)
                    
                    
                    Spacer()
                }
                
                ZStack {
                    HStack{
                        Button(action: {
                            print("Trade button tapped")
                            if numberOfShares.contains("a")  {
                                self.toastText = "Please enter a valid amount"
                                self.showToast = true
                                
                            }
                            else if numberOfShares.isEmpty || (Double(numberOfShares) ?? 0) <= 0 {
                                self.toastText = "Please enter a valid amount"
                                self.showToast = true
                            }
                            else if calculateTotal() > wallet.wallet {
                                self.toastText = "Not enough money to buy"
                                self.showToast = true
                            }
                            else{
                                singlePortfolio.addPortfolio(ticker: stockName, company: companyName, quantity: numberOfShares, price:String(calculateTotal()))
                                wallet.addWallet(wallet: calculateTotal())
//                                presentationMode.wrappedValue.dismiss()
                                self.isSheetPresentedCongrtatulation.toggle()
                            }
                        }) {
                            Text("Buy")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 30).fill(Color.green))
                                .padding(.horizontal)
                        }
                        .sheet(isPresented: $isSheetPresentedCongrtatulation) {
                            CongratulationsSheetBought(presentationMode:presentationMode,share: numberOfShares, stockName: stockName)
                        }
                        //                .sheet(isPresented: $isSheetPresented) {
                        //                    TradeSheet(companyName: companyProfile.companyProfile?.name ?? ":",stockName:stockName,quoteData:quoteData,wallet:wallet)
                        //                }
                        Button(action: {
                            print("Trade button tapped")
                            if numberOfShares.contains("o") {
                                self.toastText = "Please enter a valid amount"
                                self.showToast = true
                            }
                            else if numberOfShares.isEmpty || (Double(numberOfShares) ?? 0) <= 0 {
                                self.toastText = "Please enter a valid amount"
                                self.showToast = true
                            }
                            else if let numberOfShares = Int(numberOfShares), numberOfShares > singlePortfolio.singlePortfolio?.Quantity ?? 0{
                                self.toastText = "Not enough shares to sell"
                                self.showToast = true
                            }
                            else{
                                singlePortfolio.deleteProtfolio(ticker: stockName, company: companyName, quantity: numberOfShares, price:String(calculateTotal()))
                                wallet.deleteWallet(wallet: calculateTotal())
                                //                            presentationMode.wrappedValue.dismiss()
                                self.isSheetPresentedCongrtatulationSold.toggle()
                            }
                        }) {
                            Text("Sell")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 30).fill(Color.green))
                                .padding(.horizontal)
                        }.sheet(isPresented:$isSheetPresentedCongrtatulationSold , onDismiss: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=On Dismiss@*/{ }/*@END_MENU_TOKEN@*/, content: {
                            CongratulationsSheetSold(quoteData:quoteData,wallet:wallet,singlePortfolio:singlePortfolio,portfolio:portfolio,companyProfile: companyProfile,localNews: localNews, peersData: peersData, favorities: favorities,insiderSentiment:insiderSentiment,quoteDatalist:quoteDatalist,autocompleteList:autocompleteList,tickerManager:tickerManager,presentationMode:presentationMode,share: numberOfShares, stockName: stockName)
                        })
                        //                .sheet(isPresented: $isSheetPresented) {
                        //                    TradeSheet(companyName: companyProfile.companyProfile?.name ?? ":",stockName:stockName,quoteData:quoteData,wallet:wallet)
                        
                    }
                }
                
                
                //            .overlay(
                //                ToastView(isShowing: $showToast, text: toastText)
                //                //                        .animation(.easeInOut)
                //            )
                //            Spacer()
            }   .padding()
            .toast(isPresented: self.$showToast) {
                Text("\(toastText)")
            }
//            .overlay(
//                                ToastView(isShowing: $showToast, text: toastText)
//                                //                        .animation(.easeInOut)
//                            )
//            .toast(isShowing: $showToast, text: Text("Hello toast!"))
            
       
        
    }
    // Function to calculate total price
    func calculateTotal() -> Double {
        guard let shares = Double(numberOfShares) else { return 0.0 }
        return shares * (quoteData.quoteDataWithTicker?.c ?? 0.0)
    }
//    func calculateWalletBought() -> Double{
//        return wallet.wallet-calculateTotal()
//    }
}

//class QuoteDataWithTickerList: ObservableObject {
//    @Published var sharePrice: Double = 172.57
//}


//struct TradeSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        TradeSheet(
//            companyName: "AAPL",
//            stockName: "AAPL",
//            quoteData: QuoteDataWithTickerList(),
//            wallet: WalletList(),
//            singlePortfolio: SinglePortfolioList(),
//            portfolio: PortfolioList()
//        )
//    }
//}
