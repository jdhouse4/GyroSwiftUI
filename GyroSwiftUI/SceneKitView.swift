//
//  SceneKitView.swift
//  GyroSwiftUI
//
//  Created by James Hillhouse IV on 1/6/20.
//  Copyright © 2020 PortableFrontier. All rights reserved.
//

import SwiftUI
import SceneKit
import SpriteKit




struct SceneKitView: UIViewRepresentable {
    @ObservedObject var motion: MotionManager = MotionManager()


    func makeCoordinator() -> Coordinator {
        return Coordinator(self, lightSwitch: $lightSwitch, sunlightSwitch: $sunlightSwitch)
    }


    @Binding var lightSwitch: Bool
    @Binding var sunlightSwitch: Int
    @Binding var spacecraftCameraSwitch: Bool


    // SceneKit Properties
    let scene = SCNScene(named: "GyroSwiftUI.scnassets/Orion_CSM.scn")!

    //var orionCSMNode: SCNNode = SCNNode()

    //var sunlightNode: SCNNode = SCNNode()

    var lightTextNode: SKLabelNode = SKLabelNode(fontNamed: "HelveticaNeue")

    //var overlayScene: SKScene = SKScene()



    func makeUIView(context: Context) -> SCNView {
        print("makeUIView")

        
        // retrieve the SCNView
        let scnView = SCNView()

        // configure the view
        scnView.backgroundColor = UIColor.black

        // WorldCamera from scn file.
        if let exteriorCameraNode = scene.rootNode.childNode(withName: "OrionCommanderCameraNode", recursively: true) {
            print("Found OrionCommanderCameraNode")
            scnView.pointOfView = exteriorCameraNode
        }
        else { print("Couldn't find OrionChase360CameraNode") }

        //scnView.pointOfView = scene.rootNode.childNode(withName: "OrionCommanderCameraNode", recursively: true)


        // Create Node
        //orionCSMNode = scene.rootNode.childNode(withName: "Orion_CSM", recursively: true)!

        // Now, using WorldLight from scn file.
        //let sunlight  = scene.rootNode.childNode(withName: "SunLight", recursively: true)!

        // This code is needed for placing the overlay text.
        //let screenSize: CGSize =  UIScreen.main.bounds.size

        // Find the center of the screen
        //let screenCenter: CGPoint = CGPoint(x: screenSize.width/2, y: screenSize.height/2)

        /*
        // Give the overlayScene property a size.
        overlayScene.size = CGSize(width: screenSize.width, height: screenSize.height)


        // Add-in SKLabelNode for the light currently in use
        lightTextNode.name = "SunlightTypeTextNode"
        lightTextNode.text = worldLight.light!.type.rawValue
        lightTextNode.fontSize = 30
        lightTextNode.fontColor = .white
        lightTextNode.position = CGPoint(x: screenCenter.x, y:  50)
        overlayScene.addChild(lightTextNode)

        scnView.overlaySKScene = overlayScene
        */

        // Double-Tap Gesture Recognizer to Reset Orientation of the Model
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.triggerDoubleTapAction(gestureReconizer:)))
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        scnView.addGestureRecognizer(doubleTapGestureRecognizer)


        let panGestureRecognizer = UIPanGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.panGesture(_:)))
        scnView.addGestureRecognizer(panGestureRecognizer)

        return scnView
    }



    func updateUIView(_ scnView: SCNView, context: Context) {
        //print("updateUIView")
        // set the scene to the view
        scnView.scene = scene

        scnView.backgroundColor     = UIColor.black

        scnView.allowsCameraControl = false

        // show statistics such as fps and timing information
        scnView.showsStatistics     = true

        //toggleBuzzFaceLamp(scnView)

        toggleSunlight(scnView)

        toggleSpacecraftCamera(scnView)

        print("Motion Manager: \(motion.motionQuaternion.debugDescription)")


        if scnView.pointOfView == scnView.scene?.rootNode.childNode(withName: "OrionCommanderCameraNode", recursively: true) {
            print("We're moving with device motion.")
            moveCameraWithDeviceMotion(scnView)
        }
    }


    /*
    func toggleBuzzFaceLamp(_ scnView: SCNView) {
        guard let lightNode = scnView.scene!.rootNode.childNode(withName: "BuzzFaceLight", recursively: true) else { return }

        lightNode.isHidden = lightSwitch
    }
    */


    func toggleSunlight(_ scnView: SCNView) {
        guard let worldLight = scnView.scene!.rootNode.childNode(withName: "SunLight", recursively: true) else { return }

        switch sunlightSwitch {
        case 0:
            worldLight.light?.type = .directional
            lightTextNode.text = worldLight.light?.type.rawValue
        case 1:
            worldLight.light?.type = .spot
            lightTextNode.text = worldLight.light?.type.rawValue
        case 2:
            worldLight.light?.type = .omni
            lightTextNode.text = worldLight.light?.type.rawValue
        case 3:
            worldLight.light?.type = .ambient
            lightTextNode.text = worldLight.light?.type.rawValue
        default:
            worldLight.light?.type = .directional
            lightTextNode.text = worldLight.light?.type.rawValue
        }
    }



    func toggleSpacecraftCamera(_ scnView: SCNView) {
        if spacecraftCameraSwitch == true {
            scnView.pointOfView = scnView.scene?.rootNode.childNode(withName: "OrionCommanderCameraNode", recursively: true)
            motion.resetReferenceFrame()
        } else {
            scnView.pointOfView = scnView.scene?.rootNode.childNode(withName: "OrionChase360CameraNode", recursively: true)
        }
    }



    func moveCameraWithDeviceMotion(_ scnView: SCNView) {
        if scnView.pointOfView == scnView.scene?.rootNode.childNode(withName: "OrionCommanderCameraNode", recursively: true)
        {
            //let reference                        = motion.referenceFrame // This is a CMAttitude! Converet!!!
            var cmdrCameraQuaternion             = motion.motionQuaternion
            //cmdrCameraQuaternion                 = simd_mul(cmdrCameraQuaternion, reference.simdOrientation).normalized


            let commanderCameraNode              = scnView.scene?.rootNode.childNode(withName: "OrionCommanderCameraNode", recursively: true)
            /*commanderCameraNode?.simdOrientation = simd_quatf(angle: -.pi / 2.0,
                                                                axis: simd_normalize(simd_float3(x: 0, y: 1, z: 0))).normalized*/

            commanderCameraNode?.simdOrientation = simd_quatf(angle: -.pi / 2.0,
                                                                axis: simd_normalize(simd_float3(x: 0, y: 1, z: 0))).normalized

            commanderCameraNode!.simdOrientation  = simd_mul(commanderCameraNode!.simdOrientation, cmdrCameraQuaternion).normalized
        }
    }




    class Coordinator: NSObject {

        @Binding var lightSwitch: Bool
        @Binding var sunlightSwitch: Int

        var scnView: SceneKitView

        init(_ scnView: SceneKitView, lightSwitch: Binding<Bool>, sunlightSwitch: Binding<Int>) {
            self.scnView = scnView
            self._lightSwitch = lightSwitch
            self._sunlightSwitch = sunlightSwitch
        }


        // Double-Tap Action
        @objc func triggerDoubleTapAction(gestureReconizer: UITapGestureRecognizer) {
            //print("Just double-tapped")
            guard let spacecraftNode = self.scnView.scene.rootNode.childNode(withName: "Orion_CSM", recursively: true) else{
                print("There's no Spacecraft Node!")
                return
            }
            print("spacecraftNode: \(String(describing: spacecraftNode.name))")

            let currentPivot = spacecraftNode.pivot

            let changePivot = SCNMatrix4Invert( totalChangePivot )

            spacecraftNode.pivot = SCNMatrix4Mult(changePivot, currentPivot)
        }



        // Pan Action
        var initialCenter = CGPoint()  // The initial center point of the view.


        /*@objc func panPiece(_ gestureRecognizer : UIPanGestureRecognizer) {
            guard gestureRecognizer.view != nil else {return}

            print("More panning...")
            
            let piece = gestureRecognizer.view!

            // Get the changes in the X and Y directions relative to the superview's coordinate space.
            let translation = gestureRecognizer.translation(in: piece.superview)

            if gestureRecognizer.state == .began {

                // Save the view's original position.
              self.initialCenter = piece.center
            }

            // Update the position for the .began, .changed, and .ended states
            if gestureRecognizer.state != .cancelled {
              // Add the X and Y translation to the view's original position.
              let newCenter = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y + translation.y)
              piece.center = newCenter
            }
           else {
              // On cancellation, return the piece to its original location.
              piece.center = initialCenter
           }
        }*/

        var totalChangePivot = SCNMatrix4Identity


        @objc func panGesture(_ gestureRecognize: UIPanGestureRecognizer){

            //print("Panning...")
            let translation = gestureRecognize.translation(in: gestureRecognize.view!)

            let x = Float(translation.x)
            let y = Float(-translation.y)

            let anglePan = sqrt(pow(x,2)+pow(y,2))*(Float)(Double.pi)/180.0

            guard let spacecraftNode = self.scnView.scene.rootNode.childNode(withName: "Orion_CSM", recursively: true) else{
                print("There's no Spacecraft Node!")
                return
            }
            //print("spacecraftNode: \(String(describing: spacecraftNode.name))")

            var rotationVector = spacecraftNode.rotation // SCNVector4()
            rotationVector.x = -y
            rotationVector.y = x
            rotationVector.z = 0
            rotationVector.w = anglePan

            spacecraftNode.rotation = rotationVector

            if(gestureRecognize.state == UIGestureRecognizer.State.ended) {

                let currentPivot            = spacecraftNode.pivot
                let changePivot             = SCNMatrix4Invert( spacecraftNode.transform)

                totalChangePivot            = SCNMatrix4Mult(changePivot, currentPivot)
                spacecraftNode.pivot        = SCNMatrix4Mult(changePivot, currentPivot)

                spacecraftNode.transform    = SCNMatrix4Identity
            }
        }
    }
}
