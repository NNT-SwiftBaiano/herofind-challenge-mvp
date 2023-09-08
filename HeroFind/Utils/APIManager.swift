import Foundation

import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

class APIManager {
    
    static let shared = APIManager()
    
    private let baseURL = "https://gateway.marvel.com/v1/public"
    
    private let publicKey = "1697bab80a846b0c277fbb689d66f856"
    
    private let privateKey = "4a963905d9d1e86ec8c322527a05b4444b316cb6"
    
    private init() {}
    
    func fetchRemote(completion: @escaping ([Hero]?) -> Void) {
        
        let timestamp  = "\(Int((Date().timeIntervalSince1970 * 1000.0).rounded()))"
        
        let hash = MD5Hex(string: "\(timestamp )\(privateKey)\(publicKey)")
        
        var urlComponent = URLComponents(string: "\(baseURL)/characters")
        urlComponent?.queryItems = [
            URLQueryItem(name: "apikey", value: publicKey),
            URLQueryItem(name: "hash", value: hash),
            URLQueryItem(name: "ts", value: timestamp)
        ]
        
        guard let url =  urlComponent?.url else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            guard let heroResponse = try? decoder.decode(HeroResponse.self, from: data) else {
                completion(nil)
                return
            }
            
            let heroes = heroResponse.data.results.map {
                Hero(id: $0.id, name: $0.name, description: $0.description, thumbnail: $0.thumbnail)
            }
            
            completion(heroes)
        }
        
        task.resume()
    }
    
    //code from: https://stackoverflow.com/questions/32163848/how-can-i-convert-a-string-to-an-md5-hash-in-ios-using-swift
    private func MD5(string: String) -> Data {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData
    }
    
    private func MD5Hex(string: String) -> String {
        let md5Data = MD5(string: string)
        return md5Data.map { String(format: "%02hhx", $0) }.joined()
    }
}
