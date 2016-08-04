//
//  SCRestKitHelper.swift
//  SoundCloud
//
//  Created by sasha ataman on 04.08.16.
//  Copyright © 2016 sasha ataman. All rights reserved.
//

import UIKit
import RestKit

class SCRequestHelper: NSObject {
    class func registrationRequest(registration registration: SCRegistration, success: ((SCLogin)->())?, failed: (()->())?) {
        RKObjectManager.sharedManager().postObject(registration, path: Constants.Pathes.RegistrationPath, parameters: nil, success: {
            if let user = $1.array().first as? LLUser {
                LLUser.setCurrentUser(user: user)
                success?(user)
            }
            }, failure: {
                if $1 != nil {
                    failed?()
                }
        })
    }

}
