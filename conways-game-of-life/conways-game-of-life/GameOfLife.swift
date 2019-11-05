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
    
    func updateGrid(grid: Grid) {
        let tempStates: [[[Int]]] = copyGridStates(grid: grid)
        
        var count: Int
        
        for y in (0..<tempStates.count) {
            for z in (0..<tempStates[y].count) {
                for x in (0..<tempStates[y][z].count) {
                    count = countLivingNeighbors(states: tempStates, x: x, y: y, z: z)
                    
                    if tempStates[y][z][x] == 1 {
                        if (count <= 2) || (count >= 5) {
                            grid.cubes[y][z][x].state = 0
                        }
                    } else {
                        if count == 4 {
                            grid.cubes[y][z][x].state = 1
                        }
                    }
                }
            }
        }
    }
    
    func resetGrid(grid: Grid) {
        for y in (0..<grid.cubes.count) {
            for z in (0..<grid.cubes[y].count) {
                for x in (0..<grid.cubes[y][z].count) {
                    grid.cubes[y][z][x].state = 0
                }
            }
        }
    }
    
    func cloneCube(oldCube: Cube) -> Cube {
        let newCube: Cube = Cube(x: oldCube.coord.x, y: oldCube.coord.y, z: oldCube.coord.z, cubeEdgeSize: oldCube.cubeEdgeSize)
        
        newCube.state = oldCube.state
        
        return newCube
    }
    
    func cloneGrid(oldGrid: Grid) -> Grid {
        let newGrid: Grid = Grid(width: oldGrid.size.width, height: oldGrid.size.height, depth: oldGrid.size.depth, cubeEdgeSize: oldGrid.cubeEdgeSize)
        
        for y in (0..<oldGrid.cubes.count) {
            for z in (0..<oldGrid.cubes[y].count) {
                for x in (0..<oldGrid.cubes[y][z].count) {
                    newGrid.cubes[y][z][x].state = oldGrid.cubes[y][z][x].state
                }
            }
        }
        
        return newGrid
    }
    
    func copyGridStates(grid: Grid) -> [[[Int]]] {
        var states: [[[Int]]] = []
        
        for y in (0..<grid.cubes.count) {
            states.append([])
            
            for z in (0..<grid.cubes[y].count) {
                states[y].append([])
                
                for x in (0..<grid.cubes[y][z].count) {
                    states[y][z].append(grid.cubes[y][z][x].state)
                }
            }
        }
        return states
    }
    
    func countLivingNeighbors(grid: Grid, x: Int, y: Int, z: Int) -> Int {
        var count = 0
        
        if y-1 >= 0 && y-1 < grid.cubes.count {
            if z-1 >= 0 && z-1 < grid.cubes[y-1].count {
                if x-1 >= 0 && x-1 < grid.cubes[y-1][z-1].count {
                    if grid.cubes[y-1][z-1][x-1].state == 1 {
                        count += 1
                    }
                }
                
                if x >= 0 && x < grid.cubes[y-1][z-1].count {
                    if grid.cubes[y-1][z-1][x].state == 1 {
                        count += 1
                    }
                }
                
                if x+1 >= 0 && x+1 < grid.cubes[y-1][z-1].count {
                    if grid.cubes[y-1][z-1][x+1].state == 1 {
                        count += 1
                    }
                }
            }
            
            if z >= 0 && z < grid.cubes[y-1].count {
                if x-1 >= 0 && x-1 < grid.cubes[y-1][z].count {
                    if grid.cubes[y-1][z][x-1].state == 1 {
                        count += 1
                    }
                }
                
                if x >= 0 && x < grid.cubes[y-1][z].count {
                    if grid.cubes[y-1][z][x].state == 1 {
                        count += 1
                    }
                }
                
                if x+1 >= 0 && x+1 < grid.cubes[y-1][z].count {
                    if grid.cubes[y-1][z][x+1].state == 1 {
                        count += 1
                    }
                }
            }
            
            if z+1 >= 0 && z+1 < grid.cubes[y-1].count {
                if x-1 >= 0 && x-1 < grid.cubes[y-1][z+1].count {
                    if grid.cubes[y-1][z+1][x-1].state == 1 {
                        count += 1
                    }
                }
                
                if x >= 0 && x < grid.cubes[y-1][z+1].count {
                    if grid.cubes[y-1][z+1][x].state == 1 {
                        count += 1
                    }
                }
                
                if x+1 >= 0 && x+1 < grid.cubes[y-1][z+1].count {
                    if grid.cubes[y-1][z+1][x+1].state == 1 {
                        count += 1
                    }
                }
            }
        }
        
        if y >= 0 && y < grid.cubes.count {
            if z-1 >= 0 && z-1 < grid.cubes[y].count {
                if x-1 >= 0 && x-1 < grid.cubes[y][z-1].count {
                    if grid.cubes[y][z-1][x-1].state == 1 {
                        count += 1
                    }
                }
                
                if x >= 0 && x < grid.cubes[y][z-1].count {
                    if grid.cubes[y][z-1][x].state == 1 {
                        count += 1
                    }
                }
                
                if x+1 >= 0 && x+1 < grid.cubes[y][z-1].count {
                    if grid.cubes[y][z-1][x+1].state == 1 {
                        count += 1
                    }
                }
            }
            
            if z >= 0 && z < grid.cubes[y].count {
                if x-1 >= 0 && x-1 < grid.cubes[y][z].count {
                    if grid.cubes[y][z][x-1].state == 1 {
                        count += 1
                    }
                }
                
                if x+1 >= 0 && x+1 < grid.cubes[y][z].count {
                    if grid.cubes[y][z][x+1].state == 1 {
                        count += 1
                    }
                }
            }
            
            if z+1 >= 0 && z+1 < grid.cubes[y].count {
                if x-1 >= 0 && x-1 < grid.cubes[y][z+1].count {
                    if grid.cubes[y][z+1][x-1].state == 1 {
                        count += 1
                    }
                }
                
                if x >= 0 && x < grid.cubes[y][z+1].count {
                    if grid.cubes[y][z+1][x].state == 1 {
                        count += 1
                    }
                }
                
                if x+1 >= 0 && x+1 < grid.cubes[y][z+1].count {
                    if grid.cubes[y][z+1][x+1].state == 1 {
                        count += 1
                    }
                }
            }
        }
        
        if y+1 >= 0 && y+1 < grid.cubes.count {
            if z-1 >= 0 && z-1 < grid.cubes[y+1].count {
                if x-1 >= 0 && x-1 < grid.cubes[y+1][z-1].count {
                    if grid.cubes[y+1][z-1][x-1].state == 1 {
                        count += 1
                    }
                }
                
                if x >= 0 && x < grid.cubes[y+1][z-1].count {
                    if grid.cubes[y+1][z-1][x].state == 1 {
                        count += 1
                    }
                }
                
                if x+1 >= 0 && x+1 < grid.cubes[y+1][z-1].count {
                    if grid.cubes[y+1][z-1][x+1].state == 1 {
                        count += 1
                    }
                }
            }
            
            if z >= 0 && z < grid.cubes[y+1].count {
                if x-1 >= 0 && x-1 < grid.cubes[y+1][z].count {
                    if grid.cubes[y+1][z][x-1].state == 1 {
                        count += 1
                    }
                }
                
                if x >= 0 && x < grid.cubes[y+1][z].count {
                    if grid.cubes[y+1][z][x].state == 1 {
                        count += 1
                    }
                }
                
                if x+1 >= 0 && x+1 < grid.cubes[y+1][z].count {
                    if grid.cubes[y+1][z][x+1].state == 1 {
                        count += 1
                    }
                }
            }
            
            if z+1 >= 0 && z+1 < grid.cubes[y+1].count {
                if x-1 >= 0 && x-1 < grid.cubes[y+1][z+1].count {
                    if grid.cubes[y+1][z+1][x-1].state == 1 {
                        count += 1
                    }
                }
                
                if x >= 0 && x < grid.cubes[y+1][z+1].count {
                    if grid.cubes[y+1][z+1][x].state == 1 {
                        count += 1
                    }
                }
                
                if x+1 >= 0 && x+1 < grid.cubes[y+1][z+1].count {
                    if grid.cubes[y+1][z+1][x+1].state == 1 {
                        count += 1
                    }
                }
            }
        }
        return count
    }
    
    func countLivingNeighbors(states: [[[Int]]], x: Int, y: Int, z: Int) -> Int {
        var count = 0
        
        if y-1 >= 0 && y-1 < states.count {
            if z-1 >= 0 && z-1 < states[y-1].count {
                if x-1 >= 0 && x-1 < states[y-1][z-1].count {
                    if states[y-1][z-1][x-1] == 1 {
                        count += 1
                    }
                }
                
                if x >= 0 && x < states[y-1][z-1].count {
                    if states[y-1][z-1][x] == 1 {
                        count += 1
                    }
                }
                
                if x+1 >= 0 && x+1 < states[y-1][z-1].count {
                    if states[y-1][z-1][x+1] == 1 {
                        count += 1
                    }
                }
            }
            
            if z >= 0 && z < states[y-1].count {
                if x-1 >= 0 && x-1 < states[y-1][z].count {
                    if states[y-1][z][x-1] == 1 {
                        count += 1
                    }
                }
                
                if x >= 0 && x < states[y-1][z].count {
                    if states[y-1][z][x] == 1 {
                        count += 1
                    }
                }
                
                if x+1 >= 0 && x+1 < states[y-1][z].count {
                    if states[y-1][z][x+1] == 1 {
                        count += 1
                    }
                }
            }
            
            if z+1 >= 0 && z+1 < states[y-1].count {
                if x-1 >= 0 && x-1 < states[y-1][z+1].count {
                    if states[y-1][z+1][x-1] == 1 {
                        count += 1
                    }
                }
                
                if x >= 0 && x < states[y-1][z+1].count {
                    if states[y-1][z+1][x] == 1 {
                        count += 1
                    }
                }
                
                if x+1 >= 0 && x+1 < states[y-1][z+1].count {
                    if states[y-1][z+1][x+1] == 1 {
                        count += 1
                    }
                }
            }
        }
        
        if y >= 0 && y < states.count {
            if z-1 >= 0 && z-1 < states[y].count {
                if x-1 >= 0 && x-1 < states[y][z-1].count {
                    if states[y][z-1][x-1] == 1 {
                        count += 1
                    }
                }
                
                if x >= 0 && x < states[y][z-1].count {
                    if states[y][z-1][x] == 1 {
                        count += 1
                    }
                }
                
                if x+1 >= 0 && x+1 < states[y][z-1].count {
                    if states[y][z-1][x+1] == 1 {
                        count += 1
                    }
                }
            }
            
            if z >= 0 && z < states[y].count {
                if x-1 >= 0 && x-1 < states[y][z].count {
                    if states[y][z][x-1] == 1 {
                        count += 1
                    }
                }
                
                if x+1 >= 0 && x+1 < states[y][z].count {
                    if states[y][z][x+1] == 1 {
                        count += 1
                    }
                }
            }
            
            if z+1 >= 0 && z+1 < states[y].count {
                if x-1 >= 0 && x-1 < states[y][z+1].count {
                    if states[y][z+1][x-1] == 1 {
                        count += 1
                    }
                }
                
                if x >= 0 && x < states[y][z+1].count {
                    if states[y][z+1][x] == 1 {
                        count += 1
                    }
                }
                
                if x+1 >= 0 && x+1 < states[y][z+1].count {
                    if states[y][z+1][x+1] == 1 {
                        count += 1
                    }
                }
            }
        }
        
        if y+1 >= 0 && y+1 < states.count {
            if z-1 >= 0 && z-1 < states[y+1].count {
                if x-1 >= 0 && x-1 < states[y+1][z-1].count {
                    if states[y+1][z-1][x-1] == 1 {
                        count += 1
                    }
                }
                
                if x >= 0 && x < states[y+1][z-1].count {
                    if states[y+1][z-1][x] == 1 {
                        count += 1
                    }
                }
                
                if x+1 >= 0 && x+1 < states[y+1][z-1].count {
                    if states[y+1][z-1][x+1] == 1 {
                        count += 1
                    }
                }
            }
            
            if z >= 0 && z < states[y+1].count {
                if x-1 >= 0 && x-1 < states[y+1][z].count {
                    if states[y+1][z][x-1] == 1 {
                        count += 1
                    }
                }
                
                if x >= 0 && x < states[y+1][z].count {
                    if states[y+1][z][x] == 1 {
                        count += 1
                    }
                }
                
                if x+1 >= 0 && x+1 < states[y+1][z].count {
                    if states[y+1][z][x+1] == 1 {
                        count += 1
                    }
                }
            }
            
            if z+1 >= 0 && z+1 < states[y+1].count {
                if x-1 >= 0 && x-1 < states[y+1][z+1].count {
                    if states[y+1][z+1][x-1] == 1 {
                        count += 1
                    }
                }
                
                if x >= 0 && x < states[y+1][z+1].count {
                    if states[y+1][z+1][x] == 1 {
                        count += 1
                    }
                }
                
                if x+1 >= 0 && x+1 < states[y+1][z+1].count {
                    if states[y+1][z+1][x+1] == 1 {
                        count += 1
                    }
                }
            }
        }
        return count
    }
}
