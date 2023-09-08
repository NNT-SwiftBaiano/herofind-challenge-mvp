import Foundation

struct HeroResponse: Decodable {
    let data: HeroData
}

struct HeroData: Decodable {
    let results: [Hero]
}
