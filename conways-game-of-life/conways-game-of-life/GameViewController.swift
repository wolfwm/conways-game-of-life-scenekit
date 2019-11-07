//
//  GameViewController.swift
//  conways-game-of-life
//
//  Created by Wolfgang Walder on 31/10/19.
//  Copyright © 2019 Wolfgang Walder. All rights reserved.
//

import SceneKit
import QuartzCore

class GameViewController: NSViewController, SCNSceneRendererDelegate {
    
    let game = GameOfLife()
    
    var grids: [Grid] = []
    
    // create a new scene
    let scene = SCNScene(named: "art.scnassets/GameOfLife.scn")
    
    let cameraNode = SCNNode()
    
    let lightNode = SCNNode()
    
    var scnView: SCNView = SCNView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create and add a camera to the scene
        
        cameraNode.camera = SCNCamera()
        scene?.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 30, y: 30, z: 30)
        cameraNode.look(at: SCNVector3(x: 0, y: 0, z: 0))
        cameraNode.camera?.zFar = 500
        
        // create and add a light to the scene
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 30, z: 30)
        scene?.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = NSColor.darkGray
        scene?.rootNode.addChildNode(ambientLightNode)
        
        grids.append(Grid(width: 10, height: 10, depth: 10, cubeEdgeSize: 1))
        scene?.rootNode.addChildNode(grids[0])
        
        // retrieve the SCNView
        scnView = self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = NSColor.black
        
        // Add a click gesture recognizer
        let clickGesture = NSClickGestureRecognizer(target: self, action: #selector(handleClick(_:)))
        var gestureRecognizers = scnView.gestureRecognizers
        gestureRecognizers.insert(clickGesture, at: 0)
        scnView.gestureRecognizers = gestureRecognizers
        
        scnView.pointOfView = cameraNode
        
        scnView.delegate = self
        
        scnView.isPlaying = true
        scnView.loops = true
    }
    
    @objc
    func handleClick(_ gestureRecognizer: NSGestureRecognizer) {
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // check what nodes are clicked
        let p = gestureRecognizer.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result = hitResults[0]
            
            if let cube = result.node as? Cube {
                if cube.state == 0 {
                    cube.state = 1
                } else {
                    cube.state = 0
                }
            }
        }
    }
    
    var layer: Int = 0
    
    override func keyDown(with event: NSEvent) {
        let keyCode = event.keyCode
        
        if keyCode == 0x31 { // 0x31 = spacebar
            step()
            
        } else if keyCode == 0x24 || keyCode == 0x4C { // 0x24 = return, 0x4C = enter
            isRunning = !isRunning
            
        } else if keyCode == 0x33 { // 0x33 = delete
            game.resetGrid(grid: grids[0])
        }
    }
    
    var nextTime: TimeInterval = 0
    let interval: TimeInterval = 0.3
    var isRunning = false
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if time >= nextTime && isRunning {
            step()
            
            nextTime = time + interval
        }
    }
    
    func step() {
        game.updateGrid(grid: grids[0])
    }
}
