# listdetail

This project demonstrates a basic flutter application. It includes the following features:

- Multiple build flavors to build two different versions of the app.
- Application architecture separated into business logic (bloc), data (repositories), and UI
- Dark or Light theme based on system preferences
- Unit test of the most critical class which is the CharacterRepository which parses the response from the REST api.
- The app uses HydratedBloc to keep a cached copy of the list of characters. In this way if the user does not have an active network connection (on an
  airplane) but
  needs access to this critical list of character descriptions, they can still see that data. (assuming they've run the app before while they were
  online).
- Pull-to-refresh support on the character list so that the user can force a data reload if they think there might be updated information.

## Getting Started

When building the app, be sure to specify a "flavor" as either "simpsons" or "wire" and run the main.dart for The Simpsons but run main_wire.dart for
The Wire.

Examples:

flutter run --flavor simpsons lib/main.dart

flutter run --flavor wire lib/main_wire.dart

## TODO

It would probably be appropriate to add analytics and crashlytics. This would allow us to track which character is most frequently viewed
and to track any crashes that may be happening. It might also be nice to have a service that detects changes to the responses being
returned by the REST API so that we can update the app if needed. Alternatively, we should copy that data to a server that we
control so that we are not at risk of our app breaking if someone changes the format of the response from the REST API.

If you have any questions, please call John at 405 436 3538.

## DISCLAIMER

bard.google.com and previous personal flutter projects were used during the process of creating this app.
