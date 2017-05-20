//
//  File.swift
//  Podcaster 2
//
//  Created by dan on 5/18/17.
//  Copyright © 2017 Daniel Stagnaro. All rights reserved.
//

import Foundation

class Parser {
    
    func getPodcastMetaData(data:Data) -> (title: String?, imageURL: String?){
        
        let xml = SWXMLHash.parse(data)
//        print(xml["rss"]["channel"]["itunes:image"].element?.attribute(by: "href")?.text as Any)
        
        return (xml["rss"]["channel"]["title"].element?.text, xml["rss"]["channel"]["itunes:image"].element?.attribute(by: "href")?.text)
        
    }
}
