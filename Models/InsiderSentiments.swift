//
//  LocalNews.swift
//  NewFinalStockApp
//
//  Created by Param Desai on 17/04/24.
//

import Foundation
import Alamofire
import SwiftUI

@MainActor
class InsiderSentimentsList: ObservableObject {
    @Published var insiderSentiments: [InsiderSentiments]=[]
    @Published  var totalMSPR: Double = 0
    @Published  var totalChange: Double = 0
    @Published var positiveMSPR: Double = 0
    @Published var positiveChange: Double = 0
    @Published var negativeMSPR: Double = 0
    @Published var negativeChange: Double = 0
    
    @Published var isinsiderSentiments = true
    func fetchData(ticker: String) async {
        print("Fetch data called with ticker: \(ticker)")
        let url = "https://backendproject4.wl.r.appspot.com/insiderSentiment/\(ticker)"
        print("URL for fetching data: \(url)")
        
        do {
            let request = AF.request(url)
            let data = try await request.serializingDecodable([InsiderSentiments].self).value
            //            print("Local news before filter: \(data)")
            DispatchQueue.main.async {
                print("Insider Sentimients \(data)")
                self.insiderSentiments = data
                self.totalMSPR = 0
                self.totalChange = 0
                self.positiveMSPR = 0
                self.positiveChange = 0
                self.negativeMSPR = 0
                self.negativeChange = 0
                
                // Calculate totals, positive, and negative values
                for element in data {
                    self.totalMSPR += element.mspr
                    self.totalChange += Double(element.change)
                    if element.mspr > 0 {
                        self.positiveMSPR += element.mspr
                    } else {
                        self.negativeMSPR += element.mspr
                    }
                    if element.change > 0 {
                        self.positiveChange += Double(element.change)
                    } else {
                        self.negativeChange += Double(element.change)
                    }
                }
                self.isinsiderSentiments = false
            }
        } catch {
            DispatchQueue.main.async {
                print("Error fetching quote data: \(error)")
                self.isinsiderSentiments = false
            }
            print("Error caught in fetchData: \(error)")
        }
    }
}

struct InsiderSentiments: Codable,Hashable {
    let symbol: String
    let year:Int
    let  month:Int
    let change: Int
    let mspr: Double
}
