//
//  LCNavigationControllerDelegate.swift
//  UIViewControllerAnimationDemo
//
//  Created by Chana Li on 18/3/16.
//  Copyright © 2016 Chana Li. All rights reserved.
//

import UIKit

class LCNavigationDelegate: NSObject ,UINavigationControllerDelegate{//实现UINavigationControllerDelegate的协议
    @IBOutlet weak var navigationController: UINavigationController!
    var interactionController: UIPercentDrivenInteractiveTransition?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let panGesture = UIPanGestureRecognizer(target: self, action: Selector("panned:"))
      self.navigationController.view.addGestureRecognizer(panGesture)
    }
    
    func panned(gestureRecognizer: UIPanGestureRecognizer){
    
        switch gestureRecognizer.state{//gestureRecognizer的几个状态
        case .Began://手势被识别时，初始化UIPercentDrivenInteractiveTransition 实例对象和设置属性，比如如果是第一个VC就实现push，反之是pop
            self.interactionController = UIPercentDrivenInteractiveTransition()
            if self.navigationController?.viewControllers.count > 1{
            self.navigationController?.popViewControllerAnimated(true)
            }else{
        self.navigationController?.topViewController!.performSegueWithIdentifier("PushSegue", sender: nil)
            }
        case .Changed://开始手势和结束手势的一个过程，下面代码中是根据偏移量改变self.interactionController的位置
            let translation = gestureRecognizer.translationInView(self.navigationController!.view)
            let completionProgress = translation.x / CGRectGetWidth(self.navigationController!.view.bounds)
            self.interactionController?.updateInteractiveTransition(completionProgress)
        case .Ended://手势结束以后的操作，设置动画结束或者取消动画，最后将self.interactionController置为nil
            if(gestureRecognizer.velocityInView(self.navigationController!.view).x > 0){
            self.interactionController?.finishInteractiveTransition()
            }else{
            self.interactionController?.cancelInteractiveTransition()
            }
            self.interactionController = nil
        default://其他的状态
            self.interactionController?.cancelInteractiveTransition()
            self.interactionController = nil
        }
        
    }
    
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return LCTransitionAnimation();//执行动画效果
    }
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactionController//self.interactionController 导航控制器
    }
}
