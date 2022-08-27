//
//  BottomMenu.swift
//  MarqueeText
//
//  Created by Amini on 25/08/22.
//

import SwiftUI

struct BottomMenu: View {
    
    @State private var showSetup = false
    
    @StateObject var settingViewModel: SettingViewModel
    @StateObject var systemViewModel: SystemViewModel
    
    @Namespace var namespace
    
    
    var body: some View {
        VStack(alignment: .center) {
            
            ZStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack (spacing: 20) {
                        ForEach(settingsArr, id: \.id) { setting in
                            SettingItem(namespace: namespace,
                                        numberVM: settingViewModel,
                                        id: setting)
                        }
                    }
                    
                }
                .padding()
                
                if settingViewModel.tapped {
                    SettingView(settingViewModel: settingViewModel,
                                systemViewModel: systemViewModel,
                                namespace: namespace)
                    
                        .padding()
                }
                
            }
        }
    }
}
