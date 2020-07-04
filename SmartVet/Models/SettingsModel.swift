//
//  SettingsModel.swift
//  SmartVet
//
//  Created by Koushal, KumarAjitesh on 2020/07/05.
//  Copyright © 2020 Koushal, KumarAjitesh. All rights reserved.
//

import Foundation

//Struct for Settings
struct SettingsModel: Codable {
    let isChatEnabled: Bool?
    let isCallEnabled: Bool?
    let workHours: String?
}
