//
//  ContentView.swift
//  GyroSwiftUI
//
//  Created by James Hillhouse IV on 1/6/20.
//  Copyright © 2020 PortableFrontier. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    //@ObservedObject var motion: MotionManager = MotionManager()

    @State var lightSwitch: Bool            = false
    @State var sunlightSwitch: Int          = 0
    @State var spacecraftCameraSwitch: Bool = false

    @State var showSplash = true



    var body: some View {
        ZStack {
            VStack {

                //Spacer()

                Text("Orion In SwiftUI")
                    //.fixedSize()
                    .font(.headline)

                //Spacer()


                SceneKitView(lightSwitch: $lightSwitch,
                             sunlightSwitch: $sunlightSwitch,
                             spacecraftCameraSwitch: $spacecraftCameraSwitch)
                //.scaleEffect(0.9, anchor: .center)


                //Spacer()

                ControlsView(lightSwitch: $lightSwitch, sunlightSwitch: $sunlightSwitch, bodyCameraSwitch: $spacecraftCameraSwitch)

                Text("Motion Data")
                //Text("quaternion: \(motion.motionQuaternion.debugDescription)")


            }

            SplashScreen()
                .opacity(showSplash ? 1 : 0)
                .onAppear() {
                    self.retireSplashScreen()
            }
        }
    }



    fileprivate func retireSplashScreen() {
        let deadline: DispatchTime = .now() + 3

        DispatchQueue.main.asyncAfter(deadline: deadline) {
            SplashScreen.shouldAnimate = false

            withAnimation(Animation.easeOut(duration: 2)) {
                self.showSplash = false
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
