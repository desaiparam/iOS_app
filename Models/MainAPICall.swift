////
////  MainAPICall.swift
////  stockapp
////
////  Created by Param Desai on 09/04/24.
////
//
//import Foundation
//import Alamofire
//import SwiftUI
//
//class MainAPICall: ObservableObject{
//    @Published var isLoading = true
//
//       
//       // Dependencies
//       private var companyProfileList = CompanyProfileList()
//       private var quoteDataWithTickerList = QuoteDataWithTickerList()
//
//       var companyProfile: CompanyProfile? {
//           companyProfileList.companyProfile
//       }
//
//       var quoteDataWithTicker: QuoteDataWithTicker? {
//           quoteDataWithTickerList.quoteDataWithTicker
//       }
//
//       func fetchData(ticker: String) async {
////           isLoading = true
//           
//           async let companyProfileFetch: () = companyProfileList.fetchData(ticker: ticker)
//           async let quoteDataFetch: () = quoteDataWithTickerList.fetchData(ticker: ticker)
//
//           do {
//               // Await the results of the concurrent fetch operations
//               _ = try await companyProfileFetch
//               _ = try await quoteDataFetch
//           } catch {
//               // Handle errors here
//               DispatchQueue.main.async {
//                   self.isLoading = false
//               }
//               return
//           }
//
//           // If both fetch operations are successful, update isLoading on the main thread
//           DispatchQueue.main.async {
//               self.isLoading = false
//           }
//       }
//   
//}
//
