//
//  SmartVetTests.swift
//  SmartVetTests
//
//  Created by Koushal, KumarAjitesh on 2020/07/05.
//  Copyright © 2020 Koushal, KumarAjitesh. All rights reserved.
//

import XCTest
@testable import SmartVet

class SmartVetTests: XCTestCase {

    // Used in test_serializeSettingsModel()
    let settingsMockedJSON: [String: Any] = ["isCallEnabled": true, "isChatEnabled": true, "workHours": "M-F 5:00 - 10:00"]
    
    // Used in test_serializePetsModel()
    let petsMockedJSON = ["date_added": "2018-06-02T03:27:38.027Z", "content_url": "https://en.wikipedia.org/wiki/Cat", "title": "Cat", "image_url": "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Cat_poster_1.jpg/1200px-Cat_poster_1.jpg"]

    /*
     // Test: For checking HomeViewController conforms to CollectionViewDatasource
     */
    func test_controllerConformsToCollectionViewDataSourceProtocol() {
        let controller = HomeViewController()
        XCTAssertTrue(controller.conforms(to: UICollectionViewDataSource.self))
        XCTAssertTrue(controller.responds(to: #selector(controller.collectionView(_:numberOfItemsInSection:))))
        XCTAssertTrue(controller.responds(to: #selector(controller.collectionView(_:cellForItemAt:))))
    }
    
    /*
     // Test: For serializing mocked JSON object into SettingsModel
     */
    func test_serializeSettingsModel() {
        guard let data = try? JSONSerialization.data(withJSONObject: settingsMockedJSON, options: .prettyPrinted), let settingsInfo = try? JSONDecoder().decode(SettingsModel.self, from: data) else {
            XCTFail()
            return
        }
        
        XCTAssert(settingsInfo.isCallEnabled == true)
        XCTAssert(settingsInfo.isChatEnabled == true)
        XCTAssert(settingsInfo.workHours == "M-F 5:00 - 10:00")
    }
    
    /*
     // Test: For serializing mocked JSON object into PetsModel
     */
    func test_serializePetsModel()
    {
        guard let data = try? JSONSerialization.data(withJSONObject: petsMockedJSON, options: .prettyPrinted), let petsModel = try? JSONDecoder().decode(Pets.self, from: data) else {
            XCTFail()
            return
        }
        
        XCTAssert(petsModel.title == "Cat")
        XCTAssert(petsModel.date_added == "2018-06-02T03:27:38.027Z")
        XCTAssert(petsModel.content_url == "https://en.wikipedia.org/wiki/Cat")
        XCTAssert(petsModel.image_url == "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Cat_poster_1.jpg/1200px-Cat_poster_1.jpg")
    }
}
