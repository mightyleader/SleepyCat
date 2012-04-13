/*
Receive binary data from Arduino
*/

 import processing.serial.*;

 //USB Serial Port
 Serial myPort;
 short portIndex = 2;

 //Data receiving vars
 char HEADER = 'H';
 int receivedValue1, receivedValue2, receivedValue3;
 String tweetStatus;
 //Twitter Setup
 // This is where you enter your Oauth info
 static String OAuthConsumerKey = "C8446BBGbHir088uSPhGQ";
 static String OAuthConsumerSecret = "Q36bffjjltymfNJN6KslNeHrt9qO3QledNfGY4nZZI";

 // This is where you enter your Access Token info
 static String AccessToken = "197696544-2dp8NHHvEhEQTBgnaOqEfZAINTIpKvv0VKwaxhQ6";
 static String AccessTokenSecret = "V67kxdTlln4KLXRTiPW5xgTuyFnDi2R2y97nrQtWGOg";
 
 Twitter twitter = new TwitterFactory().getInstance();
 RequestToken requestToken;

void setup()
{
 size(255,255); //output window
 String portName = Serial.list()[portIndex]; //Setup connection
 println(Serial.list()); //Output serial ports available
 println(" Connecting to -> " + portName);
 myPort = new Serial(this, portName, 9600); 
 connectTwitter(); //kinda obvious
}

void draw()
{
  if ( myPort.available() >= 5 )
  {
   if (myPort.read() == HEADER)
   {
     receivedValue1 = myPort.read();
     receivedValue1 = myPort.read() * 256 + receivedValue1;
     receivedValue2 = myPort.read();
     receivedValue2 = myPort.read() * 256 + receivedValue2;
     receivedValue3 = myPort.read();
     receivedValue3 = myPort.read() * 256 + receivedValue3;
     //println("Message received: " + receivedValue1 + ", " + receivedValue2); DEBUG
     float tempRandom = random(5);
     int randomResponse = int(tempRandom);
     switch(randomResponse)
     {
       case 0:
       tweetStatus = "I'm in my bed having a cat nap";
       break;
       
       case 1:
       tweetStatus = "Yawn... time for sleep";
       break;
       
       case 2:
       tweetStatus = "Nap in progress, leave a message after the purrrrr...";
       break;
       
       case 3:
       tweetStatus = "Zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz";
       break;
       
       case 4:
       tweetStatus = "Dreaming of catching flies, mmmmmmmm flies";
       break;
     }
     sendTweet(tweetStatus);
   }
  }
}

// Initial connection
void connectTwitter() 
{
  twitter.setOAuthConsumer(OAuthConsumerKey, OAuthConsumerSecret);
  AccessToken accessToken = loadAccessToken();
  twitter.setOAuthAccessToken(accessToken);
}

// Sending a tweet
void sendTweet(String t) 
{
  try {
    Status status = twitter.updateStatus(t);
    println("Successfully updated the status to [" + status.getText() + "].");
  } catch(TwitterException e) { 
    println("Send tweet: " + e + " Status code: " + e.getStatusCode());
  }
}

// Loading up the access token
private static AccessToken loadAccessToken()
{
  return new AccessToken(AccessToken, AccessTokenSecret);
}
