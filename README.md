# graffiti_classmate_view README
Private copy of the front end of our repo for other groups blackbox testing

## Installation Guide

If you have a Mac OS X machine:

- Contact Kyle Jablon at jablonk@uchicago.edu or (858) 353-5978 for access to the private repo to download the code (Frontend code only)
  - This will allow you to run the app in iPhone Simulator

If you have an iPhone:

  - Download the app on your phone by contacting Amanda Aizuss at amandaaizuss@me.com or (818) 282-6494
  - She will be on campus (likely in the reg) during the day Thursday and Friday to help install the app on your phone (Apple has strict restrictions about installing apps on devices)
## Xcode Installation
- Download the latest version of Xcode on your Mac free from the App Store.
- In the search field in the top-right corner, type Xcode and press the Return key.
- Click Get and then click Install App
- Enter your Apple ID and password when prompted
## Running the app in iPhone Simulator (note: you will not be able to try posting photos if you only test in simulator)
1. Clone this repo https://github.com/kylej1994/graffiti_classmate_view (contact Kyle for access)
2. On the Mac, navigate to graffiti_classmate_view > Graffiti. (Screenshot below shows what you should see):
3. Open Graffiti.xcworkspace (by double clicking). This will open Xcode. 
![image](https://d2mxuefqeaa7sj.cloudfront.net/s_B4A3E709240AA2A5A2720EBAE4DBFDC06F4C2268776FCFF1CE8D76622B726E4F_1489017796696_Screen+Shot+2017-03-08+at+6.02.08+PM.png)




1. Before running the app, choose a device from the dropdown (where the screenshot says Generic iOS device). Choose iPhone 7 Plus from the dropdown (we also support 6S devices, and the 5S and SE). 
![image](https://d2mxuefqeaa7sj.cloudfront.net/s_B4A3E709240AA2A5A2720EBAE4DBFDC06F4C2268776FCFF1CE8D76622B726E4F_1489018494276_Screen+Shot+2017-03-08+at+6.14.26+PM.png)

1. Hold down the option key + click the play button. Choose `release` from the Build Configuration dropdown. Then run the app. This will launch the simulator.
2. With the simulator selected, go to the menu bar. Debug > Location > Custom Location and use `Latitude: 41.792296`  and `Longitude: -87.59951` (you can choose other locations, but you won’t be able to see posts in the feed except for your own unless someone else happened to post in those locations). Because you’re setting these coordinates after the app has launched, you might have to pull on the feed to refresh with the new coordinates (our app does not refresh automatically as you move).


## Running the app on an iPhone (you need to do this to test posting photos): 
1. Update to the latest version of iOS
2. Go to Amanda Aizuss (text her 8182826494 or email her amandaaizuss@me.com)


## Installing the app with Apple Configurator 2 (we were not able to test this, so it might not work. We are including this as an option because we want this to be easy for you, but the easiest way is to let Amanda install the app for you from her computer)
1. Download Apple Configurator 2 for free from the Mac App Store. 
2. Connect the testing device to a Mac running Apple Configurator 2.
3. Select the device, click the Add button (+), and select Apps from the pop-up menu.
https://developer.apple.com/library/content/documentation/IDEs/Conceptual/AppDistributionGuide/Art/5_appleconfigurator1_2x.png

4. In the dialog that appears, click “Choose from my Mac”.
https://developer.apple.com/library/content/documentation/IDEs/Conceptual/AppDistributionGuide/Art/5_appleconfigurator2_2x.png

5. Choose the iOS App file from the repo. It’s in the root directory, and it’s called Graffiti.ipa

## Tutorial
* When you open the app you while be prompted to sign with an Google Account 
* You will then be prompted to pick a username because you are a new user. You cannot change your username once you have created one. 
* You will then be taken to the Newsfeed page where you will see all posts within the 1 mile radius 
* In the top right corner you can create a new post by tapping the compose button.
  * You have two options for a new post: Text and Photo
* On the bottom of the screen their are tabs to take you to the map view and your profile 
* In map view there are pins place everywhere that a post has been uploaded and a circle that denotes the radius where you’ll be able to view posts in the feed
* On your profile you can see your profile picture, your bio, and your post History 
  * You also have the ability to edit your profile information and sign out of the app. 

## Functionality
**Sign In**: sign in with google. If you have a google profile picture, it your profile picture on Grafitti will be automatically set to that picture
**Feed**: Pull to refresh the feed. It’s slow because we load all of the images. 

- The feed tells you that it is loading posts while the posts are downloading. 
- The feed loads a few posts, and as you scroll, it tells you it is loading more posts
- You can up vote and down vote posts. 
- You can tap an image post to view the uncropped, full screen image. 
- You can swipe the image up or down to go back to the feed, or you can tap the button in the top right.
- Posts are displayed in order of most recent to least recent

**Posting**: Tap the compose button in the top right to create a new post. Then, you can choose between text and photo. 

- Text: There is a character counter. Posts are limited to 140 characters
- Photo: Opens the camera. You can take photos with front or back facing camera.
- Your new post will be displayed at the top of the feed 

**Map View**: There are pins where posts have been created. Posts corresponding to pins outside of the circle won’t be visible to you. You’ll need to be within 1 mile of the pin to see the post in the feed. 

- Interactivity: you can pan around the map and zoom in and out. As you move the map, the pins will redraw themselves. You can’t actually interact with pins though.

**Profile**: View all posts that you’ve made, regardless of location
**Edit Profile:** You can add/edit your bio (but we do not support emojis in the bio) and change your profile picture

## Inputs not handled well
- Tapping vote buttons several times in a row will crash the app
- Trying to make a post immediately when app launches sometimes causes a strange display bug
  - it switches back to the feed and the keyboard doesn’t dismiss
- Sometimes after using the keyboard, it’s dismisses a bit slowly




