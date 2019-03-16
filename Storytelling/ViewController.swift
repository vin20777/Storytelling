//
//  ViewController.swift
//  Storytelling
//
//  Created by VTStudio on 3/15/19.
//  Copyright © 2019 VTStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var drawingImageView: UIImageView!
    @IBOutlet weak var storyLabel: StoryLabel!
    @IBOutlet weak var continueImageView: UIImageView!
    @IBOutlet weak var belowView: UIView!
    
    private var tapGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        continueImageView.isHidden = true
        storyLabel.delegate = self
        super.viewDidLoad()
    }
    
    @IBAction private func startReading(_ sender: UIButton) {
        UIView.animate(withDuration: 1.0, animations: {
            sender.alpha = 0.0
        }) { _ in
            sender.isHidden = true
            self.startPlaying()
        }
    }
    
    private func startPlaying() {
        storyLabel.paragraphGenerator()
    }
    
    private func addTapGestureForNext() {
        hintAnimate()
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        belowView.addGestureRecognizer(tapGesture)
    }
    
    private func hintAnimate() {
        self.continueImageView.isHidden = false
        UIView.animate(withDuration: 0.5, animations: {
            self.continueImageView.frame.origin.y -= 30.0
        }) { _ in
            UIView.animateKeyframes(withDuration: 1.0, delay: 0.25, options: [.autoreverse, .repeat], animations: {
                self.continueImageView.frame.origin.y += 30.0
            })
        }
    }
    
    @objc private func handleTap(sender: UITapGestureRecognizer) {
        belowView.removeGestureRecognizer(tapGesture)
        continueImageView.isHidden = true
        continueImageView.layer.removeAllAnimations()
        UIView.animate(withDuration: 0.3, animations: {
            self.storyLabel.alpha = 0.0
        }) { _ in
            self.storyLabel.text = ""
            self.storyLabel.alpha = 1.0
            self.startPlaying()
        }
    }
}

extension ViewController: EndPageDelegate {
    func endAnimation() {
        self.addTapGestureForNext()
    }
}
