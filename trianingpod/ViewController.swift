//
//  ViewController.swift
//  trianingpod
//
//  Created by 林洪州 on 2017/12/6.
//  Copyright © 2017年 林洪州. All rights reserved.
//

import UIKit
import SnapKit
import JTAppleCalendar
import FontAwesomeKit

class ViewController: UIViewController {
  
  
  var monthLabel: UILabel!
  var calendarView: JTAppleCalendarView!
  var weeksView: UIView!
  
  var testCalendar = Calendar.current
  
  var numberOfRows = 6
  let formatter = DateFormatter()

  var generateInDates: InDateCellGeneration = .forAllMonths
  var generateOutDates: OutDateCellGeneration = .tillEndOfGrid
  var prePostVisibility: ((CellState, CellView?)->())?
  var hasStrictBoundaries = true
  let firstDayOfWeek: DaysOfWeek = .monday
  var prepostHiddenValue = false

  //需要标记的日期
  var selectedDate:[String] = []
  var selectedColors:[UIColor] = []
  
  let appWidth: CGFloat = UIScreen.main.bounds.width
  let appHeight: CGFloat = UIScreen.main.bounds.height

    
  let daysOfWeekSrting = [ NSLocalizedString("MON", comment: ""),
                           NSLocalizedString("TUE", comment: ""),
                           NSLocalizedString("WED", comment: ""),
                           NSLocalizedString("THU", comment: ""),
                           NSLocalizedString("FRI", comment: ""),
                           NSLocalizedString("SAT", comment: ""),
                           NSLocalizedString("SUN", comment: "")
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setCalendarView()
    
  }
  
  
 
}



extension ViewController{
  func setCalendarView(){
    monthLabel = UILabel()
    monthLabel.translatesAutoresizingMaskIntoConstraints = false
    monthLabel.textColor = UIColor.white
    monthLabel.text = "123"
    monthLabel.textAlignment = .center
    monthLabel.font = UIFont.systemFont(ofSize: 20)
    monthLabel.backgroundColor = UIColor.black
    
    weeksView = UIView()
    weeksView.translatesAutoresizingMaskIntoConstraints = false
    weeksView.backgroundColor = UIColor.black
    
    calendarView = JTAppleCalendarView()
    calendarView.translatesAutoresizingMaskIntoConstraints = false
    calendarView.backgroundColor = UIColor.black
    calendarView.calendarDataSource = self
    calendarView.calendarDelegate = self
    calendarView.register(CellView.self, forCellWithReuseIdentifier: "CellView")
    calendarView.scrollDirection = .horizontal
    calendarView.scrollingMode = .stopAtEachCalendarFrame
    calendarView.scrollToDate(Date())
    calendarView.selectDates([Date()])
    
    calendarView.minimumLineSpacing = 0
    calendarView.minimumInteritemSpacing = 0
    
    
    let fontSize: CGFloat = 20
    let nextIonImage = FAKFontAwesome.chevronRightIcon(withSize: fontSize)
    nextIonImage?.setAttributes([NSAttributedStringKey.foregroundColor: UIColor.white])
    let nextImage = nextIonImage?.image(with: CGSize(width: fontSize, height: fontSize))
    
    let previousIonImage = FAKFontAwesome.chevronLeftIcon(withSize: fontSize)
    previousIonImage?.setAttributes([NSAttributedStringKey.foregroundColor: UIColor.white])
    let previousImage = previousIonImage?.image(with: CGSize(width: fontSize, height: fontSize))
    
    let nextBtn = UIButton()
    nextBtn.setImage(nextImage, for: .normal)
    nextBtn.addTarget(self, action: #selector(nextMonth), for: .touchUpInside)
    
    let previousBtn = UIButton()
    previousBtn.setImage(previousImage, for: .normal)
    previousBtn.addTarget(self, action: #selector(previousMonth), for: .touchUpInside)
    
    self.view.addSubview(monthLabel)
    self.view.addSubview(weeksView)
    self.view.addSubview(calendarView)
    self.view.addSubview(nextBtn)
    self.view.addSubview(previousBtn)
    
    
    monthLabel.snp.makeConstraints { (make) -> Void in
      make.left.right.equalTo(view)
      make.top.equalTo(view.snp.top).offset(30)
    }
    
    weeksView.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(monthLabel.snp.bottom)
      make.height.equalTo(40)
      make.left.right.equalTo(view)
    }
    
    calendarView.snp.makeConstraints { (make) -> Void in
      make.size.equalTo(CGSize(width: appWidth, height: appWidth/7*5))
      make.right.left.equalTo(view)
      make.top.equalTo(weeksView.snp.bottom)
    }
    
    nextBtn.snp.makeConstraints { (make) -> Void in
      make.centerY.equalTo(monthLabel)
      make.size.equalTo(CGSize(width: 20, height: 20))
      make.left.equalTo(appWidth/4*3)
    }
    
    previousBtn.snp.makeConstraints { (make) -> Void in
      make.centerY.equalTo(monthLabel)
      make.size.equalTo(CGSize(width: 20, height: 20))
      make.left.equalTo(appWidth/4-20)
    }
  
    for index in 0..<7{
      let leftCGFlot:CGFloat = CGFloat(appWidth/7)  * CGFloat(index)
      let daysOfWeek = UILabel()
      daysOfWeek.text = daysOfWeekSrting[index]
      daysOfWeek.textColor = UIColor.white
      daysOfWeek.backgroundColor = UIColor.clear
      daysOfWeek.textAlignment = .center
      daysOfWeek.font = UIFont.systemFont(ofSize: 16)
      weeksView.addSubview(daysOfWeek)
      daysOfWeek.snp.makeConstraints { (make) -> Void in
        make.left.equalTo(weeksView).offset(leftCGFlot)
        make.centerY.equalTo(weeksView)
        make.size.equalTo(CGSize(width: appWidth/7, height: 40))

      }
    }
  }
  

  

  
}

//MARK:- Helper
extension ViewController{
  @objc func nextMonth(){
    calendarView.scrollToSegment(.next)
  }
  
  
  @objc func previousMonth() {
    calendarView.scrollToSegment(.previous)
  }
  
  func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
    guard let startDate = visibleDates.monthDates.first?.date else {
      return
    }
    let month = testCalendar.dateComponents([.month], from: startDate).month!
    let monthName = DateFormatter().monthSymbols[(month-1) % 12]
    // 0 indexed array
    let year = testCalendar.component(.year, from: startDate)
    monthLabel.text = monthName + " " + String(year)
    
  }
  
  //改变选中的颜色
  func handleCellConfiguration(cell: JTAppleCell?, cellState: CellState) {
    handleCellSelection(view: cell, cellState: cellState)
    handleCellTextColor(view: cell, cellState: cellState)
    prePostVisibility?(cellState, cell as? CellView)
  }
  
  //本月的颜色。 非本月的字体颜色
  func handleCellTextColor(view: JTAppleCell?, cellState: CellState) {
    
    guard let myCustomCell = view as? CellView  else {
      return
    }
    
    if cellState.isSelected {
      myCustomCell.dayLabel.textColor = UIColor.white
    } else {
      if cellState.dateBelongsTo == .thisMonth {
        myCustomCell.dayLabel.textColor = UIColor.white
      } else {
        myCustomCell.dayLabel.textColor = UIColor.gray
      }
    }
    
    
  }
  
  //改变选中的样式
  func handleCellSelection(view: JTAppleCell?, cellState: CellState) {
    guard let myCustomCell = view as? CellView else {return }
    
    if cellState.isSelected {
      myCustomCell.selectedView.layer.cornerRadius =  13
      myCustomCell.selectedView.isHidden = false
      Animate.elasticitAnimate(view: myCustomCell.selectedView)
      Animate.elasticitAnimate(view: myCustomCell.dayLabel)
      Animate.transAnimate(view: myCustomCell.dotMakerView, y: 46.66)
    } else {
      myCustomCell.selectedView.isHidden = true
      Animate.transAnimate(view: myCustomCell.dotMakerView, y: 41.66)
    }
  }
  
  
  
  func configureVisibleCell(myCustomCell: CellView, cellState: CellState, date: Date) {
    myCustomCell.dayLabel.text = cellState.text
    
//    if testCalendar.isDateInToday(date) {
//      myCustomCell.backgroundColor = UIColor.gray
//      //      myCustomCell.dayLabel.textColor = UIColor.red
//    } else {
//      myCustomCell.backgroundColor = UIColor.white
//    }
    
    handleCellConfiguration(cell: myCustomCell, cellState: cellState)
    
    //做标记的的位置
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd"
    let dotMakerDate =  formatter.string(from: date)
    
    selectedDate = ["2018/05/11", "2018/05/12" , "2018/05/13","2018/06/05"]
    selectedColors = [UIColor.red,UIColor.yellow,UIColor.blue]
    //需要判断selectedColors是否为空
    if (selectedDate.contains(dotMakerDate)){
      
      if(dotMakerDate == "2018/05/11"){
        selectedColors = [UIColor.red, UIColor.yellow,UIColor.blue,UIColor.purple]
      }
      
      if(dotMakerDate == "2018/05/13"){
        selectedColors = [UIColor.red]
      }
      myCustomCell.dotMakerView.isHidden = false
      myCustomCell.addMakers(colors: selectedColors, bool: true)
    } else {
      myCustomCell.dotMakerView.isHidden = true
      myCustomCell.addMakers(colors: selectedColors, bool: false)
    }

  }
}






// MARK : JTAppleCalendarDelegate
extension ViewController: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
  
  func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
    //日历的现实日期开始到以后  还有日期的行数
    formatter.dateFormat = "yyyy MM dd"
    formatter.timeZone = testCalendar.timeZone
    formatter.locale = testCalendar.locale
    let startDate = formatter.date(from: "2018 01 01")!
    let endDate = formatter.date(from: "2019 01 01")!
    let parameters = ConfigurationParameters(startDate: startDate,
                                             endDate: endDate,
                                             numberOfRows: numberOfRows,
                                             calendar: testCalendar,
                                             generateInDates: generateInDates,
                                             generateOutDates: generateOutDates,
                                             firstDayOfWeek: firstDayOfWeek,
                                             hasStrictBoundaries: hasStrictBoundaries)
    return parameters
  }
  

  
  func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
    // This function should have the same code as the cellForItemAt function
    let myCustomCell = cell as! CellView
    configureVisibleCell(myCustomCell: myCustomCell, cellState: cellState, date: date)
  }
  
  //日历开始的样式
  func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
    let myCustomCell = calendar.dequeueReusableCell(withReuseIdentifier: "CellView", for: indexPath) as! CellView
    
    configureVisibleCell(myCustomCell: myCustomCell, cellState: cellState, date: date)
    return myCustomCell
  }
  
  //点击别的日期 原来的日期需要更改
  func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
    handleCellConfiguration(cell: cell, cellState: cellState)
  }
  
  //点击事件
  func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
    handleCellConfiguration(cell: cell, cellState: cellState)
  }
  
  //翻页后的操作
  func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
    self.setupViewsOfCalendar(from: visibleDates)
  }

}
