import Foundation

class HttpResponseFactory: HttpResponseFactoryDelegate {
    public func createResponse() -> HttpResponseDelegate {
        return HttpResponse()
    }
}
