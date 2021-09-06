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
    
    struct Body: CodableBody {
        var item1: String?
        var item2: String?
    }

    var body: Body?
}


final class EndpointsTest: XCTestCase {
    
    func testGET() {
        var get = GetAPI()
        get.pathPart = "fasciating-path"
        get.itemId = "2345trgf"
        print(get)
    }
    
    func testPOST() {
        var api = PostAPI()
        api.pathPart = "some-kind-of-path"
        api.body = .init(item1: "test", item2: nil)
        print(api)
    }
}
