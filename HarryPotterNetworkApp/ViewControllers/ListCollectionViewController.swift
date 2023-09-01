//
//  ListCollectionViewController.swift
//  HarryPotterNetworkApp
//
//  Created by Arseniy Oksenoyt on 8/31/23.
//

import UIKit

class ListCollectionViewController: UICollectionViewController {
    
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
        let character = characters[indexPath.item]
        cell.configure(with: character)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = characters[indexPath.item]
        performSegue(withIdentifier: "detailsSegue", sender: character)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsViewController = segue.destination as? DetailsViewController else { return }
        guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
        
        detailsViewController.character = characters[indexPath.item]
    }
}

// MARK: - Private methods
extension ListCollectionViewController {
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

// MARK: - UICollectionViewDelegateFlowLayout
extension ListCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 200)
    }
}
