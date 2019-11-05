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
    var depth: Int = 0
}

class Grid: SCNNode {
    var cubes: [[[Cube]]] = []
    var size: Size = Size()
    var cubeEdgeSize: CGFloat
    
    init(width: Int, height: Int, depth: Int, cubeEdgeSize: CGFloat) {
        self.size.width = width
        self.size.height = height
        self.size.depth = depth
        self.cubeEdgeSize = cubeEdgeSize
        
        super.init()
        
        for y in (0..<self.size.depth) {
            cubes.append([])
            for z in (0..<self.size.height) {
                cubes[y].append([])
                for x in (0..<self.size.width) {
                    cubes[y][z].append(Cube(x: x, y: y, z: z, cubeEdgeSize: self.cubeEdgeSize))
                    
                    self.addChildNode(cubes[y][z][x])
                }
            }
        }
        
        self.position = SCNVector3(x: (CGFloat(self.size.width) / 2) - (self.cubeEdgeSize / 2), y: (CGFloat(self.size.depth) / 2) - (self.cubeEdgeSize / 2), z: (CGFloat(self.size.height) / 2) - (self.cubeEdgeSize / 2))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
