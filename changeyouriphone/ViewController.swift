//
//  ViewController.swift
//  changeyouriphone
//
//  Created by JillOU on 2020/7/31.
//  Copyright © 2020 Jillou. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    @IBOutlet weak var iphone: UIImageView!
    @IBOutlet weak var iphoneview: UIView!
    @IBOutlet weak var colorview: UIView!
    @IBOutlet weak var textview: UIView!
    @IBOutlet weak var segmentcontrol: UISegmentedControl!
    @IBOutlet var slidercolor: [UISlider]!
    @IBOutlet var colorvaluelabel: [UILabel]!
    @IBOutlet weak var nametextfield: UITextField!
    @IBOutlet weak var namelabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //show iphone view
        let iphonecolorimageview = UIImageView(image: UIImage(named: "iphonecolor"))
        iphonecolorimageview.frame = iphoneview.bounds
        iphonecolorimageview.contentMode = .scaleAspectFit
        iphoneview.mask = iphonecolorimageview
        //init
        colorview.isHidden = false
        textview.isHidden = true
        //點done收鍵盤
        nametextfield.addTarget(self, action: #selector(closekeyboard), for: .editingDidEndOnExit)
        //keyboard observer
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification , object: nil)
    }
    
    //監聽鍵盤
    @objc func keyboardWillShow(notification:NSNotification){
        notificationkeyboard(true)

    }
    @objc func keyboardWillHide(notification:NSNotification){
        notificationkeyboard(false)

    }
    func notificationkeyboard(_ show:Bool){
        let screenSize = UIScreen.main.bounds.height/5
        if show {
            view.center.y -= screenSize
        } else {
            view.center.y += screenSize
        }
    }
    //點done收鍵盤
    @objc func closekeyboard(){
    }
    //點空白處收鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //slide UISlider
    @IBAction func Slidecolorslide(_ sender: UISlider) {
        slidecolor()
        for color in 0...3{
            if color == 3{
                colorvaluelabel[color].text = String(format: "%.2f", slidercolor[color].value)
            }else{
                colorvaluelabel[color].text = String(format: "%.f", slidercolor[color].value)
                
            }
        }
    }
    
    //choose to changecolor/enteryourname
    @IBAction func choosesegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            colorview.isHidden = false
            textview.isHidden = true
        }else{
            colorview.isHidden = true
            textview.isHidden = false
        }
    }
    
    //enteryourname and show on iphoneview
    @IBAction func entername(_ sender: UITextField) {
        namelabel.text = sender.text
    }
    
    //can change color
    func slidecolor(){
        iphoneview.backgroundColor = UIColor(red: CGFloat(slidercolor[0].value/255), green: CGFloat(slidercolor[1].value/255), blue: CGFloat(slidercolor[2].value/255), alpha: CGFloat(slidercolor[3].value))
    }
}

