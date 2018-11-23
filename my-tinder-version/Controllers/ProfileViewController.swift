//
//  ProfileViewController.swift
//  my-tinder-version
//
//  Created by Luis Mendez on 11/22/18.
//  Copyright © 2018 Luis Mendez. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageTabBarView: UIImageView!
    
    var image: UIImage!
    
    var imageTransition: ImageTransition!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        imageTabBarView.alpha = 0
        
        UIView.animate(withDuration: 0.4,
                       animations: {
                        self.imageTabBarView.alpha = 1})
        }

    @IBAction func didTapDone(_ sender: UITapGestureRecognizer) {
        print("didTap")
        dismiss(animated: false, completion: nil)
    }
    
}
/*
 let image: UIImage = self.image//UIImage(named: "ryan.png")!
 let tempImageView = UIImageView(image: image)
 tempImageView.frame = CGRect(x:8,y:127,width:398,height:487)
 //tempImageView.contentMode = .scaleAspectFit
 tempImageView.contentMode = .scaleAspectFill
 tempImageView.clipsToBounds = true
 //tempImageView.animationRepeatCount = 0
 //tempImageView.isUserInteractionEnabled = true
 view.addSubview(tempImageView)
 
 imageView.alpha = 0
 imageTabBarView.alpha = 0
 
 UIView.animate(withDuration: 0.01,
 animations: {
 self.imageView.alpha = 1
 }, completion: {  (finished: Bool) in
 tempImageView.removeFromSuperview()  // this removes it from your view hierarchy
 })
 */
