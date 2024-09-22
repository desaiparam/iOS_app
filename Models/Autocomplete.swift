//
//  Autocomplete.swift
//  NewFinalStockApp
//
//  Created by Param Desai on 28/04/24.
//

import Foundation
import Alamofire
import SwiftUI

@MainActor
class AutocompleteList: ObservableObject {
    @Published var autocompleteList: [Autocomplete] = []
    //    @Published var isPeers = true
    
    func fetchData(ticker: String) async {
        print(ticker)
        let url = "https://backendproject4.wl.r.appspot.com/autocomplete/\(ticker)"
        
        do {
            let request = AF.request(url)
            let data = try await request.serializingDecodable([Autocomplete].self).value
//            print("Autocomplete data: \(data)")
            DispatchQueue.main.async {
//                print("autocomplete data",data)
                self.autocompleteList = data
                print(self.autocompleteList)
            }
        } catch {
            DispatchQueue.main.async {
                print("Error fetching autocomplete data: \(error)")
            }
        }
    }

}

class Debouncer {
    private let delay: TimeInterval
    private var timer: Timer?

    init(delay: TimeInterval) {
        self.delay = delay
    }

    func debounce(action: @escaping () -> Void) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { _ in
            action()
        }
    }
}

struct Autocomplete: Codable, Hashable {
    let description:String?
    let displaySymbol:String?
    let symbol:String?
    let type: String?
}
