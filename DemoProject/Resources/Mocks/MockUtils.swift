import UIKit

func getDataFromFile(named fileName: String, bundle: Bundle = Bundle.main) -> Data {
    let path = bundle.path(forResource: fileName, ofType: "json")!
    return try! Data(contentsOf: URL(fileURLWithPath: path))
}

func getEntity<T: Codable>(fromFileNamed fileName: String, bundle: Bundle) -> T? {
    let data = getDataFromFile(named: fileName, bundle: bundle)
    return try? JSONDecoder().decode(T.self, from: data)
}
