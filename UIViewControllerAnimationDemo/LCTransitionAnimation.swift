//
//  LCTransitionAnimation.swift
//  UIViewControllerAnimationDemo
//
//  Created by Chana Li on 18/3/16.
//  Copyright © 2016 Chana Li. All rights reserved.
//

import UIKit

class LCTransitionAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    weak var transitionContextT: UIViewControllerContextTransitioning?
    
    //动画时间
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    //动画过程
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContextT = transitionContext
        
        //计算最后大圆效果的半径
        let containerView = transitionContext.containerView()
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! ViewController
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! ViewController
        let button = fromVC.popBtn
        containerView?.addSubview(toVC.view)
         let circleMaskPathInitial = UIBezierPath(ovalInRect: button.frame)
        let extremePoint = CGPoint(x: button.center.x - 0, y: button.center.y - CGRectGetHeight(toVC.view.bounds))
          let radius = sqrt((extremePoint.x * extremePoint.x) + (extremePoint.y * extremePoint.y))
        let circleMaskPathFinal = UIBezierPath(ovalInRect: CGRectInset(button.frame, -radius, -radius))
        
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = circleMaskPathFinal.CGPath
        toVC.view.layer.mask = maskLayer
        
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = circleMaskPathInitial.CGPath
        maskLayerAnimation.toValue = circleMaskPathFinal.CGPath
        maskLayerAnimation.duration = self.transitionDuration(transitionContext)
        maskLayerAnimation.delegate = self
        maskLayer.addAnimation(maskLayerAnimation, forKey: "path")
        
        
    }
    
    //动画结束
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        self.transitionContextT?.completeTransition(!self.transitionContextT!.transitionWasCancelled())//取消动画
        self.transitionContextT?.viewControllerForKey(UITransitionContextFromViewControllerKey)?.view.layer.mask = nil//释放掉FromViewController
    }
    
    

}
