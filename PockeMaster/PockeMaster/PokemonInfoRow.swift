//
//  PokemonInfoRow.swift
//  PockeMaster
//
//  Created by CWH on 2023/5/4.
//

import SwiftUI

struct PokemonInfoRow: View {
    let mode = PokemonViewModel.sample(id:1)
    var body: some View {
        VStack {
            HStack {
                Image("Pokemon-\(mode.id)")
                    .resizable()
                    .frame(width: 50,height: 50)
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 4)
                Spacer()
                VStackLayout(alignment: .trailing) {
                    Text(mode.name)
                    Text(mode.nameEN)
                }
            }
            HStack {
                Spacer()
                Button(action: {}) {
                    Text("Fav")
                }
                Button(action: {}) {
                    Text("Panel")
                }
                Button(action: {}) {
                    Text("Web")
                }
            }
        }.background(Color.green)
    }
}

struct PokemonInfoRow_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoRow()
    }
}
