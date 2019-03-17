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
    @IBOutlet weak var continueImageView: ContinueImageView!
    @IBOutlet weak var belowView: UIView!
    
    private var nextPicTag: Int = 0
    private var tapGesture: UITapGestureRecognizer!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        continueImageView.isHidden = true
        storyLabel.delegate = self
    }
    
    // MARK: Action
    @IBAction private func startReading(_ sender: UIButton) {
        UIView.animate(withDuration: 1.0, animations: {
            sender.alpha = 0.0
        }) { _ in
            sender.isHidden = true
            self.startPlaying()
        }
    }
    
    // MARK: Private
    private func startPlaying() {
        storyLabel.paragraphGenerator()
    }
    
    private func addTapGestureForNext() {
        continueImageView.startJumping()
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        belowView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap(sender: UITapGestureRecognizer) {
        belowView.removeGestureRecognizer(tapGesture)
        continueImageView.stopJumping()
        UIView.animate(withDuration: 0.3, animations: {
            self.storyLabel.alpha = 0.0
        }) { _ in
            self.storyLabel.text = ""
            self.storyLabel.alpha = 1.0
            self.startPlaying()
        }
        
        UIView.animate(withDuration: 2.0, animations: {
            self.drawingImageView.alpha = 0.0
        }) { _ in
            self.drawingImageView.image = StorySource.hareAndTheTortoise[self.nextPicTag].image
            UIView.animate(withDuration: 2.0, animations: {
                self.drawingImageView.alpha = 1.0
            })
        }
    }
}

// MARK: - EndPageDelegate
extension ViewController: EndPageDelegate {
    func endAnimation(nextTag: Int) {
        self.addTapGestureForNext()
        self.nextPicTag = nextTag
    }
}
