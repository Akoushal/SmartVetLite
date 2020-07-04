//
//  ViewProtocols.swift
//  SmartVet
//
//  Created by Koushal, KumarAjitesh on 2020/07/05.
//  Copyright © 2020 Koushal, KumarAjitesh. All rights reserved.
//

import Foundation

protocol ViewProtocols: class {
    func displayPets(pets: [Pets])
    func displayConfigSettings(config: SettingsModel)
    func displayError(error: String)
}
