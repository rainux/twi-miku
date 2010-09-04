What's TwiMiku?
===============

TwiMiku is a Twitter OAuth API to Basic Auth API adapter.  
TwiMiku was written with Ruby and Sinatra, it can runs in any Rack application server and Google App Engine.

Why?
====

The GFW of China blocked direct access to Twitter.com, so we can't use OAuth API without a proxy or VPN.  
This could be a serious problem when using mobile devices to access Twitter.

How?
====

1. OAuth with Twitter **once** by click the "Sign in with Twitter" button below.
2. Set a separated password which will only be used with TwiMiku.
3. Use the domain name of the server running TwiMiku as a Twitter API proxy for **any Twitter clients** which support Basic Auth API.

Be sure to use your Twitter user name and **the separated password** in your Twitter clients.

Try it!
=======

You can try an instance of [TwiMiku](http://twi-miku.appspot.com) running on Google App Engine.

Deploy to Google App Engine
===========================

Use the pre-bundled zipball on Windows
--------------------------------------

1. Install Sun Java 6, JRE should be enough.
2. Download [Google App Engine Java SDK](http://code.google.com/appengine/downloads.html#Google_App_Engine_SDK_for_Java), unzip to `D:\appengine` directory.
3. Download [twi-miku.bundled.zip](http://github.com/rainux/twi-miku/downloads), unzip to `D:\twi-miku` directory.
4. Create an application with your Google App Engine account.
5. Edit `D:\twi-miku\WEB-INF\appengine-web.xml` with any text editor, change the value in `<application>` tag to the application's id you've created.
6. Create a Twitter OAuth application with your Twitter account.
7. Rename `D:\twi-miku\config.example.yml` to `D:\twi-miku\config.yml`, edit it with any text editor, change `YOUR_CONSUMER_KEY` and `YOUR_CONSUMER_SECRET`.
8. Open a cmd window, execute the following commands, fill your Gmail address and password for Google App Engine authentication.

Note: You may need to wait for several minutes.

    cd D:\appengine
    bin\appcfg.cmd D:\twi-miku

Links
=====

* Source code: [http://github.com/rainux/twi-miku](http://github.com/rainux/twi-miku)
* Issues : [http://code.google.com/p/twi-miku/issues/list](http://code.google.com/p/twi-miku/issues/list)
