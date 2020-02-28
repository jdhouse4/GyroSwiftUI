//
//  ContentView.swift
//  GyroSwiftUI
//
//  Created by James Hillhouse IV on 1/6/20.
//  Copyright © 2020 PortableFrontier. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State var lightSwitch: Bool            = false
    @State var sunlightSwitch: Int          = 0
    @State var spacecraftCameraSwitch: Bool = false

    @State private var retireSplash = false



    var body: some View {
        ZStack {

            SplashScreen(animationComplete: self.$retireSplash)
                .animation(.easeIn(duration: 1.0))
                .transition(.opacity)
                .opacity(retireSplash ? 0 : 1)



            if self.retireSplash {
                OrionView(lightSwitch: $lightSwitch,
                          sunlightSwitch: $sunlightSwitch,
                          spacecraftCameraSwitch: $spacecraftCameraSwitch)
                    .background(Color.black)
            }
        }
    }
}



/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //ContentView(motion: MotionManager())
        ControlsView()
    }
}
 */

