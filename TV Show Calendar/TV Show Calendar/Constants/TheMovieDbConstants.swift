public final class TheMovieDbConstants {
    private static let tMDBApiKey: String = "?api_key=f0da25f6492c7f3f3c1b40fa29de8f6c"
    private static let tMDBApiUrl: String = "https://api.themoviedb.org/3";
    private static let tvShowsBaseUrl: String = "\(tMDBApiUrl)/tv"
    public static let popularTvShows: String = "\(tMDBApiUrl)/tv/popular\(tMDBApiKey)"
    public static let imageUrl: String = "https://image.tmdb.org/t/p/w640"
    
    
    func getSearchTvShowUrl(queryString query: String) -> String {
        return "\(TheMovieDbConstants.tMDBApiUrl)/search/tv\(TheMovieDbConstants.tMDBApiKey)&language=en-US&query=\(query)&page=1"
    }
    
    static func getTvDetailsUrl(serialId id: String) -> String {
        let url = "\(TheMovieDbConstants.tvShowsBaseUrl)/\(id)\(TheMovieDbConstants.tMDBApiKey)"
        return url
    }
    
    static func getSeasonDetailsUrl(serialId id: String, _ seasonNumber: String) -> String {
        return "\(TheMovieDbConstants.tvShowsBaseUrl)/\(id)/season/\(seasonNumber)\(TheMovieDbConstants.tMDBApiKey)"
    }
    
    func getEpisodeDetailsUrl(serialId id: String, _ seasonNumber: Int, _ episodeNumber: Int) -> String {
        return "\(TheMovieDbConstants.tvShowsBaseUrl)\(id)/season/\(seasonNumber)/episode/\(episodeNumber)\(TheMovieDbConstants.tMDBApiKey)"
    }
    
    
    
}
