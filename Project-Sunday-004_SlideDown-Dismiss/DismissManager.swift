//
//  DismissManager.swift
//  Project-Sunday-004_SlideDown-Dismiss
//
//  Created by Virata Yindeeyoungyeon on 7/1/17.
//  Copyright © 2017 ObjV. All rights reserved.
//

import UIKit

class DismissManager: NSObject,UIViewControllerTransitioningDelegate {
    static let sharedInstance = DismissManager()
    var isInteract:Bool?
    var percentDrivenInteractive:UIPercentDrivenInteractiveTransition?
    
    override init() {
        super.init()
        isInteract = false
        percentDrivenInteractive = nil
    }
    
    func handleGesture(progress:CGFloat,gestureState:UIGestureRecognizerState,gestureAction:()->()) {
        switch gestureState {
        case .began:
            isInteract = true
            percentDrivenInteractive = UIPercentDrivenInteractiveTransition()
            gestureAction()
        case .changed:
            percentDrivenInteractive?.update(progress)
        case .ended:
            isInteract = false
            if progress > 0.3 {
                percentDrivenInteractive?.finish()
            } else {
                percentDrivenInteractive?.cancel()
            }
        case .cancelled:
            isInteract = false
            percentDrivenInteractive?.cancel()
        default:
            break
        }
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimatedController()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return isInteract! ? percentDrivenInteractive : nil
    }
}
