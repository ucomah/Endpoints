import XCTest
@testable import Endpoints

struct GetAPI: Endpoint {
    
    var method: HTTP.Method { .get }
    
    var baseURL: String { "https://dev.myserver.com/v2" }
    
    var path: String { "/fantastic-path/\(self.pathPart)" }
    
    
    @HTTP.Parameter(name: "path-part", kind: .path)
    var pathPart: String
    
    @HTTP.Parameter(name: "item-id", help: "item id")
    var itemId: String

    var body: EmptyBody?
}


struct PostAPI: Endpoint {
    
    var method: HTTP.Method { .post }
    
    var baseURL: String { "https://dev.myserver.com/v2" }
    
    var path: String { "/fantastic-path/\(self.pathPart)" }
    
    
    @HTTP.Parameter(name: "path-part", kind: .path)
    var pathPart: String
    
    struct Body: HTTPPayload {
        var item1: String?
        var item2: String?
    }

    var body: Body?
}


final class EndpointsTest: XCTestCase {
    
    func testGET() {
        let get = GetAPI(pathPart: "fasciating-path", itemId: "2345trgf")
        print(get)
    }
    
    func testPOST() {
        var api = PostAPI(pathPart: "some-kind-of-path")
        let body =  PostAPI.Body(item1: "test", item2: nil)
        api.body = body
        print(api)
        let data = try! JSONEncoder().encode(body) // swiftlint:disable:this force_cast
        print(String(data: data, encoding: .utf8) ?? "n/a")
    }
}
