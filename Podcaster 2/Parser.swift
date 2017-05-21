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
        return (xml["rss"]["channel"]["title"].element?.text, xml["rss"]["channel"]["itunes:image"].element?.attribute(by: "href")?.text)
        
    }
    func getEpisodes(data:Data) -> [Episode] {
        let xml = SWXMLHash.parse(data)

        var episodes : [Episode] = []
        
        for item in xml["rss"]["channel"]["item"] {
            let episode = Episode()
            if let title = item["title"].element?.text{
                episode.title = title
            }
            if let desc = item["description"].element?.text{
                episode.htmlDescription = desc
            }
            if let link = item["link"].element?.text {
                episode.audioURL = link
            }
            if let pubDate = item["pubDate"].element?.text {
                if let date = Episode.formatter.date(from: pubDate){
                    episode.pubDate = date
                }
            }
            episodes.append(episode)
            print(episode.pubDate)
        }
        
        return episodes
    }
    
}
