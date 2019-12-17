import Moya

public enum API {
    case login(body: [String: Any])
    case register(body: [String: Any])
    case search(zipcode: String)
    case comment(body: [String: Any], zipcode: String)
}

extension API: TargetType {
    public var baseURL: URL {
        return URL(string: "https://65dc3dd1.ngrok.io")!
    }
    
    public var path: String {
        switch self {
             case .login:
                return "user/login"
            case .register:
                return "user/register"
            case .search(let zipcode):
                return "weather/\(zipcode)"
            case .comment(_, let zipcode):
                return "weather/\(zipcode)/comment"
        }
    }
    
    public var method: Method {
        switch self {
            case .search:
                return .get
            case .login, .register, .comment:
                return .post
        }
    }
    
    public var task: Task {
        switch self {
            case .register(let body), .login(let body):
                return .requestParameters(parameters: body, encoding: JSONEncoding.default)
            default:
                return .requestPlain
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var headers: [String : String]? {
        var headers = Dictionary<String, String>()
        
        headers["Content-Type"] = "application/json"
        
        return headers
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
