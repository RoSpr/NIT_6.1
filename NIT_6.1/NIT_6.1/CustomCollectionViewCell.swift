//
//  CustomCollectionViewCell.swift
//  NIT_6.1
//
//  Created by Родион Сприкут on 03.12.2020.
//

import UIKit

struct Image {
    var url: String
    var image: UIImage?
    
    init(url: String) {
        self.url = url
    }
    
//    private enum CodingKeys: String, CodingKey {
//        case url = "url"
//    }
    
}


class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setImage(imageModel: Image, completion: @escaping (UIImage?) -> Void) {
        if let image = imageModel.image {
            imageView.image = image
            return
        } else {
            DispatchQueue.global().async {
                guard let imageURL = URL(string: imageModel.url) else { return }
                let imageData = try? Data(contentsOf: imageURL)
                
                let image = UIImage(data: imageData!)
                completion(image)
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }

}
