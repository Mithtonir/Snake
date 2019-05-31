//
//  GameScene.swift
//  Snake
//
//  Created by tonio on 31/05/2019.
//  Copyright © 2019 tonio. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var gameLogo: SKLabelNode!
    var bestScore: SKLabelNode!
    var playButton: SKShapeNode!
    
   
    
    override func didMove(to view: SKView) {
        initializeMenu()
    }
     
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
        private func initializeMenu() {
            //Create game title
            gameLogo = SKLabelNode(fontNamed: "ArialRoundedMTBold")
            gameLogo.zPosition = 1
            gameLogo.position = CGPoint(x: 0, y: (frame.size.height / 2) - 200)
            gameLogo.fontSize = 60
            gameLogo.text = "SNAKE"
            gameLogo.fontColor = SKColor.red
            self.addChild(gameLogo)
            //Create best score label
            bestScore = SKLabelNode(fontNamed: "ArialRoundedMTBold")
            bestScore.zPosition = 1
            bestScore.position = CGPoint(x: 0, y: gameLogo.position.y - 50)
            bestScore.fontSize = 40
            bestScore.text = "Best Score: 0"
            bestScore.fontColor = SKColor.white
            self.addChild(bestScore)
            //Create play button
            playButton = SKShapeNode()
            playButton.name = "play_button"
            playButton.zPosition = 1
            playButton.position = CGPoint(x: 0, y: (frame.size.height / -2) + 200)
            playButton.fillColor = SKColor.cyan
            let topCorner = CGPoint(x: -50, y: 50)
            let bottomCorner = CGPoint(x: -50, y: -50)
            let middle = CGPoint(x: 50, y: 0)
            let path = CGMutablePath()
            path.addLine(to: topCorner)
            path.addLines(between: [topCorner, bottomCorner, middle])
            playButton.path = path
            self.addChild(playButton)
        }
}
