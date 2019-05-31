//
//  GameManager.swift
//  Snake
//
//  Created by tonio on 31/05/2019.
//  Copyright © 2019 tonio. All rights reserved.
//
import SpriteKit
import Foundation
class GameManager {
    var scene: GameScene!
    var nextTime: Double?
    var timeExtension: Double = 0.5 //speed
    var playerDirection: Int = 4 //1 == left 2== up, 3 == right
    init(scene: GameScene){
        self.scene = scene
    }

func initGame() {
    scene.playerPositions.append((10,10))
    scene.playerPositions.append((10,11))
    scene.playerPositions.append((10,12))
    renderChange();
}
    func update (time: Double){
        if nextTime == nil {
            nextTime = time + timeExtension
            print(time)
           // updatePlayerPosition()
            
        }
        
    }
    
func renderChange() {
    for (node, x, y) in scene.gameArray {
        if contains(a: scene.playerPositions, v: (x,y)) {
            node.fillColor = SKColor.cyan
        } else {
            node.fillColor = SKColor.clear
        }
    }
}

func contains(a:[(Int, Int)], v:(Int,Int)) -> Bool {
    let (c1, c2) = v
    for (v1, v2) in a { if v1 == c1 && v2 == c2 { return true } }
    return false
}
}
