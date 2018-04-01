//
//  ViewController.swift
//  trianingpod
//
//  Created by 林洪州 on 2017/12/6.
//  Copyright © 2017年 林洪州. All rights reserved.
//

import UIKit
import RealmSwift
import DatePickerDialog
import SnapKit
import Hue
import Photos
import PDFReader


//相簿列表项
struct HGImageAlbumItem {
  //相簿名称
  var title: String?
  //相簿内的资源
  var fetchResult: PHFetchResult<PHAsset>
  
}

class ViewController: UIViewController {
  var imageCollectionView: UICollectionView!
  
  fileprivate var alertStyle: UIAlertControllerStyle = .actionSheet
  var items:[HGImageAlbumItem] = []
  //取得的资源结果，用了存放的PHAsset
  var assetsFetchResults: PHFetchResult<PHAsset>?
  //带缓存的图片管理对象
  var imageManager: PHCachingImageManager!
  //缩略图大小
  var assetGridThumbnailSize: CGSize!
   //照片选择完毕后的回调
  var completeHandler:((_ assets:[PHAsset])->())?
  //完成按钮
//  var completeButton: HGImageCompleteButton!
  
  var DateItems: Results<ConsumeItem>!
  
    override func viewDidLoad() {
      super.viewDidLoad()

//      setPickView()
      setColorPick()
     
      }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
  private func showDocument(_ document: PDFDocument) {
    let image = UIImage(named: "")
    let controller = PDFViewController.createNew(with: document, title: "", actionButtonImage: image, actionStyle: .activitySheet)
    navigationController?.pushViewController(controller, animated: true)
  }

}


//mark:- UI
extension ViewController{
  //颜色选择器
  func setColorPick(){
    let alert = UIAlertController(style: self.alertStyle)
    
    alert.addColorPicker(color: UIColor(hex: 0xFF2DC6), title: "Selcet color") { color in Log(color)
      print("颜色\(color.hexString)")
      self.view.backgroundColor = color
    }
    alert.addAction(title: "Cancel", style: .cancel){ _ in
      
    }
    alert.show()
  }
  

  //数字选择pickview
  func setPickView(){
    let alert = UIAlertController(style: self.alertStyle, title: "Picker View", message: "Preferred Content Height")
    let frameSizes: [CGFloat] = (8...23).map { CGFloat($0) }
    let pickerViewValues: [[String]] = [frameSizes.map { Int($0).description }]
    let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: frameSizes.index(of: 3) ?? 0)
    
    alert.addPickerView(values: pickerViewValues, initialSelection: pickerViewSelectedValue) { vc, picker, index, values in
      var i = Int(frameSizes[index.row])
      
      print("\(i)")
      
    }
    alert.addAction(title: "Done", style: .cancel)
    alert.show()
  }
  
  func setupCollectionView(){
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 90 , height: 100)
    layout.scrollDirection = .vertical
    layout.minimumInteritemSpacing = 5
    layout.minimumLineSpacing = 5
    layout.sectionHeadersPinToVisibleBounds = true
    layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    
    imageCollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
    imageCollectionView.translatesAutoresizingMaskIntoConstraints = false
    imageCollectionView.tag = 1
    imageCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    imageCollectionView.dataSource = self
    imageCollectionView.delegate = self
    imageCollectionView.backgroundColor = UIColor.white
    view.addSubview(imageCollectionView)
    
    imageCollectionView.snp.makeConstraints{ (make) -> Void in
      make.top.equalTo(self.view.snp.top).offset(64)
      make.left.right.equalTo(view)
      make.right.equalTo(view)
      make.bottom.equalTo(view.snp.bottom)
    }
  }
}


//mark: helper
extension ViewController{
  func resetCachedAssets(){
    self.imageManager.stopCachingImagesForAllAssets()
  }
  private func titleOfAlbumForChinse(title:String?) -> String? {
    if title == "Slo-mo" {
      return "慢动作"
    } else if title == "Recently Added" {
      return "最近添加"
    } else if title == "Favorites" {
      return "个人收藏"
    } else if title == "Recently Deleted" {
      return "最近删除"
    } else if title == "Videos" {
      return "视频"
    } else if title == "All Photos" {
      return "所有照片"
    } else if title == "Selfies" {
      return "自拍"
    } else if title == "Screenshots" {
      return "屏幕快照"
    } else if title == "Camera Roll" {
      return "相机胶卷"
    }
    return title
  }
  
  
  
  //转化处理获取到的相簿
  private func convertCollection(collection:PHFetchResult<PHAssetCollection>){
    for i in 0..<collection.count{
      //获取出但前相簿内的图片
      let resultsOptions = PHFetchOptions()
      resultsOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
      resultsOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
      let c = collection[i]
      let assetsFetchResult = PHAsset.fetchAssets(in: c , options: resultsOptions)
      //没有图片的空相簿不显示
      if assetsFetchResult.count > 0 {
        let title = titleOfAlbumForChinse(title: c.localizedTitle)
        items.append(HGImageAlbumItem(title: title, fetchResult: assetsFetchResult))
      }
    }
  }
  func findImages(){
   
    
      // 列出所有系统的智能相册
      let smartOptions = PHFetchOptions()
      let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: smartOptions)
      self.convertCollection(collection: smartAlbums)
      
      //列出所有用户创建的相册
      let userCollections = PHCollectionList.fetchTopLevelUserCollections(with: nil)
      self.convertCollection(collection: userCollections as! PHFetchResult<PHAssetCollection>)
      
      //相册按包含的照片数量排序（降序）
      self.items.sort { (item1, item2) -> Bool in
        return item1.fetchResult.count > item2.fetchResult.count
      }
      let fetchResult = self.items.first?.fetchResult
      //传递相簿内的图片资源
      self.assetsFetchResults = fetchResult
      //异步加载表格数据,需要在主线程中调用reloadData() 方法
//      DispatchQueue.main.async{
//        self.tableView?.reloadData()
//
//        //首次进来后直接进入第一个相册图片展示页面（相机胶卷）
//        if let imageCollectionVC = self.storyboard?
//          .instantiateViewController(withIdentifier: "hgImageCollectionVC")
//          as? HGImageCollectionViewController{
//          imageCollectionVC.title = self.items.first?.title
//          imageCollectionVC.assetsFetchResults = self.items.first?.fetchResult
//          imageCollectionVC.completeHandler = self.completeHandler
//          imageCollectionVC.maxSelected = self.maxSelected
//          self.navigationController?.pushViewController(imageCollectionVC,
//                                                        animated: false)
//        }
//      }

  }
}


//
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate{
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.assetsFetchResults?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
    cell.backgroundColor = UIColor.red
    
    let asset = self.assetsFetchResults![indexPath.row]
    //获取缩略图
    self.imageManager.requestImage(for: asset, targetSize: assetGridThumbnailSize,contentMode: .aspectFill, options: nil) {(image, nfo) in
      cell.imageView.image = image
    }
    
    return cell
  }
  
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
   let asset = self.assetsFetchResults![indexPath.row]
    print(asset)

  }
  
}
