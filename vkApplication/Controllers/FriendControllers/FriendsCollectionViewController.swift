//
//  FriendsCollectionViewController.swift
//  vkApplication
//
//  Created by Timur Sasin on 27/01/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import UIKit

class FriendsCollectionViewController: UICollectionViewController {
    
    var image: UIImage!
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendPhoto", for: indexPath) as? FriendCollectionViewCell else {
            print("Something went wrong with collection view cell")
            return UICollectionViewCell()
        }
        cell.friendPhoto.image = image
        return cell
    }   

}
