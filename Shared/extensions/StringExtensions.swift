#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

extension String {
     
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
     
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
}
