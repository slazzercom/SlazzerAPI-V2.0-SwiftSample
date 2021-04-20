//
//  Constant.swift
//  POC
//
//  Created by Netra Technosys on 19/04/21.
//

import Foundation
import UIKit

let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let appName = Bundle.main.infoDictionary!["CFBundleName"] as! String
let screenSize = UIScreen.main.bounds
