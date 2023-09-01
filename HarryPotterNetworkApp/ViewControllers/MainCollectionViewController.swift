//
//  MainCollectionViewController.swift
//  HarryPotterNetworkApp
//
//  Created by Arseniy Oksenoyt on 8/31/23.
//

import UIKit

private let reuseIdentifier = "Cell"

class MainCollectionViewController: UICollectionViewController {

    var characters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacters()

    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "characterCell",
                for: indexPath
            ) as? MainCollectionViewCell
        else {
            return UICollectionViewCell()
        }
       return cell
    }
}

//MARK: Private methods
extension MainCollectionViewController {
    private func fetchCharacters() {
        NetworkManager.shared.fetch([Character].self, from: NetworkManager.shared.link) { [weak self] result in
            switch result {
            case .success(let characters):
                self?.characters = characters
                self?.collectionView.reloadData()
                print(characters)
            case .failure(let error):
                print(error)
            }
        }
    }
}
