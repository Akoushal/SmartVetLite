//
//  PetsModel.swift
//  SmartVet
//
//  Created by Koushal, KumarAjitesh on 2020/07/05.
//  Copyright © 2020 Koushal, KumarAjitesh. All rights reserved.
//

import Foundation

//Struct for Pets
struct Pets: Codable {
    let image_url: String?
    let title: String?
    let content_url: String?
    let date_added: String?
}
