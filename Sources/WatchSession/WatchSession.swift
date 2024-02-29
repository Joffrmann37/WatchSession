// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

// 1. import
import WatchConnectivity

public class WatchSession: NSObject, ObservableObject {
  static var shared = WatchSession()
    // 2. initialize WCSession
    var wcSession: WCSession?
    
    // 7. initialize published variable to get data
    @Published var receivedData: String = "Haven't receive any data"
    
    // 3. init
    override init() {
        super.init()
        
        // 4. WCSession delegate and activate
        wcSession = WCSession.default
        wcSession?.delegate = self
        wcSession?.activate()
    }
    
}

// 5. delegate WCSession
extension WatchSession: WCSessionDelegate {
  #if os(iOS)
    public func sessionDidBecomeInactive(_ session: WCSession) {
    
    }
  
    public func sessionDidDeactivate(_ session: WCSession) {
    
    }
  #endif
  
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
      // do something when active
    }
  
  // 6. receive data
  // a. via Message
    public func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
      if let data = message["Message"] as? String {
          self.receivedData = data
      }
    }
  
    public func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
      if let data = message["Message"] as? String {
          self.receivedData = data
      }
    }
  
  // b. via Application Context
    public func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
      if let data = applicationContext["Message"] as? String {
          receivedData = data
      }
    }
}
