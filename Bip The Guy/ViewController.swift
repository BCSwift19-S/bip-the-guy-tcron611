//
//  ViewController.swift
//  Bip The Guy
//
//  Created by Thomas Ronan on 2/4/19.
//  Copyright © 2019 Thomas Ronan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //Mark: Properties
    @IBOutlet weak var imageToPunch: UIImageView!
    var audioPlayer = AVAudioPlayer()
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    //Mark: Functions
    func animateImage() {
        let bounds = self.imageToPunch.bounds
        //shrink our imageToPunch by 60 points
        self.imageToPunch.bounds = CGRect(x: self.imageToPunch.bounds.origin.x + 60, y: self.imageToPunch.bounds.origin.y + 60, width: self.imageToPunch.bounds.size.width - 60, height: self.imageToPunch.bounds.size.height - 60)
        
        //animate
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: [], animations: { self.imageToPunch.bounds = bounds }, completion: nil)
    }
    
    func playSound(soundName: String, audioPlayer: inout AVAudioPlayer){
        //can we load in the file soundname?
        if let sound = NSDataAsset(name: soundName) {
            //check if sound.data is a sound file
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                //if sound.data isn't a sound file
                print("ERROR: data in \(soundName) couldn't be played as a sound")
            }
        }else {
            //if reading in the NSDataAsset didn't work, tell the user report the error
            print("ERROR: file \(soundName) didn't load")
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageToPunch.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //Mark: Actions
    @IBAction func libraryPressed(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraPressed(_ sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        } else {
            showAlert(title: "Camera Not Available", message: "There is no camera available on this device")
        }
        
        
    }
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        animateImage()
        playSound(soundName: "punchSound", audioPlayer: &audioPlayer)
    }
    
}

