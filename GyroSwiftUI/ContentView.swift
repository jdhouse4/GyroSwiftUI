//
//  ContentView.swift
//  GyroSwiftUI
//
//  Created by James Hillhouse IV on 1/6/20.
//  Copyright © 2020 PortableFrontier. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var motion: MotionManager


    var body: some View {
        VStack {
            Text("Motion Data")
            Text("quaternion: \(motion.motionQuaternion.debugDescription)")

            
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(motion: MotionManager())
    }
}
