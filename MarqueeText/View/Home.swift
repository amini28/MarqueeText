//
//  Home.swift
//  MarqueeText
//
//  Created by Amini on 26/01/22.
//

import SwiftUI

struct Home: View {
    
    @StateObject var systemViewModel = SystemViewModel()
    @StateObject var settingViewModel = SettingViewModel()
    
    // Gesture Properties..
    @State var selected = 0
    @State var lastOffset: CGFloat = 0
    @State var showEditing = false
    @State var rotateMarquee:Double = 90

    var body: some View {
        ZStack {
            
            Image(systemViewModel.backgroundImage)
                .resizable()
                .background(systemViewModel.backgroundColor)
                .ignoresSafeArea(.all)

            VStack {
//                Marquee(systemViewModel: systemViewModel)
                if systemViewModel.animationPlay {
                    Marquee(systemViewModel: systemViewModel)
                    .frame(width: UIScreen.main.bounds.height)

//                    MarqueeText(systemViewModel: systemViewModel)
//                        .frame(width: UIScreen.main.bounds.height + widthOfText()*2)

                    .rotationEffect(.degrees(rotateMarquee))
                }
            }
            
            VStack {
                
                TopMenu(systemViewModel: systemViewModel)
                    .frame(height: 30)
                    .frame(maxWidth: .infinity)

                Spacer()
                
                if systemViewModel.settingShow {
                    BottomMenu(settingViewModel: settingViewModel, systemViewModel: systemViewModel)
                    .background(Color.black.opacity(0.5))
                    .frame(height: 64)
                    .frame(maxWidth: .infinity)
                }
            }
            .frame(width: UIScreen.main.bounds.width)
            
            VStack {
                
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width-16)
            .padding(.leading, 16)
            .padding(.trailing, 16)
        }
    }
    
    func widthOfText() -> CGFloat {
        
        return systemViewModel.textToShow.widthOfString(usingFont: UIFont(name: systemViewModel.textFont, size: systemViewModel.textSize) ?? .systemFont(ofSize: systemViewModel.textSize))
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
