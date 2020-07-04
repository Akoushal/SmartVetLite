//
//  TopView.swift
//  SmartVet
//
//  Created by Koushal, KumarAjitesh on 2020/07/05.
//  Copyright © 2020 Koushal, KumarAjitesh. All rights reserved.
//

import UIKit

protocol ErrorDisplayDelegate {
    func displayAlert(message: String)
    func layoutUpdate(settings: SettingsModel)
}

class TopView: UIView {
    
    let margin: CGFloat = 20
    var settings = SettingsModel.init(isChatEnabled: false, isCallEnabled: false, workHours: "")
    private lazy var chatButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 116/255, green: 188/255, blue: 227/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        button.setTitle("Chat", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var callButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 116/255, green: 188/255, blue: 227/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        button.setTitle("Call", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }()
    
    var delegate: ErrorDisplayDelegate?
    
    //MARK: Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        callConfigSettingsAPI()
    }
    
    //MARK: Private Methods
    private func callConfigSettingsAPI() {
        let presenter = PresenterLayer(view: self)
        presenter.getSettings()
    }
    
    @objc func buttonPressed(_ sender:UIButton) {
        var alertMessage = ""
        if checkWithinHours(hours: self.settings.workHours ?? "") {
            alertMessage = Constants.kWithinHours
        } else {
            alertMessage = Constants.kOutsideHours
        }
        self.delegate?.displayAlert(message: alertMessage)
    }
    
    func checkWithinHours(hours: String) -> (Bool) {
        let substring = hours.suffix(12)//To get the time range only
        let tempString = substring.replacingOccurrences(of: " ", with: "")
        let array = tempString.components(separatedBy: "-")
        let hour = Calendar.current.component(.hour, from: Date())
        guard let lowerBounds = Int(array[0].replacingOccurrences(of: ":00", with: "")), let upperBounds = Int(array[1].replacingOccurrences(of: ":00", with: "")) else { return false}
    
        let contains = hour > lowerBounds && hour < upperBounds
        return contains
    }
    
    private func setUpView(settings: SettingsModel) {
        self.settings = settings
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(chatButton)
        addSubview(callButton)

        self.delegate?.layoutUpdate(settings: settings)
        var chatWidthMultiplier: CGFloat = 0
        var callWidthMultiplier: CGFloat = 0
        if settings.isChatEnabled == true && settings.isCallEnabled == true {
            chatWidthMultiplier = 0.45
            callWidthMultiplier = 0.45
        } else if settings.isChatEnabled == true && settings.isCallEnabled == false {
            chatWidthMultiplier = 1
            callWidthMultiplier = -10
        } else if settings.isChatEnabled == false && settings.isCallEnabled == true {
            chatWidthMultiplier = -10
            callWidthMultiplier = 1
        }
    
        NSLayoutConstraint.activate([
            chatButton.topAnchor.constraint(equalTo: self.topAnchor, constant: margin/2),
            chatButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            chatButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: chatWidthMultiplier),
            chatButton.heightAnchor.constraint(equalToConstant: 80),
            
            callButton.topAnchor.constraint(equalTo: self.topAnchor, constant: margin/2),
            callButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            callButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: callWidthMultiplier),
            callButton.heightAnchor.constraint(equalToConstant: 80),
            ])
    }
}

extension TopView: ViewProtocols {
    
    func displayError(error: String) {
        self.delegate?.displayAlert(message: error)
    }
    
    func displayConfigSettings(config: SettingsModel) {
        DispatchQueue.main.async { [weak self] in
            self?.setUpView(settings: config)
        }
    }
    
    func displayPets(pets: [Pets]) {}
}
