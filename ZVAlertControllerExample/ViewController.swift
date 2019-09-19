//
//  ViewController.swift
//  ZVAlertControllerExample
//
//  Created by 张伟 on 2019/9/19.
//  Copyright © 2019 zevwings. All rights reserved.
//

import UIKit
import ZVAlertController

class ViewController: UIViewController {

    @IBOutlet weak var presentStyleTableView: UITableView!
    @IBOutlet weak var dismissStyleTableView: UITableView!
    
    let presentStyles = ["system", "bounce", "fadeIn", "expandHorizontal", "expandvertical", "slideDown", "slideUp", "slideLeft", "slideRight"]
    let dismissStyles = ["fadeOut", "contractHorizontal", "contractVertical", "slideDown", "slideUp", "slideLeft", "slideRight"]
    
    var presentStyle: AlertPresentStyle = .fadeIn
    var dismissStyle: AlertDismissStyle = .fadeOut

    var shouldShowDismissButton: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func oneButton(_ sender: Any) {
        let alertController = AlertController(title: "title", message: "message")
        alertController.presentStyle = presentStyle
        alertController.dismissStyle = dismissStyle
        alertController.shouldShowDismissButton = shouldShowDismissButton
        alertController.addAction(AlertAction(title: "confirm", style: .default, handler: { _ in
            print("comfirm action")
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func twoButton(_ sender: Any) {
        let alertController = AlertController(title: "title", message: "message")
        alertController.presentStyle = presentStyle
        alertController.dismissStyle = dismissStyle
        alertController.shouldShowDismissButton = shouldShowDismissButton
        alertController.addAction(AlertAction(title: "cancel", style: .cancel, handler: { _ in
            print("cancel action")
        }))
        alertController.addAction(AlertAction(title: "confirm", style: .default, handler: { _ in
            print("comfirm action")
        }))
        present(alertController, animated: true, completion: nil)

    }
    
    @IBAction func threeButton(_ sender: Any) {
        let alertController = AlertController(title: "title", message: "message")
        alertController.presentStyle = presentStyle
        alertController.dismissStyle = dismissStyle
        alertController.shouldShowDismissButton = shouldShowDismissButton
        alertController.addAction(AlertAction(title: "cancel", style: .cancel, handler: { _ in
            print("cancel action")
        }))
        alertController.addAction(AlertAction(title: "confirm", style: .default, handler: { _ in
            print("comfirm action")
        }))
        alertController.addAction(AlertAction(title: "destructive", style: .destructive, handler: { _ in
            print("destructive action")
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func attributedString(_ sender: Any) {
        let attributedString = NSMutableAttributedString(string: "message")
        attributedString.addAttributes([.foregroundColor: UIColor.cyan], range: NSRange(location: 0, length: 4))
        let alertController = AlertController(title: "title", message: attributedString)
        alertController.presentStyle = presentStyle
        alertController.dismissStyle = dismissStyle
        alertController.shouldShowDismissButton = shouldShowDismissButton
        alertController.addAction(AlertAction(title: "confirm", style: .default, handler: { _ in
            print("comfirm action")
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func noTitle(_ sender: Any) {
        let alertController = AlertController(title: "", message: "message")
        alertController.presentStyle = presentStyle
        alertController.dismissStyle = dismissStyle
        alertController.shouldShowDismissButton = shouldShowDismissButton
        alertController.addAction(AlertAction(title: "confirm", style: .default, handler: { _ in
            print("comfirm action")
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func noMessage(_ sender: Any) {
        let alertController = AlertController(title: "title", message: "")
        alertController.presentStyle = presentStyle
        alertController.dismissStyle = dismissStyle
        alertController.shouldShowDismissButton = shouldShowDismissButton
        alertController.addAction(AlertAction(title: "确定", style: .default, handler: { _ in
            print("comfirm action")
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func changeDismissButtonHidden(_ sender: UISwitch) {
        shouldShowDismissButton = sender.isOn
    }
    
}

extension ViewController : UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.presentStyleTableView {
            return presentStyles.count
        } else if tableView == self.dismissStyleTableView {
            return dismissStyles.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        
        if tableView == self.presentStyleTableView {
            cell?.textLabel?.text = presentStyles[indexPath.row]
        } else if tableView == self.dismissStyleTableView {
            cell?.textLabel?.text = dismissStyles[indexPath.row]
        }

        return cell!
    }
    

}

extension ViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == self.presentStyleTableView {
            switch indexPath.row {
            case 0:
                self.presentStyle = .system
                break
            case 1:
                self.presentStyle = .bounce
                break
            case 2:
                self.presentStyle = .fadeIn
                break
            case 3:
                self.presentStyle = .expandHorizontal
                break
            case 4:
                self.presentStyle = .expandvertical
                break
            case 5:
                self.presentStyle = .slideDown
                break
            case 6:
                self.presentStyle = .slideUp
                break
            case 7:
                self.presentStyle = .slideLeft
                break
            case 8:
                self.presentStyle = .slideRight
                break
            default: break
            }
        } else if tableView == self.dismissStyleTableView {
            switch indexPath.row {
            case 0:
                self.dismissStyle = .fadeOut
                break
            case 1:
                self.dismissStyle = .contractHorizontal
                break
            case 2:
                self.dismissStyle = .contractVertical
                break
            case 3:
                self.dismissStyle = .slideDown
                break
            case 4:
                self.dismissStyle = .slideUp
                break
            case 5:
                self.dismissStyle = .slideLeft
                break
            case 6:
                self.dismissStyle = .slideRight
                break
            default: break
            }
        }

    }
}
