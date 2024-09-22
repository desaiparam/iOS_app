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
//                    self.companyProfile.append(post) // Append the retrieved CompanyProfile to the array
//                }
//                print("Received company profile:", post)
//
//            case .failure(let error):
//                print("Error fetching data:", error)
//            }
//        }
//    }
//}
@MainActor
class CompanyProfileList: ObservableObject {
    
  
    
    @Published var companyProfile: CompanyProfile?
//    @ObservedObject var quoteData = QuoteDataWithTickerList()
    
//    @Published var loader = false
    @Published var isCompanyLoading = true
    
    func fetchData(ticker: String) async {
//        print("Fetching data on main thread in cp: \(Thread.isMainThread)")
        isCompanyLoading = true
           let url = "https://backendproject4.wl.r.appspot.com/SearchData/\(ticker)"
           
           do {
               let request = AF.request(url)
               let data = try await request.serializingDecodable(CompanyProfile.self).value
               DispatchQueue.main.async {
//                   print("Updating UI on main thread in cp: \(Thread.isMainThread)")
//                   print("cp",data)
                   self.companyProfile = data
                   self.isCompanyLoading = false
               }
           } catch {
               DispatchQueue.main.async {
                   print("Error fetching company profile data: \(error)")
                   self.isCompanyLoading = false
               }
           }
    
    
//    func fetchData(ticker: String) async {
//        loader = true
//        do {
////            self.loader=true
//            let url = "https://backendproject4.wl.r.appspot.com/SearchData/\(ticker)"
//            let request = AF.request(url)
//            let data = try await request.serializingDecodable(CompanyProfile.self).value
//            DispatchQueue.main.async {
//                self.companyProfile = data
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
//
//        let url = "https://backendproject4.wl.r.appspot.com/SearchData/\(ticker)"
//            let request = AF.request(url)
//
//            do {
//                let data = try await request.serializingDecodable(CompanyProfile.self).value
//                DispatchQueue.main.async {
//                    self.companyProfile = data
////                    self.loader = false
//                }
////                try await self.quoteData.fetchData(ticker: ticker)
//            } catch {
//
//                print("Error fetching data: \(error)")
//            }
//
    }
}
struct CompanyProfile: Hashable, Codable {
//    let id :String?
//    let id: UUID
    let country: String?
    let currency: String?
    let estimateCurrency: String?
    let exchange: String?
    let finnhubIndustry: String?
    let ipo: String?
    let logo: String?
    let marketCapitalization: Float
    let name: String?
    let phone: String?
    let shareOutstanding: Double?
    let ticker: String?
    let weburl:String?
}
