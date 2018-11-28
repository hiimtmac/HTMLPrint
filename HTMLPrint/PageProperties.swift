//
//  PageProperties.swift
//  PrintManager
//
//  Created by Taylor McIntyre on 2017-07-25.
//  Copyright © 2017 hiimtmac All rights reserved.
//

import UIKit

public enum PageSize {
    /// Letter size paper: 8.5" x 11"
    case letter
    /// Legal size paper: 8.5" x 14"
    case legal
    /// Ledger size paper: 11" x 17"
    case ledger
    
    /// The **shorter** dimension, based on the `CGPageSize`
    internal var dimShort: CGFloat {
        switch self {
        case .letter:
            return 8.5
        case .legal:
            return 8.5
        case .ledger:
            return 11
        }
    }
    
    /// The **longer** dimension, based on the `CGPageSize`
    internal var dimLong: CGFloat {
        switch self {
        case .letter:
            return 11
        case .legal:
            return 14
        case .ledger:
            return 17
        }
    }
}

public enum PageOrientation {
    /// Height > Width
    case portrait
    /// Width > Height
    case landscape
}

public enum Dpi: CGFloat {
    /// 72 ppi
    case dpi72 = 72
    /// 300 ppi
    case dpi300 = 300
}
