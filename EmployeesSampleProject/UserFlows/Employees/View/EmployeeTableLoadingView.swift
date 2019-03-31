//
//  EmployeeTableLoadingView.swift
//  EmployeesSampleProject
//
//  Created by Artem Semavin on 28/03/2019.
//  Copyright © 2019 Semavin Artem. All rights reserved.
//

import UIKit

class EmployeeTableLoadingView: UIView {
    
    private var animateLayer: CALayer = CALayer()
    private var isActive: Bool = false
    private var sizeAnimation = CGSize(width: Space.quadruple, height: Space.quadruple)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let frame = CGRect(
            x: (layer.bounds.width - sizeAnimation.width) / 2,
            y: (layer.bounds.height - sizeAnimation.height) / 2,
            width: sizeAnimation.width,
            height: sizeAnimation.height
        )
        animateLayer.frame = frame
    }
    
    private func setupView() {
        backgroundColor = UIColor.white.withAlphaComponent(0.6)
    }
    
    func startAnimation() {
        guard isActive == false else { return }
        setUpAnimation(in: layer, size: sizeAnimation, color: .blue)
        isActive = true
    }
    
    func stopAnimation(animate: Bool = true) {
        guard isActive else { return }
        layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        isActive = false
    }
    
    private func setUpAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
        let beginTime: Double = 0.5
        let strokeStartDuration: Double = 1.2
        let strokeEndDuration: Double = 0.7
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.byValue = Float.pi * 2
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.duration = strokeEndDuration
        strokeEndAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0.0, 0.2, 1.0)
        strokeEndAnimation.fromValue = 0
        strokeEndAnimation.toValue = 1
        
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.duration = strokeStartDuration
        strokeStartAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0.0, 0.2, 1.0)
        strokeStartAnimation.fromValue = 0
        strokeStartAnimation.toValue = 1
        strokeStartAnimation.beginTime = beginTime
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [rotationAnimation, strokeEndAnimation, strokeStartAnimation]
        groupAnimation.duration = strokeStartDuration + beginTime
        groupAnimation.repeatCount = .infinity
        groupAnimation.isRemovedOnCompletion = false
        groupAnimation.fillMode = .forwards
        
        animateLayer = makeLayer(size: size, color: color)
        let frame = CGRect(
            x: (layer.bounds.width - size.width) / 2,
            y: (layer.bounds.height - size.height) / 2,
            width: size.width,
            height: size.height
        )
        
        animateLayer.frame = frame
        animateLayer.add(groupAnimation, forKey: "animation")
        layer.addSublayer(animateLayer)
    }
    
    private func makeLayer(size: CGSize, color: UIColor) -> CALayer {
        let layer = CAShapeLayer()
        let path: UIBezierPath = UIBezierPath()
        let lineWidth: CGFloat = 2
        let center = CGPoint(x: size.width / 2, y: size.height / 2)
        
        path.addArc(withCenter: center,
                    radius: size.width / 2,
                    startAngle: -(.pi / 2),
                    endAngle: .pi + .pi / 2,
                    clockwise: true)
        
        layer.fillColor = nil
        layer.strokeColor = color.cgColor
        layer.backgroundColor = nil
        
        layer.lineWidth = lineWidth
        layer.path = path.cgPath
        layer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        return layer
    }
}
