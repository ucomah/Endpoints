public final class HTTP {
    
    private init() {}
    
    public enum Method: String {
        case options = "OPTIONS"
        case get     = "GET"
        case head    = "HEAD"
        case post    = "POST"
        case put     = "PUT"
        case patch   = "PATCH"
        case delete  = "DELETE"
        case trace   = "TRACE"
        case connect = "CONNECT"
    }

    public typealias Headers = [String: String]
    
    public enum ContentType: String {
        /// Content-Type: application/json
        case json = "application/json"
        /// Content-Type: multipart/form-data
        case formData = "multipart/form-data"
        /// Content-Type: text/plain
        case plainText = "text/plain"
        /// Content-Type: application/x-www-form-urlencoded
        case formURL = "application/x-www-form-urlencoded"
    }
}
