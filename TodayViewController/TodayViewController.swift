//
//  TodayViewController.swift
//  TodayViewController
//
//  Created by 林洪州 on 2018/3/6.
//  Copyright © 2018年 林洪州. All rights reserved.
//

import UIKit
import NotificationCenter
import SnapKit
import TextFieldEffects
import FontAwesomeKit
import CVCalendar


class TodayViewController: UIViewController, NCWidgetProviding {
  
  var menuView: CVCalendarMenuView!
  var calendarView: CVCalendarView!
  var monthLabel: UILabel!
  private var currentCalendar: Calendar?
    override func viewDidLoad() {
        super.viewDidLoad()
      
      preferred()
      setCalendar()

      
    }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    menuView.commitMenuViewUpdate()
    calendarView.commitCalendarViewUpdate()
  }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
      
        
        completionHandler(NCUpdateResult.newData)
    }
  
  func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
    print("maxWidth %f maxHeight %f",maxSize.width,maxSize.height)
    
    if activeDisplayMode == NCWidgetDisplayMode.compact {
      self.preferredContentSize = CGSize(width:maxSize.width,height: 100);
    }else{
      self.preferredContentSize = CGSize(width: maxSize.width,height: 30 + monthLabel.frame.height + menuView.frame.height + calendarView.frame.height);
    }
  }
}

//Mark:- UI
extension TodayViewController{
  func setCalendar(){
    monthLabel = UILabel()
    monthLabel.translatesAutoresizingMaskIntoConstraints = false
    monthLabel.backgroundColor = UIColor.clear
    monthLabel.text = CVDate(date: Date()).globalDescription
    monthLabel.textAlignment = .center
    monthLabel.textColor = UIColor.darkGray
    monthLabel.font = UIFont(name: "AmericanTypewriter-Bold", size: 20)
    
    menuView = CVCalendarMenuView()
    menuView.backgroundColor = UIColor.clear
    menuView.dayOfWeekFont = UIFont(name: "AmericanTypewriter", size: 16)
    menuView.menuViewDelegate = self
    menuView.translatesAutoresizingMaskIntoConstraints = false
    
    calendarView = CVCalendarView()
    calendarView.backgroundColor = UIColor.clear
    calendarView.translatesAutoresizingMaskIntoConstraints = false
    calendarView.calendarAppearanceDelegate = self
    calendarView.animatorDelegate = self
    calendarView.calendarDelegate = self
    
    view.addSubview(monthLabel)
    view.addSubview(menuView)
    view.addSubview(calendarView)
    
    monthLabel.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(view.snp.top).offset(5)
      make.left.equalTo(view)
      make.right.equalTo(view)
    }
    
    menuView.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(monthLabel.snp.bottom)
      make.left.equalTo(view)
      make.right.equalTo(view)
      make.height.equalTo(30)
    }
    
    calendarView.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(menuView.snp.bottom)
      make.left.equalTo(view)
      make.right.equalTo(view)
      make.height.equalTo(300)
    }
  }
}

//Mark:- Helper
extension TodayViewController{
  func preferred(){
    if ProcessInfo().isOperatingSystemAtLeast(OperatingSystemVersion(majorVersion: 10, minorVersion: 0, patchVersion: 0)) {
      //在ios10 中支持折叠
      self.extensionContext?.widgetLargestAvailableDisplayMode = NCWidgetDisplayMode.expanded
    }
    
  }
}

extension TodayViewController:CVCalendarViewDelegate, CVCalendarMenuViewDelegate, CVCalendarViewAppearanceDelegate{
 func presentationMode() -> CalendarMode {
  return .monthView
  
  }
 
  func firstWeekday() -> Weekday {
    return .monday
  }
  func shouldAutoSelectDayOnMonthChange() -> Bool { return false }
  func presentedDateUpdated(_ date: CVDate) {
    monthLabel.text = date.globalDescription
  }

  func latestSelectableDate() -> Date {
    return Date()
  }
  
 
 
}


