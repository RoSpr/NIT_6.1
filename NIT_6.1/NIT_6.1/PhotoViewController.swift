//
//  PhotoViewController.swift
//  NIT_6.1
//
//  Created by Родион Сприкут on 03.12.2020.
//

import UIKit

struct ParsedImages: Codable  {
    var image: UIImage?
    var url: String
    
    init(url: String) {
        self.url = url
    }
    
    private enum CodingKeys: String, CodingKey {
        case url = "url"
    }
}

class PhotoViewController: UIViewController {
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var thirdImageView: UIImageView!
    
    var image = UIImage()
    var labelAlpha: CGFloat = 1
    
    private var images: [ParsedImages] = []

    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var warningLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        warningLabel.alpha = labelAlpha
        photoImageView.image = image
        
        guard let imagesURL = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }
        
        URLSession.shared.dataTask(with: imagesURL) { data, _, _ in
            if
                let data = data,
                let images = try? JSONDecoder().decode([ParsedImages].self, from: data)
            {
                self.images = images.prefix(3).map { ParsedImages(url: $0.url) }
                
                var imageData: [Data] = []
                
                DispatchQueue.global().async {
                    for i in 0...2 {
                        guard let imageURL = URL(string: self.images[i].url) else { return }
                        let imgData = try! Data(contentsOf: imageURL)
                        imageData.append(imgData)
                    }
                    
                    DispatchQueue.main.async {
                        self.firstImageView.image = UIImage(data: imageData[0] )
                        self.secondImageView.image = UIImage(data: imageData[1] )
                        self.thirdImageView.image = UIImage(data: imageData[2] )
                    }
                }
            }
        }.resume()
    }
}
