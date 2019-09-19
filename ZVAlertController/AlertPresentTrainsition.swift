//
//  ZVAlertPresentTrainsition.swift
//  ZVAlertController
//
//  Created by 张伟 on 2019/9/19.
//  Copyright © 2019 zevwings. All rights reserved.
//

import UIKit

public enum AlertPresentStyle {
    case system
    case bounce
    case fadeIn
    case expandHorizontal
    case expandvertical
    case slideDown
    case slideUp
    case slideLeft
    case slideRight
    
    fileprivate var animationDuration: TimeInterval {
        switch self {
        case .system: return 0.3
        case .fadeIn: return 0.3
        case .bounce: return 0.3
        case .expandHorizontal: return 0.4
        case .expandvertical: return 0.4
        case .slideDown: return 0.5
        case .slideUp: return 0.5
        case .slideLeft: return 0.4
        case .slideRight: return 0.4
        }
    }
}

final class AlertPresentTrainsition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var presentStyle: AlertPresentStyle = .bounce
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return presentStyle.animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        switch presentStyle {
        case .system:
            systemAnimation(using: transitionContext)
            break
        case .fadeIn:
            fadeInAnimation(using: transitionContext)
            break
        case .bounce:
            bounceAnimation(using: transitionContext)
            break
        case .expandHorizontal:
            expandHorizontalAnimation(using: transitionContext)
            break
        case .expandvertical:
            expandverticalAnimation(using: transitionContext)
            break
        case .slideDown:
            slideDownAnimation(using: transitionContext)
            break
        case .slideUp:
            slideUpAnimation(using: transitionContext)
            break
        case .slideLeft:
            slideLeftAnimation(using: transitionContext)
            break
        case .slideRight:
            slideRightAnimation(using: transitionContext)
            break

        }
    }
    
    private func presentedView(_ presntedView: UIView ,to containerView: UIView) {
        containerView.addSubview(presntedView)
        
        presntedView.layer.cornerRadius = 8
        presntedView.layer.masksToBounds = true
        presntedView.translatesAutoresizingMaskIntoConstraints = false
        
        let centerX = NSLayoutConstraint(item: presntedView, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        centerX.isActive = true
        let centerY = NSLayoutConstraint(item: presntedView, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        centerY.isActive = true
        let width = NSLayoutConstraint(item: presntedView, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 0.8, constant: 0.0)
        width.isActive = true
    }

    private func systemAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        
        let duration = transitionDuration(using: transitionContext)
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        toView.alpha = 0
        containerView.alpha = 0
        toView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        
        presentedView(toView, to: containerView)
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            toView.alpha = 1
            containerView.alpha = 1
            toView.transform = .identity
        }, completion: { isFinished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
        
    }
    
    private func fadeInAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        
        let duration = transitionDuration(using: transitionContext)
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        toView.alpha = 0
        containerView.alpha = 0
        presentedView(toView, to: containerView)
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            toView.alpha = 1
            containerView.alpha = 1
        }, completion: { isFinished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    private func bounceAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        
        let duration = transitionDuration(using: transitionContext)
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        toView.alpha = 0
        containerView.alpha = 0
        toView.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        presentedView(toView, to: containerView)
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            toView.alpha = 1
            containerView.alpha = 1
            toView.transform = .identity
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    private func expandHorizontalAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        
        let duration = transitionDuration(using: transitionContext)
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        toView.alpha = 0
        containerView.alpha = 0
        toView.transform = CGAffineTransform(scaleX: 0, y: 1)
        
        presentedView(toView, to: containerView)
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            toView.alpha = 1
            containerView.alpha = 1
            toView.transform = .identity
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    private func expandverticalAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        
        let duration = transitionDuration(using: transitionContext)
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        toView.alpha = 0
        containerView.alpha = 0
        toView.transform = CGAffineTransform(scaleX: 1, y: 0)
        
        presentedView(toView, to: containerView)
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            toView.alpha = 1
            containerView.alpha = 1
            toView.transform = .identity
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    private func slideDownAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        
        let duration = transitionDuration(using: transitionContext)
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        toView.alpha = 0
        containerView.alpha = 0
        toView.center = CGPoint(x: containerView.center.x, y: -toView.frame.height / 2.0)

        presentedView(toView, to: containerView)
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            toView.alpha = 1
            containerView.alpha = 1
            toView.center = containerView.center
        }, completion: { isFinished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    private func slideUpAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        
        let duration = transitionDuration(using: transitionContext)
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        toView.alpha = 0
        containerView.alpha = 0
        toView.center = CGPoint(x: containerView.center.x, y: containerView.frame.height + toView.frame.height/2.0)
        
        presentedView(toView, to: containerView)
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            toView.alpha = 1
            containerView.alpha = 1
            toView.center = containerView.center
        }, completion: { isFinished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    private func slideLeftAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        
        let duration = transitionDuration(using: transitionContext)
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        toView.alpha = 0
        containerView.alpha = 0
        toView.center = CGPoint(x: containerView.frame.width + toView.frame.width, y: containerView.center.y)
        
        presentedView(toView, to: containerView)
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            toView.alpha = 1
            containerView.alpha = 1
            toView.center = containerView.center
        }, completion: { isFinished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    private func slideRightAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        
        let duration = transitionDuration(using: transitionContext)
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        toView.alpha = 0
        containerView.alpha = 0
        toView.center = CGPoint(x: -toView.frame.width, y: containerView.center.y)
        
        presentedView(toView, to: containerView)
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            toView.alpha = 1
            containerView.alpha = 1
            toView.center = containerView.center
        }, completion: { isFinished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}

