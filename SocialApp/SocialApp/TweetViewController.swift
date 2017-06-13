//
//  TweetViewController.swift
//  SocialApp
//
//  Created by Александр Лебедев on 22/02/2017.
//  Copyright © 2017 Александр Лебедев. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let userData = selectedTweet?.object(forKey: "user") as! NSDictionary
        tweetText.text? = selectedTweet?.object(forKey: "text") as! String
        tweetAuthorName.text? = userData.object(forKey: "name") as! String
        let imageURLString = userData.object(forKey: "profile_image_url_https") as! String
        let imageURL = URL(string: imageURLString)
        if let imageData = NSData(contentsOf: imageURL!) {
            DispatchQueue.main.async {
                self.tweetAuthorAvatar.image = UIImage(data: imageData as Data)
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBOutlet weak var tweetAuthorAvatar: UIImageView!
    @IBOutlet weak var tweetAuthorName: UILabel!
    @IBOutlet weak var tweetText: UITextView!
    var selectedTweet : NSDictionary?
}
