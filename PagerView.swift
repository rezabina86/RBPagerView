import SwiftUI

protocol PageElement: Equatable, Hashable {
    var title: String { get }
}

struct PagerView<Element, ID, PageView>: View where PageView: View, Element: PageElement, ID: Hashable {
    
    // MARK: Lifecycle
    
    init(
        data: [Element],
        id: KeyPath<Element, ID>,
        selectedTab: Binding<Element>,
        @ViewBuilder content: @escaping (Element) -> PageView
    ) {
        self.data = data.map { PageWrapper(keyPath: id, element: $0) }
        self.id = \PageWrapper<Element, ID>.id
        self.selectedTab = selectedTab
        self.content = content
    }
    
    var body: some View {
        VStack {
            Picker("", selection: selectedTab) {
                ForEach(data) { item in
                    Text(item.element.title)
                        .tag(item.id)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            TabView(
                selection: selectedTab,
                content:  {
                    ForEach(data) { item in
                        content(item.element)
                            .tag(item.id)
                    }
                }
            )
            .tabViewStyle(.page)
            .animation(.easeInOut, value: selectedTab.wrappedValue)
            .transition(.slide)
        }
    }
    
    // MARK: - Privates
    
    private var selectedTab: Binding<Element>
    private let id: KeyPath<PageWrapper<Element, ID>, ID>
    private let data: [PageWrapper<Element, ID>]
    private let content: (Element) -> PageView
}

struct PageWrapper<Element, ID>: Equatable, Identifiable where Element: PageElement, ID: Hashable {
    var keyPath: KeyPath<Element, ID>
    var element: Element
    var id: ID {
        element[keyPath: keyPath]
    }
}
