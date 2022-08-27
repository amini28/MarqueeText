//
//  TopMenu.swift
//  MarqueeText
//
//  Created by Amini on 25/08/22.
//

import SwiftUI

struct TopMenu: View {
    
    @ObservedObject var systemViewModel: SystemViewModel
    
    @State private var isShowingField = false

    var body: some View {
        VStack {
            HStack {
                if !isShowingField {
                    Button {
                        withAnimation {
                            systemViewModel.animationPlay.toggle()
                        }
                    } label: {
                        Image(systemName: systemViewModel.animationPlay ? "play.fill" : "pause.fill")
                            .frame(width: 24, height: 24)
                            .foregroundColor(systemViewModel.textColor)
                    }
                    Spacer()
                    Button {
                        withAnimation {
                            systemViewModel.settingShow.toggle()
                        }
                    } label: {
                        Image(systemName: systemViewModel.settingShow ? "eye.slash.circle.fill" : "eye.slash.circle.fill")
                            .frame(width: 24, height: 24)
                            .foregroundColor(systemViewModel.textColor)
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width - 16)
            .frame(height: 24)
            
            if systemViewModel.settingShow {
                
                if !isShowingField {
                    Button {
                        withAnimation {
                            isShowingField.toggle()
                        }
                    } label: {
                        Text("T")
                            .font(.title3)
                            .foregroundColor(.white)
                            
                        Image(systemName: "chevron.down")
                            .foregroundColor(.white)
                    }

                } else {
                    VStack(spacing: 8) {
                        TextField("", text: $systemViewModel.textToShow)
                                .foregroundColor(.white)
                                .textFieldStyle(.plain)
                                .frame(height: 40, alignment: .center)
                                .transition(.slide)
                        Rectangle()
                            .fill(.white)
                            .frame(height: 1)
                            .offset(y: -8)
                        
                        Button {
                            withAnimation {
                                withAnimation(.easeInOut) {
                                    isShowingField.toggle()
                                }

                            }
                        } label: {
                            Image(systemName: "chevron.up")
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                }
            }

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(systemViewModel.settingShow ? Color.black.opacity(0.5) : Color.clear)
        
    }
}
