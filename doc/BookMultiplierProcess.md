# How I Did This #

## The Tools ##
I use a MacBook Pro. I resisted using Apple stuff for a long time but since I got one in exchange for a bit of software I made I'm convinced. Yes it is expensive and closed and whatnot but the hardware is excellent, it integrates extremely well with an iPhone and for most things the online store suffices. 

I use Rubymine as the IDE. I invested in a personal version some time ago and I quite like it. I like the support you get from it (lookups etcetera) and being in an 'environment'.

For revision control I use git, command line mostly. If I need a GUI for git I use SourceTree.  

For writing documents I use MultiMarkdown Composer.
## The Process ##

What follows is a rough list of what I did to finish at the result of the assessment.

### Setup RAILS ###

I always think of it as a chore. Because it is not a regular task I always need to find out how exactly it needs to be done. For example I found out that in the latest dvm the configuration files have changed. OK fine after some ado I succeeded to set up a ruby and a gemset.
### Standard gems ###
Add a number of 'standard' gems to get things going. The most important are:

- rails_config to do configuration stuff in RAILS using YAML files. Saves a lot of finding out wheels myself. 
- rails_admin to spelunk around in databases if need be
- kaminari instead of will_paginate
- simple_form for form building
- better_errors e.a. to get a reasonable error page in your browser instead of the standard one

### Fighting Nokogiri Native Extensions ###

Aargh. That needed some brew hacking. MmmOkay lets d=just write that off as the disadvantage of cutting edge. nokogiri requires zlib-1.2.7 while latest brew provides zlib-1.2.8 so I solved this by pointing /opt/local/lib/zlib to the 1.2.7 version in the brew cellar.

### Learning Heroku ###

I never worked with Heroku. Interesting system. After some ado I managed to make it run (especially setting up de database was a challenge). In a later stage I added delayed_jobs to fork off loading the books from Google in a separate job due to runlenght of that job.

