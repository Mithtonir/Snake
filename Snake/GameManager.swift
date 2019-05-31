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
            
        } else {
            if time >= nextTime! {
                nextTime = time + timeExtension
                updatePlayerPosition()
            }
        }
        
        
    }
    func swipe(ID: Int){
        if !(ID == 2 && playerDirection == 4) && !(ID == 4 && playerDirection == 2){
            if !(ID == 1 && playerDirection == 3) && !(ID == 3 && playerDirection == 1){
                playerDirection = ID
            }
        }
    }
    private func updatePlayerPosition() {
        //1 == left 2== up, 3 == right
        var xChange = -1
        var yChange = 0
        
        switch playerDirection {
        case 1:
            
            xChange = -1
            yChange = 0
            break
        case 2:
            
            xChange = 0
            yChange = -1
            break
        case 3:
            
            xChange = 1
            yChange = 0
            break
        case 4:
          
            xChange = 0
            yChange = 1
            break
        default:
            break
        }
        
        if scene.playerPositions.count > 0 {
            var start = scene.playerPositions.count - 1
            while start > 0 {
                scene.playerPositions[start] = scene.playerPositions[start - 1]
                start -= 1
            }
            scene.playerPositions[0] = (scene.playerPositions[0].0 + yChange, scene.playerPositions[0].1 + xChange)
        }
        
        renderChange()
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
