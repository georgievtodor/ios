import Foundation

protocol HttpResponseFactoryDelegate {
    func createResponse() -> HttpResponseDelegate
}
