//
//  MotionControlsView.swift
//  GyroSwiftUI
//
//  Created by James Hillhouse IV on 1/6/20.
//  Copyright © 2020 PortableFrontier. All rights reserved.
//

import SwiftUI

struct MotionControlsView: View {

    @Binding var spacecraftCameraSwitch: Bool



    var body: some View {
        VStack {
            HStack {
                Spacer()

                //CameraButton(spacecraftCameraSwitch: $spacecraftCameraSwitch)

                Spacer(minLength: 150)
            }

            HStack {
                Spacer()


                Spacer()
            }
        }
    }
}



    /*
    struct ControlsView_Previews: PreviewProvider {
        static var previews: some View {
            ControlsView(lightSwitch: lightSwitch, sunlightSwitch: sunlightSwitch, spacecraftCameraSwitch: buzzBodyCamera)
        }
    }
    */
