# ExactaShop
This is an app developed with SwiftUI, TCA and SwiftData. 

## Features

- List Products
- Shopping cart
- Product Details


## Conclusion - after development thoughts
Using TCA with SwiftUI results in a smooth implementation. The basic concept of TCA can be absorbed quickly, but it has some more advanced features that need more time and study to completely understand: ChildReducers calling a ParentReducer by a DelegateAction. 

This is one aspect that this project lacks. The approach presented [here](https://www.merowing.info/boundries-in-tca/)   sets a separation of concerns for actions, this way the parent action could only watch for Delegate Actions, but sharing the trigger of a delegate action is more complex.

The most challenging part of this project was using SwiftData. This library is based on CoreData, which helped me to solve some problems along the way (multiple contexts being created, as an example), but this was not enough. It is lacking in documentation, forum topics, and users to report bugs and answer questions. This impacted the unit testing and the layout for the sizes on ProductDetails. If these problems were more clear in the beginning I would have used CoreData.

Roadmap:

- Creating a requestBuilder for the networking layer.
- Change swift data for a more reliable library: CoreData.
- Implementing unit tests.
- Implementing the DelegateAction pattern.
