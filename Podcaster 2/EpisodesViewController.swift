//
//  EpisodesViewController.swift
//  Podcaster 2
//
//  Created by dan on 5/19/17.
//  Copyright © 2017 Daniel Stagnaro. All rights reserved.
//

import Cocoa
import AVFoundation

class EpisodesViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var pausePlayButton: NSButton!
    @IBOutlet weak var tableView: NSTableView!
    
    var podcast: Podcast?
    var podcastsVC: PodcastsViewController? = nil
    var episodes: [Episode] = []
    var player: AVPlayer? = nil
    
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
        pausePlayButton.isHidden = false
        getEpisodes()
    }
    
    func getEpisodes() {
        if podcast?.rssURL != nil {
            
            if let url = URL(string: podcast!.rssURL!) {
                
                URLSession.shared.dataTask(with: url) { (data:Data?, response:URLResponse?, error: Error?) in
                    if error != nil {
                        print(error as Any)
                    } else if data != nil {
                        let parser = Parser()
                        self.episodes = parser.getEpisodes(data: data!)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                    }.resume()
            }
        }
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
        if player?.rate == Float(0.0) {
            player?.rate = 1.0
        } else if player?.rate == Float(1.0) {
            player?.rate = 0.0
        }
        
    }
    func numberOfRows(in tableView: NSTableView) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let episode = episodes[row]
        let cell = tableView.make(withIdentifier: "episodeCell", owner: self) as? NSTableCellView
        cell?.textField?.stringValue = episode.title
        return cell
    }
    func tableViewSelectionDidChange(_ notification: Notification) {
        if tableView.selectedRow >= 0 {
            let episode = episodes[tableView.selectedRow]
            if let url = URL(string: episode.audioURL) {
                player = AVPlayer(url: url)
                player?.play()
            }
        }
    }
}
