//
//  MainCollectionViewCell.swift
//  HarryPotterNetworkApp
//
//  Created by Arseniy Oksenoyt on 8/31/23.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    
    func configure(with character: Character) {
        characterNameLabel.text = character.name
        characterDescriptionLabel.text = character.house
        
        NetworkManager.shared.fetchImage(from: character.imageUrl) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.characterImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
