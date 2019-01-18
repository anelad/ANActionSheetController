//
//  AnActionSheet+UIViewControllerTransitioningDelegate.swift
//  ANActionSheet
//
//  Created by Arda Oğul Üçpınar on 17.01.2019.
//  Copyright © 2019 Anelad Nailaben. All rights reserved.
//

import UIKit

extension ANActionSheetController: UIViewControllerTransitioningDelegate {
  public func presentationController(forPresented presented: UIViewController,
                              presenting: UIViewController?,
                              source: UIViewController) -> UIPresentationController? {

    return ANActionSheetPresentationController(presentedViewController: presented,
                                               presenting: presenting)
  }

  public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return self
  }

}
