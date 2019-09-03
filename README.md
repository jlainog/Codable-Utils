# Codable-Utils

<p align="center">
    <img src="https://api.travis-ci.com/jlainog/Codable-Utils.svg?branch=master"/>
    <img alt="GitHub tag (latest SemVer)" src="https://img.shields.io/github/v/tag/jlainog/Codable-Utils">
    <img src="https://img.shields.io/badge/language-Swift--5.0-orange"/>
    <a href="https://swift.org/package-manager">
        <img alt="Swift Package Manager"src="https://img.shields.io/badge/spm-compatible-brightgreen.svg" />
    </a>
    <a href="https://github.com/jlainog/Codable-Utils/blob/master/LICENSE"><img alt="GitHub license" src="https://img.shields.io/github/license/jlainog/Codable-Utils"></a>
</p>

## Motivation

The new Framework [Combine](https://developer.apple.com/documentation/combine) introduce a couple of protocols that create a common interface for Encoders and Decoders allowing to chain them. 
* [TopLevelEncoder](https://developer.apple.com/documentation/combine/toplevelencoder)
* [TopLevelDecoder](https://developer.apple.com/documentation/combine/topleveldecoder)

but those are available only in `iOS 13.0+`
Wanting to use those in previous versions motivate this set of  `utils`  API starting by declaring  `AnyTopLevelEncoder`  &  `AnyTopLevelDecoder`  and then creating extension for `Encodable` and `Decodable` to use them.

## Uses
```swift
struct Article: Codable {
    var name: String
}

// Encoding
let article = Article(name: "jaime")
let encodedArticle = try article.encode()
// Using an specific encoder
let encoder = PropertyListEncoder()
let encodedArticle = try article.encode(using: encoder)

// Decoding
let data = "{\"name\":\"jaime\"}".data(using: .utf8)!
let article = try Article.decode(from: data)
// Using an specific decoder
let article = try Article.decode(from: data,
                                    using: JSONDecoder())
```

### Custom Encoders
```swift
let jsonString = article.encode(using: JSONStringEncoder())
// output: "{\"name\":\"jaime\"}"
let dictionary = article.encode(using: JSONSerializationEncoder())
// output: ["name": "jaime"]
```

### Custom Decoders
```swift
let article = try Article.decode(from: "{\"name\":\"jaime\"}",
                                     using: JSONStringDecoder())
let article = try Article.decode(from: ["name": "jaime"],
                                     using: JSONSerializationDecoder())
```

### Extras
Type Inference can be leverage using the extension added over `KeyedDecodingContainer`
```swift
struct Page: Decodable {
    var index: Int
    var title: String
    var content: String?
        
    enum CodingKeys: String, CodingKey {
        case page, title, content
    }
}

// Regular way
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
            
        index = try container.decode(Int.self, forKey: .page)
        title = try container.decode(String, forKey: .title)
        content = try container.decodeIfPresent(String.self, forKey: .content)
    }

// Using the extension
    init(from decoder: Decoder) throws {
         let container = try decoder.container(keyedBy: CodingKeys.self)
            
        index = try container.decode(.page)
        title = try container.decode(.title)
        content = try container.decodeIfPresent(.content)
    }

// 3-way to do the same
try container.decode(.page, as: Int)
try container.decode(.page) as Int
let page: Int = try container.decode(.page)
```

A default implementation for `CustomDebugStringConvertible` is added to `Encodable` types returning a JSON string representation by simple make the `Encodable` type to conform it.
```swift
extension Article: CustomDebugStringConvertible {}
print(article.ddebugDescription)
// output: "{\n  \"name\" : \"jaime\"\n}"
po article
//{
//  "name" : "jaime"
//}
```

As a plus a simple type inferred way to load data and decode it from the Bundle.
```swift
// load as Data
let data = try bundle.load("article.json")
// load and decoded as type
try Bundle.main.load("article.json", 
                        using: JSONDecoder()) as Article
```
