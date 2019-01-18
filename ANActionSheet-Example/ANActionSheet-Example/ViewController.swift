//
//  ViewController.swift
//  ANActionSheet-Example
//
//  Created by Arda Oğul Üçpınar on 17.01.2019.
//  Copyright © 2019 Anelad Nailaben. All rights reserved.
//

import UIKit
import ANActionSheet
import TouchVisualizer

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    Visualizer.start()

  }

  @IBAction func showActionSheetOnlyButton (_ sender: Any) {
    let action = ANActionSheetController.init(title: nil , message: nil)

    action.addAction(ANActionSheetNormalAction.init(title: "Button 1", handler: nil))
    action.addAction(ANActionSheetNormalAction.init(title: "Button 2", handler: nil))

    present(action, animated: true, completion: nil)
  }

  @IBAction func showActionSheetTitled (_ sender: Any) {
    let action = ANActionSheetController.init(title: "This is title" , message: nil)

    action.addAction(ANActionSheetNormalAction.init(title: "Button 1", handler: nil))
    action.addAction(ANActionSheetNormalAction.init(title: "Button 2", handler: nil))

    present(action, animated: true, completion: nil)
  }

  @IBAction func showActionSheetSubTitled (_ sender: Any) {
    let action = ANActionSheetController.init(title: "This is title" , message: "And this is message")

    action.addAction(ANActionSheetNormalAction.init(title: "Button 1", handler: nil))
    action.addAction(ANActionSheetNormalAction.init(title: "Button 2", handler: nil))

    present(action, animated: true, completion: nil)
  }

  @IBAction func showActionSheetWithCancel(_ sender: Any) {
    let action = ANActionSheetController.init(title: "This is title" , message: "And this is message")

    action.addAction(ANActionSheetNormalAction.init(title: "Button 1", handler: nil))
    action.addAction(ANActionSheetNormalAction.init(title: "Button 2", handler: nil))

    action.setCancelAction(title: "Cancel Button")
    present(action, animated: true, completion: nil)
  }

  @IBAction func showActionSheetCustom(_ sender: Any) {

    let action = ANActionSheetController.init(title: "Wow.\nI used this font randomly, but I really liked it!" , message: "This sheet's some attributes are changed as you see.\n\n Sorry for the bad color choices")

    action.addAction(ANActionSheetNormalAction.init(title: "Button 1", handler: nil))
    action.addAction(ANActionSheetNormalAction.init(title: "Button 2", handler: nil))
    action.addAction(ANActionSheetNormalAction.init(title: "Button 3", handler: nil))

    var customButtonAppearence = ANActionSheetAppearence.CustomActionAppearence.init()
    customButtonAppearence.font = UIFont.init(name: "IntroRustG-Base2Line", size: 17)!
    customButtonAppearence.titleColor = UIColor.red
    customButtonAppearence.minimumHeight = 10

    action.addAction(ANActionSheetCustomAction.init(title: "Custom button with\nauto height\nred label \nand \ncustom font", apperarence: customButtonAppearence, handler: nil))
    action.addAction(ANActionSheetNormalAction.init(title: "Button 5", handler: nil))
    action.setCancelAction(title: "Cancel Button")


    // "aCustomAppearence" has been implemented in this file as an extension. Check below this class
    action.appearence = ANActionSheetAppearence.aCustomAppearence

    present(action, animated: true, completion: nil)
  }
}

extension ANActionSheetAppearence {

  static var aCustomAppearence: ANActionSheetAppearence = {
    var customAppearence = ANActionSheetAppearence.init()

    customAppearence.actionAppearence.titleColor = UIColor(red:0.929, green:0.922, blue:0.923, alpha: 1.000)
    customAppearence.actionAppearence.color = UIColor(red:0.69, green:0.714, blue:0.616, alpha: 1.000)
    customAppearence.buttonSeperatorColor = UIColor.init(red: 0.427, green: 0.498, blue: 0.192, alpha: 1)

    customAppearence.cancelActionAppearence.color = UIColor(red:0.929, green:0.922, blue:0.923, alpha: 1.000)
    customAppearence.cancelActionAppearence.titleColor = UIColor.init(red: 0.427, green: 0.498, blue: 0.192, alpha: 1)

    customAppearence.titleViewAppearence.backgroundColor = UIColor(red:0.929, green:0.922, blue:0.923, alpha: 1.000)
    customAppearence.titleViewAppearence.messageTextColor = UIColor(red:0.415, green:0.545, blue:0, alpha: 1.000)
    customAppearence.titleViewAppearence.titleTextColor = UIColor.init(red: 0.427, green: 0.498, blue: 0.192, alpha: 1)
    customAppearence.titleViewAppearence.titleFont = UIFont.init(name: "IntroRustG-Base2Line", size: 17)!

    customAppearence.shadowColor = UIColor.darkGray.cgColor
    customAppearence.shadowOffset = CGSize.zero
    customAppearence.shadowOpacity = 0.7
    customAppearence.shadowRadius = 10
    customAppearence.seperatorSize = 6

    return customAppearence
  }()
}
