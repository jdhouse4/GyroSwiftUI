//
//  MotionManager.swift
//  GyroSwiftUI
//
//  Created by James Hillhouse IV on 1/6/20.
//  Copyright © 2020 PortableFrontier. All rights reserved.
//

import Foundation
import Combine
import CoreMotion
import simd



class MotionManager: ObservableObject {
    private var motionManager: CMMotionManager

    @Published var motionQuaternion: simd_quatf = simd_quatf()

    var referenceFrame:     CMAttitude?
    var motionTimer: Timer?




    init() {
        self.motionManager = CMMotionManager()
        self.startDeviceMotion()
    }



    func startDeviceMotion() {
        if motionManager.isDeviceMotionAvailable {
            self.motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
            self.motionManager.startDeviceMotionUpdates()

            self.motionTimer = Timer(fire: Date(), interval: (1.0 / 60.0), repeats: true,
                                     block: { (motionTimer) in
                                        if let deviceMotion = self.motionManager.deviceMotion {
                                            self.referenceFrame     = deviceMotion.attitude
                                            let deviceQ             = deviceMotion.attitude.quaternion
                                            self.motionQuaternion   = simd_quatf(ix: Float(deviceQ.x), iy: Float(deviceQ.y), iz: Float(deviceQ.z), r: Float(deviceQ.w))
                                        }
            })

            // Add the timer to the current run loop.
            RunLoop.current.add(self.motionTimer!, forMode: RunLoop.Mode.default)
        }
    }



    func startContinuousDeviceMotion() {
        if motionManager.isDeviceMotionAvailable {
            self.motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
            //self.motionManager.showsDeviceMovementDisplay = true


            self.motionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: {
                myDeviceMotion, error in
                if let deviceMotion         = myDeviceMotion {
                    self.referenceFrame     = deviceMotion.attitude
                    let deviceQ             = deviceMotion.attitude.quaternion
                    self.motionQuaternion   = simd_quatf(ix: Float(deviceQ.x), iy: Float(deviceQ.y), iz: Float(deviceQ.z), r: Float(deviceQ.w))
                }
            })
        }
    }



    func stopMotion()
    {
        motionManager.stopDeviceMotionUpdates()
    }



    func resetReferenceFrame()
    {
        print("resetReferenceFrame")

        if motionManager.isDeviceMotionActive
        {
            referenceFrame          = motionManager.deviceMotion!.attitude
        }
    }
}
