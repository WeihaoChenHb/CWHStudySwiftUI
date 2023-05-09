//
//  PokemonList.swift
//  PockeMaster
//
//  Created by CWH on 2023/5/8.
//

import SwiftUI

struct PokemonList: View {
    
    @State var expandingIndex : Int?
    
    var body: some View {
//        List(PokemonViewModel.all) { pokemon in
//            PokemonInfoRow(mode: pokemon, expanded: false)
//        }
        ScrollView {
            LazyVStack {
                ForEach(PokemonViewModel.all) { pokemon in
                    PokemonInfoRow(
                        mode: pokemon,
                        expanded: self.expandingIndex == pokemon.id
                    )
                    .onTapGesture {
                        withAnimation (
                            .spring(
                                response: 0.55,
                                dampingFraction: 0.425,
                                blendDuration: 0
                            )
                        ) {
                            if self.expandingIndex == pokemon.id {
                                self.expandingIndex = nil
                            } else {
                                self.expandingIndex = pokemon.id
                            }
                        }
                    }
                }
            }
        }.overlay(
            VStack {
                Spacer()
                PokemonInfoPanel(model: .sample(id: 1))
            }.edgesIgnoringSafeArea(.bottom)
        )
    }
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
    }
}
