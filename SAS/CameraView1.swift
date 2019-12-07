//
//  CameraView1.swift
//  SAS
//
//  Created by Lauren Saxton on 11/16/19.
//  Copyright © 2019 Lauren Saxton. All rights reserved.
//

// citation for the view controller -> adding a ARSCNView on it (not code, but storyboard)
//https://stackoverflow.com/questions/39629926/ios-can-i-integrate-scenekit-or-spritekit-with-single-view-application

import UIKit
import SceneKit
import ARKit

// BEGIN CODE with citation
//code citation for line class definition only
//https://stackoverflow.com/questions/45342327/how-to-add-arkit-in-single-view-application
class CameraView1: UIViewController, ARSCNViewDelegate {
//END CODE with citation

var empty_node = SCNNode()
var current_node = SCNNode()
var rwing = SCNNode()
var lwing = SCNNode()
var rfin = SCNNode()
var lfin = SCNNode()

//BEGIN code with citation - text node
// https://stackoverflow.com/questions/35733916/changing-the-value-of-string-on-scntext-produces-no-change
//AND
// https://stackoverflow.com/questions/50591866/how-to-point-and-position-arkit-text
let textNode = SCNNode()
var textGeometry = SCNText(string: "Target is None", extrusionDepth: 1)
//BEGIN code with citation - text node
    
    
// BEGIN CODE with citation - basic setup
// code citation for all lines from here to end of "viewWillAppear", unless otherwise marked
// citation: https://stackoverflow.com/questions/47007614/add-arscnview-programmatically
 let sceneView = ARSCNView(frame: UIScreen.main.bounds)

     override func viewDidLoad() {
         super.viewDidLoad()

         self.view.addSubview(sceneView)
         sceneView.delegate = self
         let scene = SCNScene(named: "art.scnassets/body.scn")!
         sceneView.scene = scene
         
         //BEGIN CODE with citation - multiple scenes
         //for adding multiple scns
         // https://stackoverflow.com/questions/28655395/scenekit-display-multiple-scenes-in-same-scnview
         
         let rw_subScene = SCNScene(named: "art.scnassets/rwing.scn")!
         rwing = rw_subScene.rootNode.childNode(withName: "rwing", recursively: true)!
        
         let lw_subScene = SCNScene(named: "art.scnassets/lwing.scn")!
         lwing = lw_subScene.rootNode.childNode(withName: "lwing", recursively: true)!
         
         let rf_subScene = SCNScene(named: "art.scnassets/rfin.scn")!
         rfin = rf_subScene.rootNode.childNode(withName: "rfin", recursively: true)!
        
         let lf_subScene = SCNScene(named: "art.scnassets/lfin.scn")!
         lfin = lf_subScene.rootNode.childNode(withName: "lfin", recursively: true)!
        
         //BEGIN code with citation - naming nodes
         // https://mobile-ar.reality.news/how-to/arkit-101-pilot-your-3d-plane-location-using-hittest-arkit-0184060/
         rwing.name = "rwing"
         lwing.name = "lwing"
         rfin.name = "rfin"
         lfin.name = "lfin"
         //END code with citation - naming nodes
        
         //BEGIN code with citation - how to position things code
         // https://blog.markdaws.net/arkit-by-example-part1-7830677ef84d
         rwing.position = SCNVector3Make(0.3, -0.2, -1.0);
         lwing.position = SCNVector3Make(0.3, -0.2, -1.0);
         rfin.position = SCNVector3Make(0, -0.2, -1.5);
         lfin.position = SCNVector3Make(0.2, -0.2, -1.5);
         //END CODE with citation - how to position things code
        
         sceneView.scene.rootNode.addChildNode(rwing)
         sceneView.scene.rootNode.addChildNode(lwing)
         sceneView.scene.rootNode.addChildNode(rfin)
         sceneView.scene.rootNode.addChildNode(lfin)
         //END CODE with citation - multiple scenes
        
         //BEGIN code with citation - how to rotate objects
         //https://stackoverflow.com/questions/50368377/rotate-object-in-arkit
         lfin.eulerAngles.x = 90
         rfin.eulerAngles.x = 90
         lwing.eulerAngles.x = -99
         rwing.eulerAngles.x = -99
         // END code - how to rotate objects
        
        //BEGIN code with citation - text node
        // https://stackoverflow.com/questions/35733916/changing-the-value-of-string-on-scntext-produces-no-change
         //AND
         // https://stackoverflow.com/questions/50591866/how-to-point-and-position-arkit-text
         textGeometry.font = UIFont(name: "Helvatica", size: 1)
         textGeometry.flatness = 0
         textGeometry.firstMaterial?.diffuse.contents = UIColor.white
         textNode.geometry = textGeometry
         let min = textNode.boundingBox.min
         let max = textNode.boundingBox.max
         textNode.pivot = SCNMatrix4MakeTranslation(
             min.x + (max.x - min.x)/2,
             min.y + (max.y - min.y)/2,
             min.z + (max.z - min.z)/2
         )
         textNode.scale = SCNVector3(0.005, 0.005 , 0.005)
         sceneView.scene.rootNode.addChildNode(textNode)
         textNode.position = SCNVector3Make(0.5, -1.0, -2.0);
        
         let textNode2 = SCNNode()
         let textGeometry2 = SCNText(string: "I'm done!", extrusionDepth: 1)
         textGeometry2.font = UIFont(name: "Helvatica", size: 1)
         textGeometry2.flatness = 0
         textGeometry2.firstMaterial?.diffuse.contents = UIColor.red
         textNode2.geometry = textGeometry2
         let min2 = textNode2.boundingBox.min
         let max2 = textNode2.boundingBox.max
         textNode.pivot = SCNMatrix4MakeTranslation(
             min2.x + (max2.x - min2.x)/2,
             min2.y + (max2.y - min2.y)/2,
             min2.z + (max2.z - min2.z)/2
         )
         textNode2.scale = SCNVector3(0.005, 0.005 , 0.005)
         textNode2.name = "done"
         sceneView.scene.rootNode.addChildNode(textNode2)
         textNode2.position = SCNVector3Make(-0.5, 0.5, -1.0);
        //END code with citation - text node
     }
    
     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         sceneView.debugOptions = ARSCNDebugOptions.showFeaturePoints
         let configuration = ARWorldTrackingConfiguration()
         configuration.planeDetection = .horizontal
         sceneView.session.run(configuration)
        
         //BEGIN code with citation - UITap and double tapp
         // https://mobile-ar.reality.news/how-to/arkit-101-pilot-your-3d-plane-location-using-hittest-arkit-0184060/
         let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
         sceneView.addGestureRecognizer(gestureRecognizer)
        
         let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
         doubleTapGestureRecognizer.numberOfTapsRequired = 2
         gestureRecognizer.require(toFail: doubleTapGestureRecognizer)

         sceneView.addGestureRecognizer(doubleTapGestureRecognizer)
         //END code with citation - UITap
     }

 //BEGIN code with citation - Tapped, double tapped, and animate functions
 // https://stackoverflow.com/questions/56393370/is-there-anyway-to-identify-the-touched-node-in-arkit
 @objc func tapped(recognizer: UIGestureRecognizer) {
     guard let sceneView = recognizer.view as? SCNView else { return }
     let touchLocation = recognizer.location(in: sceneView)

     let results = sceneView.hitTest(touchLocation, options: [:])
    
    //BEGIN code with citation - for each loops
    // https://www.avanderlee.com/swift/loops-swift/
     for result in results {
        let name = result.node.name
        print(name)
        if name == nil {
            textGeometry = SCNText(string: "Target is None", extrusionDepth: 1)
            textNode.geometry = textGeometry
            continue
        }
        if name == "lwing" || name == "rwing" || name == "rfin" || name == "lfin" {
            current_node = result.node
            textGeometry = SCNText(string: "Target is " + (result.node.name ?? "None") ?? "None", extrusionDepth: 1)
            textNode.geometry = textGeometry
            break
        } else if name == "done" {
            animateAll()
        }
        
    }
    //END code with citation - for each loops
 }
    
    private func animateAll() {
        let rwing_position = SCNVector3Make(0.1, -0.1, -0.8);
        let lwing_position = SCNVector3Make(0, -0.1, -0.8);
        let rfin_position = SCNVector3Make(0, -0.3, -0.8);
        let lfin_position = SCNVector3Make(0, -0.3, -0.8);
        let rwing_action = SCNAction.move(to: rwing_position, duration: 5)
        let lwing_action = SCNAction.move(to: lwing_position, duration: 5)
        let rfin_action = SCNAction.move(to: rfin_position, duration: 5)
        let lfin_action = SCNAction.move(to: lfin_position, duration: 5)
        rwing.runAction(rwing_action)
        lwing.runAction(lwing_action)
        rfin.runAction(rfin_action)
        lfin.runAction(lfin_action)
    }
    
 @objc func doubleTapped(recognizer: UIGestureRecognizer) {
     // Get exact position where touch happened on screen of iPhone (2D coordinate)
     print("In double tap, current node is", current_node.name)
     let touchPosition = recognizer.location(in: sceneView)

     // Conduct hit test on tapped point
     let hitTestResult = sceneView.hitTest(touchPosition, types: .featurePoint)

     guard let hitResult = hitTestResult.first else {
         return
     }
     
     if current_node.name != nil {
        let move_position = SCNVector3(hitResult.worldTransform.columns.3.x,hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)
        animateRockerPiece(to: move_position, node: current_node)
        current_node = empty_node
        textGeometry = SCNText(string: "Target is None", extrusionDepth: 1)
        textNode.geometry = textGeometry
        }
     }
    
    private func animateRockerPiece(to destinationPoint: SCNVector3, node: SCNNode) {
        let action = SCNAction.move(to: destinationPoint, duration: 7)
        node.runAction(action)
    }
 //END code with citation - Tapped, double tapped, and animate functions
    
 }
//END CODE with citation - basic setup




