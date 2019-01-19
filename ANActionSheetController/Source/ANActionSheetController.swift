//
//  ANActionSheetController.swift
//  ANActionSheet
//
//  Created by Arda Oğul Üçpınar on 17.01.2019.
//  Copyright © 2019 Anelad Nailaben. All rights reserved.
//

import UIKit

/// Struct for ANActionSheet's user interface customizations.
public struct ANActionSheetAppearence {

  /// ANActionSheet shadow color. Defaults to clear.
  public var shadowColor: CGColor = UIColor.clear.cgColor
  /// ANActionSheet shadow radius. Defaults to 0.
  public var shadowRadius: CGFloat = 0
  /// ANActionSheet shadow offset. Defaults to CGSize.zero.
  public var shadowOffset: CGSize = CGSize.zero
  /// ANActionSheet shadow opacity. Defaults to 0.
  public var shadowOpacity: Float = 0
  /// ANActionSheet corner radius. Defaults to 10.
  public var cornerRadius: CGFloat = 10

  /// Color of the the space between action container and titleView and/or cancelAction. Default is clear color.
  /// When it's set to clear color, you will see the sheets shadowColor - if it's set- or it will be fully transparent.
  public var separatorColor: UIColor = .clear
  /// Size of the the space between actions and titleView and/or cancelAction. Defaults to 3 px.
  public var separatorSize: CGFloat = 3

  /// Color of the the space between actions. Default is clear color. When it's set to clear color, you will see the sheets seperator color.
  public var actionSeparatorColor: UIColor = .clear
  /// Size of the space between actions. Default is 1.
  public var actionSeparatorSize: CGFloat = 1

  /// Apearence struct for customizing all actions in ANActionSheet
  public struct ActionAppearence {
    /// Action minimum height. Defaults to 44.
    public var minimumHeight: CGFloat = 44
    /// Font for the action title. Default is system font of size 17
    public var font: UIFont = UIFont.systemFont(ofSize: 17)
    /// Color for the action. Default is white with 0.9 alpha component
    public var color: UIColor = UIColor.white.withAlphaComponent(0.9)
    /// Color for the action title. Default is default iOS tint color, which is a blue kind.
    public var titleColor: UIColor = UIColor.init(red: 0, green: 122/255, blue: 1, alpha: 1)

    public init() {}
  }

  /// Apearence struct for customizing all actions in ANActionSheet
  public struct CustomActionAppearence {
    /// Action minimum height.
    public var minimumHeight: CGFloat?
    /// Font for the action title
    public var font: UIFont?
    /// Color for the action.
    public var color: UIColor?
    /// Color for the action title.
    public var titleColor: UIColor?

    public init() {}
  }

  /// Apearence struct for customizing title container, title label and message label
  public struct TitleViewAppearence {

    /// Text color for title. Default is darkGray
    public var titleTextColor: UIColor = .darkGray
    /// Text font for title. Default is system font of size 17
    public var titleFont: UIFont = UIFont.systemFont(ofSize: 17)

    /// Text color for message. Default is darkGray
    public var messageTextColor: UIColor = .darkGray
    /// Text font for message. Default is system font of size 13
    public var messageFont: UIFont = UIFont.systemFont(ofSize: 13)
    /// Background color for title and message section.
    public var backgroundColor: UIColor = .white

    public init() {}
  }

  /// Apearence struct for customizing cancel action
  public struct CancelActionAppearence {
    /// Cancel action height. Defaults to 44.
    public var height: CGFloat = 44
    /// Font for the cancel action title. Default is system font of size 17
    public var font: UIFont = UIFont.boldSystemFont(ofSize: 17)
    /// Color for the cancel action. Default is white.
    public var color: UIColor = .white
    /// Color for the cancel action title. Default is default iOS tint color, which is a blue kind.
    public var titleColor: UIColor = UIColor.init(red: 0, green: 122/255, blue: 1, alpha: 1)

    public init() {}
  }

  /// Appearence attributes for actions
  public var actionAppearence = ActionAppearence.init()
  /// Appearence attributes for title label, message label and their background
  public var titleViewAppearence = TitleViewAppearence.init()
  /// Appearence attributes for cancel action
  public var cancelActionAppearence = CancelActionAppearence.init()

  public init() {}
}

public final class ANActionSheetController: UIViewController {  

  private let titleContainer = UIView.init()
  private let titleView = UILabel.init()
  private let messageView = UILabel.init()
  private let buttonContainer = UIView.init()
  private var buttons : [ANActionSheetButton] = []
  private let borderView = UIView.init()
  private let scrollView = UIScrollView.init()

  private var cancelButton: ANActionSheetNormalButton?

  /// Appearence attributes. Make changes before presenting the controller. Otherwise some unexpected results may occur.
  public var appearence = ANActionSheetAppearence.init()

  /// Default initializer.
  public init(title: String?, message: String?) {
    super.init(nibName: nil, bundle: nil)
    borderView.clipsToBounds = true

    titleView.text = title
    messageView.text = message

    titleView.textAlignment = .center
    titleView.numberOfLines = 0

    messageView.textAlignment = .center
    messageView.numberOfLines = 0

    transitioningDelegate = self
    modalPresentationStyle = .custom
  }

  

  /// Reqired initializer, to initialize from a xib. DO NOT USE!
  required init?(coder aDecoder: NSCoder) {
    fatalError("Initialization with a coder is not supported.")
  }

  override public func viewDidLoad() {
    if buttons.count == 0 {
      fatalError("ANActionSheet requires at least 1 action.")
    }

    super.viewDidLoad()

    let mainView = self.view!
    mainView.backgroundColor = .clear
    mainView.translatesAutoresizingMaskIntoConstraints = false

    scrollView.translatesAutoresizingMaskIntoConstraints = false

    mainView.addSubview(scrollView)
    mainView.addConstraint(NSLayoutConstraint.init(item: mainView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1, constant: 0))
    mainView.addConstraint(NSLayoutConstraint.init(item: mainView, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1, constant: 0))
    mainView.addConstraint(NSLayoutConstraint.init(item: mainView, attribute: .leading , relatedBy: .equal, toItem: scrollView, attribute: .leading, multiplier: 1, constant: 0))
    mainView.addConstraint(NSLayoutConstraint.init(item: mainView, attribute: .trailing, relatedBy: .equal, toItem: scrollView, attribute: .trailing, multiplier: 1, constant: 0))

    scrollView.backgroundColor = .clear
    scrollView.clipsToBounds = false
    scrollView.showsVerticalScrollIndicator = false
    scrollView.showsHorizontalScrollIndicator = false

    let view = UIView.init(frame: CGRect.zero)
    view.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(view)

    scrollView.addConstraint(NSLayoutConstraint.init(item: scrollView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0))
    scrollView.addConstraint(NSLayoutConstraint.init(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))
    scrollView.addConstraint(NSLayoutConstraint.init(item: scrollView, attribute: .leading , relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0))
    scrollView.addConstraint(NSLayoutConstraint.init(item: scrollView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0))
    scrollView.addConstraint(NSLayoutConstraint.init(item: scrollView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))
    let h = NSLayoutConstraint.init(item: scrollView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0)
    h.priority = UILayoutPriority.defaultLow
    scrollView.addConstraint(h)

    view.layer.shadowColor = appearence.shadowColor
    view.layer.shadowOffset = appearence.shadowOffset
    view.layer.shadowRadius = appearence.shadowRadius
    view.layer.shadowOpacity = appearence.shadowOpacity

    borderView.layer.cornerRadius = appearence.cornerRadius
    borderView.backgroundColor = appearence.separatorColor

    titleContainer.backgroundColor = appearence.titleViewAppearence.backgroundColor
    titleView.textColor = appearence.titleViewAppearence.titleTextColor
    titleView.font = appearence.titleViewAppearence.titleFont
    messageView.textColor = appearence.titleViewAppearence.messageTextColor
    messageView.font = appearence.titleViewAppearence.messageFont

    buttonContainer.backgroundColor = appearence.actionSeparatorColor


    let hasTitleContainer = titleView.text != nil || messageView.text != nil

    borderView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(borderView)
    view.addConstraint(NSLayoutConstraint.init(item: view, attribute: .top, relatedBy: .equal, toItem: borderView, attribute: .top, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint.init(item: view, attribute: .bottom, relatedBy: .equal, toItem: borderView, attribute: .bottom, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint.init(item: view, attribute: .leading, relatedBy: .equal, toItem: borderView, attribute: .leading, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint.init(item: view, attribute: .trailing, relatedBy: .equal, toItem: borderView, attribute: .trailing, multiplier: 1, constant: 0))
    borderView.clipsToBounds = true

    if hasTitleContainer {
      titleContainer.translatesAutoresizingMaskIntoConstraints = false
      borderView.addSubview(titleContainer)
      borderView.addConstraint(NSLayoutConstraint.init(item: borderView, attribute: .top, relatedBy: .equal, toItem: titleContainer, attribute: .top, multiplier: 1, constant: 0))
      borderView.addConstraint(NSLayoutConstraint.init(item: borderView, attribute: .leading, relatedBy: .equal, toItem: titleContainer, attribute: .leading, multiplier: 1, constant: 0))
      borderView.addConstraint(NSLayoutConstraint.init(item: borderView, attribute: .trailing, relatedBy: .equal, toItem: titleContainer, attribute: .trailing, multiplier: 1, constant: 0))

      if (titleView.text != nil) {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleContainer.addSubview(titleView)
        titleContainer.addConstraint(NSLayoutConstraint.init(item: titleContainer, attribute: .top, relatedBy: .equal, toItem: titleView, attribute: .top, multiplier: 1, constant: -16))
        titleContainer.addConstraint(NSLayoutConstraint.init(item: titleContainer, attribute: .leading, relatedBy: .equal, toItem: titleView, attribute: .leading, multiplier: 1, constant: -16))
        titleContainer.addConstraint(NSLayoutConstraint.init(item: titleContainer, attribute: .trailing, relatedBy: .equal, toItem: titleView, attribute: .trailing, multiplier: 1, constant: 16))

        if messageView.text == nil {
          titleContainer.addConstraint(NSLayoutConstraint.init(item: titleContainer, attribute: .bottom, relatedBy: .equal, toItem: titleView, attribute: .bottom, multiplier: 1, constant: 16))
        }
      }

      if messageView.text != nil {
        messageView.translatesAutoresizingMaskIntoConstraints = false
        titleContainer.addSubview(messageView)

        if titleView.text == nil {
          titleContainer.addConstraint(NSLayoutConstraint.init(item: titleContainer, attribute: .top, relatedBy: .equal, toItem: messageView, attribute: .top, multiplier: 1, constant: -16))
        } else {
          titleContainer.addConstraint(NSLayoutConstraint.init(item: titleView, attribute: .bottom, relatedBy: .equal, toItem: messageView, attribute: .top, multiplier: 1, constant: -8))
        }

        titleContainer.addConstraint(NSLayoutConstraint.init(item: titleContainer, attribute: .leading, relatedBy: .equal, toItem: messageView, attribute: .leading, multiplier: 1, constant: -16))
        titleContainer.addConstraint(NSLayoutConstraint.init(item: titleContainer, attribute: .trailing, relatedBy: .equal, toItem: messageView, attribute: .trailing, multiplier: 1, constant: 16))

        titleContainer.addConstraint(NSLayoutConstraint.init(item: titleContainer, attribute: .bottom, relatedBy: .equal, toItem: messageView, attribute: .bottom, multiplier: 1, constant: 16))
      }
    }

    buttonContainer.translatesAutoresizingMaskIntoConstraints = false
    borderView.addSubview(buttonContainer)

    if hasTitleContainer {
      borderView.addConstraint(NSLayoutConstraint.init(item: titleContainer, attribute: .bottom, relatedBy: .equal, toItem: buttonContainer, attribute: .top, multiplier: 1, constant: -appearence.separatorSize))
    } else {
      borderView.addConstraint(NSLayoutConstraint.init(item: borderView, attribute: .top, relatedBy: .equal, toItem: buttonContainer, attribute: .top, multiplier: 1, constant: 0))
    }

    borderView.addConstraint(NSLayoutConstraint.init(item: borderView, attribute: .leading, relatedBy: .equal, toItem: buttonContainer, attribute: .leading, multiplier: 1, constant: 0))
    borderView.addConstraint(NSLayoutConstraint.init(item: borderView, attribute: .trailing, relatedBy: .equal, toItem: buttonContainer, attribute: .trailing, multiplier: 1, constant: 0))

    if let cancelButton = cancelButton {
      cancelButton.titleLabel?.font = appearence.cancelActionAppearence.font
      cancelButton.setTitleColor(appearence.cancelActionAppearence.titleColor, for: .normal)
      cancelButton.setTitleColor(appearence.cancelActionAppearence.titleColor.withAlphaComponent(0.2 ), for: .highlighted)
      cancelButton.backgroundColor = appearence.cancelActionAppearence.color

      cancelButton.translatesAutoresizingMaskIntoConstraints = false
      borderView.addSubview(cancelButton)

      borderView.addConstraint(NSLayoutConstraint.init(item: cancelButton, attribute: .top, relatedBy: .equal, toItem: buttonContainer, attribute: .bottom, multiplier: 1, constant: appearence.separatorSize))
      borderView.addConstraint(NSLayoutConstraint.init(item: borderView, attribute: .leading, relatedBy: .equal, toItem: cancelButton, attribute: .leading, multiplier: 1, constant: 0))
      borderView.addConstraint(NSLayoutConstraint.init(item: borderView, attribute: .trailing, relatedBy: .equal, toItem: cancelButton, attribute: .trailing, multiplier: 1, constant: 0))
      borderView.addConstraint(NSLayoutConstraint.init(item: borderView, attribute: .bottom, relatedBy: .equal, toItem: cancelButton, attribute: .bottom, multiplier: 1, constant: 0))
      borderView.addConstraint(NSLayoutConstraint.init(item: cancelButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: appearence.cancelActionAppearence.height))
    } else {
      borderView.addConstraint(NSLayoutConstraint.init(item: borderView, attribute: .bottom, relatedBy: .equal, toItem: buttonContainer, attribute: .bottom, multiplier: 1, constant: 0))
    }



    // button constraints
    for (index, button) in buttons.enumerated(){

      button.translatesAutoresizingMaskIntoConstraints = false

      buttonContainer.addSubview(button)

      buttonContainer.addConstraint(NSLayoutConstraint.init(item: button, attribute: .leading, relatedBy: .equal, toItem: buttonContainer, attribute: .leading, multiplier: 1, constant: 0))
      buttonContainer.addConstraint(NSLayoutConstraint.init(item: button, attribute: .trailing, relatedBy: .equal, toItem: buttonContainer, attribute: .trailing, multiplier:1, constant: 0))

      if index == 0 {
        buttonContainer.addConstraint(NSLayoutConstraint.init(item: button, attribute: .top, relatedBy: .equal, toItem: buttonContainer, attribute: .top, multiplier: 1, constant: 0))
      }
      else{
        let prevButton = buttons[index - 1]
        buttonContainer.addConstraint(NSLayoutConstraint.init(item: button, attribute: .top, relatedBy: .equal, toItem: prevButton, attribute: .bottom, multiplier: 1, constant: appearence.actionSeparatorSize))
      }
      if index == buttons.count - 1 {
        buttonContainer.addConstraint(NSLayoutConstraint.init(item: button, attribute: .bottom, relatedBy: .equal, toItem: buttonContainer, attribute: .bottom, multiplier: 1, constant:  0))
      }

      if let button = button as? ANActionSheetCustomButton {
        button.backgroundColor = button.appearence.color ?? appearence.actionAppearence.color
        button.setTitleColor(button.appearence.titleColor ?? appearence.actionAppearence.titleColor, for: .normal)
        button.setTitleColor(button.appearence.titleColor?.withAlphaComponent(0.2 ) ?? appearence.actionAppearence.titleColor.withAlphaComponent(0.2 ), for: .highlighted)

        button.titleLabel?.font = button.appearence.font ?? appearence.actionAppearence.font
        buttonContainer.addConstraint(NSLayoutConstraint.init(item: button, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: button.appearence.minimumHeight ?? appearence.actionAppearence.minimumHeight))
      } else {
        button.backgroundColor = appearence.actionAppearence.color
        button.setTitleColor(appearence.actionAppearence.titleColor, for: .normal)
        button.setTitleColor(appearence.actionAppearence.titleColor.withAlphaComponent(0.2 ), for: .highlighted)
        button.titleLabel?.font = appearence.actionAppearence.font
        buttonContainer.addConstraint(NSLayoutConstraint.init(item: button, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: appearence.actionAppearence.minimumHeight))
      }

    }
  }

  public override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    scrollView.delaysContentTouches = !(scrollView.contentSize.height < UIScreen.main.bounds.size.height)
  }

  public override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    scrollView.delaysContentTouches = !(scrollView.contentSize.height < UIScreen.main.bounds.size.height)
  }

  /// Adds a cancel action to the action sheet.
  final public func setCancelAction(title: String) {
    cancelButton = ANActionSheetNormalButton.init(title: title, handler: nil)
    cancelButton?.owner = self
  }

  /// Adds a action to the action sheet.
  final public func addAction(_ action: ANActionSheetAction){
    var button: ANActionSheetButton
    if let action = action as? ANActionSheetCustomAction {
      button = ANActionSheetCustomButton.init(title: action.title, apperarence: action.appearence, handler: action.handler)
    } else {
      button = ANActionSheetNormalButton.init(title: action.title, handler: action.handler)
    }
    button.owner = self
    buttons.append(button)
  }
}
