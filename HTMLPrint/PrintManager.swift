//
//  PrintManager.swift
//  PrintManager
//
//  Created by Taylor McIntyre on 2017-07-20.
//  Copyright © 2017 hiimtmac All rights reserved.
//

import UIKit

public class PrintManager {
    public var paperSize: PageSize = .letter
    public var paperOrientation: PageOrientation = .portrait
    public var dpi: Dpi = .dpi72
    public var insetX: CGFloat = 40
    
    internal var html: String
    
    /**
     Creates a print manager from an html string.
     - parameter html: The rendered html string.
     */
    public init(html: String) {
        self.html = html
    }
    
    private var pageSize: CGSize {
        let shorter = paperSize.dimShort * dpi.rawValue
        let longer = paperSize.dimLong * dpi.rawValue
        
        switch paperOrientation {
        case .portrait: return CGSize(width: shorter, height: longer)
        case.landscape: return CGSize(width: longer, height: shorter)
        }
    }
    
    private let pageOrigin = CGPoint(x: 0, y: 0)
    private var page: CGRect {
        return CGRect(origin: pageOrigin, size: pageSize)
    }
    
    private var printable: CGRect {
        return page.insetBy(dx: insetX, dy: 0)
    }
    
    /**
     Renders pdf data with provided renderer
     
     - parameter renderer: an instance of `PrintRenderer`
     - returns: PDF data as type `Data`
     - Todo: fix 300 vs 72 dpi issue
     */
    public func getPDFData(renderer: PrintRenderer) -> Data {
        let formatter = UIMarkupTextPrintFormatter(markupText: html)
        renderer.addPrintFormatter(formatter, startingAtPageAt: 0)
        
        renderer.setValue(NSValue(cgRect: page), forKey: "paperRect")
        renderer.setValue(NSValue(cgRect: printable), forKey: "printableRect")

        let pdfData = NSMutableData()
        
        UIGraphicsBeginPDFContextToData(pdfData, renderer.paperRect, nil)
        
        let context = UIGraphicsGetCurrentContext()
        context!.saveGState()
        context!.concatenate(CGAffineTransform(scaleX: 72/dpi.rawValue, y: 72/dpi.rawValue))
        
        let bounds = UIGraphicsGetPDFContextBounds()
        for pageNum in 0..<renderer.numberOfPages {
            UIGraphicsBeginPDFPage()
            renderer.drawPage(at: pageNum, in: bounds)
        }
        
        context!.restoreGState()
        UIGraphicsEndPDFContext()
        
        return pdfData as Data
    }
}
