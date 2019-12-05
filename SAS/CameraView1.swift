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
         let rwing = rw_subScene.rootNode.childNode(withName: "shipMesh", recursively: true)!
         rwing.name = "rwing"
        
         let lw_subScene = SCNScene(named: "art.scnassets/lwing.scn")!
         let lwing = lw_subScene.rootNode.childNode(withName: "shipMesh", recursively: true)!
         lwing.name = "lwing"
         
         let rf_subScene = SCNScene(named: "art.scnassets/rfin.scn")!
         let rfin = rf_subScene.rootNode.childNode(withName: "shipMesh", recursively: true)!
         rfin.name = "rfin"
        
         let lf_subScene = SCNScene(named: "art.scnassets/lfin.scn")!
         let lfin = lf_subScene.rootNode.childNode(withName: "shipMesh", recursively: true)!
         lfin.name = "lfin"
        
         //BEGIN code with citation - how to position things code
         // https://blog.markdaws.net/arkit-by-example-part1-7830677ef84d
         rwing.position = SCNVector3Make(0.3, 0.1, -1.0);
         lwing.position = SCNVector3Make(0.3, 0.1, -1.0);
         rfin.position = SCNVector3Make(0, 0.2, -1.5);
         lfin.position = SCNVector3Make(0.2, 0.2, -1.5);
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
     }
    
     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         sceneView.debugOptions = ARSCNDebugOptions.showFeaturePoints
         let configuration = ARWorldTrackingConfiguration()
         configuration.planeDetection = .horizontal
         sceneView.session.run(configuration)
     }
    
 }
//END CODE with citation - basic setup




