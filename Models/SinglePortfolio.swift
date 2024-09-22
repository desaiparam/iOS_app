//
//  SinglePortfolio.swift
//  finalnewstockapp
//
//  Created by Param Desai on 14/04/24.
//


import Foundation
import Alamofire
import SwiftUI

@MainActor
class SinglePortfolioList: ObservableObject {
    @Published var singlePortfolio: SinglePortfolio?
    
    @Published var isSinglePortfolioLoading = true
    
    func fetchData(ticker: String) async {
        //        print("Fetching data on main thread in qd: \(Thread.isMainThread)")
//        isSinglePortfolioLoading = true
        let url = "https://backendproject4.wl.r.appspot.com/getSinglePortfolio/\(ticker)"
        
        do {
            let request = AF.request(url)
            print("inide singlePortfolio checking to see the URL response",request)
            let data = try await request.serializingDecodable(SinglePortfolio.self).value
            DispatchQueue.main.async {
                print("self.isSinglePortfolioLoading",self.isSinglePortfolioLoading)
                print("data of singlePortfolio",data)
                
                self.singlePortfolio = data
                self.isSinglePortfolioLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                print("Error fetching quote data: \(error)")
                self.singlePortfolio=nil
                self.isSinglePortfolioLoading = false
            }
            print("error",error)
        }
    }
    func addPortfolio(ticker:String, company:String,quantity:String,price:String){
        let url = "https://backendproject4.wl.r.appspot.com/addPortfolio/\(ticker)/\(company)/\(quantity)/\(price)"
        AF.request(url, method: .post).response { response in
            switch response.result {
            case .success:
                AF.request("https://backendproject4.wl.r.appspot.com/getSinglePortfolio/\(ticker)").responseDecodable(of: SinglePortfolio.self) { response in
                    switch response.result {
                    case .success(let posts):
                        DispatchQueue.main.async {
                            //                    self.favorities = posts
                            print("seeing the ticker we get in fs",posts)
                            self.singlePortfolio=posts
                            
                            //                    posts.forEach { favorities in
                            //                        let quoteViewModel = QuoteDataList()
                            //                        quoteViewModel.fetchData(ticker: favorities.Title)
                            //                    }
                        }
                        print(posts)
                    case .failure(let error):
                        self.singlePortfolio=nil
                        print(error)
                    }
                }
                print("Successfully added \(ticker) \(company) to watchlist")
            case .failure(let error):
                self.singlePortfolio=nil
                print("Failed to add \(ticker) \(company) to watchlist: \(error)")
            }
        }
    }
    func deleteProtfolio(ticker:String, company:String,quantity:String,price:String){
        let url = "https://backendproject4.wl.r.appspot.com/deleteProtfolio/\(ticker)/\(company)/\(quantity)/\(price)"
        AF.request(url, method: .post).response { response in
            switch response.result {
            case .success:
                AF.request("https://backendproject4.wl.r.appspot.com/getSinglePortfolio/\(ticker)").responseDecodable(of: SinglePortfolio.self) { response in
                    switch response.result {
                    case .success(let posts):
                        DispatchQueue.main.async {
                            //                    self.favorities = posts
                            print("seeing the ticker we get in fs",posts)
                            self.singlePortfolio=posts
                            
                            //                    posts.forEach { favorities in
                            //                        let quoteViewModel = QuoteDataList()
                            //                        quoteViewModel.fetchData(ticker: favorities.Title)
                            //                    }
                        }
                        print(posts)
                    case .failure(let error):
                        self.singlePortfolio=nil
                        print(error)
                    }
                }
                print("Successfully added \(ticker) \(company) to watchlist")
            case .failure(let error):
                self.singlePortfolio=nil
                print("Failed to add \(ticker) \(company) to watchlist: \(error)")
            }
        }
    }
   
}

struct SinglePortfolio: Identifiable, Codable,Hashable {
    let _id: String?
//    let id : String
    let Title:String?
    let Company:String?
    let Quantity:Int?
    let Price : Double?
    var id : String{_id ?? ""}
}
