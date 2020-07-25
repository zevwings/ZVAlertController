//
//  ZVAlertDismissTrainsition.swift
//  ZVAlertController
//
//  Created by 张伟 on 2019/9/19.
//  Copyright © 2019 zevwings. All rights reserved.
//

#if !os(macOS)

import UIKit

public enum AlertDismissStyle {
    case fadeOut
    case contractHorizontal
    case contractVertical
    case slideDown
    case slideUp
    case slideLeft
    case slideRight
    
    fileprivate var animationDuration: TimeInterval {
        switch self {
        case .fadeOut: return 0.15
        case .contractHorizontal: return 0.2
        case .contractVertical: return 0.2
        case .slideDown: return 0.25
        case .slideUp: return 0.25
        case .slideLeft: return 0.2
        case .slideRight: return 0.2
        }
    }
}

final class AlertDismissTrainsition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var dismissStyle: AlertDismissStyle = .fadeOut
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return dismissStyle.animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        switch dismissStyle {
        case .fadeOut:
            fadeOutAnimation(using: transitionContext)
            break
        case .contractHorizontal:
            contractHorizontalAnimation(using: transitionContext)
            break
        case .contractVertical:
            contractVerticalAnimation(using: transitionContext)
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
    
    private func fadeOutAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(using: transitionContext)
        let fromView = transitionContext.view(forKey: .from)
        let containerView = transitionContext.containerView
        UIView.animate(withDuration: duration, animations: {
            fromView?.alpha = 0
            containerView.alpha = 0
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    private func contractHorizontalAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(using: transitionContext)
        let fromView = transitionContext.view(forKey: .from)
        let containerView = transitionContext.containerView
        UIView.animate(withDuration: duration, animations: {
            fromView?.alpha = 0
            containerView.alpha = 0
            fromView?.transform = CGAffineTransform(scaleX: 0.001, y: 1)
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    private func contractVerticalAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(using: transitionContext)
        let fromView = transitionContext.view(forKey: .from)
        let containerView = transitionContext.containerView
        UIView.animate(withDuration: duration, animations: {
            fromView?.alpha = 0
            containerView.alpha = 0
            fromView?.transform = CGAffineTransform(scaleX: 1, y: 0.001)
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    private func slideDownAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(using: transitionContext)
        let containerView = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from)!
        UIView.animate(withDuration: duration, animations: {
            containerView.alpha = 0
            fromView.center = CGPoint(x: containerView.center.x, y: containerView.frame.height + fromView.frame.height / 2.0)
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    private func slideUpAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(using: transitionContext)
        let containerView = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from)!
        UIView.animate(withDuration: duration, animations: {
            containerView.alpha = 0
            fromView.center = CGPoint(x: containerView.center.x, y: -fromView.frame.height / 2.0)
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    private func slideLeftAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(using: transitionContext)
        let containerView = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from)!
        UIView.animate(withDuration: duration, animations: {
            containerView.alpha = 0
            fromView.center = CGPoint(x: -fromView.frame.width / 2.0, y: containerView.center.y)
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    private func slideRightAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(using: transitionContext)
        let containerView = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from)!
        UIView.animate(withDuration: duration, animations: {
            containerView.alpha = 0
            fromView.center = CGPoint(x: containerView.frame.width + fromView.frame.width / 2.0, y: containerView.center.y)
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}

#endif
