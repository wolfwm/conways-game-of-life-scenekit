//
//  Cube.swift
//  conways-game-of-life
//
//  Created by Wolfgang Walder on 31/10/19.
//  Copyright © 2019 Wolfgang Walder. All rights reserved.
//

import SceneKit

struct Coord {
    var x: Int = 0
    var y: Int = 0
    var z: Int = 0
}

class Cube: SCNNode {
    var coord: Coord = Coord()
    var cubeEdgeSize: CGFloat
    var state: Int {
        willSet {// 0 = Dead, 1 = Alive, 2 = Fading.
            if newValue == 0 {
                self.geometry?.firstMaterial?.diffuse.contents = colorDead
            } else if newValue == 1 {
                self.geometry?.firstMaterial?.diffuse.contents = colorAlive
            } else {
                self.geometry?.firstMaterial?.diffuse.contents = colorFading
            }
        }
    }
    let colorAlive: CGColor = CGColor(red: 0.3, green: 0.7, blue: 0.1, alpha: 1)
    let colorDead: CGColor = CGColor(red: 0.3, green: 0.5, blue: 0.7, alpha: 0.05)
    let colorFading: CGColor = CGColor(red: 1, green: 0.5, blue: 0.2, alpha: 0.5)
    
    init(x: Int, y: Int, z: Int, cubeEdgeSize: CGFloat) {
        self.coord.x = x
        self.coord.y = y
        self.coord.z = z
        self.cubeEdgeSize = cubeEdgeSize
        self.state = 0
        super.init()
        self.position = SCNVector3(CGFloat(self.coord.x) * -self.cubeEdgeSize, CGFloat(self.coord.y) * -self.cubeEdgeSize, CGFloat(self.coord.z) * -self.cubeEdgeSize)
        self.geometry = SCNBox(width: self.cubeEdgeSize, height: self.cubeEdgeSize, length: self.cubeEdgeSize, chamferRadius: 0.05)
        self.geometry?.firstMaterial?.diffuse.contents = colorDead
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
