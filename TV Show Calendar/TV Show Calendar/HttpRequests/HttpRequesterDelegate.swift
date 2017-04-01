import Foundation
import RxSwift

protocol RequesterDelegate {
    func get(_ url: String) -> Observable<ResponseDelegate>
    
    func post(_ url: String, params: [String: Any]) -> Observable<ResponseDelegate>
}
