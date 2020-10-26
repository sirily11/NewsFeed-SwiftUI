import UIKit

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
