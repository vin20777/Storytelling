//
//  ContinueImageView.swift
//  Storytelling
//
//  Created by VTStudio on 3/16/19.
//  Copyright © 2019 VTStudio. All rights reserved.
//

import UIKit

class ContinueImageView: UIImageView {
    
    let jumpingHeight: CGFloat = 20.0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func startJumping() {
        self.isHidden = false
        UIView.animate(withDuration: 0.5, animations: {
            self.frame.origin.y -= self.jumpingHeight
        }) { _ in
            UIView.animateKeyframes(withDuration: 1.0, delay: 0.25, options: [.autoreverse, .repeat], animations: {
                self.frame.origin.y += self.jumpingHeight
            })
        }
    }
    
    func stopJumping() {
        self.isHidden = true
        self.layer.removeAllAnimations()
    }
}
