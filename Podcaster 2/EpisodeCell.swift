//
//  EpisodeCell.swift
//  Podcaster 2
//
//  Created by dan on 5/21/17.
//  Copyright © 2017 Daniel Stagnaro. All rights reserved.
//

import Cocoa
import WebKit

class EpisodeCell: NSTableCellView {

    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var dateLabel: NSTextField!
    @IBOutlet weak var descriptionWebView: WebView!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
