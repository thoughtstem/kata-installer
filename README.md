kata-installer
==============

This takes care of installing Racket packages we use at ThoughtSTEM.
When installed on one of our Chromebooks, it does additional system configurations through those packages.

In fact, the model is that all configuration is done through Racket packages.  And they would all be added or removed via this master package.

Installation:

```
raco pkg install --deps search-auto https://github.com/thoughtstem/kata-installer.git
```

This has the effect of installing various packages, and also installing pkg-watcher, which keeps those packages up to date.
After that, you shouldn't ever have to update this package, since pkg-watcher is capable of watching this package too.

Installed packages are:

```
     tzinfo 
     gregor 

     https://github.com/thoughtstem/pkg-watcher.git 
     https://github.com/thoughtstem/ratchet.git
     https://github.com/thoughtstem/racket-chipmunk.git
     https://github.com/thoughtstem/game-engine.git
     https://github.com/thoughtstem/game-engine-rpg.git
     https://github.com/thoughtstem/game-engine-demos.git?path=game-engine-demos-common
     https://github.com/thoughtstem/TS-Languages.git?path=battlearena-avengers
     https://github.com/thoughtstem/TS-Languages.git?path=battlearena-fortnite
     https://github.com/thoughtstem/TS-Languages.git?path=battlearena-starwars
     https://github.com/thoughtstem/TS-Languages.git?path=battlearena
     https://github.com/thoughtstem/TS-Languages.git?path=fundamentals
     https://github.com/thoughtstem/TS-Languages.git?path=k2
     https://github.com/thoughtstem/TS-Languages.git?path=survival-minecraft
     https://github.com/thoughtstem/TS-Languages.git?path=survival-pokemon
     https://github.com/thoughtstem/TS-Languages.git?path=survival
```

Updates:

You push updates to Chromebooks by pushing to the master branches of whichever packages are installed.  Note: That includes this package itself.

Suppose you want to deploy a new version of the `battlearena-starwars` language.  Simply push to that repo's master branch.

Suppose you want to deploy a brand new language in some repo `foo`.  Add that repo to the list of packages installed and watched by this package.  And push to this package's master branch.










