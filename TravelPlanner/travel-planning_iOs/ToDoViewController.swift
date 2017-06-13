//
//  ToDoViewController.swift
//  travel-planning_iOs
//
//  Created by Студент on 5/13/17.
//  Copyright © 2017 Александр Сивцов. All rights reserved.
//

import UIKit

class ToDoViewController: UIViewController {
    
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        // window?.makeKeyAndVisible()
    
        let collectionViewController = UICollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        window?.rootViewController = UINavigationController(rootViewController: collectionViewController)
        
        navigationItem.title = "To-Do List"

    }
}
