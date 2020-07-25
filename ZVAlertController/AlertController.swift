//
//  AlertController.swift
//  ZVAlertController
//
//  Created by 张伟 on 2019/9/19.
//  Copyright © 2019 zevwings. All rights reserved.
//

#if !os(macOS)

import UIKit

open class AlertAction: NSObject, NSCopying {
    
    public enum Style {
        case `default`
        case cancel
        case destructive
    }

    public typealias Handler = (AlertAction) -> ()
    
    public private(set) var title: String
    
    public var style: AlertAction.Style
    
    public var handler: AlertAction.Handler
    
    public init(title: String, style: AlertAction.Style, handler: @escaping AlertAction.Handler) {
        self.title = title
        self.style = style
        self.handler = handler
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        let action = AlertAction(title: title, style: style, handler: handler)
        return action
    }
}

open class AlertController: UIViewController {

    public typealias DismissHandler = () -> ()
    
    // MARK: Constant
    private struct Constant {
        
        static let singleActionButtonHeight: CGFloat = 40.0
        static let doubleActionButtonHeight: CGFloat = 44.0
        
        static var bundle: Bundle? {
            return Bundle(for: AlertController.self)
        }
        
        static var nibName: String? {
            return "AlertController"
        }
        
        static let negativeColor = UIColor(red: 68.0 / 255.0, green: 68.0 / 255.0, blue: 68.0 / 255.0, alpha: 1.0)
        static let positiveColor = UIColor(red: 215.0 / 255.0, green: 33.0 / 255.0, blue: 59.0 / 255.0, alpha: 1.0)
        static let tintColor = UIColor(red: 136.0 / 255.0, green: 136.0 / 255.0, blue: 136.0 / 255.0, alpha: 1.0)
        static let titleColor = UIColor(red: 68.0 / 255.0, green: 68.0 / 255.0, blue: 68.0 / 255.0, alpha: 1.0)
        static let messageColor = UIColor(red: 68.0 / 255.0, green: 68.0 / 255.0, blue: 68.0 / 255.0, alpha: 1.0)
    }
    
    // MARK: Props
    
    public var presentStyle: AlertPresentStyle = .fadeIn
    public var dismissStyle: AlertDismissStyle = .fadeOut

    public var dismissHandler: DismissHandler?
    public var shouldShowDismissButton: Bool = false

    public var tintColor: UIColor = Constant.tintColor
    public var positiveColor: UIColor = Constant.positiveColor
    public var negativeColor: UIColor = Constant.negativeColor
    public var buttonFont: UIFont = .systemFont(ofSize: 14.0)

    public var titleColor: UIColor = Constant.titleColor
    public var titleFont: UIFont = .systemFont(ofSize: 14.0)

    public var messageColor: UIColor = Constant.messageColor
    public var messageFont: UIFont = .systemFont(ofSize: 14.0)

    private var actions: [AlertAction] = []
    private var alertTitle: String
    private var alertMessage: Any
    
    // MARK: Widget
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var messageLabelTop: NSLayoutConstraint!
    @IBOutlet private weak var separatorLine: UIView!
    @IBOutlet private weak var separatorLineHeight: NSLayoutConstraint!
    @IBOutlet private weak var actionContainerView: UIView!
    @IBOutlet private weak var dismissButton: UIButton!

    override open func viewDidLoad() {
        super.viewDidLoad()

        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        separatorLine.backgroundColor = UIColor(white: 214.0/255.0, alpha: 1.0)
        separatorLineHeight.constant = 1 / UIScreen.main.scale

        setupAlertTitle()
        setupAlertMessage()
        setupAlertActions()
        setupDismissButton()
    }

    public init(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        super.init(nibName: Constant.nibName, bundle: Constant.bundle)
        setupTransionDelegate()
    }
    
    public init(title: String, message: NSAttributedString) {
        alertTitle = title
        alertMessage = message
        super.init(nibName: Constant.nibName, bundle: Constant.bundle)
        setupTransionDelegate()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        alertTitle = ""
        alertMessage = ""
        super.init(coder: aDecoder)
        setupTransionDelegate()
    }
    
    open func addAction(_ action: AlertAction) {
        self.actions.append(action)
    }
    
    // MARK: Setup
    private func setupTransionDelegate() {
        transitioningDelegate = self
        modalPresentationStyle = .custom
    }
    
    private func setupAlertTitle() {
        titleLabel.textColor = titleColor
        titleLabel.font = titleFont
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        if alertTitle.count == 0 {
            let heightConstraint = NSLayoutConstraint(item: titleLabel!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
            heightConstraint.isActive = true
            titleLabel?.isHidden = true
        } else {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 2
            paragraphStyle.alignment = .center
            let attributedString = NSMutableAttributedString(string: alertTitle, attributes: [.paragraphStyle: paragraphStyle])
            titleLabel?.attributedText = attributedString
        }
    }
    
    private func setupAlertMessage() {
        
        messageLabel.textColor = messageColor
        messageLabel.font = messageFont
        messageLabel?.translatesAutoresizingMaskIntoConstraints = false

        let message: String
        if let msg = alertMessage as? String {
            message = msg
        } else if let msg = alertMessage as? NSAttributedString {
            message = msg.string
        } else {
            message = ""
        }
        
        let top: CGFloat
        if alertTitle.count > 0 && message.count > 0 {
            top = 8.0
        } else {
            top = 0.0
        }
        messageLabelTop.constant = top
        
        if message.count == 0 {
            let heightConstraint = NSLayoutConstraint(item: messageLabel!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
            heightConstraint.isActive = true
            messageLabel?.isHidden = true
            return
        }
        
        messageLabel?.numberOfLines = 0
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        paragraphStyle.alignment = .center
        if let msg = alertMessage as? String {
            let attributedString = NSMutableAttributedString(string: msg, attributes: [.paragraphStyle: paragraphStyle])
            messageLabel?.attributedText = attributedString
        } else if let msg = alertMessage as? NSAttributedString {
            let attributedString = NSMutableAttributedString(attributedString: msg)
            let range = NSRange(location: 0, length: message.count)
            let attrs: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 14.0),
                                                         .paragraphStyle: paragraphStyle]
            attributedString.addAttributes(attrs, range: range)
            messageLabel?.attributedText = attributedString
        }
    }
    
    private func setupAlertActions() {
        
        if actions.count == 0 {
            self.separatorLine.isHidden = false
        }
        
        if actions.count == 2 {
            handleHorizontalActionButton()
        } else {
            handleVerticalActionButtton()
        }
    }
    
    private func setupDismissButton() {
        let dismissImage = UIImage(named: "dismiss_button_icon", in: Constant.bundle, compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
        dismissButton.setImage(dismissImage, for: .normal)
        dismissButton.tintColor = tintColor
        dismissButton.isHidden = !shouldShowDismissButton
    }
    
    // MARK: Action Button
    private func handleHorizontalActionButton() {
        
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.backgroundColor = .orange
        
        actionContainerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstants = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[stackView]-0-|", options: .init(rawValue: 0), metrics: nil, views: ["stackView": stackView])
        NSLayoutConstraint.activate(horizontalConstants)
        let verticalConstants = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[stackView]-0-|", options: .init(rawValue: 0), metrics: nil, views: ["stackView": stackView])
        NSLayoutConstraint.activate(verticalConstants)
        let heightConstaint = NSLayoutConstraint(item: stackView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: Constant.doubleActionButtonHeight)
        heightConstaint.isActive = true

        let leftAction = actions[0]
        let leftButton = button(for: leftAction, at: 1)
        stackView.addArrangedSubview(leftButton)
        leftButton.translatesAutoresizingMaskIntoConstraints = false

        let separatorLine = UIView()
        separatorLine.backgroundColor = UIColor(white: 214.0/255.0, alpha: 1.0)
        stackView.addArrangedSubview(separatorLine)
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        let separatorLineWidthConstaint = NSLayoutConstraint(item: separatorLine, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 1 / UIScreen.main.scale)
        separatorLineWidthConstaint.isActive = true

        let rightAction = actions[1]
        let rightButton = button(for: rightAction, at: 1)
        stackView.addArrangedSubview(rightButton)
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        
        let equalConstaint = NSLayoutConstraint(item: leftButton, attribute: .width, relatedBy: .equal, toItem: rightButton, attribute: .width, multiplier: 1.0, constant: 0)
        equalConstaint.isActive = true
    }
    
    private func handleVerticalActionButtton() {
        
        // stackView
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.backgroundColor = .orange
        
        actionContainerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstants = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[stackView]-0-|", options: .init(rawValue: 0), metrics: nil, views: ["stackView": stackView])
        NSLayoutConstraint.activate(horizontalConstants)
        let verticalConstants = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[stackView]-0-|", options: .init(rawValue: 0), metrics: nil, views: ["stackView": stackView])
        NSLayoutConstraint.activate(verticalConstants)
        
        for idx in 0 ..< actions.count {
            let action = actions[idx]
            let actionButton = button(for: action, at: idx)
            stackView.addArrangedSubview(actionButton)
            actionButton.translatesAutoresizingMaskIntoConstraints = false

            if actions.count == 1 {
                let actionButtonHeightConstaint = NSLayoutConstraint(item: actionButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: Constant.doubleActionButtonHeight)
                actionButtonHeightConstaint.isActive = true
            } else {
                let actionButtonHeightConstaint = NSLayoutConstraint(item: actionButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: Constant.singleActionButtonHeight)
                actionButtonHeightConstaint.isActive = true
            }
            
            if idx < actions.count - 1 {
                let separatorLine = UIView()
                separatorLine.backgroundColor = UIColor(white: 214.0/255.0, alpha: 1.0)
                stackView.addArrangedSubview(separatorLine)
                separatorLine.translatesAutoresizingMaskIntoConstraints = false
                let separatorLineWidthConstaint = NSLayoutConstraint(item: separatorLine, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 1 / UIScreen.main.scale)
                separatorLineWidthConstaint.isActive = true
            }
        }
    }
    
    private func button(for action: AlertAction, at index: Int) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(action.title, for: .normal)
        button.setTitleColor(titleColor(for: action.style) , for: .normal)
        button.titleLabel?.font = font(for: action.style)
        button.tag = index
        button.addTarget(self, action: #selector(actionButtionAction(_:)), for: .touchUpInside)
        return button
    }
    
    private func titleColor(for style: AlertAction.Style) -> UIColor {
        switch style {
        case .default, .destructive:
            return positiveColor
        default:
            return negativeColor
        }
    }
    
    private func font(for style: AlertAction.Style) -> UIFont {
        switch style {
        case .default, .cancel:
            return buttonFont
        default:
            return UIFont.systemFont(ofSize: buttonFont.pointSize, weight: .medium)
        }
    }
    
    // MARK: Event Handler
    @objc private func actionButtionAction(_ sender: UIButton) {
        dismiss(animated: true) {
            let action = self.actions[sender.tag];
            let handler = action.handler
            handler(action)
            self.dismissHandler?()
        }
    }
    
    @IBAction private func dismissButtonAction(_ sender: Any) {
        dismiss(animated: true) {
            self.dismissHandler?()
        }
    }
}

extension AlertController : UIViewControllerTransitioningDelegate {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let presentTransition = AlertPresentTrainsition()
        presentTransition.presentStyle = presentStyle
        return presentTransition
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let dismissTransition = AlertDismissTrainsition()
        dismissTransition.dismissStyle = dismissStyle
        return dismissTransition
    }
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return AlertPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

#endif
