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
    var podcastsVC: PodcastsViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func updateView() {
        if podcast?.imageURL != nil {
            let image = NSImage(byReferencing: URL(string: podcast!.imageURL!)!)
            imageView.image = image
        } else {
            imageView.image = nil
        }
        if podcast?.title != nil {
            titleLabel.stringValue = podcast!.title!
        } else {
            titleLabel.stringValue = ""
            
            
        }
        pausePlayButton.isHidden = true
    }
    
    @IBAction func deleteClicked(_ sender: Any) {
        
        if podcast != nil {
            if let context = (NSApplication.shared().delegate as? AppDelegate)?.persistentContainer.viewContext {
                context.delete(podcast!)
                (NSApplication.shared().delegate as? AppDelegate)?.saveAction(nil)
                
                podcastsVC?.getPodcasts()
                
                podcast = nil
                updateView()
            }
        }
    }
    @IBAction func pausePlayClicked(_ sender: Any) {
        
    }
    
}
