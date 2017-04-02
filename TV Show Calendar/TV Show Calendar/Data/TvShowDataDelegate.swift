import Foundation
import RxSwift

protocol TvShowDataDelegate {
    func getTopTvShows() -> Observable<TvShowModelDelegate>
    
        func getTvShow(_ id: String) -> Observable<SeasonModelDelegate>
    
        func getTvShowSeasonEpisodes(_ seasonNumber: String, _ tvShowId: String) -> Observable<EpisodeModelDelegate>
    
        
}
