//
//  ViewController.swift
//  trianingpod
//
//  Created by 林洪州 on 2017/12/6.
//  Copyright © 2017年 林洪州. All rights reserved.
//

import UIKit
import ViewAnimator
import Gemini
import CircleMenu
import AnimatedCollectionViewLayout

class ViewController: UIViewController {
    
    
    let kIdentifer = "ThemeViewControllerCell"
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupcollectionview()
        setupbtn()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
extension ViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
   

    func setupcollectionview(){
        
    
        let layout = AnimatedCollectionViewLayout()
        layout.animator = PageAttributesAnimator()
    
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 200)
//        //滑动方向 默认方向是垂直
        layout.scrollDirection = .horizontal
//        //每个Item之间最小的间距
//        layout.minimumInteritemSpacing = 0
//        //每行之间最小的间距
//        layout.minimumLineSpacing = 0


        let collectionView = UICollectionView(frame: CGRect(x:0, y:0, width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.height), collectionViewLayout: layout)

        collectionView.register(ThemeViewControllerCell.self, forCellWithReuseIdentifier: kIdentifer)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self;
        collectionView.dataSource = self;

        
        
        
        self.view.addSubview(collectionView);
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kIdentifer, for: indexPath)as! ThemeViewControllerCell
        
       let cos = [UIColor.red, UIColor.yellow, UIColor.blue,UIColor.red, UIColor.yellow, UIColor.blue,UIColor.red, UIColor.yellow, UIColor.blue,UIColor.red, UIColor.yellow, UIColor.blue,UIColor.red, UIColor.yellow, UIColor.blue]
    let coss = cos[indexPath.row]
        
        cell.backgroundColor = coss
        
        
        
        return cell
    }
    
}
extension ViewController: CircleMenuDelegate{
    func setupbtn(){
        let button = CircleMenu(
            frame: CGRect(x: 200, y: 200, width: 50, height: 50),
            normalIcon:"icon_menu",
            selectedIcon:"icon_close",
            buttonsCount: 4,
            duration: 1,
            distance: 120)
        button.delegate = self
        button.layer.cornerRadius = button.frame.size.width / 2.0
        button.backgroundColor = UIColor.black
        
     
        
        
        view.addSubview(button)
    }
    
    
    func circleMenu(_ circleMenu: CircleMenu, willDisplay button: UIButton, atIndex: Int){
        let items: [(icon: String, color: UIColor)] = [
            ("icon_menu", UIColor(red:0.90, green:0.57, blue:1, alpha:1)),
            ("icon_menu", UIColor(red:0.22, green:0.74, blue:0, alpha:1)),
            ("icon_close", UIColor(red:0.96, green:0.23, blue:0.21, alpha:1)),
            ("icon_close", UIColor(red:0.39, green:1.79, blue:0.66, alpha:2)),
            ]
        
        
        
        
        button.backgroundColor = items[atIndex].color
        button.setImage(UIImage(named: items[atIndex].icon), for: .normal)
    }
    
    
    func circleMenu(_ circleMenu: CircleMenu, buttonWillSelected button: UIButton, atIndex: Int) {
        print("button will selected: \(atIndex)")
    }
    
    func circleMenu(_ circleMenu: CircleMenu, buttonDidSelected button: UIButton, atIndex: Int) {
        print("button did selected: \(atIndex)")
    }
}

