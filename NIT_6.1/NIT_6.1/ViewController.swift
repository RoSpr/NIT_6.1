//
//  ViewController.swift
//  NIT_6.1
//
//  Created by Родион Сприкут on 03.12.2020.
//

import UIKit

class ViewController: UIViewController {
    
    var images = Array(repeating: Image(url: "https://picsum.photos/200"), count: 3)
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
    }

    @IBAction func loadPhotosButton(_ sender: Any) {
        for index in 0..<images.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: IndexPath(index: index)) as! CustomCollectionViewCell
            cell.setImage(imageModel: self.images[index]) { [weak self] image in
                self?.images[index].image = image
            }
            self.collectionView.reloadData()
        }
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        cell.backgroundColor = UIColor(red: 0.3, green: 0.7, blue: 0.7, alpha: 1)

//        cell.setImage(imageModel: self.images[indexPath.item]) { [weak self] image in
//            self?.images[indexPath.item].image = image
//        }
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
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
//        let image = cell.imageView.image
//        controller.photoImageView.image = self.images[indexPath.item].image
        
        present(controller, animated: true)
    }
    
}
