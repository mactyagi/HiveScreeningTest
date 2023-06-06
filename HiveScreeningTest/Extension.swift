//
//  Extension.swift
//  HiveScreeningTest
//
//  Created by Manu on 06/06/23.
//

import Foundation
import UIKit
extension UIImageView {

 public func imageFromServerURL(urlString: String) {

        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in

            if error != nil {
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                if let image = image{
                    self.isHidden = false
                    self.image = image
                }else{
                    self.isHidden = true
                }
                
            })

        }).resume()
    }
}
