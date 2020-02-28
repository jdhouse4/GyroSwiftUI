//
//  CameraButton.swift
//  BuzzWithSwiftUI
//
//  Created by James Hillhouse IV on 12/14/19.
//  Copyright © 2019 PortableFrontier. All rights reserved.
//

import SwiftUI

struct CameraButton: View {
    @Binding var bodyCameraSwitch: Bool

    var body: some View {
        Button(action: {
            withAnimation{ self.bodyCameraSwitch.toggle() }
        }) {
            Image("Cameras")
                .imageScale(.small)
                .background(Color.init(red: 0.5, green: 0.5, blue: 0.5, opacity: 0.4))
                .cornerRadius(.infinity)
        }

    }
}




/*
struct CameraButton_Previews: PreviewProvider {
    static var previews: some View {
        CameraButton()
    }
}
*/
