//
//  PokemonInfoRow.swift
//  PockeMaster
//
//  Created by CWH on 2023/5/4.
//

import SwiftUI

struct PokemonInfoRow: View {
//    let mode = PokemonViewModel.sample(id:1)
    let mode : PokemonViewModel
//    @State var expanded: Bool
    var expanded: Bool
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
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                    Text(mode.nameEN)
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
            }.padding(.top, 12)
            Spacer()
            HStack (spacing: expanded ? 20 : -30) {
                Spacer()
                Button(action: {print("Fav")}) {
                    Image(systemName: "star")
                        .modifier(ToolButtonModifier())
                }
                Button(action: {print("panel")}) {
                    Image(systemName: "chart.bar")
                        .modifier(ToolButtonModifier())
                }
                Button(action: {print("web")}) {
                    Image(systemName: "info.circle")
                        .modifier(ToolButtonModifier())
                }
            }
            .padding(.bottom, 12)
            .opacity(expanded ? 1.0 : 0.0)
            .frame(maxHeight: expanded ? .infinity : 0)
        }
        .frame(height: expanded ? 120 : 80)
        .padding(.leading, 23)
        .padding(.trailing, 15)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(mode.color, style: StrokeStyle(lineWidth: 4))
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [.white, mode.color]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
            }
        )
        .padding(.horizontal)
//        .onTapGesture {
//            withAnimation (
//                .spring(
//                    response: 0.55,
//                    dampingFraction: 0.425,
//                    blendDuration: 0
//                )
//            ) {
//                self.expanded.toggle()
//            }
//        }
    }
}

struct PokemonInfoRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PokemonInfoRow(mode: .sample(id: 1), expanded: false)
            PokemonInfoRow(mode: .sample(id: 21), expanded: true)
            PokemonInfoRow(mode: .sample(id: 25), expanded: false)
        }
    }
}


struct ToolButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 25))
            .foregroundColor(.white)
            .frame(width: 30,height: 30)
    }
}
