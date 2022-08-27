//
//  SettingView.swift
//  MarqueeText
//
//  Created by Amini on 25/08/22.
//

import SwiftUI

struct SettingView: View {
    @ObservedObject var settingViewModel: SettingViewModel
    @ObservedObject var systemViewModel: SystemViewModel
    
    var namespace: Namespace.ID

    @State var offset: CGFloat = 0
    
    var body: some View {
        HStack {
            GeometryReader { geo in
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {

                    Capsule()
                        .fill(Color.black.opacity(0.8))
                        .matchedGeometryEffect(id: "back\(settingViewModel.selected!.number)", in: namespace)
                        .frame(height: 40)
                    
                    HStack(spacing: 8) {
                        ZStack {
                            Image(systemName: "\(settingViewModel.selected!.icon)")
                                .foregroundColor(.gray)
                                .matchedGeometryEffect(id: "circle\(settingViewModel.selected!.number)", in: namespace)
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                                .onTapGesture {
                                    withAnimation {
                                        settingViewModel.tapped = false
                                    }
                                }
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                switch (settingViewModel.selected?.type) {
                                case .textColors(let colors):
                                    ForEach(colors, id:\.self) { color in
                                        Circle()
                                            .fill(color)
                                            .frame(width: 30, height: 30)
                                            .onTapGesture {
                                                print("text Color Tapped \(color)")
                                                systemViewModel.textColor = color
                                            }
                                    }
                                    
                                case .backgroundColor(let colors):
                                    ForEach(colors, id:\.self) { color in
                                        Circle()
                                            .fill(color)
                                            .frame(width: 30, height: 30)
                                            .onTapGesture {
                                                print("Background Color Tapped \(color)")
                                                systemViewModel.backgroundColor = color
                                            }
                                    }
                                    
                                case .textDesign(let designs):
                                    ForEach(designs, id:\.self) { design in
                                        Text("   \(String(describing: design))   ")
                                            .foregroundColor(.black)
                                            .font(.system(size: 14,
                                                          weight: .regular,
                                                          design: design))
                                            .background(.white)
                                            .clipShape(Capsule())
                                            .onTapGesture {
                                                print("design tapped \(String(describing: design))")
                                                systemViewModel.textDesign = design
                                            }
                                            
                                    }
                                    
                                case .textWeight(let weights):
                                    ForEach(weights, id:\.self) { weight in
                                        Text("   \(getName(weight: weight))   ")
                                            .foregroundColor(.black)
                                            .background(.white)
                                            .font(.system(size: 14,
                                                          weight: weight,
                                                          design: .default))
                                            .clipShape(Capsule())
                                            .onTapGesture {
                                                print("weight tapped \(String(describing: weight))")
                                                systemViewModel.textFontWeight = weight
                                            }
                                    }
                                    
                                case .textEffect(_):
                                    Capsule()
                                        .fill(.yellow)
                                        .frame(height: 40)
                                    
                                case .textSize(_,_):
                                    Capsule()
                                        .fill(.teal)
                                        .frame(height: 40)
                                    
                                case .backgroundImage(_):
                                    Capsule()
                                        .fill(.purple)
                                        .frame(height: 40)
                                case .none:
                                    EmptyView()
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        .frame(height: 40)
    }
    
    func getName(weight: Font.Weight) -> String {
        switch(weight) {
            
        case .regular: return "regular"
        case .black: return "black"
        case .ultraLight: return "ultralight"
        case .thin: return "thin"
        case .semibold: return "semibold"
        case .bold: return "bold"
        case .medium: return "medium"
        case .light: return "light"
        case .heavy: return "heavy"
            
        default:
            return ""
        }
    }
}

