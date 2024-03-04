//
//  CircularProgress.swift
//  NexWell.
//
//  Created by Keoni Li on 8/14/23.
//

import UIKit

//Make transitions of other circles more smooth
@IBDesignable
class CircularProgressView: UIView {
    
    var rotateDirection: Int = 0 {
        didSet { setNeedsDisplay() }
    }

    var otherCircle: Bool = false {
        didSet { setNeedsDisplay() }
    }
    
    var innerCircleColor: UIColor = UIColor(red: 0.03, green: 1, blue: 0.96, alpha: 0.25) {
        didSet { setNeedsDisplay() }
    }
    
    // This property will store the fraction of the circle to fill
    var progress: CGFloat = 0.0 {
        // We want to redraw whenever this value changes
        didSet { setNeedsDisplay() }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // This will allow us to see through the parts of the circle that are not filled
        backgroundColor = UIColor.clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        // This will allow us to see through the parts of the circle that are not filled
        backgroundColor = UIColor.clear
    }

    override func draw(_ rect: CGRect) {
        
        let lineWidth: CGFloat = 77.5
        let radius = rect.width / 2 - lineWidth / 2
        let arcCenter = CGPoint(x: rect.midX, y: rect.midY)

        // Determine direction based on rotateDirection
        let startAngle: CGFloat
        let endAngle: CGFloat
        let startAngle1: CGFloat
        let endAngle1: CGFloat
        var cloc: Bool
        
        cloc = true
        startAngle1 = CGFloat(-0.5 * .pi)
        endAngle1 = CGFloat(1.5 * .pi)
        
        if rotateDirection % 2 == 1 {
            cloc = true
            startAngle = CGFloat(-0.5 * .pi)
            endAngle = CGFloat(1.5 * .pi)
            
            if progress == 1 {
                rotateDirection += 1
            }
            //Clockwise
        } else {
            cloc = false
            startAngle = CGFloat(1.5 * .pi)
            endAngle = CGFloat(-0.5 * .pi)
            
            if progress == 1 {
                rotateDirection += 1
            }
            //Counter clockwise
        }
        
        // Inner Circle - Remaining Time
        let progressEndAngle = startAngle + (endAngle - startAngle) * (1 - progress)
        let progressPath = UIBezierPath(arcCenter: arcCenter,
                                        radius: radius,
                                        startAngle: startAngle,
                                        endAngle: progressEndAngle,
                                        clockwise: cloc)
        innerCircleColor.setStroke()
        progressPath.lineWidth = lineWidth
        progressPath.stroke()
        
        // Outer Circle - Full Time
        if otherCircle {
            let path = UIBezierPath(arcCenter: arcCenter,
                                    radius: radius,
                                    startAngle: startAngle1,
                                    endAngle: endAngle1,
                                    clockwise: true)
            UIColor.white.withAlphaComponent(0.25).setStroke()
            path.lineWidth = lineWidth
            path.stroke()
        }
        
        let path = UIBezierPath(arcCenter: arcCenter,
                                radius: radius,
                                startAngle: startAngle1,
                                endAngle: endAngle1,
                                clockwise: true)
        UIColor.white.withAlphaComponent(0.1).setStroke()
        path.lineWidth = lineWidth
        path.stroke()
    }
}
