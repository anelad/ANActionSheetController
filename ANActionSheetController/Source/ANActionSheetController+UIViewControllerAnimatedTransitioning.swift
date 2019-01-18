//
//  ANActionSheetController+UIViewControllerAnimatedTransitioning.swift
//  ANActionSheet
//
//  Created by Arda Oğul Üçpınar on 17.01.2019.
//  Copyright © 2019 Anelad Nailaben. All rights reserved.
//

import UIKit

extension ANActionSheetController: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.6
  }

  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    if let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to) {

      let centre = presentedView.center

      presentedView.center = CGPoint(x: centre.x, y: transitionContext.containerView.frame.size.height + presentedView.frame.size.height)

      transitionContext.containerView.addSubview(presentedView)

      UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
                     delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 8.0, options: [],
                     animations: {
                      presentedView.center = centre
      }, completion: {
        _ in
        transitionContext.completeTransition(true)
      })
    }
  }
}
