//
//  HHBadgeButton.swift
//  HHObjectiveCDemo
//
//  Created by Michael on 2023/4/3.
//

import UIKit
import HHUtils

enum HHTabItemBadgeStyle: UInt {
    case number = 0 // 数字样式
    case dot = 1 // 小圆点
}

public class HHBadgeButton: UIButton {
    // 显示badge的数值
    @objc public var badge: Int = 0 {
        didSet {
            updateBadge()
        }
    }
    
    // badge的样式
    var badgeStyle: HHTabItemBadgeStyle = .number
    
    // badge的标题字体
    @objc public var badgeTitleFont: UIFont? {
        didSet {
            self.titleLabel?.font = badgeTitleFont
            updateBadge()
        }
    }
    
    /// badgeButton与TabItem顶部的距离
    private var numberBadgeMarginTop: CGFloat = 0
    /// badgeButton中心与TabItem右侧的距离
    private var numberBadgeCenterMarginRight: CGFloat = 0
    private var numberBadgeTitleHorizonalSpace: CGFloat = 0
    private var numberBadgeTitleVerticalSpace: CGFloat = 0
    /// badgeButton与TabItem顶部的距离
    private var dotBadgeMarginTop: CGFloat = 0
    private var dotBadgeCenterMarginRight: CGFloat = 0
    private var dotBadgeSideLength: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = false
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 设置数字badge的位置
    @objc public func setNumberBadge(marginTop: CGFloat, centerMarginRight: CGFloat, titleHorizonalSpace: CGFloat, titleVerticalSpace: CGFloat) {
        numberBadgeMarginTop = marginTop
        numberBadgeCenterMarginRight = centerMarginRight
        numberBadgeTitleHorizonalSpace = titleHorizonalSpace
        numberBadgeTitleVerticalSpace = titleVerticalSpace
        updateBadge()
    }
    
    // 设置小圆点badge的位置
    @objc func setDotBadge(marginTop: CGFloat, centerMarginRight: CGFloat, sideLength: CGFloat) {
        dotBadgeMarginTop = marginTop
        dotBadgeCenterMarginRight = centerMarginRight
        dotBadgeSideLength = sideLength
        updateBadge()
    }
    
    // 更新badge
    @objc func updateBadge() {
        if badgeStyle == .number {
            if badge == 0 {
                isHidden = true
            } else {
                var badgeStr = String(badge)
                if badge > 99 {
                    badgeStr = "99+"
                } else if badge < -99 {
                    badgeStr = "-99+"
                }
                setTitle(badgeStr, for: .normal)
                // 计算badgeStr的size
                let size = badgeStr.calculateStringSize(font: (titleLabel?.font)!)
                // 计算badgeButton的宽度和高度
                var width = ceil(size.width) + numberBadgeTitleHorizonalSpace
                let height = ceil(size.height) + numberBadgeTitleVerticalSpace
                // 宽度取width和height的较大值，使badge为个数时，badgeButton为圆形
                width = max(width, height)
                // 设置badgedButton的frame
                frame = CGRect(x: superview?.bounds.size.width ?? 0 - width / 2 - numberBadgeCenterMarginRight, y: numberBadgeMarginTop, width: width, height: height)
                layer.cornerRadius = bounds.size.height / 2.0
                isHidden = false
            }
        } else if badgeStyle == .dot {
            setTitle(nil, for: .normal)
            frame = CGRect(x: superview?.bounds.size.width ?? 0 - dotBadgeCenterMarginRight - dotBadgeSideLength, y: dotBadgeMarginTop, width: dotBadgeSideLength, height: dotBadgeSideLength)
            layer.cornerRadius = bounds.size.width / 2.0
            isHidden = false
        }
    }
}
