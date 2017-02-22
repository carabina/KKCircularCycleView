//
//  KKCircularCycleView.swift
//  KKCircularCycleView
//
//  Created by 王铁山 on 2017/2/19.
//  Copyright © 2017年 kk. All rights reserved.
//

import Foundation

import UIKit

public class KKCircularCycleView: UIView {
    
    // MARK: - public
    
    public var hiddenWhenStoped: Bool = true
    
    public var colors: [UIColor] = [UIColor.init(red: 250.0 / 255.0, green: 87.0 / 255.0, blue: 101.0 / 255.0, alpha: 1),
                             UIColor.init(red: 250.0 / 255.0, green: 132.0 / 255.0, blue: 133.0 / 255.0, alpha: 1),
                             UIColor.init(red: 252.0 / 255.0, green: 185.0 / 255.0, blue: 190.0 / 255.0, alpha: 1)
                            ]
    
    public init(origin: CGPoint, radius: CGFloat, padding: CGFloat, duration: NSTimeInterval, colors: [UIColor]?) {
        
        let frame = CGRect.init(x: origin.x, y: origin.y, width: 2 * radius * 3 + 2 * padding, height: 2 * radius)
        
        super.init(frame: frame)
        
        if let c = colors {
            self.colors = c
        }
        
        self.radius = radius
        
        self.padding = padding
        
        self.duration = duration
        
        self.commitInitView()
    }
    
    public override init(frame: CGRect) {
        
        let origin = CGPoint.zero
        
        let frame = CGRect.init(x: origin.x, y: origin.y, width: 2 * self.radius * 3 + 2 * self.padding, height: 2 * self.radius)
        
        super.init(frame: frame)
        
        self.commitInitView()
    }
    
    convenience public init() {
        
        self.init(origin: CGPointZero, radius: 4, padding: 8, duration: 1, colors: nil)
    }
    
    convenience public init(origin: CGPoint) {
        
        self.init(origin: origin, radius: 4, padding: 8, duration: 1, colors: nil)
    }
    
    convenience public init(colors: [UIColor]) {
        
        self.init(origin: CGPoint.zero, radius: 4, padding: 8, duration: 1, colors: colors)
    }
    
    convenience public init(origin: CGPoint, colors: [UIColor]) {
        
        self.init(origin: origin, radius: 4, padding: 8, duration: 1, colors: colors)
    }
    
    public func starAnimation() {
        
        self.willStop = false
        
        self.secondView.layer.addAnimation(self.secondAnimation(), forKey: "group")
        
        self.thirdView.layer.addAnimation(self.thirdAnimation(), forKey: "group")
        
        self.firstView.layer.addAnimation(self.firstAnimation(), forKey: "group")
    }
    
    public func stopAnimation() {
        
        self.willStop = true
        
        if self.hiddenWhenStoped {
            
            self.hidden = true
        }
    }
    
    // MARK: - private
    
    private var willStop: Bool = false
    
    private var radius: CGFloat = 4
    
    private var padding: CGFloat = 8
    
    private var duration: Double = 1
    
    private func commitInitView() {
        
        for i in 0...2 {
            
            let view = UIView.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize(width: 2 * self.radius, height: 2 * self.radius)))
            
            view.center = self.positionAtIndex(i)
            
            view.backgroundColor = self.colors[i]
            
            view.layer.masksToBounds = true
            
            view.layer.cornerRadius = self.radius
            
            self.addSubview(view)
        }
        
        dispatch_async(dispatch_get_main_queue()) { 
            self.starAnimation()
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private var firstView: UIView {
        
        return self.subviews[0]
    }
    
    private var secondView: UIView {
        
        return self.subviews[1]
    }
    
    private var thirdView: UIView {
        
        return self.subviews[2]
    }
    
    private func firstAnimation() -> CAAnimation {
        
        let first = self.positionAtIndex(0)
        
        let second = self.positionAtIndex(1)
        
        let third = self.positionAtIndex(2)
        
        let path = CGPathCreateMutable()
        
        // 第一个点
        CGPathMoveToPoint(path, nil, first.x, first.y)
        
        // 第一个点到第二个点的半圆
        CGPathAddArc(path, nil, (first.x + second.x) / 2.0, first.y, self.radius + self.padding / 2.0, CGFloat(M_PI), 0, false)
        
        // 第二个点到第三个点的半圆
        CGPathAddArc(path, nil, (second.x + third.x) / 2.0, second.y, self.radius + self.padding / 2.0, CGFloat(M_PI), 0, true)
        
        let animation = CAKeyframeAnimation.init(keyPath: "position")
        
        animation.path = path
        
        animation.calculationMode = kCAAnimationPaced;
        
        let alpha = CABasicAnimation.init(keyPath: "backgroundColor")
        
        alpha.fromValue = self.colors[0].CGColor
        
        alpha.toValue = self.colors[2].CGColor
        
        let group = CAAnimationGroup.init()
        
        group.animations = [animation,alpha]
        
        group.duration = self.duration
        
        group.fillMode = kCAFillModeForwards
        
        group.delegate = self
                
        return group
    }
    
    private func thirdAnimation() -> CAAnimation {
        
        let second = self.positionAtIndex(1)
        
        let third = self.positionAtIndex(2)
        
        let path = CGPathCreateMutable()
        
        // 第三个点
        CGPathMoveToPoint(path, nil, third.x, third.y)
        
        // 第三个点到第二个点的半圆
        CGPathAddArc(path, nil, (third.x + second.x) / 2.0, second.y, self.radius + self.padding / 2.0, 0, CGFloat(M_PI) , true)
        
        let animation = CAKeyframeAnimation.init(keyPath: "position")
        
        animation.path = path
        
        animation.calculationMode = kCAAnimationPaced;
        
        let alpha = CABasicAnimation.init(keyPath: "backgroundColor")
        
        alpha.fromValue = self.colors[2].CGColor
        
        alpha.toValue = self.colors[1].CGColor
        
        let group = CAAnimationGroup.init()
        
        group.animations = [animation,alpha]
        
        group.duration = self.duration
        
        group.fillMode = kCAFillModeForwards
        
        return group
    }
    
    private func secondAnimation() -> CAAnimation {
        
        let first = self.positionAtIndex(0)
        
        let second = self.positionAtIndex(1)
        
        let path = CGPathCreateMutable()
        
        // 第二个点
        CGPathMoveToPoint(path, nil, second.x, second.y)
        
        // 第二个点到第一个点的半圆
        CGPathAddArc(path, nil, (first.x + second.x) / 2.0, first.y, self.radius + self.padding / 2.0, 0, CGFloat(M_PI) , false)
        
        let animation = CAKeyframeAnimation.init(keyPath: "position")
        
        animation.path = path
        
        animation.calculationMode = kCAAnimationPaced;
        
        let alpha = CABasicAnimation.init(keyPath: "backgroundColor")
        
        alpha.fromValue = self.colors[1].CGColor
        
        alpha.toValue = self.colors[0].CGColor
        
        let group = CAAnimationGroup.init()
        
        group.animations = [animation,alpha]
        
        group.duration = self.duration
        
        group.fillMode = kCAFillModeForwards
        
        return group
    }
    
    private func positionAtIndex(index: Int) -> CGPoint {
        
        return CGPoint.init(x: self.radius + CGFloat(index) * (2 * self.radius + self.padding), y: self.radius)
    }
    
    private func realStopAnimation() {
        
        self.firstView.layer.removeAnimationForKey("group")
        
        self.secondView.layer.removeAnimationForKey("group")
        
        self.thirdView.layer.removeAnimationForKey("group")
    }
    
    override public func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        
        if self.willStop {
            return
        }
        
        if flag {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 350 * Int64(NSEC_PER_MSEC)), dispatch_get_main_queue(), {
                
                self.starAnimation()
            })
        }
    }
}




