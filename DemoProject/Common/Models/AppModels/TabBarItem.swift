import UIKit

enum TabBarItem: Int, CaseIterable {
    case data
    case info
    
    var value: UITabBarItem {
        switch self {
        case .data:
            return UITabBarItem(title: "Data",
                                image: UIImage(),
                                selectedImage: nil)
        case .info:
            return UITabBarItem(title: "Info",
                                image: UIImage(),
                                selectedImage: nil)
        }
    }
    var contentInset: UIEdgeInsets {
        switch self {
        default:
            return .zero
        }
    }
    
    var titleOffset: UIOffset {
        switch self {
        default:
            return .zero
        }
    }
}
