import Foundation
import RxSwift
import Alamofire


class HttpRequester: HttpRequesterDelegate {
    private let responseFactory: HttpResponseFactoryDelegate
    
    init() {
        self.responseFactory = HttpResponseFactory()
    }
    
    func get(_ url: String) -> Observable<HttpResponseDelegate> {
        return Observable.create {
            observer in
            Alamofire.request(url)
                .validate()
                .responseJSON {
                    response in
                    var respResult = self.buildResponse(response: response)
                    
                    switch response.result {
                    case .success(let value):
                        respResult.body = value as? [String: Any]
                        observer.onNext(respResult)
                    case .failure(let error):
                        observer.onError(error)
                    }
                    
                    observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    func post(_ url: String, params: [String: Any]) -> Observable<HttpResponseDelegate> {
        return Observable.create {
            observer in
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
                .validate()
                .responseJSON {
                    response in
                    var respResult = self.buildResponse(response: response)
                    
                    switch response.result {
                    case .success(let value):
                        respResult.body = value as? [String: Any]
                        observer.onNext(respResult)
                    case .failure(let error):
                        observer.onError(error)
                    }
                    
                    observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    
    func buildResponse(response: DataResponse<Any>) -> HttpResponseDelegate {
        let response = response.response
        
        var respResult = responseFactory.createResponse()
        respResult.statusCode = response?.statusCode
        respResult.headers = response?.allHeaderFields as? [String: Any]
        
        return respResult
    }
}
