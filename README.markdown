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

Links
=====

* Source code: [http://github.com/rainux/twi-miku](http://github.com/rainux/twi-miku)
* Issues : [http://code.google.com/p/twi-miku/issues/list](http://code.google.com/p/twi-miku/issues/list)
