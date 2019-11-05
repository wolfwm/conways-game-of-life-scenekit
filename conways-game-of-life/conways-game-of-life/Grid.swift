//
//  Grid.swift
//  conways-game-of-life
//
//  Created by Wolfgang Walder on 31/10/19.
//  Copyright © 2019 Wolfgang Walder. All rights reserved.
//

import SceneKit

struct Size {
    var width: Int = 0
    var height: Int = 0
    var depth: Int = 1
}

class Grid: SCNNode {
    var cubes: [[Cube]] = []
    var size: Size = Size()
    var cubeEdgeSize: CGFloat
    var y: Int
    
    init(width: Int, height: Int, y: Int, cubeEdgeSize: CGFloat) {
        self.size.width = width
        self.size.height = height
        self.cubeEdgeSize = cubeEdgeSize
        self.y = y
        
        super.init()
        
        for z in (0..<self.size.height) {
            cubes.append([])
            for x in (0..<self.size.width) {
                cubes[z].append(Cube(x: x, y: self.y, z: z, cubeEdgeSize: self.cubeEdgeSize))
                
                self.addChildNode(cubes[z][x])
            }
        }
        
        self.position = SCNVector3(x: (CGFloat(width) / 2) - (self.cubeEdgeSize / 2), y: CGFloat(self.y) * self.cubeEdgeSize, z: (CGFloat(height) / 2) - (self.cubeEdgeSize / 2))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
