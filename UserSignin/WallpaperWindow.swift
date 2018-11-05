//
//  WallpaperWindow.swift
//  UserSignin
//
//  Created by Rana,Sumnima on 11/4/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class WallpaperWindow: UIWindow {

    var wallpaper: UIImage? = UIImage(named: "appimage6.jpg") {
        didSet {
            // refresh if the image changed
            setNeedsDisplay()
        }
    }
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        //clear the background color of all table views, so we can see the background
        UITableView.appearance().backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        // draw the wallper if set, otherwise default behaviour
        if let wallpaper = wallpaper {
            wallpaper.draw(in: self.bounds);
        } else {
            super.draw(rect)
        }
    }    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
