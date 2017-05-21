//
//  Episode.swift
//  Podcaster 2
//
//  Created by dan on 5/20/17.
//  Copyright © 2017 Daniel Stagnaro. All rights reserved.
//

import Cocoa

class Episode {
    var title = ""
    var pubDate = Date()
    var htmlDescription = ""
    var audioURL = ""
    
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
        return formatter
    }()
}
