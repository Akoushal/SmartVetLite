//
//  OfficeHoursView.swift
//  SmartVet
//
//  Created by Koushal, KumarAjitesh on 2020/07/05.
//  Copyright © 2020 Koushal, KumarAjitesh. All rights reserved.
//

import UIKit

class OfficeHoursView: UIView {

    let margin: CGFloat = 20

    lazy var hoursLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        layer.borderWidth = 2
        layer.borderColor = UIColor(red: 116/255, green: 188/255, blue: 227/255, alpha: 1).cgColor
        layer.masksToBounds = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }

    //MARK: Private Methods
    private func setUpView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(hoursLabel)
        NSLayoutConstraint.activate([
            hoursLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            hoursLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            hoursLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            hoursLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
            ])
    }
}
