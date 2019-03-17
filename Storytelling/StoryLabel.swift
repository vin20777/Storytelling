//
//  StoryLabel.swift
//  Storytelling
//
//  Created by VTStudio on 3/16/19.
//  Copyright © 2019 VTStudio. All rights reserved.
//

import UIKit

protocol EndPageDelegate: AnyObject {
    func endAnimation(nextTag: Int)
}

class StoryLabel: UILabel {
    
    weak var delegate: EndPageDelegate?
    
    // How long will it take to finish a paragraph?
    private let speed: Double = 7.0

    private var startValue: Double = 0.0
    private var endValue: Double = 0.0
    private var animationStartDate: Date!
    private var startString = ""
    private var paragraphCounter: Int = 0
    private var storyString: String?
    
    private var displayLink: CADisplayLink!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        text = startString
        animationStartDate = Date()
    }
    
    func paragraphGenerator() {
        let nowParagraph = StorySource.hareAndTheTortoise[paragraphCounter]
        let numberOfParagraphs = StorySource.hareAndTheTortoise.count
        paragraphCounter = (paragraphCounter + 1) % numberOfParagraphs
        startString = ""
        startValue = 0.0
        endValue = Double(nowParagraph.paragraph.count)
        animationStartDate = Date()
        storyString = nowParagraph.paragraph
        
        displayLink = CADisplayLink(target: self, selector: #selector(self.handleUpdate))
        displayLink.add(to: .main, forMode: .default)
    }
    
    @objc func handleUpdate() {
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        let percentage = elapsedTime/speed
        let nowShowing = Int(percentage * (endValue - startValue))
        
        let index = storyString!.index(storyString!.startIndex, offsetBy: nowShowing)
        let mySubstring = String(storyString![..<index])
        self.attributedText = applyFancy(normal: mySubstring)
        
        if nowShowing >= storyString!.count {
            displayLink.invalidate()
            delegate?.endAnimation(nextTag: paragraphCounter)
        }
    }
    
    private func applyFancy(normal: String) -> NSAttributedString {
        if normal.isEmpty {
            return NSMutableAttributedString(string: "")
        }
        let attributedString = NSMutableAttributedString(string: normal)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 15
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        let fontAttribute = [NSAttributedString.Key.font: UIFont(name: Theme.mainFontName, size: 26.0)!]
        let firstWordAttribute = [NSAttributedString.Key.font: UIFont(name: Theme.mainFontName, size: 60.0)!]
        attributedString.addAttributes(firstWordAttribute, range: NSMakeRange(0, 1))
        attributedString.addAttributes(fontAttribute, range: NSMakeRange(1, normal.count - 1))
        return attributedString
    }
}
