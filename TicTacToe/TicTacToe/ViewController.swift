//
//  ViewController.swift
//  TicTacToe
//
//  Created by MAC Home on 01.03.17.
//  Copyright © 2017 HSE. All rights reserved.
//
// https://codeshare.io/29ORJX

import UIKit

fileprivate let reuseIdentifier = "tictactoecell"
fileprivate let screenWidth = UIScreen.main.bounds.width


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var currentTurn: cellSelection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupCollectionViewCells()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Setup
    
    func setupCollectionViewCells() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        
        let padding: CGFloat = 10
        let itemWidth = screenWidth/4 - padding
        let itemHeight = screenWidth/4 - padding
        
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        
        collectionView.collectionViewLayout = layout
    }
    
    // MARK: UICollectionViewDataSource
    
    // Overall number of items in data list
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? TictactoeCell else { fatalError()}
        cell.iconView.image = nil
        return cell
    }

    // MARK: - UICollectionViewDelegates
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateCell(having: indexPath, crossGoesFirst: true)
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        updateCell(having: indexPath, selected: false, outOfStock: false)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//        updateCell(having: indexPath, selected: true, outOfStock: false)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
//        updateCell(having: indexPath, selected: false, outOfStock: false)
//    }
    
    func updateCell(having indexPath: IndexPath, crossGoesFirst: Bool) {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? TictactoeCell else { fatalError() }
        
        var cellImage = cell.iconView.image
        
        if cellImage == #imageLiteral(resourceName: "cross") || cell == #imageLiteral(resourceName: "circle") {
            print("Kek")
        }
        
        else if crossGoesFirst && cellImage == nil {
        
            cellImage = #imageLiteral(resourceName: "cross")
        }
        
        else { cellImage = #imageLiteral(resourceName: "circle")}
        
//        if let cell = collectionView.cellForItem(at: indexPath) {
        
            
        
    }

}

