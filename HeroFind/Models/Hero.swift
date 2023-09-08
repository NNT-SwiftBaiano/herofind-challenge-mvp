struct Hero: Decodable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail

    struct Thumbnail: Decodable {
        let path: String
        let `extension`: String
    }
    
    var imageURL: String {
        return "\(thumbnail.path).\(thumbnail.extension)"
    }
    
}
