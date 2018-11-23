//
//  CardsViewController.swift
//  my-tinder-version
//
//  Created by Luis Mendez on 11/20/18.
//  Copyright © 2018 Luis Mendez. All rights reserved.
//

/**
 * For multi gesture purposes, not applicable for this lab, see Canvas lab
 * 1. UIGestureRecognizerDelegate
 * 2. (gestureRecognizer).delegate = self -> name of gesture u gave, any gesture will do, the other gesture do not need to do this if used multigestures.
 * 3. add this method, it has to return true coz by default returns false
 func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
 return true
 }
 **/
import UIKit

class CardsViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet var gestureRecognizer: UIPanGestureRecognizer!
    
    //create a instance variable at the top of the file for the initial center.
    var cardInitialCenter: CGPoint!
    
    var fadeTransition: FadeTransition!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLoad")
        
        cardInitialCenter = imageView.center
        gestureRecognizer.delegate = self
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @IBAction func didSwipeLike(_ sender: UIPanGestureRecognizer) {
    
        //update it
        //imageView.transform = imageView.transform.rotated(by: CGFloat(translation.x))
    
        let location = sender.location(in: view)
        let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
 
//        if sender.state == .recognized {
//            print("Screen edge swiped!")
//        }
        
        //When the gesture begins (.began), store the image's center into the cardInitialCenter  variable
        if sender.state == .began {
            print("Gesture began")
            //cardInitialCenter = imageView.center
            imageView.transform = CGAffineTransform(rotationAngle: CGFloat(0))
        } else if sender.state == .changed {
            print("Gesture is changing")
            
            //As the user pans (.changed), change the imageView.center by the translation. Note: we ignore the y translation because we only want the tray to left and right:
            imageView.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)
            print("cardInitialCenter.x: \(cardInitialCenter.x)")
            print("translation.x: \(translation.x)")
            
            //imageView.transform = CGAffineTransform(rotationAngle: CGFloat(45 * Double.pi/180))
            
            
            //angle is in radiants, 45 degree in radiants is 0.785398 so I noticed that
            //translation of image at 200 is at about 45 degrees so translation.x / 0.785398
            //is equal to 255
            //if location of touch is greater (below) the center of image change to opposite rotation else do normal to right clockwise and to left counterclockwise
            if location.y >= cardInitialCenter .y {
                //initialize it everytime
                imageView.transform = CGAffineTransform(rotationAngle: CGFloat(-1*translation.x/255))
            } else {
                ///initialize it everytime
                imageView.transform = CGAffineTransform(rotationAngle: CGFloat(translation.x/255))
            }
            //print("imageView.transform: \(imageView.transform)")
        } else if sender.state == .ended {
            print("Gesture ended")
            print("translation.x: \(translation.x)")
            //If the x translation is greater than 50, animate it off screen to the right. If the x translation is less than -50, animate it off screen to the left.
            
            if translation.x >= 200 {
                UIView.animate(withDuration:0.8,
                               animations: {
                    // This causes first view to fade in and second view to fade out
                    self.imageView.alpha = 0
                }, completion: {  (finished: Bool) in
                    self.imageView.removeFromSuperview()
                })
            } else if translation.x <= -200 {
                UIView.animate(withDuration:0.8,
                               animations: {
                                // This causes first view to fade in and second view to fade out
                                self.imageView.alpha = 0
                }, completion: {  (finished: Bool) in
                    self.imageView.removeFromSuperview()
                })
            } else {
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.imageView.center = self.cardInitialCenter
                                self.imageView.transform = CGAffineTransform.identity
                }, completion: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Access the ViewController that you will be transitioning too, a.k.a, the destinationViewController.
        let profileViewController = segue.destination as! ProfileViewController
        
        // Set the modal presentation style of your destinationViewController to be custom.
        profileViewController.modalPresentationStyle = UIModalPresentationStyle.custom
        
        // Create a new instance of your fadeTransition.
        fadeTransition = FadeTransition()
        
        // Tell the destinationViewController's  transitioning delegate to look in fadeTransition for transition instructions.
        profileViewController.transitioningDelegate = fadeTransition
        
        // Adjust the transition duration. (seconds)
        fadeTransition.duration = 1.0
        
        profileViewController.image = self.imageView.image
    }
    
    @IBAction func didTap(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toProfileSegue", sender: nil)
    }
}
