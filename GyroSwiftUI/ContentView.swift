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
                .opacity(retireSplash ? 0 : 1)
                //.hidden()
                .onAppear() {
                    if self.retireSplash {
                        print("SplashScreen retired.")
                    }
                    //self.retireSplashScreen()
            }



            if self.retireSplash {
                VStack {

                    //Spacer()

                    Text("Orion In SwiftUI")
                        //.fixedSize()
                        .font(.headline)

                    //Spacer()


                    SceneKitView(lightSwitch: $lightSwitch,
                                 sunlightSwitch: $sunlightSwitch,
                                 spacecraftCameraSwitch: $spacecraftCameraSwitch)
                        .scaleEffect(0.95, anchor: .top)


                    //Spacer()

                    ControlsView(lightSwitch: $lightSwitch, sunlightSwitch: $sunlightSwitch, bodyCameraSwitch: $spacecraftCameraSwitch)

                    Text("Motion Data")
                    //Text("quaternion: \(motion.motionQuaternion.debugDescription)")


                }
            }


            /*
            SplashScreen()
                .opacity(showSplash ? 1 : 0)
                .onAppear() {
                    self.retireSplashScreen()
            }
            */
        }
    }


    /*
    fileprivate func retireSplashScreen() {
        /*
        if animationComplete == true {
            print("Animation completed, so now time to fade-out the splash screen.")
            let deadline: DispatchTime = .now() + 1

            DispatchQueue.main.asyncAfter(deadline: deadline) {
                SplashScreen.shouldAnimate = false

                withAnimation(Animation.easeOut(duration: 2)) {
                    self.showSplash = false
                }
            }
        }
        */
        /*
        let deadline: DispatchTime = .now() + 3

        DispatchQueue.main.asyncAfter(deadline: deadline) {
            SplashScreen.shouldAnimate = false

            withAnimation(Animation.easeIn(duration: 1.0)) {
                self.showSplash = false
            }
        }
        */
        /*
        let deadline: DispatchTime = .now() + 3

        DispatchQueue.main.asyncAfter(deadline: deadline) {
            SplashScreen.shouldAnimate = false

            withAnimation(Animation.easeIn(duration: 1.0)) {
                self.retireSplash = true
            }
        }
        */
    }
    */
}



/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //ContentView(motion: MotionManager())
        ControlsView()
    }
}
 */

