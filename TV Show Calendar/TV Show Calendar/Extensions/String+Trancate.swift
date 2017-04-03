import Foundation

extension String {
    func trunc(length: Int) -> String {
        if self.characters.count > length {
            let index = self.index(self.startIndex, offsetBy: length)
            return "\(self.substring(to: index))..."
        } else {
            return self
        }
    }
}
