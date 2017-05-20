//
//  EpisodesViewController.swift
//  Podcaster 2
//
//  Created by dan on 5/19/17.
//  Copyright © 2017 Daniel Stagnaro. All rights reserved.
//

import Cocoa

class EpisodesViewController: NSViewController {

    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var pausePlayButton: NSButton!
    @IBOutlet weak var tableView: NSTableView!
    
    var podcast : Podcast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func updateView() {
        if podcast?.title != nil {
            titleLabel.stringValue = podcast!.title!
        }
    }
    
    @IBAction func deleteClicked(_ sender: Any) {
        
    }
    @IBAction func pausePlayClicked(_ sender: Any) {
        
    }
    
}
