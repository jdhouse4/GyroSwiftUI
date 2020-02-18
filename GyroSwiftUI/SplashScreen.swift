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

    static var shouldAnimate            = true

    let launchCenterBlue                = Color("LaunchCenterBlue")

    let textZoomFactor: CGFloat         = 1.4
    let rocketZoomFactor: CGFloat       = 0.35

    @State var lineScale: CGFloat       = 1
    @State var textAlpha                = 0.5
    @State var textScale: CGFloat       = 1

    @State var rocketScale: CGFloat     = 0.0
    @State var rocketAlpha              = 0.0
    @State var rocketPosition: CGFloat  = -18.0




    var body: some View {
        ZStack {
            /*
            Image("Rocket")
                .resizable(resizingMode: .tile)
                .opacity(textAlpha)
                .scaleEffect(textScale)

            Circle()
                .fill(launchCenterBlue)
                .frame(width: 1, height: 1, alignment: .center)
                .scaleEffect(rocketScale)
                .opacity(rocketAlpha)

            */
            Image("Rocket")
                .resizable(resizingMode: .stretch)
                .opacity(rocketAlpha)
                .scaleEffect(rocketScale)
                .offset(x:0, y: rocketPosition)


            Text("Launch      Center")
                .font(.largeTitle)
                .foregroundColor(.white)
                .opacity(textAlpha)
                .offset(x: -5, y: 0)
                .scaleEffect(textScale)

            /*
            Image("Rocket")
                .resizable(resizingMode: .tile)
                .opacity(textAlpha)
                .scaleEffect(textScale)
            */

            /*
            Rectangle()
                .fill(squareColor)
                .scaleEffect(squareScale * uZoomFactor)
                .frame(width: uSquareLength, height: uSquareLength, alignment: .center)
                .onAppear() {
                    self.squareColor = Color.blue
            }



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
    var animationDuration: Double { return 1.5 }
    var animationDelay: Double { return 0.2 }
    var rocketLiftOffAnimationDuration: Double { return 2.0 }
    var exitAnimationDuration: Double { return 0.3 }
    var finalAnimationDuration: Double { return 0.4 }
    var minAnimationInterval: Double { return 0.1 }
    var fadeAnimationDuration: Double { return 2.0 }



    func handleAnimations () {
        runAnimationPart1()
        runAnimationPart2()
        //runAnimationPart3()
        finishAnmation()
        //restartAnimation()
    }



    func runAnimationPart1() {
        print("runAnimationPart1")

        withAnimation(.easeIn(duration: animationDuration)) {
            textAlpha   = 1.0
            rocketAlpha = 1.0
            rocketScale = 0.1
        }
        /*
        withAnimation(Animation.easeIn(duration: animationDuration).delay(0.2)) {
            textAlpha   = 1.0
            rocketAlpha = 1.0
        }
        */
        let deadline: DispatchTime = .now() + animationDuration + animationDelay

        DispatchQueue.main.asyncAfter(deadline: deadline) {
            withAnimation(Animation.spring()) {
                self.textScale      = self.textZoomFactor
                self.rocketScale    = self.rocketZoomFactor
            }
        }
    }



    func runAnimationPart2() {
        print("runAnimationPart2")
        let deadline: DispatchTime = .now() + animationDuration + animationDelay + minAnimationInterval

        DispatchQueue.main.asyncAfter(deadline: deadline) {
            /*
            withAnimation(Animation.easeIn(duration: self.animationDelay)) {
                self.rocketAlpha = 1
                //self.rocketPosition = -500.0
                print("Rocket blasting-off")
            }
            */
            withAnimation(Animation.easeOut(duration: self.rocketLiftOffAnimationDuration)) {
                self.rocketPosition = -800.0
                //print("Animation Completed!")
            }
        }
    }



    func runAnimationPart3() {
        let deadline: DispatchTime = .now() + 2 * animationDuration

        DispatchQueue.main.asyncAfter(deadline: deadline) {
            withAnimation(.easeIn(duration: self.finalAnimationDuration)) {
                self.animationComplete = true
                print("Animation Completed!")
            }
        }
    }

    

    func finishAnmation() {
        let deadline: DispatchTime = .now() + 2 * animationDuration

        DispatchQueue.main.asyncAfter(deadline: deadline) {
            withAnimation(Animation.easeOut(duration: self.fadeAnimationDuration)) {
                self.animationComplete = true
                print("Animation Completed!")
            }
            //self.animationComplete = true
            //print("Animation Completed!")
            print("That's all, folks!")
        }
    }



    func restartAnimation() {
        let deadline: DispatchTime = .now() + 2 * animationDuration + finalAnimationDuration

        DispatchQueue.main.asyncAfter(deadline: deadline) {
            self.textScale     = 1
            self.rocketAlpha   = 0
            self.rocketScale   = 1
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
