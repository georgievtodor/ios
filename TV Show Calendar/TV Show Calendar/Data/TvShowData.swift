import Foundation
import RxSwift
import SwiftyJSON

class TvShowData: TvShowDataDelegate {
    private let httpRequester: HttpRequesterDelegate
    
    init() {
        self.httpRequester = HttpRequester()
    }
    
    func getTopTvShows() -> Observable<TvShowModelDelegate> {
    
        return self.httpRequester.get(TheMovieDbConstants.popularTvShows)
            .filter { $0.body != nil }
            .flatMap { Observable.from(JSON($0.body!)["results"].arrayValue) }
            .map {
                serialJson in
                let id = serialJson["id"].stringValue
                let name = serialJson["name"].stringValue
                let rating = serialJson["vote_average"].stringValue
                let imagePath = "\(TheMovieDbConstants.imageUrl)\(serialJson["poster_path"].stringValue)"
                let backDropPath = "\(TheMovieDbConstants.imageUrl)\(serialJson["backdrop_path"].stringValue)"
                
                return TvShowModel(id: id, imagePath: imagePath, backDropPath: backDropPath, name: name, rating:
                    rating)
        }
            .filter { $0 != nil }
            .map { $0! }
    }
    
    
//    func getTvShow(_ id: String) -> Observable<TvShowModelDelegate> {
//
//    }
//
//    func getTvShowSeasonEpisodes(_ seasonNumber: String, _ tvShowId: String) -> Observable<SeasonModelDelegate> {
//
//    }
}

