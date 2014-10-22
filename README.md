scoreFollowsAudio
=================

a JavaScript library for time based measure highlighting in rendered MEI (http://www.music.encoding.org) and facsimile page turning (loading images). The implementation requires a JSON file with the corresponding measure parameters as e.g. in Weber_Freischuetz-06_annoMeasures.json

this repository implements the "Gitflow" branching model as described at:

http://nvie.com/posts/a-successful-git-branching-model/

Demo
=====

The package contains a test folder. To build and run scoreFollowsAudio, you'll need Node.js, npm, and bower installed on your system. In the main directory run the following commands from command line:

```
bower install
npm install
grunt 
grunt run
```

This will download, compile, and copy corresponding files, and finally serve the test/index.html page and open it in your browser.