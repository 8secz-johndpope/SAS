//
//  MissionImpactLaunchScreen.swift
//  SAS
//
//  Created by Lauren Saxton on 11/16/19.
//  Copyright © 2019 Lauren Saxton. All rights reserved.
//

// citation for the view controller -> adding a ARSCNView on it (not code, but storyboard)
//https://stackoverflow.com/questions/39629926/ios-can-i-integrate-scenekit-or-spritekit-with-single-view-application

//for references on all model objects -> see references.rtf
//the ship is a default asset when starting new Xcode AR projects
//the asteroid is my own creation after studying a few blender tutorials

import UIKit
import SceneKit
import ARKit
// BEGIN CODE with citation
//code citation for line class definition only
//https://stackoverflow.com/questions/45342327/how-to-add-arkit-in-single-view-application
class MissionImpactLaunchScreen: UIViewController, ARSCNViewDelegate {
//END CODE with citation

    var ship = SCNNode()

// BEGIN CODE with citation - basic setup
// code citation for all lines from here to end of "viewWillAppear", unless otherwise marked
// citation: https://stackoverflow.com/questions/47007614/add-arscnview-programmatically
 let sceneView = ARSCNView(frame: UIScreen.main.bounds)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(sceneView)
        sceneView.delegate = self
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        sceneView.scene = scene
        
        //BEGIN CODE with citation - multiple scenes
        //for adding multiple scns
        // https://stackoverflow.com/questions/28655395/scenekit-display-multiple-scenes-in-same-scnview
        ship = scene.rootNode.childNode(withName: "ship", recursively: true)!
        
        let asteroid_subScene = SCNScene(named: "art.scnassets/asteroid.scn")!
        let asteroid = asteroid_subScene.rootNode.childNode(withName: "asteroid", recursively: true)!
        
        //BEGIN code with citation - how to position things code
        // https://blog.markdaws.net/arkit-by-example-part1-7830677ef84d
        asteroid.position = SCNVector3Make(-0.3, 8.0, -2.5)
        //END CODE with citation - how to position things code
        
        sceneView.scene.rootNode.addChildNode(asteroid)
        //END code with citation - multiple scenes
        
        //BEGIN code with citation - how to position things code
        // https://blog.markdaws.net/arkit-by-example-part1-7830677ef84d
        ship.position = SCNVector3Make(-0.3, -0.2, -2.5);
        //END code with citation - how to position things code
        
        //BEGIN code with citation - how to rotate objects
        //https://stackoverflow.com/questions/50368377/rotate-object-in-arkit
        ship.eulerAngles.x = 30
        ship.eulerAngles.y = 90
        
    }
    
    //BEGIN code with citation - configs and debug, tapped, double tapped function
    // https://mobile-ar.reality.news/how-to/arkit-101-launch-your-own-augmented-reality-rocket-into-real-world-skies-0184922/
    override func viewWillAppear(_ animated: Bool) {
     super.viewWillAppear(animated)
     //sceneView.debugOptions = ARSCNDebugOptions.showFeaturePoints
     let configuration = ARWorldTrackingConfiguration()
     configuration.planeDetection = .horizontal
     sceneView.session.run(configuration)
    
     let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
     sceneView.addGestureRecognizer(gestureRecognizer)
     
     let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        
     doubleTapGestureRecognizer.numberOfTapsRequired = 2
     gestureRecognizer.require(toFail: doubleTapGestureRecognizer)
     sceneView.addGestureRecognizer(doubleTapGestureRecognizer)
    }
    
    @objc func tapped(gesture: UITapGestureRecognizer) {
        print("tapped")
    }
    
    @objc func doubleTapped(gesture: UITapGestureRecognizer) {
        print("double tap")
        ship.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        ship.physicsBody?.isAffectedByGravity = false
        ship.physicsBody?.damping = 0.0
        ship.physicsBody?.applyForce(SCNVector3(0,100,0), asImpulse: false)
        
        //BEGIN code with citation - delay functions in swift
        // https://stackoverflow.com/questions/28821722/delaying-function-in-swift
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0, execute: {
            self.sceneView.removeFromSuperview()
        })
        //End code with citation - delay function in swift
    }
    //END code with citation - configs and debug, tapped, double tapped function

}
