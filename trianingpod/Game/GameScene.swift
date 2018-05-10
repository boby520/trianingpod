//
//  GameScene.swift
//  b
//
//  Created by 林洪州 on 2018/2/14.
//  Copyright © 2018年 林洪州. All rights reserved.
//

//
//  GameScene.swift
//  RainCat
//
//  Created by Marc Vandehey on 8/29/16.
//  Copyright © 2016 Thirteen23. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
  //雨滴生成数量和时间
  private var lastUpdateTime : TimeInterval = 0
  private var currentRainDropSpawnTime : TimeInterval = 0
  private var rainDropSpawnRate : TimeInterval = 0.1
  
  
//  private let bird = SKSpriteNode(imageNamed: "bird")
//  private let house2 = SKSpriteNode(imageNamed: "house2")
  //生成房子,金币，天使
  private let house = SKSpriteNode(imageNamed: "house")
  private let angle = SKSpriteNode(imageNamed: "angle")
  private let gold = SKSpriteNode(imageNamed: "1")
  private let goldBG = SKSpriteNode(imageNamed: "goldBG")
  
  
  //Mark:- back and setting icon
  private let back = SKSpriteNode(imageNamed: "back")
  private let setting = SKSpriteNode(imageNamed: "setting")
  //MARK:- 购买的按钮以及界面
  private let buyBG = SKSpriteNode(imageNamed: "buyBG")
  private let buyHouse = SKSpriteNode(imageNamed: "buyHouse")
  private let buyFlower = SKSpriteNode(imageNamed: "buyFlower")
  private let buyTree = SKSpriteNode(imageNamed: "buyTree")
  private let buyAnimal = SKSpriteNode(imageNamed: "buyAnimal")
  private let buyOther = SKSpriteNode(imageNamed: "buyOther")
  
  private let buyOpen = SKSpriteNode(imageNamed: "buyOpen")
  private let buyClose = SKSpriteNode(imageNamed: "buyClose")
  
  private let buyTreeBG = SKSpriteNode(imageNamed: "buyTreeBG")
  private let buyOK = SKSpriteNode(imageNamed: "buyOC")
  private let buyNO = SKSpriteNode(imageNamed: "buyOC")
  
  private let backgroundNode = BackgroundNode()
  
  override func didMove(to view: SKView) {
  }
  
  override func sceneDidLoad() {

   setupUI()
    
  }
  
  //MARK:- 点击事件
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //获取点击的位置
    let touch = touches.first
    let a:CGPoint = (touch?.location(in: self))!
    let node = self.atPoint(a)
  
    if(node.name != nil){
      switch node.name!{
        //购买按钮
      case buyOpen.name!:
        buyBG.isHidden = false
        buyOpen.isHidden = true
        
      case buyClose.name!:
        buyBG.isHidden = true
        buyOpen.isHidden = false
        
        
        //确认和取消按钮
      case buyOK.name!:
        print("保存状态")
      case buyNO.name!:
        buyTreeBG.isHidden = true
        
        
      case buyTree.name!:
        buyTreeBG.isHidden = false
        
        
      case goldBG.name!:
        print("金币")
        
        //返回按钮
      case back.name!:
        print("back")
        
      case buyHouse.name!:
        print("买房子")
      
    
      case house.name!:
        print("房子")
      default:
        break
      }
    }else{
      //让天使移动到鼠标点击空地位置
        let move = SKAction.move(to: touch!.location(in: self), duration: 2)
        angle.run(move, withKey: "Move")
    }
  }
  

  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    
  }

}


//MARK:- setup UI
extension GameScene{
  func setupUI(){
    let bg = SKSpriteNode(imageNamed: "bg")
    bg.size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
    bg.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
    bg.zPosition = 0
    addChild(bg)
    
    angle.size = CGSize(width: 200, height: 200)
    angle.zPosition = 1
    angle.position = CGPoint(x: self.frame.size.width/2 , y: self.frame.size.height/2)
    addChild(angle)
    move(skn: angle)
    
    let angleImages = ["angle1","angle2","angle3","angle4","angle5",]
    animateCrocodile(skn: angle, images: angleImages, duration: 0.15)
    
    back.size = CGSize(width: 25, height: 25)
    back.position = CGPoint(x:back.frame.width/2 + 20 , y:self.size.height - 20)
    back.name = "back"
    back.zPosition = 1
    addChild(back)
    
    setting.size = CGSize(width: 25, height: 25)
    setting.position = CGPoint(x:back.frame.width/2 + 60 , y:self.size.height - 20)
    setting.name = "setting"
    setting.zPosition = 1
    addChild(setting)
    
    
    //    house2.position = CGPoint(x: 100, y: 200)
    //    house2.zPosition = 1
    //    house2.name = "house2"
    //    addChild(house2)
    //    house2.isHidden = true
    
    house.position = CGPoint(x: 100, y: 200)
    house.zPosition = 1
    house.name = "house"
    addChild(house)
    
    buyBG.size = CGSize(width: 250, height: 50)
    buyBG.position = CGPoint(x: self.frame.size.width - buyBG.frame.size.width/2 - 40, y:buyBG.frame.height/2 + 20)
    buyBG.zPosition = 1
    buyBG.isHidden = true
    addChild(buyBG)
    
    
    buyHouse.size = CGSize(width:30, height: 30)
    buyHouse.name = "buyHouse"
    buyHouse.position = CGPoint(x: buyBG.frame.width/2 - buyHouse.frame.width/2 - 10, y: 5)
    buyHouse.zPosition = 2
    buyBG.addChild(buyHouse)
    
    let buyHouseLabel = SKLabelNode(fontNamed: "Arial")
    buyHouseLabel.text = NSLocalizedString("house", comment: "")
    buyHouseLabel.fontSize = 10
    buyHouseLabel.zPosition = 3
    buyHouseLabel.position = CGPoint(x: 0 , y: -buyHouse.frame.height/2 - 10)
    buyHouse.addChild(buyHouseLabel)
    
    
    buyTree.size = CGSize(width:30, height: 30)
    buyTree.name = "buyTree"
    buyTree.position = CGPoint(x: buyBG.frame.width/2 - buyTree.frame.width/2 - 50, y: 5)
    buyTree.zPosition = 2
    buyBG.addChild(buyTree)
    
    let buyTreeLabel = SKLabelNode(fontNamed: "Arial")
    buyTreeLabel.text = NSLocalizedString("Tree", comment: "")
    buyTreeLabel.fontSize = 10
    buyTreeLabel.zPosition = 3
    buyTreeLabel.position = CGPoint(x: 0 , y: -buyTree.frame.height/2 - 10)
    buyTree.addChild(buyTreeLabel)
    
    buyFlower.size = CGSize(width:30, height: 30)
    buyFlower.position = CGPoint(x: buyBG.frame.width/2 - buyFlower.frame.width/2 - 90, y: 5)
    buyFlower.zPosition = 2
    buyBG.addChild(buyFlower)
    
    let buyFlowerLabel = SKLabelNode(fontNamed: "Arial")
    buyFlowerLabel.text = NSLocalizedString("Flower", comment: "")
    buyFlowerLabel.fontSize = 10
    buyFlowerLabel.zPosition = 3
    buyFlowerLabel.position = CGPoint(x: 0 , y: -buyFlower.frame.height/2 - 10)
    buyFlower.addChild(buyFlowerLabel)
    
    buyAnimal.size = CGSize(width:30, height: 30)
    buyAnimal.position = CGPoint(x: buyBG.frame.width/2 - buyAnimal.frame.width/2 - 130, y: 5)
    buyAnimal.zPosition = 2
    buyBG.addChild(buyAnimal)
    
    let buyAnimalLabel = SKLabelNode(fontNamed: "Arial")
    buyAnimalLabel.text = NSLocalizedString("Animal", comment: "")
    buyAnimalLabel.fontSize = 10
    buyAnimalLabel.zPosition = 3
    buyAnimalLabel.position = CGPoint(x: 0 , y: -buyAnimal.frame.height/2 - 10)
    buyAnimal.addChild(buyAnimalLabel)
    
    buyOther.size = CGSize(width:30, height: 30)
    buyOther.position = CGPoint(x: buyBG.frame.width/2 - buyOther.frame.width/2 - 170, y: 5)
    buyOther.zPosition = 2
    buyBG.addChild(buyOther)
    
    let buyOtherLabel = SKLabelNode(fontNamed: "Arial")
    buyOtherLabel.text = NSLocalizedString("Other", comment: "")
    buyOtherLabel.fontSize = 10
    buyOtherLabel.zPosition = 3
    buyOtherLabel.position = CGPoint(x: 0 , y: -buyOther.frame.height/2 - 10)
    buyOther.addChild(buyOtherLabel)
    
    buyClose.name = "buyBGidhiddenF"
    buyClose.size = CGSize(width: 30, height: 30)
    buyClose.position = CGPoint(x: buyBG.frame.width/2 - buyClose.frame.width/2 - 210, y: 5)
    buyClose.zPosition = 1
    buyBG.addChild(buyClose)
    
    let buyCloseLabel = SKLabelNode(fontNamed: "Arial")
    buyCloseLabel.text = NSLocalizedString("Close", comment: "")
    buyCloseLabel.fontSize = 10
    buyCloseLabel.zPosition = 3
    buyCloseLabel.position = CGPoint(x: 0 , y: -buyClose.frame.height/2 - 10)
    buyClose.addChild(buyCloseLabel)
    
    buyOpen.name = "buyBGidhidden"
    buyOpen.size = CGSize(width: 40, height: 40)
    buyOpen.position = CGPoint(x:self.frame.width - buyOpen.frame.width - 10, y:buyOpen.frame.height/2 + 20)
    buyOpen.zPosition = 1
    addChild(buyOpen)
    
    let buyOpenLabel = SKLabelNode(fontNamed: "Arial")
    buyOpenLabel.text = NSLocalizedString("decoration", comment: "")
    buyOpenLabel.fontSize = 10
    buyOpenLabel.zPosition = 3
    buyOpenLabel.position = CGPoint(x: 0 , y: -buyOpen.frame.height/2 - 10)
    buyOpen.addChild(buyOpenLabel)
    
    buyTreeBG.size = CGSize(width: 250, height: 250)
    buyTreeBG.position = CGPoint(x: self.frame.size.width - buyTreeBG.frame.size.width/2 - 40, y:buyTreeBG.frame.height/2 + 80)
    buyTreeBG.zPosition = 1
    buyTreeBG.isHidden = true
    addChild(buyTreeBG)
    
    buyOK.size = CGSize(width: 100, height: 25)
    buyOK.zPosition = 2
    buyOK.name = "buyOK"
    buyOK.position = CGPoint(x: -(buyTreeBG.frame.width - buyOK.frame.width)/2 + 10, y:-(buyTreeBG.frame.height - buyOK.frame.height)/2 + 10 )
    buyTreeBG.addChild(buyOK)
    let buyOKLable = SKLabelNode(fontNamed: "Arial")
    buyOKLable.name = "buyOK"
    buyOKLable.text = NSLocalizedString("OK", comment: "")
    buyOKLable.fontSize = 10
    buyOKLable.zPosition = 3
    buyOKLable.position = CGPoint(x: 0 , y: -(buyOKLable.frame.height/2))
    buyOK.addChild(buyOKLable)
    
    
    buyNO.size = CGSize(width: 100, height: 25)
    buyNO.zPosition = 2
    buyNO.name = "buyNO"
    buyNO.position = CGPoint(x: (buyTreeBG.frame.width - buyNO.frame.width)/2 - 10, y:-(buyTreeBG.frame.height - buyNO.frame.height)/2 + 10 )
    buyTreeBG.addChild(buyNO)
    let buyNOLable = SKLabelNode(fontNamed: "Arial")
    buyNOLable.name = "buyNO"
    buyNOLable.text = NSLocalizedString("Cancel", comment: "")
    buyNOLable.fontSize = 10
    buyNOLable.zPosition = 3
    buyNOLable.position = CGPoint(x: 0 , y: -(buyNOLable.frame.height/2))
    buyNO.addChild(buyNOLable)
    
    goldBG.size = CGSize(width: 90, height: 25)
    goldBG.position = CGPoint(x:150 , y:self.size.height - 20)
    goldBG.name = "gold"
    goldBG.zPosition = 1
    addChild(goldBG)
    
    gold.position = CGPoint(x:-goldBG.frame.width/2 + gold.frame.width/2, y:0)
    gold.zPosition = 2
    gold.size = CGSize(width: 25, height: 25)
    gold.name = "gold"
    goldBG.addChild(gold)
    
    //让金币执行动画
    let goldImages = ["1","2","3","4","5",]
    animateCrocodile(skn: gold, images: goldImages, duration: 0.2)
    
    
    let goldLabel = SKLabelNode(fontNamed: "Arial")
    goldLabel.name = "gold"
    goldLabel.text = "12334"
    goldLabel.fontSize = 18
    goldLabel.zPosition = 3
    goldLabel.position = CGPoint(x: 5 , y: -7)
    goldBG.addChild(goldLabel)

  }
}

//MARK: helper
extension GameScene{
  //执行动画
  func animateCrocodile(skn: SKSpriteNode, images: [String], duration: Double) {
    let duration = duration
    let wait = SKAction.wait(forDuration: duration)
    let open = SKAction.setTexture(SKTexture(imageNamed: images[0]))
    let close = SKAction.setTexture(SKTexture(imageNamed: images[1]))
    let haha = SKAction.setTexture(SKTexture(imageNamed: images[2]))
    let four = SKAction.setTexture(SKTexture(imageNamed: images[3]))
    let five = SKAction.setTexture(SKTexture(imageNamed: images[4]))
    let sequence = SKAction.sequence([wait, open, wait, close, wait, haha, wait, four, wait,five])
    skn.run(SKAction.repeatForever(sequence))
  }
  
  // 执行随机移动
  func move(skn: SKSpriteNode){
    let max: UInt32 = 100
    let min: UInt32 = 5
    
    let tmax: UInt32 = 8
    let tmin: UInt32 = 2
    
    let x = CGFloat(arc4random_uniform(max - min) + min)
    let y = CGFloat(arc4random_uniform(max - min) + min)
    let t = Int(arc4random_uniform(tmax - tmin) + tmin)
    
    let recursive = SKAction.sequence([
      SKAction.moveBy(x: x, y: y, duration: TimeInterval(t)),
      SKAction.moveBy(x: -x, y: -y, duration: TimeInterval(t+1)),
      SKAction.run({self.move(skn: skn)})
      ])
    skn.run(recursive, withKey: "move")
  }
  
  // 雨滴生成
  override func update(_ currentTime: TimeInterval) {
    
    if (self.lastUpdateTime == 0) {
      self.lastUpdateTime = currentTime
    }
    
    let dt = currentTime - self.lastUpdateTime
    currentRainDropSpawnTime += dt
    
    if currentRainDropSpawnTime > rainDropSpawnRate {
      currentRainDropSpawnTime = 0
      spawnRaindrop()
    }
    
    self.lastUpdateTime = currentTime
  }
  
  private func spawnRaindrop() {
    let raindropTexture = SKTexture(imageNamed: "raindrop")
    let raindrop = SKSpriteNode(texture: raindropTexture)
    //物理属性 physicsBody
    raindrop.physicsBody = SKPhysicsBody(texture: raindropTexture, size: raindrop.size)
    raindrop.physicsBody?.categoryBitMask = RainDropCategory
    raindrop.physicsBody?.contactTestBitMask = FloorCategory | WorldCategory
    //随机生成雨滴
    let xPosition = CGFloat(arc4random()).truncatingRemainder(dividingBy: size.width)
    let yPosition = size.height + raindrop.size.height
    raindrop.position = CGPoint(x: xPosition, y: yPosition)
    raindrop.zPosition = 2
    
    addChild(raindrop)
  }
  
  func didBegin(_ contact: SKPhysicsContact) {
    if (contact.bodyA.categoryBitMask == RainDropCategory) {
      contact.bodyA.node?.physicsBody?.collisionBitMask = 0
      contact.bodyA.node?.physicsBody?.categoryBitMask = 0
    } else if (contact.bodyB.categoryBitMask == RainDropCategory) {
      contact.bodyB.node?.physicsBody?.collisionBitMask = 0
      contact.bodyB.node?.physicsBody?.categoryBitMask = 0
    }
    
    if contact.bodyA.categoryBitMask == WorldCategory {
      contact.bodyB.node?.removeFromParent()
      contact.bodyB.node?.physicsBody = nil
      contact.bodyB.node?.removeAllActions()
    } else if contact.bodyB.categoryBitMask == WorldCategory {
      contact.bodyA.node?.removeFromParent()
      contact.bodyA.node?.physicsBody = nil
      contact.bodyA.node?.removeAllActions()
    }
  }
}
