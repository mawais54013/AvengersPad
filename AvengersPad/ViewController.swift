//
//  ViewController.swift
//  AvengersPad
//
//  Created by muhammad Awais on 8/28/19.
//  Copyright © 2019 muhammad Awais. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration();
        
        if let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "MarvelImage", bundle: Bundle.main) {
            configuration.trackingImages = trackedImages
            
            configuration.maximumNumberOfTrackedImages = 1
            
            print("Images found")
        }

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            
            let videoNode = SKVideoNode(fileNamed: "marvel.mp4")
            
            videoNode.play()
            
            let videoScene = SKScene(size: CGSize(width: 480, height: 360))
            
            videoNode.position = CGPoint(x: videoScene.size.width / 2, y: videoScene.size.height/2)
            
            videoNode.yScale = -1.0
            
            videoScene.addChild(videoNode)
            
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            
            plane.firstMaterial?.diffuse.contents = videoScene
            
            let planeNode = SCNNode(geometry: plane)
            
            planeNode.eulerAngles.x = -.pi/2
            
            node.addChildNode(planeNode)
        }
        
        return node
    }

}
