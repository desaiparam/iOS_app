//
//  Wallet.swift
//  stockapp
//
//  Created by Param Desai on 05/04/24.
//

import Foundation
import Alamofire
import SwiftUI


//class CompanyProfileList: ObservableObject {
//    @Published var companyProfile: [CompanyProfile] = []
//
//    func fetchData(ticker: String) async {
//        AF.request("https://backendproject4.wl.r.appspot.com/SearchData/\(ticker)").responseDecodable(of: CompanyProfile.self) { response in
//            switch response.result {
//            case .success(let post):
//                DispatchQueue.main.async {
//                    self.companyProfile.append(post) }
//                print("Received company profile:", post)
//
//            case .failure(let error):
//                print("Error fetching data:", error)
//            }
//        }
//    }
//}
@MainActor
class QuoteDataWithTickerList: ObservableObject {
    @Published var quoteDataWithTicker: QuoteDataWithTicker?
    
    @Published var isQuoteLoading = true
//   @ObservedObject var hourlyChartsList = HourlyChartsList()

    func fetchData(ticker: String) async {
//        print("Fetching data on main thread in qd: \(Thread.isMainThread)")
        isQuoteLoading = true
           let url = "https://backendproject4.wl.r.appspot.com/quote/\(ticker)"
           
        do {
               let request = AF.request(url)
               let data = try await request.serializingDecodable(QuoteDataWithTicker.self).value
               DispatchQueue.main.async {
                   self.quoteDataWithTicker = data
                   self.isQuoteLoading = false
                   
                   
//                       Task {
//                           await self.hourlyChartsList.fetchData(ticker: ticker, chartsDate: date)
//                       }
//                   } else {
//                       print("Date is nil, cannot fetch hourly charts")
//                   }
               }
            
           } catch {
               DispatchQueue.main.async {
                   print("Error fetching quote data: \(error)")
                   self.isQuoteLoading = false
               }
           }
        
//    @Published var loader = false
//    func fetchData(ticker: String) async {
//        loader = true
//        do {
////            self.loader=true
//            let url = "https://backendproject4.wl.r.appspot.com/quote/\(ticker)"
//            let request = AF.request(url)
//            let data = try await request.serializingDecodable(QuoteDataWithTicker.self).value
//            DispatchQueue.main.async {
//                self.quoteDataWithTicker=data
////                self.companyProfile = data
////                let quoteViewModel = QuoteDataList(globalQuoteData:  self.globalFavorities)
////quoteViewModel.fetchData(ticker: w.Title)
////                await self.quoteData.fetchData(ticker: ticker)
//                self.loader=false
//               
//            }
//           
//        } catch {
//            print("Error fetching data: \(error)")
//        }
//    @Published var loader = true
//    func fetchData(ticker: String) async throws {
//        do {
////            self.loader=true
//            let url = "https://backendproject4.wl.r.appspot.com/quote/\(ticker)"
//            let request = AF.request(url)
//            let data = try await request.serializingDecodable(QuoteDataWithTicker.self).value
//            DispatchQueue.main.async {
//                self.quoteDataWithTicker = data
//                print(self.quoteDataWithTicker!)
////                self.loader=false
//            }
//        } catch {
//            print("Error fetching data: \(error)")
//        }
    }
}
struct QuoteDataWithTicker:  Codable,Hashable {
    
    let c: Double
    let d: Double
    let dp:Double
    let h:Double
    let l:Double
    let o:Double
    let pc:Double
    let t: Int64
}
