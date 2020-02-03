//
//  Extensions.swift
//  Bandana_Update_2
//
//  Created by Rakesh Nangunoori on 03/02/20.
//  Copyright © 2020 Rakesh Nangunoori. All rights reserved.
//

import Foundation
import UIKit
extension String{
    func formatChanges(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssZ"
        let dateStr = dateFormatter.date(from: self)
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: dateStr!)
    }
}
extension UIViewController{
    var screenHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    func showAlert(title:String) {
        let alert = UIAlertController.init(title: "", message: title, preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    func setUpSpinner(style: UIActivityIndicatorView.Style)-> UIActivityIndicatorView {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.style = style
        activityIndicatorView.color = UIColor.darkGray
        return activityIndicatorView
    }
    func showActivityIndicator(destination: Destination, spinner: UIActivityIndicatorView) {
        let centerFrame = CGRect.init(x: self.view.center.x - 25, y:  self.view.center.y - 64, width: 50, height: 50)
        let bottomFrame = CGRect.init(x: self.view.center.x - 25, y:  screenHeight - 64, width: 50, height: 50)
        switch destination {
        case .bottom:
            spinner.frame = bottomFrame
        case .center:
            spinner.frame = centerFrame
        }
        spinner.startAnimating()
        spinner.isHidden = false
        self.view.addSubview(spinner)
    }
    func hideActivityIndicator(spinner: UIActivityIndicatorView) {
            spinner.stopAnimating()
            spinner.isHidden = true
       }
    
}
