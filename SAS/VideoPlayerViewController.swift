//
//  VideoPlayerViewController.swift
//  SAS
//
//  Created by Lauren Saxton on 11/16/19.
//  Copyright © 2019 Lauren Saxton. All rights reserved.
//

// citation/reference for the code presented in this file:
// https://stackoverflow.com/questions/45886278/embedding-a-local-video-into-a-uiview
// answers by: Alan S and Abdelahad Darwish
// stack overflow is under the creative commons license

// video citation/reference in this file:
// https://www.pexels.com/video/cg-animation-of-a-revolving-asteroid-854240/
// https://www.pexels.com/photo-license/ (free use)


import UIKit
import AVKit

class VideoPlayerViewController: AVPlayerViewController {
    var avPlayer: AVPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()

        let filepath: String? = Bundle.main.path(forResource: "asteroid", ofType: "mp4")
        let fileURL = URL.init(fileURLWithPath: filepath!)

        avPlayer = AVPlayer(url: fileURL)
        self.showsPlaybackControls = false

        self.player = avPlayer
        self.player?.play()
    }
    
}
