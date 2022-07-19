//
//  ImageViewController.swift
//  homework18
//
//  Created by Dato on 19.07.22.
//

import UIKit
import Foundation

class ImageViewController: UIViewController {

    @IBOutlet weak var Img: UIImageView!
    private var pressStartTime : TimeInterval = 0.0
    
    
    var pinchGesture = UIPinchGestureRecognizer()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longPressRecognizer =  UILongPressGestureRecognizer(target: self, action: #selector(longPressed(_:)))
        Img.addGestureRecognizer(longPressRecognizer)
        
        Img.addGestureRecognizer(createSwipeGestureRecognizer(for: .up))
        Img.addGestureRecognizer(createSwipeGestureRecognizer(for: .down))
        Img.addGestureRecognizer(createSwipeGestureRecognizer(for: .right))
        Img.addGestureRecognizer(createSwipeGestureRecognizer(for: .left))
        
        
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinchRecognized(_:)))
        Img.addGestureRecognizer(pinchGestureRecognizer)
    }
    
    
    
    @objc func longPressed (_ sender : UILongPressGestureRecognizer) {
        if sender.state == .began {
            pressStartTime = NSDate.timeIntervalSinceReferenceDate
        }
        else if sender.state == .ended {
            let duration = NSDate.timeIntervalSinceReferenceDate - pressStartTime
            if duration < 1 {
                navigationController?.popViewController(animated: true)
            }else {
                UIView.animate(withDuration: 0.25) {
                    self.Img.isHidden = true
                   }
               
            }
        }
    }
    

    
    @objc func pinchRecognized (_ sender: UIPinchGestureRecognizer) {
        
        
        let information = ["color": UIColor.yellow]
        NotificationCenter.default.post(name: Notification.Name("com.homeWork18.Notification.colorChange"), object: nil, userInfo: information)
        
    
        sender.view?.transform = (sender.view?.transform)!.scaledBy(x: sender.scale, y: sender.scale)
        
        let guide = view.safeAreaLayoutGuide
        let width = guide.layoutFrame.size.width

       
        sender.scale = 1
        
        if Img.frame.width > width {
            self.Img.transform = CGAffineTransform.identity
        }
        
        
        
        
    }
    
    
    
    private func createSwipeGestureRecognizer(for direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeGestureRecognizer.direction = direction

        return swipeGestureRecognizer
    }
    
    
    
    @objc func didSwipe(_ sender: UISwipeGestureRecognizer) {
        var frame = Img.frame
        
        switch sender.direction {
            case .up:
                frame.origin.y -= 50.0
            case .down:
                frame.origin.y += 50.0
            case .left:
                frame.origin.x -= 50.0
            case .right:
                frame.origin.x += 50.0
            default:
                break
            }
        UIView.animate(withDuration: 0.25) {
               self.Img.frame = frame
           }
        
        
    }
    
    
}
