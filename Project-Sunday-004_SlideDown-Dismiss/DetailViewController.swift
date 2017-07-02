//
//  DetailViewController.swift
//  Project-Sunday-004_SlideDown-Dismiss
//
//  Created by Virata Yindeeyoungyeon on 7/1/17.
//  Copyright © 2017 ObjV. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: init methods
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setupTransitioningDelegate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupTransitioningDelegate()
    }
    
    private func setupTransitioningDelegate() {
        self.transitioningDelegate = DismissManager.sharedInstance
    }

    //MARK: gesture
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupGesture()
    }
    
    private func setupGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(pan(gesture:)))
        self.view.addGestureRecognizer(panGesture)
    }
    
    func pan(gesture:UIPanGestureRecognizer) {
        let percent = gesture.translation(in: self.view).y/self.view.bounds.height
        DismissManager.sharedInstance.handleGesture(progress: percent, gestureState: gesture.state, gestureAction: dismiss)
    }
    
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}
