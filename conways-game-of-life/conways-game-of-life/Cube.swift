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
    let id: Int
    var coord: Coord = Coord()
    var state: Int {
        willSet {// 0 = Dead, 1 = Alive.
            if newValue == 0 {
                self.geometry?.firstMaterial?.diffuse.contents = colorDead
            } else {
                self.geometry?.firstMaterial?.diffuse.contents = colorAlive
            }
        }
    }
    let colorAlive: CGColor = CGColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
    let colorDead: CGColor = CGColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
    
    init(id: Int, x: Int, y: Int, z: Int, cubeEdgeSize: CGFloat) {
        self.id = id
        self.coord.x = x
        self.coord.z = z
        self.state = 0
        super.init()
        self.position = SCNVector3(CGFloat(self.coord.x) * -cubeEdgeSize, CGFloat(self.coord.y) * -cubeEdgeSize, CGFloat(self.coord.z) * -cubeEdgeSize)
        self.geometry = SCNBox(width: cubeEdgeSize, height: cubeEdgeSize, length: cubeEdgeSize, chamferRadius: 0)
        self.geometry?.firstMaterial?.diffuse.contents = colorDead
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
