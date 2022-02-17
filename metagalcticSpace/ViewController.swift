//
//  ViewController.swift
//  metagalcticSpace
//
//  Created by Hamza on 2/13/22.
//  Copyright © 2022 Hamza. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var planet: String!
    let base = SCNNode()
    let planetNode = SCNNode()
    let textNode = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.debugOptions = [.showFeaturePoints]
        
        addBase()
        addPlanet()
        addText()
        addShip()
        
        
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(dismiss(fromGesture:)))
        
        sceneView.addGestureRecognizer(gesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    func addBase(){
        let location = SCNVector3(x: 0.0, y: 0.0, z: -1.0)
        base.position = location
        sceneView.scene.rootNode.addChildNode(base)
    }
    
    func addPlanet(){
        let planetSphere = SCNSphere(radius: 0.3)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: planet)
        planetSphere.materials = [material]
        planetNode.geometry = planetSphere
        base.addChildNode(planetNode)
        let planetRotate = SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 20)
        let repeatRotate = SCNAction.repeatForever(planetRotate)
        planetNode.runAction(repeatRotate)
    }
    
    func addText() {
        let text = SCNText(string: planet.capitalized, extrusionDepth: 1)
        text.font = UIFont(name: "futura", size: 16)
        let scaleFactor = 0.1 / text.font.pointSize
        textNode.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
        textNode.geometry = text
        let max = textNode.boundingBox.max.x
        let min = textNode.boundingBox.min.x
        let midpoint = -((max-min) / 2 + min) * Float(scaleFactor)
        textNode.position = SCNVector3(midpoint, 0.35, 0)
        base.addChildNode(textNode)
    }
    
    func addShip() {
        
        let orbitAction = SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 6)
        let repeatOrbit = SCNAction.repeatForever(orbitAction)
        
        let shipUpAction = SCNAction.move(to: SCNVector3(-0.35, 0.2, 0), duration: 2)
        shipUpAction.timingMode = .easeInEaseOut
        let shipDownAction = SCNAction.move(to: SCNVector3(-0.35, -0.2, 0), duration: 2)
        shipDownAction.timingMode = .easeInEaseOut
        let upDown = SCNAction.sequence([shipUpAction, shipDownAction])
        let repeatUpDown = SCNAction.repeatForever(upDown)
        
        let scene = SCNScene(named: "art.scnassets/ship.scn")
        if let shipNode = scene?.rootNode.childNode(withName: "ship", recursively: true){
            shipNode.scale = SCNVector3(0.2, 0.2, 0.2)
            shipNode.position = SCNVector3(-0.35, 0, 0)
            let rotateNode = SCNNode()
            base.addChildNode(rotateNode)
            rotateNode.addChildNode(shipNode)
            rotateNode.runAction(repeatOrbit)
            shipNode.runAction(repeatUpDown)
        }
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    @objc func dismiss(fromGesture gesture: UISwipeGestureRecognizer){
        if gesture.direction == .right {
            dismiss(animated: true, completion: nil)
        }
    }
}
