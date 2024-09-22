//
//  Portfolio.swift
//  stockapp
//
//  Created by Param Desai on 06/04/24.
//

import Foundation
import Alamofire
import SwiftUI

class FavoritiesList: ObservableObject {
    @Published var favorities: [Favorities]
//       @Published var isFavorited: StarResponse
    @Published var isFavorited: StarResponse = StarResponse(isStarred: false)

    @Published var isDataLoaded = true
       struct StarResponse: Codable {
           var isStarred: Bool
       }

       init(favorities: [Favorities] = [], isFavorited: StarResponse = StarResponse(isStarred: false)) {
           self.favorities = favorities
           self.isFavorited = isFavorited
       }
    //    @ObservedObject var globalFavorities = GlobalData()
    //    init(globalFavorities: GlobalData) {
    //        self.globalFavorities = globalFavorities
    //    }
    //    let quoteDataList =  GlobalData()
    //    func remove(atOffsets offsets: IndexSet) {
    //        globalFavorities.remove(atOffsets: offsets)
    //       }
    
    
    func fetchData() async{
        AF.request("https://backendproject4.wl.r.appspot.com/Watchlist").responseDecodable(of: [Favorities].self) { response in
            switch response.result {
            case .success(let posts):
                DispatchQueue.main.async {
                    //                    self.favorities = posts
                    print("seeing the ticker we get in fs",posts)
                    self.favorities=posts
                    self.isDataLoaded=false
                    //                    posts.forEach { favorities in
                    //                        let quoteViewModel = QuoteDataList()
                    //                        quoteViewModel.fetchData(ticker: favorities.Title)
                    //                    }
                }
                print(posts)
            case .failure(let error):
                print(error)
            }
        }
    }
    func remove(atOffsets offsets: IndexSet) {
        for index in offsets {
            let ticker = favorities[index].Title
            deleteFavorite(ticker: ticker)
        }
        favorities.remove(atOffsets: offsets)
    }
    
    private func deleteFavorite(ticker: String) {
        let url = "https://backendproject4.wl.r.appspot.com/deleteWatchlist/\(ticker)"
        AF.request(url, method: .delete).response { response in
            switch response.result {
            case .success:
                print("Successfully deleted \(ticker) from watchlist")
            case .failure(let error):
                print("Failed to delete \(ticker): \(error)")
            }
        }
    }
    func addFavorities(ticker:String, company:String){
        let url = "https://backendproject4.wl.r.appspot.com/addWatchlist/\(ticker)/\(company)"
        AF.request(url, method: .post).response { response in
            switch response.result {
            case .success:
                AF.request("https://backendproject4.wl.r.appspot.com/Watchlist").responseDecodable(of: [Favorities].self) { response in
                    switch response.result {
                    case .success(let posts):
                        DispatchQueue.main.async {
                            //                    self.favorities = posts
                            print("seeing the ticker we get in fs",posts)
                            self.favorities=posts
                            //                    posts.forEach { favorities in
                            //                        let quoteViewModel = QuoteDataList()
                            //                        quoteViewModel.fetchData(ticker: favorities.Title)
                            //                    }
                        }
                        print(posts)
                    case .failure(let error):
                        print(error)
                    }
                }
                print("Successfully added \(ticker) \(company) to watchlist")
            case .failure(let error):
                print("Failed to add \(ticker) \(company) to watchlist: \(error)")
            }
        }
    }
    func deleteFavorities(ticker:String){
        let url = "https://backendproject4.wl.r.appspot.com/deleteWatchlist/\(ticker)"
        AF.request(url, method: .delete).response { response in
            switch response.result {
            case .success:
                AF.request("https://backendproject4.wl.r.appspot.com/Watchlist").responseDecodable(of: [Favorities].self) { response in
                    switch response.result {
                    case .success(let posts):
                        
                        DispatchQueue.main.async {
                            //                    self.favorities = posts
//                            print("seeing the ticker we get in fs",posts)
                            self.favorities=posts
                            self.isFavorited.isStarred = false
                            //                    posts.forEach { favorities in
                            //                        let quoteViewModel = QuoteDataList()
                            //                        quoteViewModel.fetchData(ticker: favorities.Title)
                            //                    }
                        }
                        print(posts)
                    case .failure(let error):
                        print(error)
                    }
                }
                print("Successfully added \(ticker)  to watchlist")
            case .failure(let error):
                print("Failed to add \(ticker)to watchlist: \(error)")
            }
        }
    }
    
//    func addFavoritesIfNeeded(ticker: String) async {
//        let getStarURL = "https://backendproject4.wl.r.appspot.com/gettingStar/\(ticker)"
//        AF.request(getStarURL, method: .get).responseDecodable(of: StarResponse.self) { response in
//            switch response.result {
//            case .success(let starResponse):
//                DispatchQueue.main.async {
//                    self.isFavorited = starResponse  // Update the published variable on the main thread
//                }
////                if !starResponse.isStarred {
////                    self.addFavorities(ticker: ticker, company: company)
////                }
//            case .failure(let error):
//                print("Failed to check if \(ticker) is in the watchlist: \(error)")
//            }
//        }
//    }
    func checkIsStarred(ticker: String) async -> Bool {
        let getStarURL = "https://backendproject4.wl.r.appspot.com/gettingStar/\(ticker)"
        do {
            let response = try await AF.request(getStarURL, method: .get).serializingDecodable(Bool.self).value
            return response
        } catch {
            print("Failed to check if \(ticker) is in the watchlist: \(error.localizedDescription)")
            return false  // return false or handle error appropriately
        }
    }

   
    
    func move(from source: IndexSet, to destination: Int) {
        favorities.move(fromOffsets: source, toOffset: destination)
        // Optionally, update the server with the new order here
    }
}


struct Favorities: Identifiable, Hashable,Codable {
    let _id: String
    //    let id : String
    let Title:String
    let Company:String
    var id:String{_id}
    //    let Quantity:Int?
    //    let Price : Double?
}

