//
//  QuoteData.swift
//  stockapp
//
//  Created by Param Desai on 07/04/24.


import Foundation
import Alamofire
import SwiftUI

class QuoteDataList: ObservableObject {
//        @Published var quotesData: [String: QuoteData] = [:]
//    @ObservedObject var globalQuoteData = GlobalData()
//    init(globalQuoteData: GlobalData) {
//        self.globalQuoteData = globalQuoteData
//    }
    @Published var qd: [String: QuoteData] = [:]
//    @Published var isDataLoaded = true
    func fetchData(ticker: String)  {
        AF.request("https://backendproject4.wl.r.appspot.com/quote/\(ticker)").responseDecodable(of: QuoteData.self) { response in
            switch response.result {
            case .success(let postData):
                DispatchQueue.main.async {
                    //                    self.quotesData[ticker] = postData
                    // Update the dictionary with the fetched data
                    self.qd[ticker] = postData
//                    self.isDataLoaded = false
                }
//                print("Data fetched for \(ticker): \(postData.c)")
            case .failure(let error):
                print(error)
//                self.isDataLoaded = false
            }
        }
    }
}

struct QuoteData: Codable,Hashable {
    
    let c: Double
    let d: Double
    let dp:Double
    let h:Double
    let l:Double
    let o:Double
    let pc:Double
    let t: Int64
}
