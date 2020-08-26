//
//  ViewController.swift
//  3A.2SceneKit-Primitives
//
//  Created by Sophie Kim on 2020/08/26.
//  Copyright © 2020 Sophie Kim. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.showsStatistics = true
        sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin]
        loadCampus()
        sceneView.autoenablesDefaultLighting = true
    }
}

extension ViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    func session(_ session: ARSession, didFailWithError error: Error) {
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
    }
    
    func loadCampus() {
        let scene = SCNScene(named: "art.scnassets/campus.scn")!
        sceneView.scene = scene
        loadMainBuilding()
        loadSidewalks()
        loadGrass()
        
        for number in 1 ... 5 {
            loadTree(xValue: Float(number), zValue: 0.75)
        }
    }
    
    func loadMainBuilding() {
        let node = SCNNode()
        let geometry = SCNBox(width: 3.0, height: 1.0, length: 1.0, chamferRadius: 0.0)
        geometry.firstMaterial?.diffuse.contents = UIColor.brown
        node.geometry = geometry
        node.scale = SCNVector3(0.5, 0.5, 0.5)
        let position = SCNVector3(0.0, -0.3, 0.0)
        node.position = position
        
        sceneView.scene.rootNode.addChildNode(node)
        
        let coneNode = SCNNode()
        let coneGeometry = SCNCone.init(topRadius: 0.0, bottomRadius: 0.5, height: 0.5)
        coneGeometry.firstMaterial?.diffuse.contents = UIColor.red
        coneNode.geometry = coneGeometry
        let conePosition = SCNVector3(x: 0.0, y: 0.5, z: 0.0)
        coneNode.position = conePosition
        node.addChildNode(coneNode)
    }
    
    func loadSidewalks() {
        let node = SCNNode()
        
        let geometry = SCNPlane(width: 3.5, height: 1.5)
        geometry.firstMaterial?.diffuse.contents = UIColor.gray
        geometry.firstMaterial?.isDoubleSided = true
        node.geometry = geometry
        node.eulerAngles = SCNVector3(-Float.pi / 2, 0.0, 0.0)
        
        let position = SCNVector3(0.0, -0.501, 0.0)
        node.position = position
        
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    func loadGrass() {
        let node = SCNNode()
        
        let geometry = SCNPlane(width: 4.5, height: 2.0)
        geometry.firstMaterial?.diffuse.contents = UIColor.green
        geometry.firstMaterial?.isDoubleSided = true
        node.eulerAngles.x = -Float.pi / 2
        node.geometry = geometry
        
        let position = SCNVector3(0.0, -0.502, 0.0)
        node.position = position
        
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    func loadTree(xValue: Float, zValue: Float) {
        let trunkNode = SCNNode()
        
        let trunkGeometry = SCNCylinder(radius: 0.05, height: 0.5)
        trunkGeometry.firstMaterial?.diffuse.contents = UIColor.brown
        trunkNode.geometry = trunkGeometry
        
        let trunkPosition = SCNVector3(xValue, -0.25, zValue)
        trunkNode.position = trunkPosition
        
        sceneView.scene.rootNode.addChildNode(trunkNode)
        
        let crownNode = SCNNode()
        let crownGeometry = SCNSphere(radius: 0.2)
        crownGeometry.firstMaterial?.diffuse.contents = UIColor.green
        
        crownNode.geometry = crownGeometry
        
        let crownPosition = SCNVector3(x: 0.0, y: 0.25, z: 0.0)
        crownNode.position = crownPosition
        
        trunkNode.addChildNode(crownNode)
    }
}
