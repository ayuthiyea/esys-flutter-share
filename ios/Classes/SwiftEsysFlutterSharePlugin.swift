import Flutter
import UIKit

public class SwiftEsysFlutterSharePlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    public var eventSink: FlutterEventSink?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "channel:github.com/orgs/esysberlin/esys-flutter-share", binaryMessenger: registrar.messenger())
        let instance = SwiftEsysFlutterSharePlugin()
        
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        let eventChannel = FlutterEventChannel(name: "channel:github.com/orgs/esysberlin/esys-flutter-share-result", binaryMessenger: registrar.messenger())
        eventChannel.setStreamHandler(instance)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if(call.method == "text"){
            self.text(arguments: call.arguments)
        }
        if(call.method == "file"){
            self.file(arguments: call.arguments)
        }
        if(call.method == "files"){
            self.files(arguments: call.arguments)
        }
    }
    
    public func onListen(withArguments arguments: Any?, eventSink: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = eventSink
        
        return nil
    }

    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.eventSink = nil
        
        return nil;
    }
    
    func text(arguments:Any?) -> Void {
        // prepare method channel args
        // no use in ios
        //// let title:String = argsMap.value(forKey: "title") as! String
        let argsMap = arguments as! NSDictionary
        let text:String = argsMap.value(forKey: "text") as! String
        
        // set up activity view controller
        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        
        // present the view controller
        let controller = UIApplication.shared.keyWindow!.rootViewController as! FlutterViewController
        activityViewController.popoverPresentationController?.sourceView = controller.view
        
        controller.show(activityViewController, sender: self)
        
        //Completion handler
        activityViewController.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed: Bool, arrayReturnedItems: [Any]?, error: Error?) in
            if completed {
                if let eventSink = self.eventSink {
                    return eventSink(true)
                }
            } else {
                if let eventSink = self.eventSink {
                    return eventSink(false)
                }
            }
        }
    }
    
    func file(arguments:Any?) -> Void {
        // prepare method channel args
        // no use in ios
        //// let title:String = argsMap.value(forKey: "title") as! String
        let argsMap = arguments as! NSDictionary
        let name:String = argsMap.value(forKey: "name") as! String
        let text:String = argsMap.value(forKey: "text") as! String
        
        // load the file
        let docsPath:String = NSSearchPathForDirectoriesInDomains(.cachesDirectory,.userDomainMask , true).first!;
        let contentUri = NSURL(fileURLWithPath: docsPath).appendingPathComponent(name)
        
        // prepare sctivity items
        var activityItems:[Any] = [contentUri!];
        if(!text.isEmpty){
            // add optional text
            activityItems.append(text);
        }
        
        // set up activity view controller
        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        // present the view controller
        let controller = UIApplication.shared.keyWindow!.rootViewController as! FlutterViewController
        activityViewController.popoverPresentationController?.sourceView = controller.view
        
        controller.show(activityViewController, sender: self)
        
        //Completion handler
       activityViewController.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed: Bool, arrayReturnedItems: [Any]?, error: Error?) in
           if completed {
               if let eventSink = self.eventSink {
                   return eventSink(true)
               }
           } else {
               if let eventSink = self.eventSink {
                   return eventSink(false)
               }
           }
       }
    }
    
    func files(arguments:Any?) -> Void {
        // prepare method channel args
        // no use in ios
        //// let title:String = argsMap.value(forKey: "title") as! String
        let argsMap = arguments as! NSDictionary
        let names:[String] = argsMap.value(forKey: "names") as! [String]
        let text:String = argsMap.value(forKey: "text") as! String
        
        // prepare sctivity items
        var activityItems:[Any] = [];
        
        // load the files
        for name in names {
            let docsPath:String = NSSearchPathForDirectoriesInDomains(.cachesDirectory,.userDomainMask , true).first!;
            activityItems.append(NSURL(fileURLWithPath: docsPath).appendingPathComponent(name)!);
        }
        
        if(!text.isEmpty){
            // add optional text
            activityItems.append(text);
        }
        
        // set up activity view controller
        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        // present the view controller
        let controller = UIApplication.shared.keyWindow!.rootViewController as! FlutterViewController
        activityViewController.popoverPresentationController?.sourceView = controller.view
        
        controller.show(activityViewController, sender: self)
        
        //Completion handler
       activityViewController.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed: Bool, arrayReturnedItems: [Any]?, error: Error?) in
           if completed {
               if let eventSink = self.eventSink {
                   return eventSink(true)
               }
           } else {
               if let eventSink = self.eventSink {
                   return eventSink(false)
               }
           }
       }
    }
}
