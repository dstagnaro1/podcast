//
//  PodcastsViewController.swift
//  Podcaster 2
//
//  Created by dan on 5/18/17.
//  Copyright © 2017 Daniel Stagnaro. All rights reserved.
//

import Cocoa

class PodcastsViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    var podcasts : [Podcast] = []
    var episodesVC: EpisodesViewController? = nil
    
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var podcastURLTextField: NSTextField!
    //    var url: String = "http://rss.art19.com/nosleep"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
//        podcastURLTextField.stringValue = "http://rss.art19.com/nosleep"
        podcastURLTextField.stringValue = "http://feeds.feedburner.com/ForePlay"
        getPodcasts()
    }
    
    func getPodcasts() {
        if let context = (NSApplication.shared().delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            let fetch = Podcast.fetchRequest() as NSFetchRequest<Podcast>
            fetch.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
            
            do {
                podcasts = try context.fetch(fetch)
            } catch {}
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func addPodcastClicked(_ sender: Any) {
        if let url = URL(string: podcastURLTextField.stringValue) {
            
            URLSession.shared.dataTask(with: url) { (data:Data?, response:URLResponse?, error: Error?) in
                if error != nil {
                    print(error as Any)
                } else if data != nil {
                    let parser = Parser()
                    let info = parser.getPodcastMetaData(data: data!)
                    if let context = (NSApplication.shared().delegate as? AppDelegate)?.persistentContainer.viewContext {
                        let podcast = Podcast(context: context)
                        
//                        print(self.podcastURLTextField.stringValue)
                        
                        podcast.rssURL = self.podcastURLTextField.stringValue
                        podcast.imageURL = info.imageURL
                        podcast.title = info.title
                        
                        (NSApplication.shared().delegate as? AppDelegate)?.saveAction(nil)
                        self.getPodcasts()
                        
                        DispatchQueue.main.async {
                            self.podcastURLTextField.stringValue = ""
                        }
                        
                    }
                }
                }.resume()
        }
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return podcasts.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.make(withIdentifier: "podcastcell", owner: self) as? NSTableCellView
        
        let podcast = podcasts[row]
        
        if podcast.title != nil {
            cell?.textField?.stringValue = podcast.title!
        } else {
            cell?.textField?.stringValue = ""
        }
        return cell
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        if  tableView.selectedRow >= 0 {
            let podcast = podcasts[tableView.selectedRow]
            episodesVC?.podcast = podcast
            episodesVC?.updateView()
        }
    }
}
