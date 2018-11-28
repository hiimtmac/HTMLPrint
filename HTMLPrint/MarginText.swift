//
//  MarginText.swift
//  PrintManager
//
//  Created by Taylor McIntyre on 2017-07-25.
//  Copyright © 2017 hiimtmac All rights reserved.
//

import UIKit

public class MarginText {
    /// Attributes for text
    
    public var attributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 8),
        NSAttributedString.Key.foregroundColor: UIColor.lightGray
    ]
    
    public let textContent: String
    public let verticalType: VerticalType
    public let horizontalType: HorizontalType
    public let baseAlignment: BaseLine
    
    /**
     Returns an instance of a `MarginText`
     
     Used to write and place header/footer text in `PrintRenderer`
     
     - Parameters:
        - text: The text string to be rendered
        - vertType: Declares if text is of `.header` or .`footer` type
        - horzType: Location of the header/footer horizontally
        - baseType: Declares if text hugs baseline of header/footer, or is centered
     */
    public init(text: String, vertType: VerticalType, horzType: HorizontalType, baseType: BaseLine) {
        self.textContent = text
        self.verticalType = vertType
        self.horizontalType = horzType
        self.baseAlignment = baseType
    }
    
    var attributedString: NSAttributedString {
        return NSAttributedString(string: textContent, attributes: attributes)
    }
    
    var textSize: CGSize {
        let label = UILabel()
        label.attributedText = attributedString
        label.sizeToFit()
        return label.frame.size
    }
    
    func insertPointY(rect: CGRect, buffer: CGFloat, hasLine: Bool) -> CGFloat {
        switch verticalType {
        case .header:
            switch baseAlignment {
            case .baseline: return rect.maxY - textSize.height - buffer - (hasLine ? 2 : 0)
            case .center: return rect.midY - textSize.height/2 - (hasLine ? buffer/2 : 0)
            }
        case .footer:
            switch baseAlignment {
            case .baseline: return rect.minY + buffer + (hasLine ? 2 : 0)
            case .center: return rect.midY - textSize.height/2 + (hasLine ? buffer/2 : 0)
            }
        }
    }
    
    func insertPointX(rect: CGRect, offsetX: CGFloat) -> CGFloat {
        switch horizontalType {
        case .left: return offsetX
        case .center: return rect.width/2 - textSize.width/2
        case .right: return rect.width - offsetX - textSize.width
        }
    }
    
    func insertPoint(rect: CGRect, offsetX: CGFloat, buffer: CGFloat, hasLine: Bool) -> CGPoint {
        let insertX = insertPointX(rect: rect, offsetX: offsetX)
        let insertY = insertPointY(rect: rect, buffer: buffer, hasLine: hasLine)
        return CGPoint(x: insertX, y: insertY)
    }
}

public enum VerticalType {
    case header
    case footer
}

public enum HorizontalType {
    case left
    case center
    case right
}

public enum BaseLine {
    case baseline
    case center
}
