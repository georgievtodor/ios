import Foundation

protocol ResponseFactoryDelegate {
    func createResponse() -> ResponseDelegate
}
