# Member's Internation iOS App

## Current State
1. The project should allow a user to sign up or in, if it receives a token.
2. There isn't any local functionality for handling or storing data, nor the ability to interact with the server.

## After cloning
1. Watch [this video](https://www.youtube.com/watch?v=DL1FEvHKL_s&index=12&list=PLdW9lrB9HDw3bMSHtNZNt1Qb9XTMmQzLU) on how to install the Swift Keychain Wrapper via CocoaPods.
2. After doing so, open the project via its workspace file.


## MVP 1
Pitch: Mentors International is redesigning their microfinance training. 
The biggest problems are clients forgetting the material between sessions, forgetting to come to trainings, and difficulty taking time to travel to the training. Imagine a chat bot that helps solve these issues. 

MVP: A mentor/trainer can log in and set up a variety of reminders as to the content of the most recent lesson, goal reminders, and the time and location of the next meeting. Mentors can create a profile, and add messages to their profile, and add a list of clients to a messaging group. Once the messages are complete, you'll submit them to be sent to your list of clients throughout the month. Use Twilio (https://www.twilio.com/) to set up the messaging services necessary for your app to send out the reminders. Reminds should be sent via text or WhatsApp.

Stretch Goal: Allow a 2nd user type (board member) to be able to log in and see trainer’s profiles based on an invitation. They can also Create, Read, Update and Delete messages to send client groups.

## MVP 2

* Login/Signup Pages: A mentor can login in to an existing account with Username, and Password and a Phone Number or a user can sign up for an account with a username, and password and phone number. An e-mail address should be connected with an account creation

* Home Page: on login a user is sent to a list view page where they can see a list of their recent messages they’ve created, and a list of the schedules they’ve created.

* Message Page: User can login and create the text or voice messages to be sent. For the MVP you do not need to include the ability to create new contacts.

* Scheduling Page: User can create a message schedule to be automatically sent by adding a group of contacts, date to be sent, and selecting the message to be sent.

* Notifications: When it's time for the message to be sent, recipient will receive text notifications through Twilio sent to their phone or whatsapp number entered by the mentor.

* Edit Message Schedule Page: user can edit and/or delete a message from their schedule.

Stretch: Allow a mentor to create/import contact information for the clients they mentor. Allow a 2nd user type (board member) to be able to log in and see trainer’s profiles based on an invitation. They can also Create, Read, Update and Delete messages to send client groups.
