# HTMLPrint

[![Platform](https://img.shields.io/badge/platform-iOS-blue.svg?style=flat)](https://developer.apple.com/swift)
[![Swift Version](https://img.shields.io/badge/swift4-compatible-4BC51D.svg?style=flat)](https://developer.apple.com/swift)

A print renderer for Swift to ease HTML documents to be converted into pdfs.

It's usually difficult to setup a UIPrintPageRenderer and UIMarkupTextPrintFormatter to render html to pdf while respecting the differences html layout has to printed/paged media.

## Usage

You can use the default print settings, or tweak it to your render needs with some minor changes.

### Making a Print Manager

```swift
import CPPrintManager

let html = <html><body><p>Hello, World!</p></body></html>
let pManager = CPPrintManager(html: html)
// configure print manager settings -> Insets, PaperSize, PaperOrientation, DPI
pManager.paperOrientation = .landscape
```

### Making a Print Renderer

```swift
let renderer = CPPrintRenderer(offsetX: printManager.insetX)
// configure print render settings -> TintShade, BufferHeight, HeaderLine, FooterLine, MarginText

```

### Create Render Attributes

```swift
let attributes: [String: Any] = [NSFontAttributeName: UIFont.systemFont(ofSize: 8), NSForegroundColorAttributeName: UIColor.orange]

let leftFoot = CPMarginText(text: "Left Foot", vertType: .footer, horzType: .left, baseType: .baseline)
let rightHead = CPMarginText(text: "Right Head", vertType: .header, horzType: .right, baseType: .center)
rightHead.attributes = attributes
renderer.marginTexts = [leftFoot, rightHead]
```

### Rendering PDF Data

```swift
let pdfData = printManager.getPDFData(renderer: renderer)
// returns rendered pdf as Data object
// can be emailed or saved to disk as application/pdf
```
