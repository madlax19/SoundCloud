//
//  SCRegistration.swift
//  SoundCloud
//
//  Created by sasha ataman on 04.08.16.
//  Copyright © 2016 sasha ataman. All rights reserved.
//

import UIKit
import RestKit

class SCRegistration: NSObject {
    var username: String?
    var password: String?
    
    static var inverseMapping: RKObjectMapping = {
        let mapping = RKObjectMapping(forClass: SCRegistration.self)
        mapping.addAttributeMappingsFromArray(["username", "password"])
        return mapping.inverseMapping()
    }()
}
