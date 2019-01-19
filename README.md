# ANActionSheetController
ANActionSheetController is a highly customizable UIAlertController replica, looks like built-in action sheet, works on iPad too.

# What it looks like? (9.5 MB gif file - you might wait a while)
![](screen-recording.gif)

# Why?

ANActionSheetController can have many actions, a cancel action dedicated from the other actions, and a title and/or message, as the built-in UIAlertController. But the difference is; you can customize -almost– every attributes.

Only required thing is having at least 1 action.

# What you can customize? 
Via modifying the controller's `appearence` attribute -or setting from scratch- you can customize these:


### General
- `shadow`: shadow color, offset, radius and opacity
- `corner radius`
- `seperator`: The size and color of the space between buttons and (title container and/or cancel button)
- `button seperator`: The size and color of the space between buttons

### Title and Message
- `title and message title color`
- `title and message title font`
- `title and message background`

### Buttons & Cancel Button
- `minimum button height`
- `button title font`
- `button title color`
- `button color`

### Custom button(s)

Exceptional buttons, looks different from the others buttons.
- `minimum button height`
- `button title font`
- `button title color`
- `button color`

# Installation

### via CocoaPods
`pod 'ANActionSheetController'`

### manually
Download the repository

Add `ANActionSheetController/Source` folder - or its contents- to your project


# Usage

Usage is same with the `UIAlertController`

First, create the controller:

``` swift
let actionSheetController = ANActionSheetController.init(title: "a title" , message: "a message")
```

Then add actions - or buttons - :

``` swift
actionSheetController.addAction(ANActionSheetNormalAction.init(title: "Button 1", handler: nil))
actionSheetController.addAction(ANActionSheetNormalAction.init(title: "Button 2", handler: nil))
```

If you want to add exceptional actions - different looking actions than others - :

``` swift
var customButtonAppearence = ANActionSheetAppearence.CustomActionAppearence.init()
customButtonAppearence.font = UIFont.init(name: "IntroRustG-Base2Line", size: 17)!
customButtonAppearence.titleColor = UIColor.red
customButtonAppearence.minimumHeight = 10

actionSheetController.addAction(ANActionSheetCustomAction.init(title: "Custom button with\nauto height\nred label \nand \ncustom font", apperarence: customButtonAppearence, handler: nil))
```

You can add a cancel button:

``` swift
action.setCancelAction(title: "Cancel Button")
```

And customize the controller; for example:

``` swift

... 

actionSheetController.appearence.actionAppearence.titleColor = UIColor(red:0.929, green:0.922, blue:0.923, alpha: 1.000)
actionSheetController.appearence.actionAppearence.color = UIColor(red:0.69, green:0.714, blue:0.616, alpha: 1.000)
actionSheetController.appearence.buttonSeperatorColor = UIColor.init(red: 0.427, green: 0.498, blue: 0.192, alpha: 1)

...

```



Or you might create a shared customization:

``` swift
extension ANActionSheetAppearence {

  static var aCustomAppearence: ANActionSheetAppearence = {
    var customAppearence = ANActionSheetAppearence.init()

    customAppearence.actionAppearence.titleColor = UIColor(red:0.929, green:0.922, blue:0.923, alpha: 1.000)
    customAppearence.actionAppearence.color = UIColor(red:0.69, green:0.714, blue:0.616, alpha: 1.000)
    customAppearence.buttonSeperatorColor = UIColor.init(red: 0.427, green: 0.498, blue: 0.192, alpha: 1)

	... and other customizations ...
	
    return customAppearence
  }()
}


....

actionSheetController.appearence = ANActionSheetAppearence.aCustomAppearence

....


```

Then present it:

``` swift
myController.present(actionSheetController, animated: true, completion: nil)
```


# Need to knows

- You should set at least 1 action!
- Considering action sheets higher than the screen size (especially on landscape phone screen) I used UIScrollView. If you have a better solution, please contact me at [info@ardaucpinar.com](mailto:info@ardaucpinar.com) or implement and create a pull request.
- Due to view hiearchy, background colors you set may not look like as expected. For example; if you set seperator to `blue` and buttonSeperator to `clear`, button seperators will be seen as `blue`.




