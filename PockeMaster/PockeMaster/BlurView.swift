//
//  BlurView.swift
//  PockeMaster
//
//  Created by CWH on 2023/5/9.
//

import UIKit
import SwiftUI

struct BlurView: UIViewRepresentable {
    let style : UIBlurEffect.Style
    
    init(style: UIBlurEffect.Style) {
        print("init")
        self.style = style
    }
    
    func makeUIView(context: Context) -> some UIView {
        print("makeUIView")
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blurView)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        print("updateUIView")
    }
}

extension View {
    func blurBackground(style: UIBlurEffect.Style) -> some View {
        ZStack {
            BlurView(style: style)
            self
        }
    }
}
