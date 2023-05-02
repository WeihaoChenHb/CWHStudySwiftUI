//
//  ContentView.swift
//  Calculator
//
//  Created by CWH on 2023/4/21.
//

import SwiftUI

struct ContentView: View {
//    let row: [CalculatorButtonItem] = [
//        .digit(1),.digit(2),.digit(3),.op(.plus)
//    ]
//    @State private var brain: CalculatorBrain = .left("0")
    @ObservedObject var model: CalculatorModel = CalculatorModel()
    
    @State private var editingHistory = false

    var body: some View {
//        Button {
//            print("Button:+")
//        } label: {
//            Text("+")
//                .font(.system(size: 38))
//                .foregroundColor(.white)
//                .frame(width: 88, height: 88)
//                .background(Color(.orange))
//                .cornerRadius(44)
//        }
        
//        HStack{
//            CalculatorButton(title: "1",
//                             size: CGSize(width: 88, height: 88),
//                             backgroundColorName: "digitBackground",
//                             backColor: Color.black)
//             {
//                print("Button 1")
//            }
//            CalculatorButton(title: "2",
//                             size: CGSize(width: 88, height: 88),
//                             backgroundColorName: "digitBackground",
//                             backColor: Color.black) {
//                print("Button 2")
//            }
//            CalculatorButton(title: "3",
//                             size: CGSize(width: 88, height: 88),
//                             backgroundColorName: "digitBackground",
//                             backColor: Color.black) {
//                print("Button 3")
//            }
//            CalculatorButton(title: "+",
//                             size: CGSize(width: 88, height: 88),
//                             backgroundColorName: "operatorBackground",
//                             backColor: Color.orange) {
//                print("Button +")
//            }
            
//            ForEach(row, id: \.self) { item in
//                CalculatorButton(title: item.title,
//                                 size: item.size,
//                                 backgroundColorName: item.backgroundColorName,
//                                 backColor: Color.white) {
//
//                }
//            }
//        }
        
        
//        VStack(spacing: 8) {
//            CalculatorButtonRow(row: [
//                .command(.clear),.command(.flip),.command(.percent),.op(.divide)
//            ])
//
//            CalculatorButtonRow(row: [
//                .digit(7),.digit(8),.digit(9),.op(.multiply)
//            ])
//            CalculatorButtonRow(row: [
//                .digit(4),.digit(5),.digit(6),.op(.minus)
//            ])
//            CalculatorButtonRow(row: [
//                .digit(1),.digit(2),.digit(3),.op(.plus)
//            ])
//            CalculatorButtonRow(row: [
//                .digit(0),.dot,.op(.equal)
//            ])
//        }
//        CalculatorButtonPad()
        
//        VStack(alignment:.trailing, spacing: 12) {
//            Text("0").font(.system(size: 76))
//            CalculatorButtonPad()
//        }
                
        let scale = UIScreen.main.bounds.width / 414.0
//
//        VStack(spacing: 12) {
//            Text("0")
//                .font(.system(size: 76))
//                .minimumScaleFactor(0.5)
//                .padding(.trailing, 24)
//                .lineLimit(1)
//                .frame(
//                    minWidth: 0,
//                    maxWidth: .infinity,
//                    alignment: .trailing)
//            CalculatorButtonPad()
//                .padding(.bottom)
//        }
//        .scaleEffect(scale)
        
        VStack(spacing: 12) {
            Spacer()
            
            Button("操作履历: \(model.history.count)") {
                self.editingHistory = true
            }.sheet(isPresented: self.$editingHistory) {
                HistoryView(model: self.model)
            }
            
            Text(model.brain.output)
                .font(.system(size: 76))
                .minimumScaleFactor(0.5)
                .padding(.trailing, 24)
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    alignment: .trailing
                )
            
            CalculatorButtonPad(model: model)
                .padding(.bottom)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CalculatorButtonPad: View {
    
//    @Binding var brain: CalculatorBrain
    var model: CalculatorModel
    
    let pad: [[CalculatorButtonItem]] = [
        [.command(.clear),.command(.flip),.command(.percent),.op(.divide)],
        [.digit(7),.digit(8),.digit(9),.op(.multiply)],
        [.digit(4),.digit(5),.digit(6),.op(.minus)],
        [.digit(1),.digit(2),.digit(3),.op(.plus)],
        [.digit(0),.dot,.op(.equal)]
    ]
    
    var body: some View {
        VStack(spacing: 8) {
            ForEach(pad, id: \.self) { row in
                CalculatorButtonRow(model: model, row: row)
            }
        }
    }
}

struct CalculatorButtonRow: View {
    
//    @Binding var brain: CalculatorBrain
    var model: CalculatorModel
    
    let row: [CalculatorButtonItem]
    var body: some View {
        HStack{
            ForEach(row, id: \.self) { item in
                CalculatorButton(title: item.title,
                                 size: item.size,
                                 backgroundColorName: item.backgroundColorName,
                                 backColor: Color.white) {
//                    print("Button: \(item.title)")
                    self.model.apply(item)
                }
            }
        }
    }
}

struct CalculatorButton: View {
    
    let fontSize: CGFloat = 38
    let title: String
    let size: CGSize
    let backgroundColorName: String
    let backColor: Color
    let action: ()->Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: fontSize))
                .foregroundColor(.white)
                .frame(width: size.width,height: size.height)
                .background(Color(backgroundColorName))
                .cornerRadius(size.width / 2)
        }
    }
}

struct HistoryView: View {
    @ObservedObject var model : CalculatorModel
    
    var body: some View {
        VStack{
            if model.totalCount == 0 {
                Text("没有履历")
            } else {
                HStack {
                    Text("履历").font(.headline)
                    Text("\(model.historyDetail)").lineLimit(nil)
                }
                
                HStack {
                    Text("显示").font(.headline)
                    Text("\(model.brain.output)")
                }
                
                Slider(value: $model.slidingIndex, in: 0 ... Float(model.totalCount) ,step: 1)
            }
        }.padding()
    }
}
