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

    var referenceFrame: CMAttitude?
    var motionTimer: Timer?
    var deviceMotion: CMDeviceMotion?




    init() {
        print("MotionManager initialized")
        self.motionManager = CMMotionManager()
        self.startDeviceMotion()
        //self.startContinuousDeviceMotion()
    }



    func startDeviceMotion() {
        if motionManager.isDeviceMotionAvailable {
            self.motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
            self.motionManager.startDeviceMotionUpdates()

            self.motionTimer = Timer(fire: Date(), interval: (1.0 / 60.0), repeats: true,
                                     block: { (motionTimer) in
                                        if let tempDeviceMotion = self.motionManager.deviceMotion {
                                            self.deviceMotion       = tempDeviceMotion
                                            self.referenceFrame     = tempDeviceMotion.attitude
                                            let deviceQ             = tempDeviceMotion.attitude.quaternion
                                            self.motionQuaternion   = simd_quatf(ix: Float(deviceQ.x), iy: Float(deviceQ.y), iz: Float(deviceQ.z), r: Float(deviceQ.w))
                                        }
                                        print("deviceMotion: \(String(describing: self.deviceMotion))")
            })

            // Add the timer to the current run loop.
            RunLoop.current.add(self.motionTimer!, forMode: RunLoop.Mode.default)
        }
    }



    func startContinuousDeviceMotion() {
        if motionManager.isDeviceMotionAvailable {
            self.motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
            //self.motionManager.showsDeviceMovementDisplay = true

            /*
            self.motionManager.startDeviceMotionUpdates()

            if let tempDeviceMotion = self.motionManager.deviceMotion {
                self.deviceMotion       = tempDeviceMotion
                self.referenceFrame     = tempDeviceMotion.attitude
                let deviceQ             = tempDeviceMotion.attitude.quaternion
                self.motionQuaternion   = simd_quatf(ix: Float(deviceQ.x), iy: Float(deviceQ.y), iz: Float(deviceQ.z), r: Float(deviceQ.w))
            }
            */


            self.motionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: {
                myDeviceMotion, error in
                if let tempDeviceMotion     = myDeviceMotion {
                    self.deviceMotion       = tempDeviceMotion
                    self.referenceFrame     = tempDeviceMotion.attitude
                    let deviceQ             = tempDeviceMotion.attitude.quaternion
                    self.motionQuaternion   = simd_quatf(ix: Float(deviceQ.x), iy: Float(deviceQ.y), iz: Float(deviceQ.z), r: Float(deviceQ.w)).normalized
                }
                print("dviceMotion: \(String(describing: self.deviceMotion))")
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



    func updateAttitude() {
        referenceFrame      = motionManager.deviceMotion!.attitude

        if motionManager.deviceMotion != nil {
            deviceMotion?.attitude.multiply(byInverseOf: referenceFrame!)

            if deviceMotion?.attitude != nil {
                print("deviceMotion.attitude != nil")

                if deviceMotion?.attitude.quaternion != nil {
                    print("deviceMotion.attitude.quaternion != nil")
                    let deviceQ         = deviceMotion!.attitude.quaternion
                    motionQuaternion    = simd_quatf(ix: Float(deviceQ.x), iy: Float(deviceQ.y), iz: Float(deviceQ.z), r: Float(deviceQ.w)).normalized
                }
            }
        }
    }
}
