protocol SeasonModelDelegate {
    var episodes: [EpisodeModelDelegate] { get set }
    var name: String { get set }
    var poster: String { get set }
    var number: String { get set }
}
