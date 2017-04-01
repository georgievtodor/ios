import Foundation

class HttpResponse: HttpResponseDelegate {
    public var body: [String: Any]?
    public var message: String?
    public var statusCode: Int?
    public var headers: [String: Any]?
}
