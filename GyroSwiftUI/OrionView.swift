//
//  OrionView.swift
//  GyroSwiftUI
//
//  Created by James Hillhouse IV on 2/17/20.
//  Copyright © 2020 PortableFrontier. All rights reserved.
//

import SwiftUI

struct OrionView: View {

    @Binding var lightSwitch: Bool
    @Binding var sunlightSwitch: Int
    @Binding var spacecraftCameraSwitch: Bool


    var body: some View {
        ZStack {
            SceneKitView(lightSwitch: $lightSwitch,
                         sunlightSwitch: $sunlightSwitch,
                         spacecraftCameraSwitch: $spacecraftCameraSwitch)
                .scaleEffect(1.0, anchor: .top)


            VStack {
                Text("Orion In SwiftUI") // This will likely be removed for LaunchCenter implementation.
                    .font(.largeTitle)
                    .foregroundColor(Color.white)

                Spacer()

                ControlsView(lightSwitch: $lightSwitch, sunlightSwitch: $sunlightSwitch, bodyCameraSwitch: $spacecraftCameraSwitch)
            }
        }
        .animation(.easeIn(duration: 2.0))
        .transition(.scale)
    }
}

/*
struct OrionView_Previews: PreviewProvider {
    static var previews: some View {
        OrionView()
    }
}
*/
