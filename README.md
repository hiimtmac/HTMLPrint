# HTMLPrint

A print renderer for Swift to ease HTML documents to be converted into pdfs.

It's usually difficult to setup a UIPrintPageRenderer and UIMarkupTextPrintFormatter to render html to pdf while respecting the differences html layout has to printed/paged media.

## Usage

You can use the default print settings, or tweak it to your render needs with some minor changes.

### Making a Print Manager

```swift
import HTMLPrint

let html = <html><body><p>Hello, World!</p></body></html>
let printManager = PrintManager(html: html, size: .letter, orientation: .landscape, dpi: .dpi300)
// configure print manager settings -> Insets, PaperSize, PaperOrientation, DPI
```

### Making a Print Renderer

```swift
let renderer = PrintRenderer(offsetX: printManager.insetX)
renderer.tintShade = UIColor.cyan
renderer.showsFooterLine = true
// configure print render settings -> TintShade, BufferHeight, HeaderLine, FooterLine, MarginText
```

### Create Render Attributes

```swift
let attributes: [NSAttributedString.Key: Any] = [
    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 8),
    NSAttributedString.Key.foregroundColor: UIColor.orange
]

let leftFoot = MarginText(text: "Left Foot", verticalPosition: .footer, horizontalPosition: .left, baselinePosition: .baseline)
let rightHead = MarginText(text: "Right Head", verticalPosition: .header, horizontalPosition: .right, baselinePosition: .center)
rightHead.attributes = attributes
renderer.marginTexts = [leftFoot, rightHead]
```

### Rendering PDF Data

```swift
let pdfData = printManager.getPDFData(renderer: renderer)
// returns rendered pdf as Data object
// can be emailed or saved to disk as application/pdf
```
