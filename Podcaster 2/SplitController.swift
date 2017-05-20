//
//  splitController.swift
//  Podcaster 2
//
//  Created by dan on 5/19/17.
//  Copyright © 2017 Daniel Stagnaro. All rights reserved.
//

import Cocoa

class SplitController: NSSplitViewController {

    @IBOutlet weak var podcastsItem: NSSplitViewItem!
    @IBOutlet weak var episodesItem: NSSplitViewItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        if let podcastsVC = podcastsItem.viewController as? PodcastsViewController {
            if let episodesVC = episodesItem.viewController as? EpisodesViewController {
                podcastsVC.episodesVC = episodesVC
            }
        }
    }
    
}
