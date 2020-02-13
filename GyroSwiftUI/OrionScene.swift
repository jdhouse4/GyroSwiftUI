//
//  OrionScene.swift
//  GyroSwiftUI
//
//  Created by James Hillhouse IV on 2/12/20.
//  Copyright © 2020 PortableFrontier. All rights reserved.
//

import SceneKit
import SwiftUI



class OrionScene: SCNScene, SCNSceneRendererDelegate {
    @ObservedObject var motion: MotionManager = MotionManager()

    var orionCSMScene: SCNScene?
    var orionCSMNode: SCNNode               = SCNNode()
    var orionCameraNodesArray               = [SCNNode]()
    var orionExteriorCamerasNode: SCNNode   = SCNNode()
    var orionInteriorCamerasNode: SCNNode   = SCNNode()
    var chase360CameraNode: SCNNode         = SCNNode()
    var commanderCameraNode: SCNNode        = SCNNode()

    var _previousUpdateTime: TimeInterval   = 0.0
    var _deltaTime: TimeInterval            = 0.0

    var gyroReset: Bool                     = false

    //var cameraType: CameraType              = CameraType.OrionChase360Camera
    var cameraChange: Bool                  = true


    override init()
    {
        print("OrionScene object initialized.")

        //
        // MARK: Create an instance of missionOrionSharedMotionMangerInstance.
        //
        //self.missionOrionMotionManager  = PFMotionManager.missionOrionSharedMotionMangerInstance
        //self.sceneQuaternion            = self.missionOrionMotionManager.sceneQuaternion


        super.init()

        orionCSMScene = SCNScene(named: "GyroSwiftUI.scnassets/Orion_CSM.scn")!


        //
        // MARK: Create the Orion Node
        //
        orionCSMNode            = orionCSMScene!.rootNode.childNode(withName: "Orion_CSM", recursively: true)!


        //
        // MARK: Create the Orion Cameras Nodes
        //
        //orionExteriorCamerasNode        = rootNode.childNode(withName: "OrionExteriorCamerasNode", recursively: true)!
        //orionInteriorCamerasNode        = rootNode.childNode(withName: "OrionInteriorCamerasNode", recursively: true)!


        //
        // MARK: Fill-in Camera Nodes Array
        //
        orionCameraNodesArray   = rootNode.childNodes(passingTest: {(node, stop) in
            return node.camera?.name    != nil
        })


        //
        // MARK: Set Chase360CameraNode and CommanderCameraNode
        //
        chase360CameraNode          = orionCSMScene!.rootNode.childNode(withName: "OrionChase360CameraNode", recursively: true)!
        //: Maybe set camera quaternion here?

        commanderCameraNode         = orionCSMScene!.rootNode.childNode(withName: "OrionCommanderCameraNode", recursively: true)!
        commanderCameraNode.pivot   = SCNMatrix4MakeTranslation(0.0, -0.075, 0.0) // The camera's 'neck'
    }



    required init?(coder aDecoder: NSCoder)
    {
        print("OrionScene init?(coder aDecoder: NSCoder)")

        print("Going to instantiate an Orion Scene and later set it as a rootNode.")
        /*
        self.missionOrionMotionManager  = PFMotionManager.missionOrionSharedMotionMangerInstance
        self.sceneQuaternion            = self.missionOrionMotionManager.sceneQuaternion
        self.orionSimLevel              = PFOrionSimulationLevel()
        self.orionSimLevelNode          = self.orionSimLevel.createLevelNodes()
        */
        super.init(coder: aDecoder)
    }



    // MARK:- Rendering Properties
    var renderCountdownInt: Int         = 0
    var tempInitStateArray: [Float]     = []



    /*:
    // MARK:- SCNSceneRendererDelegate functions
    */
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval)
    {

        // The main input pump for the simulator.

        if _previousUpdateTime == 0.0
        {
            _previousUpdateTime     = time
        }


        _deltaTime                  = time - _previousUpdateTime
        _previousUpdateTime         = time


        //
        // Going to take inputs from the a PFSceneView reference type instance
        //
        //let aSceneView = renderer as! SceneKitView


        //
        // MARK: Update the attitude.quaternion from device manager
        //
        motion.updateAttitude()
    }



    @objc func changeCamera() {
        print("Change Camera in Orion Scene")
    }
}
