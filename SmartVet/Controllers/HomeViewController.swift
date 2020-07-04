//
//  HomeViewController.swift
//  SmartVet
//
//  Created by Koushal, KumarAjitesh on 2020/07/05.
//  Copyright © 2020 Koushal, KumarAjitesh. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var topView: TopView?
    @IBOutlet weak var officeHoursView: OfficeHoursView?
    @IBOutlet weak var stackView: UIStackView?
    @IBOutlet weak var petList: UICollectionView?
    var petInfoArray = [Pets]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topView?.delegate = self
        petList?.register(UINib(nibName: "PetInfoCell", bundle: Bundle.main)
            , forCellWithReuseIdentifier: "PetInfoCell")
        fetchPetList()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let flowLayout = petList?.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }
    
    //MARK: Private Methods
    func fetchPetList() {
        let presenter = PresenterLayer(view: self)
        presenter.getPets()
    }
}

//MARK: UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return petInfoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PetInfoCell", for: indexPath) as? PetInfoCell else {
            return UICollectionViewCell.init()
        }
        cell.configureCell(petInfo: petInfoArray[indexPath.item])
        return cell
    }
}

//MARK: UICollectionViewDelegate & UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PetDetailViewController()
        vc.petInfo = petInfoArray[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.size.width, height: 80)
        return size
    }
}

//MARK: View Protocols

extension HomeViewController: ViewProtocols {
    func displayPets(pets: [Pets]) {
        self.petInfoArray = pets
        DispatchQueue.main.async { [weak self] in
            self?.petList?.reloadData()
        }
    }
    
    func displayError(error: String) {
        self.displayAlert(message: error)
    }
    
    func displayConfigSettings(config: SettingsModel) {}
}

//MARK: Error Display Delegate

extension HomeViewController: ErrorDisplayDelegate {
    func displayAlert(message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "OK", style: .cancel) { (action:UIAlertAction) in
        }
        alertController.addAction(action1)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func layoutUpdate(settings: SettingsModel) {
        officeHoursView?.hoursLabel.text = "Office Hours: " + (settings.workHours ?? "")
        if settings.isCallEnabled == false && settings.isChatEnabled == false {
            stackView?.removeArrangedSubview(topView ?? UIView())
        }
    }
}
