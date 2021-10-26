import XCTest
@testable import Endpoints

struct GetAPI: AnyEndpoint {
    
    var method: HTTP.Method { .get }
    
    var baseURL: String { "https://dev.myserver.com/v2" }
    
    var path: String { "/fantastic-path/\(self.pathPart)" }
    
    var pathPart: String
    
    @HTTP.Parameter(name: "item-id", help: "item id")
    var itemId: String
}


struct PostAPI: Endpoint {
    
    var method: HTTP.Method { .post }
    
    var baseURL: String { "https://dev.myserver.com/v2" }
    
    var path: String { "/fantastic-path/\(self.pathPart)" }
    
    var pathPart: String
    
    struct Body: HTTPPayload {
        var item1: String?
        var item2: String?
    }

    var body: Body?
}

public struct ResendKey: AnyEndpoint {
    public var baseURL: String { "https://dev.myserver.com/v2" }
    
    public enum SendCodeType: String, AnyRawRepresentable {
        case activation = "1", reset = "2", back = ""
    }
    public var method: HTTP.Method { .post }
    public var path: String { "/resend-key" }
    @HTTP.Parameter(name: "email")
    public var email: String
    @HTTP.Parameter(name: "type")
    public var kind: SendCodeType
    public init(email: String, kind: SendCodeType) {
        self.email = email
        self.kind = kind
    }
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
    
    func testResend() {
        let api = ResendKey(email: "some@mail.com", kind: .activation)
        print(api)
    }
}
