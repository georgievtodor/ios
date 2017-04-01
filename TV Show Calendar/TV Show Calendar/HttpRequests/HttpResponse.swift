import Foundation

class Response: ResponseDelegate {
    public var body: [String: Any]?
    public var message: String?
    public var statusCode: Int?
    public var headers: [String: Any]?
}
