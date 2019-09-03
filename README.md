# Codable-Utils

![](https://img.shields.io/badge/language-Swift--5.0-orange)
[![Swift Package Manager](https://img.shields.io/badge/spm-compatible-brightgreen.svg)](https://swift.org/package-manager)
![](https://api.travis-ci.com/jlainog/Codable-Utils.svg?branch=master)
[![GitHub license](https://img.shields.io/github/license/jlainog/Codable-Utils)](https://github.com/jlainog/Codable-Utils/blob/master/LICENSE)
![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/jlainog/Codable-Utils)

## Motivation

The new Framework [Combine](https://developer.apple.com/documentation/combine) introduce a couple of protocols that create a common interface for Encoders and Decoders allowing to chain them. 
* [TopLevelEncoder](https://developer.apple.com/documentation/combine/toplevelencoder)
* [TopLevelDecoder](https://developer.apple.com/documentation/combine/topleveldecoder)

but those are available only in `iOS 13.0+`
Wanting to use those in previous versions motivate this set of  `utils`  API starting by declaring  `AnyTopLevelEncoder`  &  `AnyTopLevelDecoder`  and then creating extension for `Encodable` and `Decodable` to use them.

## Examples

#### Given 
```swift
struct Article: Codable {
    var name: String
}
```
#### With Encodable 
```swift
let encoder = JSONEncoder()
let article = Article(name: "jaime")
let encodedArticle = try encoder.encode(article)
```
#### With Codable-Utils
```swift
// Encode with JSONEncoder by default
let article = Article(name: "jaime")
let encodedArticle = try article.encode()

// Using an specific encoder
let encoder = PropertyListEncoder()
let encodedArticle = try article.encode(using: encoder)
```
#### With Decodable 
```swift
let decoder = JSONDecoder()
let data = "{\"name\":\"jaime\"}".data(using: .utf8)!
let article = try decoder.decode(Article.self, from: data)
```
#### With Codable-Utils 
```swift
// Decode with JSONDecoder by default
let data = "{\"name\":\"jaime\"}".data(using: .utf8)!
let article = try Article.decode(from: data)

// Using an specific decoder
let article = try Article.decode(from: data,
                                 using: JSONDecoder())
```
#### Custom Encoders
```swift
let jsonString = article.encode(using: JSONStringEncoder())
// output: "{\"name\":\"jaime\"}"
let dictionary = article.encode(using: JSONSerializationEncoder())
// output: ["name": "jaime"]
```

#### Custom Decoders
```swift
let article = try Article.decode(from: "{\"name\":\"jaime\"}",
                                 using: JSONStringDecoder())
let article = try Article.decode(from: ["name": "jaime"],
                                 using: JSONSerializationDecoder())
```

## Extras
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
```
#### Regular way
```swift
init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    index = try container.decode(Int.self, forKey: .page)
    title = try container.decode(String, forKey: .title)
    content = try container.decodeIfPresent(String.self, forKey: .content)
}
```
#### Using the extension
```swift
init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    index = try container.decode(.page)
    title = try container.decode(.title)
    content = try container.decodeIfPresent(.content)
}
```
#### 3-ways to do the same
```swift
let page1 = try container.decode(.page, as: Int.self)
let page2 = try container.decode(.page) as Int
let page3: Int = try container.decode(.page)
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

