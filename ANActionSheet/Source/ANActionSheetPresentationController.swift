//
//  ANActionSheetPresentationController.swift
//  ANActionSheet
//
//  Created by Arda Oğul Üçpınar on 17.01.2019.
//  Copyright © 2019 Anelad Nailaben. All rights reserved.
//

import UIKit

final class ANActionSheetPresentationController: UIPresentationController {
  private let dimmingView = UIView()

  override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
    super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
  }

  override func presentationTransitionWillBegin() {
    dimmingView.frame = (containerView?.bounds)!
    dimmingView.alpha = 0.0
    containerView?.insertSubview(dimmingView, at: 0)

    presentedViewController.transitionCoordinator?.animate(alongsideTransition: {
      context in
      self.dimmingView.alpha = 1.0
    }, completion: nil)
  }

  override func dismissalTransitionWillBegin() {
    presentedViewController.transitionCoordinator?.animate(alongsideTransition: {
      context in
      self.dimmingView.alpha = 0.0
    }, completion: {
      context in
      self.dimmingView.removeFromSuperview()
    })
  }


  override func containerViewWillLayoutSubviews() {
    var bottomMargin: CGFloat = 8
    if let safeBottom = containerView?.safeAreaInsets.bottom, safeBottom > 0 {
      bottomMargin = safeBottom
    }

    dimmingView.frame = (containerView?.bounds)!

    containerView?.addConstraint(NSLayoutConstraint.init(item: containerView!, attribute: .centerX, relatedBy: .equal, toItem: presentedView, attribute: .centerX, multiplier: 1, constant: 0))


    // handling unsatisfiable constraints.
    // bottom margin may vary on orientation change. So if the bottom constraint is set, get it and change its constat. else, create a new one.
    let bottomCons = containerView?.constraints.filter({ (cons) -> Bool in
      if let firstItem = cons.firstItem as? UIView,
        let containerView = containerView,
        let presentedView = presentedView,
        let secondItem = cons.secondItem as? UIView,
        firstItem == containerView && secondItem == presentedView && cons.secondAttribute == .bottom && cons.secondAttribute == .bottom {
        return true 
      } else {
        return false
      }
    }).first

    if bottomCons == nil {
      containerView?.addConstraint(NSLayoutConstraint.init(item: containerView!, attribute: .bottom, relatedBy: .equal, toItem: presentedView, attribute: .bottom, multiplier: 1, constant: bottomMargin))
    } else {
      bottomCons!.constant = bottomMargin
    }

    // handling unsatisfiable constraints.
    // since width ratio may vary at orientatioon changes on phones, get widthConstraint if exits, and remove it first, then set the new one.
    var widthratio: CGFloat = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad ? 1/2 : 9/10
    if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone && UIDevice.current.orientation.isLandscape {
      widthratio = 7/10
    }

    let widthConstraint = containerView?.constraints.filter({ (cons) -> Bool in
      if let firstItem = cons.firstItem as? UIView,
        let containerView = containerView,
        let presentedView = presentedView,
        let secondItem = cons.secondItem as? UIView,
        firstItem == presentedView && secondItem == containerView && cons.secondAttribute == .width && cons.secondAttribute == .width {
        return true
      } else {
        return false
      }
    }).first

    if widthConstraint != nil {
      containerView?.removeConstraint(widthConstraint!)
    }
    containerView?.addConstraint(NSLayoutConstraint.init(item: presentedView!, attribute: .width, relatedBy: .equal, toItem: containerView!, attribute: .width, multiplier: widthratio, constant: 0))


    let heightConstraint = containerView?.constraints.filter({ (cons) -> Bool in
      if let firstItem = cons.firstItem as? UIView,
        let containerView = containerView,
        let presentedView = presentedView,
        let secondItem = cons.secondItem as? UIView,
        firstItem == presentedView && secondItem == containerView && cons.secondAttribute == .height && cons.secondAttribute == .height {
        return true
      } else {
        return false
      }
    }).first

    if heightConstraint != nil {
      heightConstraint!.constant = -bottomMargin*2
    }
    else {
      containerView?.addConstraint(NSLayoutConstraint.init(item: presentedView!, attribute: .height, relatedBy: .lessThanOrEqual, toItem: containerView!, attribute: .height, multiplier: 1, constant: -bottomMargin*2))
    }
  }
}
