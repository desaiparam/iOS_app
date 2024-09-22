//
//  Wallet.swift
//  stockapp
//
//  Created by Param Desai on 05/04/24.
//

import Foundation
import Alamofire
import SwiftUI


class WalletList:ObservableObject{
//    @Published var wallet = [Wallet]()
//   @ObservedObject var globalWallet = GlobalData()
//    init(globalWallet:GlobalData){
//        self.globalWallet=globalWallet
//    }
    @Published var wallet: Double = 0.0
    
    
    func fetchData() async{
        AF.request("https://backendproject4.wl.r.appspot.com/Wallet").responseDecodable(of: [Wallet].self) { response in
            switch response.result {
            case .success(let posts):
                DispatchQueue.main.async {
//                    self.wallet = posts
                    self.wallet = posts.reduce(0.0) { $0 + $1.Wallet }
                    print("in wallet print",self.wallet)
                    
                }
                print("in wallet getting post",posts)
               
            case .failure(let error):
                print(error)
            }
        }
    }
    func addWallet(wallet:Double){
           let url = "https://backendproject4.wl.r.appspot.com/addWallet/\(wallet)"
           AF.request(url, method: .post).response { response in
               switch response.result {
               case .success:
                   AF.request("https://backendproject4.wl.r.appspot.com/Wallet").responseDecodable(of: [Wallet].self) { response in
                       switch response.result {
                       case .success(let posts):
                           DispatchQueue.main.async {
                               //                    self.favorities = posts
                               print("seeing the ticker we get in fs",posts)
                               self.wallet = posts.reduce(0.0) { $0 + $1.Wallet }
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
                   print("Succesfully to add \(wallet)to wallet")
               case .failure(let error):
                   print("Failed to add \(wallet)to wallet: \(error)")
               }
           }
       }
    func deleteWallet(wallet:Double){
           let url = "https://backendproject4.wl.r.appspot.com/deleteWallet/\(wallet)"
           AF.request(url, method: .post).response { response in
               switch response.result {
               case .success:
                   AF.request("https://backendproject4.wl.r.appspot.com/Wallet").responseDecodable(of: [Wallet].self) { response in
                       switch response.result {
                       case .success(let posts):
                           DispatchQueue.main.async {
                               //                    self.favorities = posts
                               print("seeing the ticker we get in fs",posts)
                               self.wallet = posts.reduce(0.0) { $0 + $1.Wallet }
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
                   print("Succesfully to add \(wallet)to wallet")
               case .failure(let error):
                   print("Failed to add \(wallet)to wallet: \(error)")
               }
           }
       }
}

struct Wallet: Hashable, Codable {
    let id: String
    let Wallet: Double
}
