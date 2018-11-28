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
    public let verticalPosition: VerticalPosition
    public let horizontalPosition: HorizontalPosition
    public let baselinePosition: BaselinePosition
    
    /**
     Returns an instance of a `MarginText`
     
     Used to write and place header/footer text in `PrintRenderer`
     
     - Parameters:
        - text: The text string to be rendered
        - vertType: Declares if text is of `.header` or .`footer` type
        - horzType: Location of the header/footer horizontally
        - baseType: Declares if text hugs baseline of header/footer, or is centered
     */
    public init(text: String, verticalPosition: VerticalPosition, horizontalPosition: HorizontalPosition, baselinePosition: BaselinePosition) {
        self.textContent = text
        self.verticalPosition = verticalPosition
        self.horizontalPosition = horizontalPosition
        self.baselinePosition = baselinePosition
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
        switch verticalPosition {
        case .header:
            switch baselinePosition {
            case .baseline: return rect.maxY - textSize.height - buffer - (hasLine ? 2 : 0)
            case .center: return rect.midY - textSize.height/2 - (hasLine ? buffer/2 : 0)
            }
        case .footer:
            switch baselinePosition {
            case .baseline: return rect.minY + buffer + (hasLine ? 2 : 0)
            case .center: return rect.midY - textSize.height/2 + (hasLine ? buffer/2 : 0)
            }
        }
    }
    
    func insertPointX(rect: CGRect, offsetX: CGFloat) -> CGFloat {
        switch horizontalPosition {
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

public enum VerticalPosition {
    case header
    case footer
}

public enum HorizontalPosition {
    case left
    case center
    case right
}

public enum BaselinePosition {
    case baseline
    case center
}
