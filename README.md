# Rockets

This is a Swift application that consumes the SpaceX API.

The app is built using the MVVM (Model-View-ViewModel) architecture, along with other design patterns such as Dependency Injection, Coordinator, Factory, and Use Cases. It also follows a protocol-oriented implementation approach.

By following to these patterns, the app becomes loosely coupled and easier to test.


## Key Design Patterns
### Coordinator  
The `Coordinator` pattern is responsible for managing navigation. It centralizes navigation logic in a single place, relieving the `ViewModel` from handling it.

### Factory.  
The Factory pattern is used to create screens. This abstraction allows the `Coordinator` to focus on navigation without worrying about how view controllers are created or what dependencies they need. The `Coordinator` retrieves view controllers from the `Factory`, which handles their creation and dependency management. This means changes to the concrete implementation of a view controller won't affect the `Coordinator`, as it’s abstracted away from these details.

### Dependency Injection & Protocol-Oriented Approach.  
By using Dependency Injection and a protocol-oriented design, the app becomes loosely coupled. Instead of depending on concrete implementations, classes depend on protocols, making the code easier to test. For instance, mock versions of dependencies that conform to a protocol can be injected during testing.

To better manage dependencies, the app uses a `Dependency Container`. This singleton holds all the app's dependencies. It maintains a dictionary where each key is associated with either a concrete instance of a type or a factory closure that creates an instance. The keys in the dictionary represent protocol types, as the objects in the app depend on protocols rather than concrete implementations. This design ensures loose coupling and flexibility in swapping out dependencies.

### Use Cases.  
Use Cases encapsulate specific functionality, further decoupling the business logic from other parts of the application. For example, the `RocketsFiltersUseCase` handles filtering logic. While the `ViewModel` is responsible for knowing which filters the user selected, it doesn't perform the filtering itself. Instead, the `ViewModel` passes the list of rockets and the selected filters to the Use Case, which returns a filtered array. This separation of concerns helps keep the `ViewModel` clean and focused on its core responsibilities.


### Tests
Some tests were written to display how a dependency injection facilitates mocking data and responses to test the correct behaviour different scenarios.

There is a `Resources` folder in the project containing JSON files with the responses from the API. This was used to develope the application with no internet access.

