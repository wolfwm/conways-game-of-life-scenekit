//
//  GameOfLife.swift
//  conways-game-of-life
//
//  Created by Wolfgang Walder on 31/10/19.
//  Copyright © 2019 Wolfgang Walder. All rights reserved.
//

import SceneKit

class GameOfLife {
    init() {}
    
    func createNextGrid(oldGrid: Grid, y: Int) -> Grid {
        let newGrid: Grid = cloneGrid(oldGrid: oldGrid, y: y)
        
        var count: Int
        
        for z in (0..<oldGrid.cubes.count) {
            for x in (0..<oldGrid.cubes[z].count) {
                count = countLivingNeighbors(grid: oldGrid, x: x, z: z)
                
                if oldGrid.cubes[z][x].state == 1 {
                    if (count <= 1) || (count >= 4) {
                        newGrid.cubes[z][x].state = 0
                    }
                } else {
                    if count == 3 {
                        newGrid.cubes[z][x].state = 1
                    }
                }
            }
        }
        return newGrid
    }
    
    func cloneCube(oldCube: Cube) -> Cube {
        let newCube: Cube = Cube(x: oldCube.coord.x, y: oldCube.coord.y, z: oldCube.coord.z, cubeEdgeSize: oldCube.cubeEdgeSize)
        
        newCube.state = oldCube.state
        
        return newCube
    }
    
    func cloneGrid(oldGrid: Grid, y: Int) -> Grid {
        let newGrid: Grid = Grid(width: oldGrid.size.width, height: oldGrid.size.height, y: y, cubeEdgeSize: oldGrid.cubeEdgeSize)
        
        for z in (0..<oldGrid.cubes.count) {
            for x in (0..<oldGrid.cubes[z].count) {
                newGrid.cubes[z][x].state = oldGrid.cubes[z][x].state
            }
        }
        
        return newGrid
    }
    
    func countLivingNeighbors(grid: Grid, x: Int, z: Int) -> Int {
        var count = 0
        
        if z-1 >= 0 && z-1 < grid.cubes.count {
            if x-1 >= 0 && x-1 < grid.cubes[z-1].count {
                if grid.cubes[z-1][x-1].state == 1 {
                    count += 1
                }
            }
            
            if x >= 0 && x < grid.cubes[z-1].count {
                if grid.cubes[z-1][x].state == 1 {
                    count += 1
                }
            }
            
            if x+1 >= 0 && x+1 < grid.cubes[z-1].count {
                if grid.cubes[z-1][x+1].state == 1 {
                    count += 1
                }
            }
        }
        
        if z >= 0 && z < grid.cubes.count {
            if x-1 >= 0 && x-1 < grid.cubes[z].count {
                if grid.cubes[z][x-1].state == 1 {
                    count += 1
                }
            }
            
            if x+1 >= 0 && x+1 < grid.cubes[z].count {
                if grid.cubes[z][x+1].state == 1 {
                    count += 1
                }
            }
        }
        
        if z+1 >= 0 && z+1 < grid.cubes.count {
            if x-1 >= 0 && x-1 < grid.cubes[z+1].count {
                if grid.cubes[z+1][x-1].state == 1 {
                    count += 1
                }
            }
            
            if x >= 0 && x < grid.cubes[z+1].count {
                if grid.cubes[z+1][x].state == 1 {
                    count += 1
                }
            }
            
            if x+1 >= 0 && x+1 < grid.cubes[z+1].count {
                if grid.cubes[z+1][x+1].state == 1 {
                    count += 1
                }
            }
        }
        return count
    }
}
