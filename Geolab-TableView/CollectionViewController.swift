//
//  CollectionViewController.swift
//  Geolab-TableView
//
//  Created by Nikoloz Tatunashvili on 17.12.20.
//

import UIKit

class CollectionViewController: UIViewController {
    
    var itemsInRow: CGFloat = 4
    let lineSpacing: CGFloat = 0
    let interitemSpacing: CGFloat = 0
    let scrollDirection: UICollectionView.ScrollDirection = .vertical
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)
        layout?.minimumInteritemSpacing = lineSpacing
        layout?.minimumLineSpacing = interitemSpacing
        layout?.sectionInset = UIEdgeInsets.zero
        layout?.scrollDirection = scrollDirection
        
        collectionView.isPagingEnabled = true
        
        self.navigationItem.setLeftBarButton(UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(changeLayout)), animated: false)
    }

    @objc func changeLayout() {
        collectionView.performBatchUpdates {
            itemsInRow = itemsInRow == 4 ? 2 : 4
        }
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = (indexPath.item + indexPath.section) % 2 == 0 ? "orange" : "red"
        return collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    }
}

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("did select at \(indexPath)")
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size

        let maxSize = scrollDirection == .horizontal ? collectionView.frame.height : collectionView.frame.width
        let height = floor( (maxSize - (lineSpacing * (itemsInRow - 1))) / itemsInRow )
        let width = height * 0.7
        return scrollDirection == .horizontal ? CGSize(width: width, height: height) : CGSize(width: height, height: width)
    }
}

