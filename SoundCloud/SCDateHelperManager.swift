//
//  SCDateHelperManager.swift
//  SoundCloud
//
//  Created by sasha ataman on 09.08.16.
//  Copyright © 2016 sasha ataman. All rights reserved.
//

import UIKit

class SCDateHelperManager: NSData {
    
    static let sharedInstance = SCDateHelperManager()
    
    func convertDate(date date: String) -> String {
        var convert = ""
        for arr in date.componentsSeparatedByString("/"){
            convert += "\(arr)."
        }
        return convert.componentsSeparatedByString(" ").first!
    }
}
