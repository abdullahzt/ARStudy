//
//  MainScreenController.swift
//  ARStudy
//
//  Created by Abdullah on 04/05/2020.
//  Copyright © 2020 Abdullah. All rights reserved.
//

import UIKit

private let reuseIdentifier = "BookCell"

class MainScreenController: UICollectionViewController {
    
    //MARK: - Properties
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .white
        self.title = "Books"
        
        collectionView.register(BookCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white
        
    }
    
}

//MARK: - UICollectionViewDataSource

extension MainScreenController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BookCell
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout

extension MainScreenController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width - 20, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        let leftInset = CGFloat(10)
        let rightInset = leftInset

        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)

    }
}
