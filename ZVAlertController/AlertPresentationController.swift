//
//  AlertPresentationController.swift
//  ZVAlertController
//
//  Created by 张伟 on 2019/9/19.
//  Copyright © 2019 zevwings. All rights reserved.
//

#if !os(macOS)

import UIKit

class AlertPresentationController: UIPresentationController {

    private var dimmingView: UIView
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        
        dimmingView = UIView()
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    override func presentationTransitionWillBegin() {
        containerView?.addSubview(dimmingView)
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstaints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[dimmingView]-0-|", options: .init(rawValue: 0), metrics: nil, views: ["dimmingView": dimmingView])
        NSLayoutConstraint.activate(horizontalConstaints)
        
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[dimmingView]-0-|", options: .init(rawValue: 0), metrics: nil, views: ["dimmingView": dimmingView])
        NSLayoutConstraint.activate(verticalConstraints)

        let transitionCoordinator = presentingViewController.transitionCoordinator
        dimmingView.alpha = 0
        transitionCoordinator?.animate(alongsideTransition: { context in
            self.dimmingView.alpha = 1.0
        }, completion: nil)
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            dimmingView.removeFromSuperview()
        }
    }
    
    override func dismissalTransitionWillBegin() {
        let transitionCoordinator = presentingViewController.transitionCoordinator
        transitionCoordinator?.animate(alongsideTransition: { (context) in
            self.dimmingView.alpha = 0.0
        }, completion: nil)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        dimmingView.removeFromSuperview()
    }
    
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        let transitionCoordinator = presentingViewController.transitionCoordinator
        if let transitionCoordinator = transitionCoordinator, let presentedView = presentedView, let containerView = containerView, transitionCoordinator.isAnimated {
            
            presentedView.translatesAutoresizingMaskIntoConstraints = false
            presentedView.layer.cornerRadius = 8
            presentedView.layer.masksToBounds = true
            
            let centerX = NSLayoutConstraint(item: presentedView, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
            centerX.isActive = true
            let centerY = NSLayoutConstraint(item: presentedView, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
            centerY.isActive = true
            let width = NSLayoutConstraint(item: presentedView, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 0.8, constant: 0.0)
            width.isActive = true
        }
    }
}

#endif
