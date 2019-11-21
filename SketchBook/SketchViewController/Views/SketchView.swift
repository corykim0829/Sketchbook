//
//  SketchView.swift
//  SketchBook
//
//  Created by Cory Kim on 2019/11/20.
//  Copyright © 2019 corykim0829. All rights reserved.
//

import UIKit

public enum SketchToolType {
    case brush
    case eraser
}

class SketchView: UIView {
    public var lineColor: UIColor = .black
    public var lineWidth: CGFloat = 5
    public var lineAlpha: CGFloat = 1
    public var drawTool: SketchToolType = .brush
    public var currentTool: SketchTool?
    
    private var pathArray: [SketchTool] = []
    
    private var currentPoint: CGPoint?
    private var previousPoint: CGPoint?

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        pathArray.forEach({ $0.draw() })
    }
    
    func changeTool(_ toolType: SketchToolType) {
        switch toolType {
        case .brush:
            drawTool = .brush
        case .eraser:
            drawTool = .eraser
        }
    }
    
    private func getCurrentTool() -> SketchTool? {
        switch drawTool {
        case .brush:
            return BrushTool()
        case .eraser:
            return nil
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let firstPoint = touches.first?.location(in: nil) else { return }
        currentPoint = firstPoint
        
        currentTool = getCurrentTool()
        currentTool?.lineColor = lineColor
        currentTool?.lineWidth = lineWidth
        currentTool?.lineAlpha = lineAlpha
        
        switch currentTool {
        case is BrushTool:
            guard let brushTool = currentTool else { return }
            brushTool.initializeFirstPoint(firstPoint)
            pathArray.append(brushTool)
        case .none:
            return
        case .some(_):
            return
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        previousPoint = currentPoint
        currentPoint = point
        
        switch currentTool {
        case is BrushTool:
            guard let brushTool = currentTool as? BrushTool else { return }
            brushTool.moveToNextPoint(previousPoint: previousPoint!, currentPoint: currentPoint!)
        case .none:
            return
        case .some(_):
            return
        }
        
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        currentTool = nil
    }
}
