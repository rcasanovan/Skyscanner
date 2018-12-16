# Implementation:

### Q) What libraries did you add to the app? What are they used for?

- SVProgressHUD (2.2.5): A clean and lightweight progress HUD for your iOS and tvOS app.
- Haneke (1.0): A lightweight zero-config image cache for iOS, in Objective-C. In this cas I used "Haneke" instead "HanekeSwift" because the last version of HanekeSwift that with Swift 4 support (0.11.0) is not available via cocoapods
- SwiftyPlistManager (1.0.2): Lightweight plist data management framework for iOS 10.3+
- Reachability file: This is the official Apple's Reachability file to validate the device connection

---

# General:

### Q) How long did you spend on the test?

I spended 3 days in total (aprox) in the following sequence:
DAY 1: Implement the api calls according with the API reference
DAY 2: Generate the view models from the data model (data response) + create the initial user interface with fake data for the tableview
DAY 3: Connect the view models with the user interface and fix some issues and details

### Q) If you had more time, what further improvements or new features would you add?

- Create a "filter data" struct: Create a struct called "FilterData" in order to configure the filter applied by the user. With this filter data I could avoid to call the endpoint with hardcoded data (Edinburgh to London with all the configuration) and it will be really helpful to apply a real filter using the app (configure another destination, another date, etc).

- Add more testing: The test is really simple but it will be great to add more tests to the app

- Manage more response codes: I'm considering a general code ranges:
* 100 - 199
* 200 - 299
* 300 - 399
* 400 - 499
* 500 - 599

And I'm managing the 410 response code (Gone – the session has expired. A new session must be created.) in order to create another session.

It would be great to manage all the possible response codes coming from the server.


### Q) Which parts are you most proud of? And why?

- Architecture: I like to use VIPER for all my projects because it's really easy to separate each layer (View, Interactor, Presenter, Entity, Router)

- SessionManager class: I save the pollEndpoint (/pricing/v1.0) in order to reuse the endpoint for future sessions. If the session has expired I'll call the pricing/v1.0 endpoint again in order to create a new session

- Simulated response: I added a local json file to simulate the API response. It's really easy to set the request manager class to retrieve the local json for testing (according with the RequestProtocol file). It was really helpful to test the view models and the UI without to call the server

- PollResponse / CreateSessionResponse: I really love to user codeblae / decodable to process an endpoint response. It's really easy because you can define the struct you're expecting so you don't need to use a wrapper to transform the response.

- Reachability logic: I applied a logic to show a new screen if the device doesn't have reachability.

### Q) Which parts did you spend the most time with? What did you find most difficult?

Probably the most complex part was to process the json response. I needed to jump between all the json struct in order to create the view models to show the data in the user interface. Once I did it everything worked like magic :).

Related with the total itineraries count I didn't see any field in the json response to set this value (XXX of YYY results shown) so I decided to show the total itineraries for the view model (all the combinations).


### Q) How did you find the test overall? If you have any suggestions on how we can improve the test or our API, we'd love to hear them.

I have some sugguestions for the test:

-JSON response struct: The struct for the json response is a little bit complex. We're receiving all the itiniraries, legs, segments, carriers and places in the response. I understand we need all this information in order to show it in the user interface but maybe one option is to return the info the UI needs for each itinerary (as a part of the itinerary struct) instead to have many structs with id references.
