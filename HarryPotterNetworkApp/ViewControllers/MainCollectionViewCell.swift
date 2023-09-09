//
//  MainCollectionViewCell.swift
//  HarryPotterNetworkApp
//
//  Created by Arseniy Oksenoyt on 8/31/23.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    private var imageURL: URL? {
        didSet {
            characterImageView.image = nil
            updateImage()
        }
    }
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    
    func configure(with character: Character) {
        characterNameLabel.text = character.name
        characterDescriptionLabel.text = character.house
        characterImageView.contentMode = .scaleAspectFill
        imageURL = URL(string: character.imageURL ?? "")
        characterImageView.layer.cornerRadius = 50
    }
}

// MARK: - Private methids
extension MainCollectionViewCell {
    private func updateImage() {
        guard let imageURL = imageURL else { return }
        getImage(from: imageURL) { [weak self] result in
            switch result {
            case .success(let image):
                self?.characterImageView.image = image
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getImage(from url: URL, completion: @escaping(Result<UIImage, Error>) -> Void) {
        if let cachedImage = ImageCacheManager.shared.object(forKey: url.lastPathComponent as NSString) {
            print("Image for cache: ", url.lastPathComponent)
            completion(.success(cachedImage))
            return
        }
        NetworkManager.shared.fetchImage(from: url) { result in
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

