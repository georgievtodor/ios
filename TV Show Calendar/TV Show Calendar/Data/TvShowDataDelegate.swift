import Foundation
import RxSwift

protocol TvShowDataDelegate {
    func getTvShowsArray(stringQuery query: String?) -> Observable<TvShowModelDelegate>
    
    func getTvShow(_ id: String) -> Observable<SeasonModelDelegate>
    
    func getTvShowSeasonEpisodes(_ seasonNumber: String, _ tvShowId: String) -> Observable<EpisodeModelDelegate>
    
    func searchTvShow(_ query: String) -> Observable<TvShowModelDelegate>
}
