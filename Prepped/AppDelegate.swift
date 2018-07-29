/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    configureAppearance()
    
    return true
  }
  
  func configureAppearance() {
    let barColor = UIColor.primaryGreenColor()
    let shadowColor = UIColor(red: 0/255, green: 114/255, blue: 30/255, alpha: 1.0)
    
    let navBarFont = UIFont.systemFont(ofSize: 17.0)
    
    window?.tintColor = barColor
    
    // Navigation Bar
    let navBarAppearance = UINavigationBar.appearance()
    navBarAppearance.isTranslucent = true
    navBarAppearance.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white,
      NSAttributedStringKey.font : navBarFont]
    
    let imageSize = CGSize(width: 1, height: 1)
    let backgroundImage = UIImage.imageWithColor(barColor, size: imageSize)
    navBarAppearance.setBackgroundImage(backgroundImage, for: .default)
    let shadowImage = UIImage.imageWithColor(shadowColor, size: imageSize)
    navBarAppearance.shadowImage = shadowImage
    navBarAppearance.tintColor = UIColor.white
    navBarAppearance.isTranslucent = false
    
    // Tab Bar
    UITabBar.appearance().tintColor = barColor
    UITabBarItem.appearance().setTitleTextAttributes([ NSAttributedStringKey.foregroundColor: barColor ], for: UIControlState())
    UITabBarItem.appearance().setTitleTextAttributes([ NSAttributedStringKey.foregroundColor: barColor ], for: UIControlState.selected)
    
    // Table View separator
    let separatorColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1.0)
    UITableView.appearance().separatorColor = separatorColor
    
    let tableHeaderLabelAppearance = UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self])
    tableHeaderLabelAppearance.font = UIFont.systemFont(ofSize: 13.0)
    tableHeaderLabelAppearance.textColor = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
  }
}

extension UIImage {
  // create image of solid color
  class func imageWithColor(_ color: UIColor, size: CGSize) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
    let ctx = UIGraphicsGetCurrentContext()
    color.setFill()
    ctx?.fill(CGRect(origin: .zero, size: size))
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
  }
}

extension UIColor {
  class func primaryGreenColor() -> UIColor {
    return UIColor(red: 0/255, green: 184/255, blue: 48/255, alpha: 1.0)
  }
  
  class func primaryAmberColor() -> UIColor {
    return UIColor(red: 187/255, green: 153/255, blue: 30/255, alpha: 1.0)
  }
}
