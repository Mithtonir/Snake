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
    var timeExtension: Double = 0.3 //speed
    var playerDirection: Int = 4 //1 == left 2== up, 3 == right
    init(scene: GameScene){
        self.scene = scene
    }
    var currentScore: Int = 0
func initGame() {
    scene.playerPositions.append((10,10))
    scene.playerPositions.append((10,11))
    scene.playerPositions.append((10,12))
    scene.playerPositions.append((10,13))
    scene.playerPositions.append((10,14))
    scene.playerPositions.append((10,15))
    scene.playerPositions.append((10,16))
    scene.playerPositions.append((10,17))
    scene.playerPositions.append((10,18))
    renderChange();
    generateNewPoint();
}
    
    private func generateNewPoint() {
        let randomX = CGFloat(arc4random_uniform(19))
        let randomY = CGFloat(arc4random_uniform(39))
        scene.scorePos = CGPoint(x: randomX, y: randomY)
    }
    func update (time: Double){
        if nextTime == nil {
            nextTime = time + timeExtension
            
        } else {
            if time >= nextTime! {
                nextTime = time + timeExtension
                updatePlayerPosition()
                checkForScore()
                checkForDeath()
                finishAnimation();
            }
        }
        
        
    }
    private func updateScore() {
        if currentScore > UserDefaults.standard.integer(forKey: "bestScore"){
            UserDefaults.standard.set(currentScore, forKey: "bestScore")
        }
        currentScore = 0
        scene.currentScore.text = "Score: 0"
        scene.bestScore.text = "Best Score: \(UserDefaults.standard.integer(forKey: "bestScore"))"
    }
    private func finishAnimation() {
        if playerDirection == 0 && scene.playerPositions.count > 0 {
            var hasFinished = true
            let headOfSnake = scene.playerPositions[0]
            for position in scene.playerPositions {
                if headOfSnake != position {
                    hasFinished = false
                }
            }
            if hasFinished {
                print("end game")
                updateScore()
                playerDirection = 4
                //animation has completed
                scene.scorePos = nil
                scene.playerPositions.removeAll()
                renderChange()
                //return to menu
                self.scene.currentScore.isHidden = true //cp
                    scene.gameBG.run(SKAction.scale(to: 0, duration: 0.4)) {
                        self.scene.gameBG.isHidden = true
                        self.scene.gameLogo.isHidden = false
                        self.scene.gameLogo.run(SKAction.move(to: CGPoint(x: 0, y: (self.scene.frame.size.height / 2) - 200), duration: 0.5)) {
                            self.scene.playButton.isHidden = false
                            self.scene.playButton.run(SKAction.scale(to: 1, duration: 0.3))
                            self.scene.bestScore.run(SKAction.move(to: CGPoint(x: 0, y: self.scene.gameLogo.position.y - 50), duration: 0.3))
                        }
                }
            }
        }
    }
    
    private func checkForScore() {
        if scene.scorePos != nil {
            let x = scene.playerPositions[0].0
            let y = scene.playerPositions[0].1
            if Int((scene.scorePos?.x)!) == y && Int((scene.scorePos?.y)!) == x {
                currentScore += 1
                scene.currentScore.text = "Score: \(currentScore)"
                generateNewPoint()
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
            }
            
        }
    }
    private func checkForDeath() {
        if scene.playerPositions.count > 0 {
            var arrayOfPositions = scene.playerPositions
            let headOfSnake = arrayOfPositions[0]
            arrayOfPositions.remove(at: 0)
            if contains(a: arrayOfPositions, v: headOfSnake ) {
                playerDirection = 0
                //here: wall of death
            }
        }
    }
    
    func swipe(ID: Int){
        if !(ID == 2 && playerDirection == 4) && !(ID == 4 && playerDirection == 2){
            if !(ID == 1 && playerDirection == 3) && !(ID == 3 && playerDirection == 1){
                playerDirection = ID
                if playerDirection != 0 { playerDirection = ID }
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
            //checkForDeath()
        case 0:
            xChange = 0
            yChange = 0
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
            if scene.scorePos != nil {
                if Int((scene.scorePos?.x)!) == y && Int((scene.scorePos?.y)!) == x {
                    node.fillColor = SKColor.red
                }
            }
        }
    }
}

func contains(a:[(Int, Int)], v:(Int,Int)) -> Bool {
    let (c1, c2) = v
    for (v1, v2) in a { if v1 == c1 && v2 == c2 { return true } }
    return false
}
}
