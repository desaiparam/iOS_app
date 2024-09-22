//
//  Portfolio.swift
//  stockapp
//
//  Created by Param Desai on 06/04/24.
//

import Foundation
import Alamofire
import SwiftUI


class PortfolioList: ObservableObject {
    @Published var portfolio :[Portfolio] = []
    //    @ObservedObject var globalPortfolio = GlobalData()
    //    init(globalPortfolio: GlobalData) {
    //        self.globalPortfolio = globalPortfolio
    //    }
    //    @Published var globalPortfolio:[Portfolio] = []
    func fetchData() async{
        AF.request("https://backendproject4.wl.r.appspot.com/Portfolio").responseDecodable(of: [Portfolio].self) { response in
            switch response.result {
            case .success(let posts):
                DispatchQueue.main.async {
                    //                    self.portfolio = posts 
                    self.portfolio=posts
                    print("trying to see if this is getting called again",posts)
                     posts.forEach { favorities in
                        let quoteViewModel = QuoteDataList()
                        quoteViewModel.fetchData(ticker: favorities.Title)
                    }
                }
//                print(posts)
            case .failure(let error):
                print(error)
            }
        }
    }
    func move(from source: IndexSet, to destination: Int) {
           portfolio.move(fromOffsets: source, toOffset: destination)
       }
    
   
}

struct Portfolio: Identifiable, Codable,Hashable {
    let _id: String
    //    let id : String
    let Title:String
    let Company:String
    let Quantity:Int
    let Price : Double?
    var id : String{_id}
}
