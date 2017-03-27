Alex Mai (amai2@u.rochester.edu)

1. Same as proposal from Project 1 - included again for reference.

2. I affirm that I did not give or receive any unauthorized help on this project, and that all work is my own.

3. Enhancements:
(a) Transitioned data from singleton to Core Data. This allows the user’s information to be stored on the device after closing, and enhances sustainability issues versus encoding it into the Documents.

(b) Image fetcher web service. One of them is implemented in the FourthViewController. For that one, I make a call to google’s custom search for a location city, State. It returns an image link. Then I make another call to that link to fetch that image. 

(c) Web service that relays information to the user about his or her location. For example, if I have an active trip and I am currently in a Starbucks, information about that Starbucks will display on that view controller. And a link will be visible where I get to visit the website of that company (if Google returns a URL), if it doesn’t have one, then that button will not be visible to the user. It also tells me if that location is open now.

(d) User location. I implement CLLocationManager to get the location of the user. If he or she has an active trip then it will utilize the user’s location to navigate them to the next destination via latitude and longitude coordinates.

(e) Use of Maps view. I embed a map view to help the user know where he or she is during an active trip. I also have a button that launches the Map app from within my app that navigates him or her to the next leg of the trip.

4. Instructions:
Launch the app and click on the buttons as you wish. 

Be sure to say yes to the app using your location, and be sure to specify your location. If you are running this on the phone, then there’s nothing to do. If you’re running this on Simulator, then with Simulator active please click on Debug > Location > Custom Location (for me, I use latitude: 43.1244, and longitude -77.6194). This is close to the Hilton Garden Inn near the Medical Center at the U of R.

After you register, you can immediately use those credentials to log in.

After logging in, you will be presented a a view controller that’s embedded in navigation controller. If you have active trip plans (which you should because I included a trip for New York City for demo purposes), then you may select it on the table view and it will display to you where you are and information about where you currently are. It will have an option for you to navigate to the next destination, which opens up the Maps app. Otherwise, there are two bar buttons on the top. The one on the left shows you more information about yourself, that you entered from the registration form. The right button shows you a form to request a trip. Once you complete the form, you can go back and you will see that it has been added as an pending trip. However, upon tapping to get more information about the trip, you will notice that the status of the trip is “pending”, instead of “active”. In there, the image dynamically loads.


5. Attachments
proposal.pdf - for reference
SampleOutput - images of the functioning application.