import UIKit

//
//let query: [String:String] = [
// "term":"adele",
// "media":"music"]
//
//var baseURL = URL(string: "https://itunes.apple.com/search")!
//
//var urlComponents = URLComponents(string: "https://itunes.apple.com/search")!
//URLComponents.queryItems = [
//    
//    ].map { URLQueryItem(name: $0.key, value: $0.value) }
//   


var urlComponents = URLComponents(string: "https://itunes.apple.com/search")!

let termQueryItem = URLQueryItem(name: "term", value: "the 1975")
let mediaQueryItem = URLQueryItem(name: "media", value: "music")

urlComponents.queryItems = [termQueryItem, mediaQueryItem]
//can do comments below as a different way
////    "limit": "1",
//    "term": "the 1975",
//    "media": "music",
//].map { URLQueryItem(name: $0.key, value: $0.value) }

Task {
    do {
        let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
        
        if let httpResponse = response as? HTTPURLResponse,
           httpResponse.statusCode == 200 {
            let results = try JSONDecoder().decode(Result.self, from: data)
            print(results.results.map { $0.trackName })
        }
    } catch {
        print(error)
    }
}

struct Result: Decodable {
    var results: [Track]
}

struct Track: Decodable {
    var trackName: String
}



