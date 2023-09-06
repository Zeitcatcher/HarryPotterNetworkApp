//
//  DetailsViewController.swift
//  HarryPotterNetworkApp
//
//  Created by Arseniy Oksenoyt on 9/1/23.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var wandLabel: UILabel!
    
    var character: Character!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = character.name
        descriptionLabel.text = character.characterDescription
//        wandLabel.text = character.wand?.wandDescription
        fetchImage()
    }
    
    private func fetchImage() {
        NetworkManager.shared.fetchImage(from: NetworkManager.shared.link) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.photoImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
