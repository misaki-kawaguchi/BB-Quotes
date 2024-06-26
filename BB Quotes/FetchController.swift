//
//  FetchController.swift
//  BB Quotes
//
//  Created by 川口美咲 on 2024/04/12.
//

import Foundation

struct FetchController {
    enum NetworkError: Error {
        case badURL, badResponse
    }
    
    // https://breaking-bad-api-six.vercel.app/api/quotes/random?production=Breaking+Bad
    
    // APIのベースURL
    private let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    func fetchQuote(from show: String) async throws -> Quote {
        // baseURLにquotes/randomパスを追加
        // https://breaking-bad-api-six.vercel.app/api/quotes/randomになる
        let quoteURL = baseURL.appending(path: "quotes/random")
        
        // URLComponents：URLを構築または解析するために使用される構造体
        var quoteComponents = URLComponents(url: quoteURL, resolvingAgainstBaseURL: true)
        
        // URLComponentsを使用して、クエリパラメータ（production）をquoteURLに追加。スペースは+に置換される。
        // URLQueryItem：キーと値のペアをクエリパラメーターとして追加しURLに含めることができる（?production="Breaking+Bad）
        let quoteQueryItem = URLQueryItem(name: "production", value: show.replaceSpaceWithPlus)
        // パスとクエリパラメータを含むURLになる
        quoteComponents?.queryItems = [quoteQueryItem]
        
        // fetchURLが正しく生成されたことを確認。
        guard let fetchURL = quoteComponents?.url else {
            // 失敗したらbadURLエラーを投げる
            throw NetworkError.badURL
        }
        
        // APIからデータを非同期に取得し、そのレスポンスを検証
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        // ステータスコードが200以外の場合はbadResponseエラーを投げる
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        // 取得したデータをJSONDecoderでデコードし、Quote型のオブジェクトに変換する
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        
        return quote
    }
    
    // https://breaking-bad-api-six.vercel.app/api/characters?name=Walter+White
    
    func fetchChacter(_ name: String) async throws -> Character {
        // baseURLにcharactersパスを追加
        // https://breaking-bad-api-six.vercel.app/api/charactersになる
        let characterURL = baseURL.appending(path: "characters")
        
        var characterComponents = URLComponents(url: characterURL, resolvingAgainstBaseURL: true)
        
        // ?name="Walter+White"
        let characterQueryItem = URLQueryItem(name: "name", value: name.replaceSpaceWithPlus)
        
        // パスとクエリパラメータを含むURLになる
        characterComponents?.queryItems = [characterQueryItem]
        
        // fetchURLが正しく生成されたことを確認。
        guard let fetchURL = characterComponents?.url else {
            // 失敗したらbadURLエラーを投げる
            throw NetworkError.badURL
        }
        
        // APIからデータを非同期に取得し、そのレスポンスを検証
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        
        // ステータスコードが200以外の場合はbadResponseエラーを投げる
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        let decoder = JSONDecoder()
        // スネークケースからキャメルケースに変換
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        // 取得したデータをJSONDecoderでデコードし、Character型のオブジェクトに変換する
        let characters = try decoder.decode([Character].self, from: data)
        
        return characters[0]
    }
}
