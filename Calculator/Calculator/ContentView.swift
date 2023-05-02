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
        VStack(spacing: 12) {
            Text("0")
                .font(.system(size: 76))
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    alignment: .trailing)
            CalculatorButtonPad()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CalculatorButtonPad: View {
    
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
                CalculatorButtonRow(row: row)
            }
        }
    }
}

struct CalculatorButtonRow: View {
    let row: [CalculatorButtonItem]
    var body: some View {
        HStack{
            ForEach(row, id: \.self) { item in
                CalculatorButton(title: item.title,
                                 size: item.size,
                                 backgroundColorName: item.backgroundColorName,
                                 backColor: Color.white) {
                    print("Button: \(item.title)")
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