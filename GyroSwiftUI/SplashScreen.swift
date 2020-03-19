//
//  SplashScreen.swift
//  Fuber
//
//  Created by James Hillhouse IV on 1/23/20.
//  Copyright © 2020 PortableFrontier. All rights reserved.
//

import SwiftUI

struct SplashScreen: View {
    @Binding var animationComplete: Bool

    static var shouldAnimate                = true

    let launchCenterBlue                    = Color("LaunchCenterBlue")

    let textZoomFactor: CGFloat             = 1.5
    let gyroZoomFactor: CGFloat           = 0.4

    @State var textAlpha                    = 0.0
    @State var textScale: CGFloat           = 0.0
    @State var leftTextPos: CGFloat         = 0.0
    @State var rightTextPos: CGFloat        = 0.0

    @State var gyroScale: CGFloat         = 0.0
    @State var gyroAlpha: Double          = 0.0




    var body: some View {
        ZStack {
            Image("Gyro")
                .opacity(gyroAlpha)
                .scaleEffect(gyroScale)
                .offset(x:0, y: 0)



            Text("Gyro")
                .font(.largeTitle)
                .foregroundColor(.white)
                .opacity(textAlpha)
                .offset(x: leftTextPos, y: 0)
                .scaleEffect(textScale)



            Text("SwiftUI")
                .font(.largeTitle)
                .foregroundColor(.white)
                .opacity(textAlpha)
                .offset(x: rightTextPos, y: 0.0)
                .scaleEffect(textScale)

            /*
            Rectangle()
                .fill(launchCenterBlue)
                .scaleEffect(lineScale, anchor: .bottom)
                .frame(width: lineWidth, height: lineHeight, alignment: .center)
                .offset(x: 0, y: -22)
            */

            Spacer()

        }
        .frame(minWidth: 0, maxWidth: .infinity,
               minHeight: 0, maxHeight: .infinity)
        .background(launchCenterBlue)
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            self.handleAnimations()
        }
    }
}



extension SplashScreen {
    var animationDuration: Double { return 1.0 }
    var animationBounceDuration: Double { 0.1 }
    var animationDelay: Double { return 0.2 }
    var textAppearsAnimationDuration: Double { 0.6 }
    var textFadesAnimationDuration: Double { 1.5 }
    var rocketLiftOffAnimationDuration: Double { return 2.0 }
    var exitAnimationDuration: Double { return 0.3 }
    var finalAnimationDuration: Double { return 0.4 }
    var minAnimationInterval: Double { return 0.1 }
    var fadeAnimationDuration: Double { return 1.5 }



    func handleAnimations () {
        runGyroAppearsAnimation()
        runTextAppearsAnimation()
        runTextAndGyroFadeAnimation()
        finishAnmation()
    }



    func runGyroAppearsAnimation() {
        print("runGyroAppearsAnimation")

        let deadline: DispatchTime = .now()

        DispatchQueue.main.asyncAfter(deadline: deadline) {

            withAnimation(Animation.easeIn(duration: self.animationDelay)) {
                self.gyroAlpha = 1.0
                self.gyroScale = 1.0
            }
        }
    }



    func runTextAppearsAnimation() {
        print("runTextAppearsAnimation")

        let deadline: DispatchTime = .now() + textAppearsAnimationDuration

        DispatchQueue.main.asyncAfter(deadline: deadline) {

            withAnimation(Animation.easeIn(duration: self.animationDelay)) {
                self.textAlpha      = 1.0
                self.textScale      = 1.0

                self.leftTextPos    = -75.0
                self.rightTextPos   =  90.0
            }
        }
    }



    func runTextAndGyroFadeAnimation() {
        print("runTextAppearsAnimation")

        let deadline: DispatchTime = .now() + textAppearsAnimationDuration + textFadesAnimationDuration + minAnimationInterval

        DispatchQueue.main.asyncAfter(deadline: deadline) {

            withAnimation(Animation.easeIn(duration: self.textFadesAnimationDuration)) {
                self.textAlpha      = 0.0
                //self.textScale      = 0.0

                //self.gyroScale      = 0.0
                self.gyroAlpha      = 0.0
            }
        }
    }




    func finishAnmation() {
        let deadline: DispatchTime = .now() + animationDuration + textAppearsAnimationDuration + textFadesAnimationDuration + minAnimationInterval

        DispatchQueue.main.asyncAfter(deadline: deadline) {
            withAnimation(Animation.easeOut(duration: self.fadeAnimationDuration)) {
                self.animationComplete  = true
                print("Animation Completed!")
            }
            print("That's all, folks!")
        }
    }



    func restartAnimation() {
        let deadline: DispatchTime = .now() + 10 * animationDuration + finalAnimationDuration

        DispatchQueue.main.asyncAfter(deadline: deadline) {
            self.textScale   = 1
            self.gyroAlpha   = 0
            self.gyroScale   = 0.1
            self.handleAnimations()
        }
    }
}


/*
struct LaunchCenterRocket: Shape {
    var percent: Double


    func path(in rect: CGRect) -> Path {
        let end = percent * 360
        var path   = Path()

        path.addArc(center: CGPoint(x: rect.size.width / 2, y: rect.size.width / 2),
                    radius: rect.size.width / 2,
                    startAngle: Angle(degrees: 0),
                    endAngle: Angle(degrees: end),
                    clockwise: false)

        return path
    }


    var animatableData: Double {
      get { return percent }
      set { percent = newValue }
    }
}
*/

/*
#if DEBUG
struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen(animationComplete: true)
    }
}
#endif
*/
