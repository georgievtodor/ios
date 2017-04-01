import Foundation
import RxSwift

protocol HttpRequesterDelegate {
    func get(_ url: String) -> Observable<HttpResponseDelegate>
    
    func post(_ url: String, params: [String: Any]) -> Observable<HttpResponseDelegate>
}
