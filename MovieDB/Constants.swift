import Foundation

class Constants {
    static let apiKey = "2d1397f4672fe37c450f8a2745a57633"
    static let baseURL = "https://api.themoviedb.org/3"
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    
    static var popularMoviesURL: String {
        return "\(baseURL)/movie/popular?api_key=\(apiKey)&language=en-US&page=1"
    }
    
    static var genresURL: String {
        return "\(baseURL)/genre/movie/list?api_key=\(apiKey)&language=en-US"
    }
}
