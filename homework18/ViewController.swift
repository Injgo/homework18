//
//  ViewController.swift
//  homework18
//
//  Created by Dato on 19.07.22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var redCircle: UIView!
    @IBOutlet weak var blueCircle: UIView!
    
    
    @IBOutlet weak var purpleTriangle: UIView!
    
    @IBOutlet weak var blackTriangle: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        setUpTriangle(name: purpleTriangle)
        setUpTriangle(name: blackTriangle)
        
        redCircle.layer.cornerRadius = redCircle.frame.width/2
        redCircle.layer.masksToBounds = true
        
        blueCircle.layer.cornerRadius = blueCircle.frame.width/2
        blueCircle.layer.masksToBounds = true
        
        redCircleTap()
        blueCircleTap()
        purpleTriangleTap()
        blackTriangleTap()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeBackgroundColor), name: Notification.Name("com.homeWork18.Notification.colorChange"), object: nil)

    }
    
    
    func redCircleTap(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
        redCircle.addGestureRecognizer(tap)

    }
    func blueCircleTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
        blueCircle.addGestureRecognizer(tap)
    }
    
    func purpleTriangleTap(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
        purpleTriangle.addGestureRecognizer(tap)
    }
    
    func blackTriangleTap(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
        blackTriangle.addGestureRecognizer(tap)
    }
    
    
    @objc func tapGesture(_ gesture: UITapGestureRecognizer){
        let vc  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    func setUpTriangle(name: UIView){
            let heightWidth = name.frame.size.width
               let path = CGMutablePath()

               path.move(to: CGPoint(x: 0, y: heightWidth))
               path.addLine(to: CGPoint(x:heightWidth/2, y: heightWidth/2))
               path.addLine(to: CGPoint(x:heightWidth, y:heightWidth))
               path.addLine(to: CGPoint(x:0, y:heightWidth))

               let shape = CAShapeLayer()
               shape.path = path
               
        if name.tag ==  1 {
            shape.fillColor = UIColor.purple.cgColor
        }
        else {
            shape.fillColor = UIColor.black.cgColor
        }
        name.isUserInteractionEnabled = true

               name.layer.insertSublayer(shape, at: 1)
           }
    
    @objc func changeBackgroundColor(notification: Notification) {
        if let color = notification.userInfo?["color"] as? UIColor {
            view.backgroundColor = color
        }
        
    }

}

