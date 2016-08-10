//
//  SCGenreManager.swift
//  SoundCloud
//
//  Created by sasha ataman on 09.08.16.
//  Copyright © 2016 sasha ataman. All rights reserved.
//

import UIKit

class SCGenreManager: NSData {
    
    static let sharedInstance = SCGenreManager()
    
    func addHashtagToGenre(genre genre: String) -> [String] {
        if genre != "" {
            let genreArr = genre.componentsSeparatedByString(" ")
            var genreHashTagArr: [String] = []
            for genreItem in genreArr {
                genreHashTagArr.append("#\(genreItem)")
            }
            return genreHashTagArr
        }
        return []
    }
}
