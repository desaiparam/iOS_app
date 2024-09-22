//
//  Peers.swift
//  NewFinalStockApp
//
//  Created by Param Desai on 18/04/24.
//

import Foundation
import Alamofire
import SwiftUI

@MainActor
class PeerDataList: ObservableObject {
    @Published var peers: [String] = []
    @Published var isPeers = true
    
    func fetchData(ticker: String) async {
        let url = "https://backendproject4.wl.r.appspot.com/peers/\(ticker)"
        
        do {
            let request = AF.request(url)
            let data = try await request.serializingDecodable([String].self).value
//            print("Local news before filter", data)
            DispatchQueue.main.async {
//                print("Peers new after ", data)
                self.peers = data
                self.isPeers = false
            }
        } catch {
            DispatchQueue.main.async {
                print("Error fetching quote data: \(error)")
                self.isPeers = false
            }
            print("error", error)
        }
    }
}

struct Peers: Codable, Hashable {
    let tickers: [String]
}

