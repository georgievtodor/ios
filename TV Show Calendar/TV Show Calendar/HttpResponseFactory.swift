import Foundation

class ResponseFactory: ResponseFactoryDelegate {
    public func createResponse() -> ResponseDelegate {
        return Response()
    }
}
