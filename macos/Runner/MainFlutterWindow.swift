import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
    
    // This method is called when the window is loaded from the storyboard or xib.
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialize the Flutter view controller
        let flutterViewController = FlutterViewController()
        
        // Get the current window frame
        let windowFrame = self.frame
        
        // Set the content view controller to the Flutter view controller
        self.contentViewController = flutterViewController
        
        // Restore the window frame after setting the content view controller
        self.setFrame(windowFrame, display: true)

        // Register generated plugins with the Flutter view controller
        RegisterGeneratedPlugins(registry: flutterViewController)
    }
}