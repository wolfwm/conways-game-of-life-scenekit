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
    
    init(width: Int, height: Int, y: Int, cubeEdgeSize: CGFloat) {
        self.size.width = width
        self.size.height = height
        
        var id: Int = 0
        
        super.init()
        
        for z in (0..<self.size.height) {
            cubes.append([])
            for x in (0..<self.size.width) {
                cubes[z].append(Cube(id: id, x: x, y: 0, z: z, cubeEdgeSize: cubeEdgeSize))
                
                self.addChildNode(cubes[z][x])
                
                id += 1
            }
            id += 1
        }
        
        self.position = SCNVector3(x: (CGFloat(width) / 2) - (cubeEdgeSize / 2), y: CGFloat(y) * cubeEdgeSize, z: (CGFloat(height) / 2) - (cubeEdgeSize / 2))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
