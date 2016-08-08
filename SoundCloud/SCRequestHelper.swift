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
    class func trackRequest(success: (([SCTracks])->())?, failed: (()->())?) {
        let params = ["client_id" : Constaints.Path.clientId]
        RKObjectManager.sharedManager().getObject(nil, path: Constaints.Path.trackPath, parameters: params, success: {
            if let tracks = $1.array() as? [SCTracks] {
                success?(tracks)
            } else {
                success?([SCTracks]())
            }
            }, failure: {
                if $1 != nil {
                    failed?()
                }
        })
    }


}
