# RBPagerView

`RBPagerView` is a page view created with SwiftUI, featuring a segmented control at the top that allows you to switch between different views. You can navigate through the pages either by tapping on the segmented control or by swiping between them. 
This is currently just a prototype, but you can customize it to meet your specific requirements.

<p align=center>
    <img src="https://github.com/rezabina86/RBPagerView/assets/22550304/366b1642-8f89-4e58-91cc-35e11d144ce4" width=300 class="center">
</p>


## Setup

To use `RBPagerView`, you first need a model to represent each tab. 
This model should conform to the `PageElement` protocol and provide a title for each tab. 
Below are two examples:
- enum:
```
enum Tab: PageElement {
    case first
    case second
    
    var title: String {
        switch self {
        case .first:
            "First Tab"
        case .second:
            "Second"
        }
    }
}
```
- struct:
```
struct Model: PageElement {
    var title: String
    var content: String
    ...
    ...
}
```

And then in your SwiftUI view you can setup `RBPagerView`:

```
struct ContentView: View {
    @State private var selectedPage: Tab = .second
    private let tabs: [Tab] = [.first, .second]

    var body: some View {
        PagerView(
            data: tabs,
            id: \.self,
            selectedTab: $selectedPage
        ) { tab in
            switch tab {
            case .first:
               FirstView()
            case .second:
               SecondView()
            }
        }
    }
}
```
