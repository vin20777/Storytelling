# Story-Telling
## How to build an auto rundown paragraph animation?
<p align="center" >
  <img src="https://user-images.githubusercontent.com/31400661/54486558-1bee7100-4847-11e9-8604-8cacf6325be6.gif" width="480">
</p>

### Can be use in ***game apps, education apps***, and etc.

## Reference Source
------
Youtube Tutorial: <a href="https://www.youtube.com/watch?v=b3kZH1vfG2U">Lets Build That App</a><br>
Story Source: <a href="http://read.gov/aesop/025.html">Æsop for Children</a><br>
Pictures Source: <a href="https://www.storytimemagazine.com/news/about-stories/growth-mindset-and-reading/">Storytime, </a>
<a href="https://meridianfinancialpartners.com/2016/12/06/the-tortoise-and-the-hare/">Meridian Financial Partners, Inc.</a>

`The race is not always to the swift.(but to Swift 4!?)`

A Glance of Code
------
```swift
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
```
**Every time the frame updates trigger this method. This method calculates what is the 
length should be shown at that moment. Therefore, the paragraph works like animation.**

## Techniques in Demo App
------
- CADisplayLink
- MVC Structure
- Delegation Pattern
- Basic Animation
- Theme Configuration
- Clean Code(Refactoring)

