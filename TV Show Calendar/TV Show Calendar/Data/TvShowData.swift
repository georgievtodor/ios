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
                let description = serialJson["overview"].stringValue
                let rating = "\(serialJson["vote_average"].stringValue) / 10"
                let imagePath = "\(TheMovieDbConstants.imageUrl)\(serialJson["poster_path"].stringValue)"
                let backDropPath = "\(TheMovieDbConstants.imageUrl)\(serialJson["backdrop_path"].stringValue)"
                
                return TvShowModel(id: id, imagePath: imagePath, backDropPath: backDropPath, name: name, description: description, rating:
                    rating)
            }
            .filter { $0 != nil }
            .map { $0! }
    }
    
    
    func getTvShow(_ id: String) -> Observable<SeasonModelDelegate> {
        let url = TheMovieDbConstants.getTvDetailsUrl(serialId: id)
        
        return self.httpRequester.get(url)
            .filter { $0.body != nil }
            .flatMap { Observable.from(JSON($0.body!)["seasons"].arrayValue) }
            .map {
                detailedTvShow in
                let seasonId = detailedTvShow["id"].stringValue
                let episodesCount = detailedTvShow["episode_count"].stringValue
                let airDate = detailedTvShow["air_date"].stringValue
                let seasonNumber = detailedTvShow["season_number"].stringValue
                
                return SeasonModel(seasonId: seasonId, episodesCount: episodesCount, airDate: airDate, seasonNumber: seasonNumber)
                
            }
            .filter { $0 != nil }
            .map { $0! }
        
    }
    
    func getTvShowSeasonEpisodes(_ seasonNumber: String, _ tvShowId: String) -> Observable<EpisodeModelDelegate> {
        let url = TheMovieDbConstants.getSeasonDetailsUrl(serialId: tvShowId, seasonNumber)
        
        return self.httpRequester.get(url)
            .filter { $0.body != nil }
            .flatMap { Observable.from(JSON($0.body!)["episodes"].arrayValue) }
            .map {
                episodes in
                let episodeNumber = episodes["episode_number"].stringValue
                let episodeName = episodes["name"].stringValue
                let airDate = episodes["air_date"].stringValue
                
                return EpisodeModel(name: episodeName, episodeNumber: episodeNumber, airDate: airDate)
            }
            .filter { $0 != nil }
            .map { $0! }
    }
    
    func searchTvShow(_ query: String) -> Observable<TvShowModelDelegate> {
        let url = TheMovieDbConstants.getSearchTvShowUrl(queryString: query)
        
        return self.httpRequester.get(url)
            .flatMap { Observable.from(JSON($0.body!)["results"].arrayValue) }
            .map {
                serialJson in
                let id = serialJson["id"].stringValue
                let name = serialJson["name"].stringValue
                let description = serialJson["overview"].stringValue
                let rating = "\(serialJson["vote_average"].stringValue) / 10"
                let imagePath = "\(TheMovieDbConstants.imageUrl)\(serialJson["poster_path"].stringValue)"
                let backDropPath = "\(TheMovieDbConstants.imageUrl)\(serialJson["backdrop_path"].stringValue)"
                
                return TvShowModel(id: id, imagePath: imagePath, backDropPath: backDropPath, name: name, description: description, rating:
                    rating)
            }
            .filter { $0 != nil }
            .map { $0! }
    }
    
}

