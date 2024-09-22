//
//  AutocompleteView.swift
//  NewFinalStockApp
//
//  Created by Param Desai on 28/04/24.
//

import SwiftUI

struct AutocompleteView: View {
    @ObservedObject var autocompleteList: AutocompleteList
    var selectSuggestion: (Autocomplete) -> Void
    
    var body: some View {
        List(autocompleteList.autocompleteList, id: \.symbol) { suggestion in
            Button(action: {
                selectSuggestion(suggestion)
            }) {
                Text(suggestion.description ?? "N?A")
            }
        }
    }
}

//#Preview {
//    AutocompleteView(autocompleteList: <#AutocompleteList#>, selectSuggestion: <#(Autocomplete) -> Void#>)
//}
