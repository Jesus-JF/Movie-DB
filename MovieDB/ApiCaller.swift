import Foundation

class ApiCaller {
    func fetchData<Response: Codable>(urlString: String, completion: @escaping (Response?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
                completion(decodedResponse)
            } catch {
                print("Decoding error: \(error)")
                completion(nil)
            }
        }
        task.resume()
    }
}
