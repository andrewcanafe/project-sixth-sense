# Chefmoji

Chefmoji is a synchronized multiplayer web-based game where pairs of players collaborate to serve plated meals. After logging in, users can either create a new game or join an existing one. In games, players navigate a 2D map comprised entirely of emojis, follow recipes to cook various emoji dishes, and rack up points with each successfully completed meal. 

### To Build

You will need to clone this repository then run some commands in the Makefile. Using a command window, navigate to an empty directory on your computer and run the following commands:

```
git clone https://github.com/cs188-software-design-security-w20/project-sixth-sense.git
git submodule update --init --recursive
make build-base
make prod
```

### To Sign Up

Go to [www.chefmoji.wtf](https://www.chefmoji.wtf), where you will be greeted by the login page. Click `sign up`, and enter in a unique player ID, a strong password, and a valid email address. Click `make my account!` to register this information with Chefmoji. Once you've successfully registered an account, a verification link will be sent to your email address. 

Now is a good time to pull out your smart device of choice and download [Google Authenticator](https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2). This will be used for multi-factor authentication. 

Head over to your email inbox and open the email sent from Chefmoji. When you click the verification link, you will be routed to a page where you can either scan the given QR code using Google Authenticator or manually type the code into the app. After this, you're all set to log in!

### To Log In

Go to [www.chefmoji.wtf](https://www.chefmoji.wtf), and enter in your player ID and password. Pull out your Google Authenticator app and enter the 6-digit key into the login form. Finally, click `log in`. If the information you entered was correct, you will be redirected to a simple dashboard where you can create or join games. 
