import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = NSMakeRect(0, 0, 350, 600) 
    self.setFrame(windowFrame, display: true)
    self.minSize = NSSize(width: 350, height: 600)
    self.contentViewController = flutterViewController
    self.center()

    RegisterGeneratedPlugins(registry: flutterViewController)
    
    super.awakeFromNib()
  }
}
