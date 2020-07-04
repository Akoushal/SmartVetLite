//
//  Configuration.swift
//  SmartVet
//
//  Created by Koushal, KumarAjitesh on 2020/07/05.
//  Copyright © 2020 Koushal, KumarAjitesh. All rights reserved.
//

import Foundation

//Struct for Urls
struct ApiUrls {
    /*
     NOTE - Also Fetching Settings Configuration API can be changed manually in the code to test Visibility og Call & Chat buttons
     https://api.jsonbin.io/b/5bd185fb51e8b664f2c1a56f/4 - Both Call & Chat Buttons Visible
     https://api.jsonbin.io/b/5bd185fb51e8b664f2c1a56f/5 - Only Chat Button Visible
     https://api.jsonbin.io/b/5bd185fb51e8b664f2c1a56f/6 - Only Call Button Visible
     https://api.jsonbin.io/b/5bd185fb51e8b664f2c1a56f/7 - Both are hidden
     */
    
    static var kSettingsUrl = "https://api.jsonbin.io/b/5bd185fb51e8b664f2c1a56f/4"
    static var kPetListURL = "https://api.jsonbin.io/b/5bd186a3adf9f5652a6504c1"
}
