//
//  ANActionSheetButton.swift
//  ANActionSheet
//
//  Created by Arda Oğul Üçpınar on 17.01.2019.
//  Copyright © 2019 Anelad Nailaben. All rights reserved.
//

import UIKit

public enum ANActionSheetActionType {
  case normal, custom
}

public protocol ANActionSheetAction {
  var title: String { get }
  var handler: (() -> Void)? { get }
}

final public class ANActionSheetNormalAction: ANActionSheetAction {
  public private(set) var title: String
  public private(set) var handler: (() -> Void)?

  public init(title: String, handler: (() -> Void)?) {
    self.title = title
    self.handler = handler
  }
}

final public class ANActionSheetCustomAction: ANActionSheetAction {
  public private(set) var title: String
  public private(set) var handler: (() -> Void)?
  public private(set) var appearence: ANActionSheetAppearence.CustomActionAppearence

  public init(title: String, apperarence: ANActionSheetAppearence.CustomActionAppearence, handler: (() -> Void)?) {
    self.title = title
    self.handler = handler
    self.appearence = apperarence
  }
}

protocol ANActionSheetButtonProtocol {
  var handler: (() -> Void)? { get set }
  var owner : ANActionSheetController? { get set }
}

typealias ANActionSheetButton = ANActionSheetButtonProtocol & UIButton

final class ANActionSheetNormalButton : ANActionSheetButton {

  var handler: (() -> Void)?
  weak var owner : ANActionSheetController?

  required init?(coder aDecoder: NSCoder) {
    fatalError("Intialization with coder is not supported.")
  }

  public init(title: String, handler: (() -> Void)?){
    self.handler = handler
    super.init(frame: CGRect.zero)
    setTitle(title, for: .normal)
    self.addTarget(self, action: #selector(tap), for: .touchUpInside)

    self.titleLabel?.numberOfLines = 0
    self.titleLabel?.textAlignment = .center

  }

  @objc private func tap(){
    owner?.dismiss(animated: true, completion: {
      self.handler?()
    })
  }
}

final class ANActionSheetCustomButton : ANActionSheetButton {

  var handler: (() -> Void)?
  weak var owner: ANActionSheetController?
  var appearence: ANActionSheetAppearence.CustomActionAppearence

  required init?(coder aDecoder: NSCoder) {
    fatalError("Intialization with coder is not supported.")
  }

  public init(title: String, apperarence: ANActionSheetAppearence.CustomActionAppearence, handler: (() -> Void)?){
    self.handler = handler
    self.appearence = apperarence
    super.init(frame: CGRect.zero)

    self.titleLabel?.numberOfLines = 0
    self.titleLabel?.textAlignment = .center

    setTitle(title, for: .normal)
    self.addTarget(self, action: #selector(tap), for: .touchUpInside)
  }

  @objc private func tap(){
    owner?.dismiss(animated: true, completion: {
      self.handler?()
    })
  }
}
