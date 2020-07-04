//
//  PetInfoCell.swift
//  SmartVet
//
//  Created by Koushal, KumarAjitesh on 2020/07/05.
//  Copyright © 2020 Koushal, KumarAjitesh. All rights reserved.
//

import UIKit

class PetInfoCell: UICollectionViewCell {
    
    @IBOutlet weak var petImage: UIImageView?
    @IBOutlet weak var petName: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(petInfo: Pets) {
        petName?.text = petInfo.title
        guard let imageUrlString = petInfo.image_url, let url = URL(string: imageUrlString) else { return}
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return} //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                self.petImage?.image = UIImage(data: data)
            }
        }
    }
}

