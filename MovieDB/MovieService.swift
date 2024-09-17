import Foundation

class MovieService {
    let apiCaller = ApiCaller()
    

    func getPopularMovies(completion: @escaping ([Movie]?) -> Void) {
        apiCaller.fetchData(urlString: Constants.popularMoviesURL) { (response: MovieResponse?) in
            //completion(response?.results)
            if let data = response?.results{
                completion(data)
            }else{
                completion(nil)
            }
        }
    }
    

    func getGenres(completion: @escaping ([Genre]?) -> Void) {
        apiCaller.fetchData(urlString: Constants.genresURL) { (response: GenreResponse?) in
            //completion(response?.genres)
            if let data = response?.genres{
                completion(data)
            }else{
                completion(nil)
            }
        }
    }
}

// MARK: - Estructuras de Movie y MovieResponse
struct MovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let title: String
    let vote_average: Double
    let genre_ids: [Int]
    let poster_path: String?
    let overview: String
    let backdrop_path: String?
    let release_date: String
}

// MARK: - Estructuras de Genre y GenreResponse
struct GenreResponse: Codable {
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String
}
