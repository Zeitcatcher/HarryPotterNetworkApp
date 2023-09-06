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
        characterImageView.contentMode = .scaleAspectFill
        characterImageView.image = nil
        updateImage(from: character)
    }
}

// MARK: - Private methids
extension MainCollectionViewCell {
    private func updateImage(from character: Character) {
        guard let imageURL = URL(string: character.imageURL ?? "") else { return }
        getImage(with: character, from: imageURL) { [weak self] result in
            switch result {
            case .success(let image):
                self?.characterImageView.image = image
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getImage(with character: Character, from url: URL, completion: @escaping(Result<UIImage, Error>) -> Void) {
        if let cachedImage = ImageCacheManager.shared.object(forKey: url.lastPathComponent as NSString) {
            print("Image for cache: ", url.lastPathComponent)
            completion(.success(cachedImage))
            return
        }
        NetworkManager.shared.fetchImage(from: character.imageURL) { result in
            switch result {
            case .success(let imageData):
                guard let uiImage = UIImage(data: imageData) else { return }
                ImageCacheManager.shared.setObject(uiImage, forKey: url.lastPathComponent as NSString)
                print("Image from network: ", url.lastPathComponent)
                completion(.success(uiImage))
            case .failure(let error):
                print(error)
            }
        }
    }
}

