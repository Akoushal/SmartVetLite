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
    
    private var presenter: PresenterLayer?

    // Used in test_serializeSettingsModel()
    let settingsMockedJSON: [String: Any] = ["isCallEnabled": true,
                                             "isChatEnabled": true,
                                             "workHours": "M-F 5:00 - 10:00"]
    
    // Used in test_serializePetsModel()
    let petsMockedJSON = ["date_added": "2018-06-02T03:27:38.027Z",
                          "content_url": "https://en.wikipedia.org/wiki/Cat",
                          "title": "Cat",
                          "image_url": "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Cat_poster_1.jpg/1200px-Cat_poster_1.jpg"]
    
    override func setUp() {
        presenter = PresenterLayer(view: MockedTopView())
    }
    
    override func tearDown() {
        presenter = nil
    }

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
    
    /*
    // Test: For testing FetchSettings Success
    */
    func test_FetchSettingsSuccess() {
        let expectation = self.expectation(description: "Fetch")
        expectation.fulfill()
        MockPresenterLayer.shouldSucceed = true
        presenter?.getSettings()
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertTrue(true)
    }
    
    /*
    // Test: For testing FetchSettings Failure
    */
    func test_FetchSettingsFail() {
        let expectation = self.expectation(description: "Fetch")
        expectation.fulfill()
        MockPresenterLayer.shouldSucceed = false
        presenter?.getSettings()
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertFalse(false)
    }
    
    /*
    // Test: For testing FetchPets Success
    */
    func test_FetchPetsSuccess() {
        let expectation = self.expectation(description: "Fetch")
        expectation.fulfill()
        MockPresenterLayer.shouldSucceed = true
        presenter?.getPets()
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertTrue(true)
    }
    
    /*
    // Test: For testing FetchPets Failure
    */
    func test_FetchPetsFail() {
        let expectation = self.expectation(description: "Fetch")
        expectation.fulfill()
        MockPresenterLayer.shouldSucceed = false
        presenter?.getPets()
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertFalse(false)
    }
}

class MockPresenterLayer: PresenterLayer {
    static var shouldSucceed = true
    
    override func getPets() {
        if MockPresenterLayer.shouldSucceed {
            self.view?.displayPets(pets: [Pets(image_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Cat_poster_1.jpg/1200px-Cat_poster_1.jpg",
                                               title: "Cat",
                                               content_url: "https://en.wikipedia.org/wiki/Cat",
                                               date_added: "2018-06-02T03:27:38.027Z")])
        } else {
            self.view?.displayError(error: "Something went wrong. Please try again!")
        }
    }
    
    override func getSettings() {
        if MockPresenterLayer.shouldSucceed {
            self.view?.displayConfigSettings(config: SettingsModel(isChatEnabled: true,
                                                                   isCallEnabled: false,
                                                                   workHours: "M-F 5:00 - 10:00"))
        } else {
            self.view?.displayError(error: "Something went wrong. Please try again!")
        }
    }
}

class MockedTopView: TopView {}
