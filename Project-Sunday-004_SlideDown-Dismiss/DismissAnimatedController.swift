//
//  DismissAnimatedController.swift
//  Project-Sunday-004_SlideDown-Dismiss
//
//  Created by Virata Yindeeyoungyeon on 7/1/17.
//  Copyright © 2017 ObjV. All rights reserved.
//

import UIKit

let kAnimationInterval:TimeInterval = 0.4

class DismissAnimatedController: NSObject,UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return kAnimationInterval;
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let toViewController = transitionContext.viewController(forKey: .to),
            let fromViewController = transitionContext.viewController(forKey: .from)
            else {return}
        
        //Insert toViewController's view below fromViewController's view
        let containerView = transitionContext.containerView
        containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
        
        //Compute final frame for fromViewController's view
        let containerRect = containerView.bounds
        let finalFrame = CGRect(x: 0, y: containerRect.height, width: containerRect.width, height: containerRect.height)
        
        //Animate fromViewController
        UIView.animate(withDuration: kAnimationInterval, animations: {
            fromViewController.view.frame = finalFrame
        }) { (finished) in
            let cancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!cancelled)
        }
    }
}
