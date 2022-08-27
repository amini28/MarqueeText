//
//  Marquee.swift
//  MarqueeText
//
//  Created by Amini on 25/08/22.
//

import SwiftUI

// MARK: Marquee Text View
struct Marquee: View {
    
    @StateObject var systemViewModel: SystemViewModel
    @State var text: String = "Marquee"
    // MARK: Animation Offset
    @State var offset: CGFloat = UIScreen.main.bounds.height
    
    // MARK: Animation Speed
    @State var delay: Double = 0.5
    
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false){
            
            HStack(spacing: 100) {
                ForEach(systemViewModel.textCount, id:\.self){ textString in
                    Text(textString)
//                        .font(Font(UIFont(name: systemViewModel.textFont,
//                                          size: systemViewModel.textSize) ?? .systemFont(ofSize: systemViewModel.textSize)))
                        .foregroundColor(systemViewModel.textColor)
                        .font(.system(size: systemViewModel.textSize, weight: systemViewModel.textFontWeight, design: systemViewModel.textDesign))
                        .offset(x: offset)
//                        .padding(.horizontal, 15)
                }
            }
        }
        .overlay(content: {
            HStack {
                let color = systemViewModel.backgroundColor
                
                LinearGradient(colors: [color, color.opacity(0.7), color.opacity(0.5)], startPoint: .leading, endPoint: .trailing)
                    .frame(width: 20)
                
                Spacer()
                
                LinearGradient(colors: [color, color.opacity(0.7), color.opacity(0.5)].reversed(), startPoint: .leading, endPoint: .trailing)
                    .frame(width: 20)
            }
        })
        // Disabling Manual Scrolling
        .disabled(true)
        .onAppear{
//            // Calculating total secs based on text width
//            // our animation speed for each character will be 0.02s
//            let timing: Double = (systemViewModel.textSpeed * widthOfText())
            let timing: Double = (systemViewModel.textSpeed)
//
//            // Delaying First Animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                withAnimation (.linear(duration: timing)){
                    offset = -(widthOfText()+100) * CGFloat(systemViewModel.textCount.count - 1)
                }
            }
        }
        // MARK: Repeating Marquee Effect with the help of Timer
        .onReceive(Timer.publish(every: ((systemViewModel.textSpeed) + delay), on: .main, in: .default).autoconnect()){ _ in
            
            // Resetting offset to 0
            // Thus its look like its looping
            offset = UIScreen.main.bounds.height
            withAnimation (.linear(duration: (systemViewModel.textSpeed))){
                offset = -(widthOfText()+100) * CGFloat(systemViewModel.textCount.count)
            }
            
        }
        
    }
    
    func widthOfText() -> CGFloat {
        
        return systemViewModel.textToShow.widthOfString(usingFont: UIFont(name: systemViewModel.textFont, size: systemViewModel.textSize) ?? .systemFont(ofSize: systemViewModel.textSize))
    }
    
}

