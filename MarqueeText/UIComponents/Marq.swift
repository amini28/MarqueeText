//
//  Marq.swift
//  MarqueeText
//
//  Created by Amini on 27/08/22.
//

import SwiftUI

struct Marq: View {
    
    @StateObject var systemViewModel: SystemViewModel
    
    @State var positionX1: CGFloat = 0
    @State var positionX2: CGFloat = 0
    
    @State var space: CGFloat = 0
        
    var body: some View {
        ZStack {
            HStack(spacing: 100) {
                ForEach(systemViewModel.textCount, id:\.self){ _ in
                    Text(systemViewModel.textToShow)
                        .foregroundColor(systemViewModel.textColor)
                        .font(.system(size: systemViewModel.textSize,
                                      weight: systemViewModel.textFontWeight,
                                      design: systemViewModel.textDesign))
                }
            }
            .background(.mint)
            .offset(x: positionX1)
            .animation(
                .easeInOut(duration: 4)
                .repeatForever(autoreverses: false),
                value: positionX1)
            
            HStack(spacing: 100) {
                ForEach(systemViewModel.textCount, id:\.self){ _ in
                    Text(systemViewModel.textToShow)
                    .foregroundColor(.black)
                    .font(.system(size: systemViewModel.textSize,
                                  weight: systemViewModel.textFontWeight,
                                  design: systemViewModel.textDesign))
                }
            }
            .background(.red)
            .offset(x: positionX2)
            .animation(
                .easeInOut(duration: 4)
                .repeatForever(autoreverses: false),
                value: positionX2)

        }
        .onAppear {
            
            print(positionX2)
            print(positionX1)
            
            if positionX1 == space {
                positionX1 = -(space + 200)
                print("in if x1 \(positionX1)")
            }
            if positionX2 == space + 200 {
                positionX2 = -space
                print("in if x2 \(positionX2)")
            }
            
        }
    }
    
    func widthOfText() -> CGFloat {
        
        return systemViewModel.textToShow.widthOfString(usingFont: UIFont(name: systemViewModel.textFont, size: systemViewModel.textSize) ?? .systemFont(ofSize: systemViewModel.textSize))
    }
    

}
