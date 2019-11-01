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
        var tempStates: [[Int]] = []
        
        for z in (0..<grid.cubes.count) {
            tempStates.append([])
            for x in (0..<grid.cubes[z].count) {
                tempStates[z].append(grid.cubes[z][x].state)
            }
        }
        
        var count: Int
        
        for z in (0..<tempStates.count) {
            for x in (0..<tempStates[z].count) {
                count = 0
                
                if z-1 >= 0 && z-1 < tempStates.count {
                    if x-1 >= 0 && x-1 < tempStates[z-1].count {
                        if tempStates[z-1][x-1] == 1 {
                            count += 1
                        }
                    }
                    
                    if x >= 0 && x < tempStates[z-1].count {
                        if tempStates[z-1][x] == 1 {
                            count += 1
                        }
                    }
                    
                    if x+1 >= 0 && x+1 < tempStates[z-1].count {
                        if tempStates[z-1][x+1] == 1 {
                            count += 1
                        }
                    }
                }
                
                if z >= 0 && z < tempStates.count {
                    if x-1 >= 0 && x-1 < tempStates[z].count {
                        if tempStates[z][x-1] == 1 {
                            count += 1
                        }
                    }
                    
                    if x+1 >= 0 && x+1 < tempStates[z].count {
                        if tempStates[z][x+1] == 1 {
                            count += 1
                        }
                    }
                }
                
                if z+1 >= 0 && z+1 < tempStates.count {
                    if x-1 >= 0 && x-1 < tempStates[z+1].count {
                        if tempStates[z+1][x-1] == 1 {
                            count += 1
                        }
                    }
                    
                    if x >= 0 && x < tempStates[z+1].count {
                        if tempStates[z+1][x] == 1 {
                            count += 1
                        }
                    }
                    
                    if x+1 >= 0 && x+1 < tempStates[z+1].count {
                        if tempStates[z+1][x+1] == 1 {
                            count += 1
                        }
                    }
                }
                
                if tempStates[z][x] == 1 {
                    if (count <= 1) || (count >= 4) {
                        grid.cubes[z][x].state = 0
                    }
                } else {
                    if count == 3 {
                        grid.cubes[z][x].state = 1
                    }
                }
            }
        }
    }
}
