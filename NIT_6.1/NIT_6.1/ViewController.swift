//
//  ViewController.swift
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
}


class ViewController: UIViewController {

    var images = Array(repeating: Image(url: "https://picsum.photos/120"), count: 30)
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
    }

    @IBAction func loadPhotosButton(_ sender: Any) {
        for index in 0..<images.count {
            DispatchQueue.global().async { [self] in
                images[index].image = loadImage(imageModel: images[index]).image
                
                let indexPath = IndexPath(item: index, section: 0)
                DispatchQueue.main.async {
                    collectionView.reloadItems(at: [indexPath])
                }
            }
        }
    }
    
    func loadImage(imageModel: Image) -> Image{
        var preparedImage = Image(url: imageModel.url)
        
        guard let imageURL = URL(string: imageModel.url) else { return preparedImage }
        let imageData = try? Data(contentsOf: imageURL)
        let image = UIImage(data: imageData!)
        
        preparedImage.image = image
        return preparedImage
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        cell.backgroundColor = UIColor(red: 0.3, green: 0.7, blue: 0.7, alpha: 1)
        cell.imageView.image = images[indexPath.item].image
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width / 3 - 10
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "PhotoViewController") as! PhotoViewController
        if images[indexPath.item].image != nil {
            controller.image = images[indexPath.item].image!
            controller.labelAlpha = 0
        }
        present(controller, animated: true)
    }
}
