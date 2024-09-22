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
class LocalNewsList: ObservableObject {
    @Published var localNews: [LocalNews]=[]
    
    @Published var isLocalNews = true
//    func fetchData(ticker: String) async {
//        print("Enter data")
//        let url = "https://backendproject4.wl.r.appspot.com/latestnews/\(ticker)"
//        
//        do {
//            let request = AF.request(url)
//            let data = try await request.serializingDecodable([LocalNews].self).value
//            print("locla news before fillter",data)
//            //            let filteredData = filterNewsItemsRemovingAnyWithNilValues(from: data)
//            DispatchQueue.main.async {
//                print("local new after filter",data)
//                self.localNews = data
//                self.isLocalNews = false
//            }
//        } catch {
//            DispatchQueue.main.async {
//                print("Error fetching quote data: \(error)")
//                self.isLocalNews = false
//            }
//            print("error",error)
//        }
//    }
    func fetchData(ticker: String) async {
//        print("Fetch data called with ticker: \(ticker)")
        let url = "https://backendproject4.wl.r.appspot.com/latestnews/\(ticker)"
//        print("URL for fetching data: \(url)")
        
        do {
            let request = AF.request(url)
            let data = try await request.serializingDecodable([LocalNews].self).value
//            print("Local news before filter: \(data)")
            DispatchQueue.main.async {
//                print("Local news after filter: \(data)")
                self.localNews = data
                self.isLocalNews = false
            }
        } catch {
            DispatchQueue.main.async {
                print("Error fetching quote data: \(error)")
                self.isLocalNews = false
            }
            print("Error caught in fetchData: \(error)")
        }
    }

    //    private func filterNewsItemsRemovingAnyWithNilValues(from newsArray: [LocalNews]) -> [LocalNews] {
    //        return newsArray.filter { news in
    //            // List the fields you consider essential
    //            news.category != nil &&
    //            news.headline != nil &&
    //            news.image != nil &&
    //            news.source != nil &&
    //            news.summary != nil &&
    //            news.url != nil
    //        }
    //    }
}

struct LocalNews: Identifiable, Codable,Hashable {
    let category: String?
    let datetime: Int?
    let headline: String?
    let id: Int?
    let image: String?
    let related :String?
    let source:String?
    let summary: String?
    let url: String?
}
