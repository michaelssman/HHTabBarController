//
//  HHTabViewController.swift
//  HHTabBarController_Example
//
//  Created by Michael on 2024/3/21.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import HHTabBarController

class HHTabViewController: UIViewController {
    
    var tabContentView: HHTabContentView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Additional setup after loading the view.
        // Offset for notch screens
        automaticallyAdjustsScrollViewInsets = false
        let barHeight: CGFloat = 40
        let buttonWidth: CGFloat = 40
        tabContentView = HHTabContentView()
        view.addSubview(tabContentView)
        view.addSubview(tabContentView.tabBar)
        //先设置controllers，再设置frame
        initViewControllers()
        tabContentView.tabBar.frame = CGRect(x: 0, y: 88, width: UIScreen.main.bounds.width - buttonWidth, height: barHeight)
        tabContentView.frame = CGRect(x: 0, y: 88 + barHeight, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 88 - barHeight - 49)
        tabContentView.interceptRightSlideGuetureInFirstPage = true
        tabContentView.tabBar.itemTitleColor = .red
        tabContentView.tabBar.itemTitleSelectedColor = .blue
        tabContentView.tabBar.itemTitleFont = .systemFont(ofSize: 11)
        tabContentView.tabBar.itemTitleSelectedFont = .boldSystemFont(ofSize: 15)
        
        tabContentView.tabBar.backgroundColor = .white
        // self.loadViewOfChildControllerWhileAppear = true
        // self.setContentScrollEnabled(true, tapSwitchAnimated: true)
        
        tabContentView.tabBar.indicatorImageView.backgroundColor = .orange
        // self.tabBar.indicatorAnimationStyle = YPTabBarIndicatorAnimationStyle2
        tabContentView.tabBar.indicatorCornerRadius = 2.0
        tabContentView.tabBar.setScrollEnabledAndItemFitTextWidth(spacing: 30, minWidth: 55)
        tabContentView.tabBar.selectedItemIndex = 0
        
        // self.tabContentView.setSelectedTabIndex(1)
        setBadge()
    }
    
    func initViewControllers() {
        var viewControllers = [UIViewController]()
        for i in 0..<7 {
            let vc = UIViewController()
            vc.view.backgroundColor = .orange
            viewControllers.append(vc)
            vc.title = "栏目\(i)"
        }
        tabContentView.viewControllers = viewControllers
    }
    
    func setBadge() {
        // TODO: To be implemented
        for item in tabContentView.tabBar.items {
            // badge
            let badgeButton = item.badgeButton
            // badgeButton.badgeStyle = HHTabItemBadgeStyleNumber
            badgeButton.badgeTitleFont = .systemFont(ofSize: 15)
            badgeButton.badge = 35
            badgeButton.backgroundColor = .cyan
            badgeButton.setTitleColor(.blue, for: .normal)
            badgeButton.setNumberBadge(marginTop: 0, centerMarginRight: 0, titleHorizonalSpace: 0, titleVerticalSpace: 0)
            print("badgeFrame: \(badgeButton.frame)")
        }
    }
}
