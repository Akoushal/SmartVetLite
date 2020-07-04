//
//  PresenterLayer.swift
//  SmartVet
//
//  Created by Koushal, KumarAjitesh on 2020/07/05.
//  Copyright © 2020 Koushal, KumarAjitesh. All rights reserved.
//

import Foundation

class PresenterLayer: NSObject {
    
    let networkLayer: NetworkLayer
    var view: ViewProtocols?
    
    init(view: ViewProtocols,
         networkLayer: NetworkLayer = NetworkLayer()) {
        self.view = view
        self.networkLayer = networkLayer
    }
    
    func getSettings() {
        let successHandler: (SettingsModel) -> Void = { (settings) in
            self.view?.displayConfigSettings(config: settings)
        }
        let errorHandler: (String) -> Void = { (error) in
            self.view?.displayError(error: error)
        }
        
        networkLayer.get(urlString: ApiUrls.kSettingsUrl,
                         successHandler: successHandler,
                         errorHandler: errorHandler)
    }
    
    func getPets() {
        let successHandler: ([Pets]) -> Void = { (pets) in
            self.view?.displayPets(pets: pets)
        }
        let errorHandler: (String) -> Void = { (error) in
            self.view?.displayError(error: error)
        }
        
        networkLayer.get(urlString: ApiUrls.kPetListURL,
                         successHandler: successHandler,
                         errorHandler: errorHandler)
    }
}
