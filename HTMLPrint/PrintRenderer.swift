//
//  PrintRenderer.swift
//  PrintManager
//
//  Created by Taylor McIntyre on 2017-07-25.
//  Copyright © 2017 hiimtmac All rights reserved.
//

import UIKit

public class PrintRenderer: UIPrintPageRenderer {
    /// Default color of all items to be rendered
    public var tintShade: UIColor = UIColor.lightGray
    /// Height between header/footer and content
    public var bufferHeight: CGFloat = 5
    /// Line should be rendered between header and content
    public var headerLine: Bool = false
    /// Line should be rendered between footer and content
    public var footerLine: Bool = false
    /// Text to be rendered in header/footer areas
    public var marginTexts: [MarginText]?
    
    internal var offsetX: CGFloat

    /**
     Creates a print renderer
     
     - Parameters:
        - headerHeight: The height of the page header. Default `40`
        - footerHeight: The height of the page footer. Default `40`
        - offsetX: The amount to inset the header/footer from the sides of the page
     */
    public init(headerHeight: CGFloat = 40, footerHeight: CGFloat = 40, offsetX: CGFloat) {
        self.offsetX = offsetX
        super.init()
        self.headerHeight = headerHeight
        self.footerHeight = footerHeight
    }
    
    override public func drawHeaderForPage(at pageIndex: Int, in headerRect: CGRect) {
        if headerLine {
            drawHorizontalLine(at: headerRect.maxY - bufferHeight, width: headerRect.width)
        }
        
        marginTexts?.filter({$0.verticalType == .header}).forEach { (headerText) in
            let insertPoint = headerText.insertPoint(rect: headerRect, offsetX: offsetX, buffer: bufferHeight, hasLine: headerLine)
            headerText.attributedString.draw(at: insertPoint)
        }
    }
    
    override public func drawFooterForPage(at pageIndex: Int, in footerRect: CGRect) {
        if footerLine {
            drawHorizontalLine(at: footerRect.minY + bufferHeight, width: footerRect.width)
        }
        
        marginTexts?.filter({$0.verticalType == .footer}).forEach { (footerText) in
            let insertPoint = footerText.insertPoint(rect: footerRect, offsetX: offsetX, buffer: bufferHeight, hasLine: footerLine)
            footerText.attributedString.draw(at: insertPoint)
        }
    }
    
    /**
     Draws horizontal line at header or footer of page
     
     - Parameters:
        - height: height of the appropriate boundary of the header/footer
        - width: width of page to draw
     */
    internal func drawHorizontalLine(at height: CGFloat, width: CGFloat) {
        if let context = UIGraphicsGetCurrentContext() {
            context.setStrokeColor(tintShade.cgColor)
            context.move(to: CGPoint(x: offsetX, y: height))
            context.addLine(to: CGPoint(x: width - offsetX, y: height))
            context.strokePath()
        }
    }
}
