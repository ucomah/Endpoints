/// General purpose protocol to define endpoints for HTTP APIs.
public protocol Endpoint: AnyHTTPEndpoint {
    
    typealias HTTPParameter = HTTP.Parameter
    
    associatedtype Body: HTTPPayload
    
    var body: Body? { get }
}

// MARK: - Default values

public extension Endpoint {
    
    var body: Body? { nil }

    var parameters: [String: Any]? {
        let buf = Mirror(reflecting: self).children.compactMap {
            $0.value as? AnyParameterValue
        }.filter {
            $0.kind == .query
        }.map {
            ($0.name, $0.anyValue)
        }
        return Dictionary(uniqueKeysWithValues: buf)
    }
}

// MARK: - LosslessStringConvertible

extension Endpoint {

    public var description: String {
        switch method {
        case .get:
            return basicDescription
        default:
            return "\(basicDescription)\nParameters: \(unwrap(parameters))\nBody: \(unwrap(body))"
        }
    }
}

// MARK: - Body variations

public struct EmptyBody: HTTPPayload {
    public init() {}
}

public protocol CodableBody: HTTPPayload, Codable {}

extension String: HTTPPayload {}
