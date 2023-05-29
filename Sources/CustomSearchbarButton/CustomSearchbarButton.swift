import SwiftUI
import Introspect
import Combine

struct SearchbarButtonModifier: ViewModifier {
    let visibility: Visibility
    let type: UISearchBar.Icon
    let image: UIImage
    let action: () -> ()

    @State var vcDelegate: VCDelegate? = nil
    @State var sbDelegate: Delegate? = nil
    
    func body(content: Content) -> some View {
        content
            .introspectSearchController { sc in
                let vcDelegate = VCDelegate(visibility: visibility)
                sc.delegate = vcDelegate
                self.vcDelegate = vcDelegate

                let delegate = Delegate {
                    if type == .clear {
                        action()
                    }
                } searchButton: {
                    if type == .search {
                        action()
                    }
                } bookmarkButton: {
                    if type == .bookmark {
                        action()
                    }
                } resultListButton: {
                    if type == .resultsList {
                        action()
                    }
                }

                sc.searchBar.delegate = delegate
                self.sbDelegate = delegate

                sc.searchBar.setImage(image, for: type, state: .normal)
                sc.searchBar.setImage(image, for: type, state: [.highlighted, .selected])

                switch visibility {
                case .visible:
                    sc.searchBar.showsBookmarkButton = true
                case .hidden:
                    sc.searchBar.showsBookmarkButton = false
                case .auto:
                    if sc.isActive {
                        sc.searchBar.showsBookmarkButton = true
                    } else {
                        sc.searchBar.showsBookmarkButton = false
                    }
                }
            }
    }
}

class VCDelegate: NSObject, UISearchControllerDelegate {
    let visibility: Visibility

    func willPresentSearchController(_ searchController: UISearchController) {
        switch visibility {
        case .auto, .visible:
            searchController.searchBar.showsBookmarkButton = true
        case .hidden:
            searchController.searchBar.showsBookmarkButton = false
        }
    }

    func didPresentSearchController(_ searchController: UISearchController) {
        switch visibility {
        case .auto, .visible:
            searchController.searchBar.showsBookmarkButton = true
        case .hidden:
            searchController.searchBar.showsBookmarkButton = false
        }
    }

    func didDismissSearchController(_ searchController: UISearchController) {
        switch visibility {
        case .auto, .hidden:
            searchController.searchBar.showsBookmarkButton = false
        case .visible:
            searchController.searchBar.showsBookmarkButton = true
        }
    }

    init(visibility: Visibility) {
        self.visibility = visibility
    }
}

class Delegate: NSObject, UISearchBarDelegate {
    let cancelButton: () -> ()
    let searchButton: () -> ()
    let bookmarkButton: () -> ()
    let resultListButton: () -> ()

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        cancelButton()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchButton()
    }

    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        bookmarkButton()
    }

    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        resultListButton()
    }

    init(cancelButton: @escaping () -> Void, searchButton: @escaping () -> Void, bookmarkButton: @escaping () -> Void, resultListButton: @escaping () -> Void) {
        self.cancelButton = cancelButton
        self.searchButton = searchButton
        self.bookmarkButton = bookmarkButton
        self.resultListButton = resultListButton
    }
}

typealias Visibility = SearchbarButtonVisibility

public enum SearchbarButtonVisibility {
    case visible
    case hidden
    case auto
}

public extension View {
    func searchbarButton(image: UIImage, type: UISearchBar.Icon, visibility: SearchbarButtonVisibility = .auto, action: @escaping () -> ()) -> some View {
        self
            .modifier(SearchbarButtonModifier(visibility: visibility, type: type, image: image, action: action))
    }
}

