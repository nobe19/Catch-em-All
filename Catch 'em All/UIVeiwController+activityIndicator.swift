//
//  UIVeiwController+activityIndicator.swift
//  Catch 'em All
//
//  Created by Nipuni Obe on 4/12/21.
//

import UIKit
private var activityIndicator = UIActivityIndicatorView()

extension UIViewController {
    func showIndicator(onView: UIView) {
        activityIndicator.center = onView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = .systemRed
        activityIndicator.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
        DispatchQueue.main.async {
            onView.addSubview(activityIndicator)
        }
        
        // force any lingering indiccator to shut down after 10 sec & print warning to the console.
        Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) {(t) in
            self.removeIndicator()
            print("⚠️ Indicator stopped after \(10.0 - t.timeInterval) seconds.)")
        }
    }
    
    func removeIndicator() {
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            activityIndicator.isUserInteractionEnabled = true
        }
    }
}
