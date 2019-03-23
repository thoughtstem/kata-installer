kata-installer
==============

This takes care of installing Racket packages we use at ThoughtSTEM.
When installed on one of our Chromebooks, it does additional system configurations through those packages.

Important points:

1) `kata-installer` only installs packages.  It doesn't technically update them.  `pkg-watcher` does that.
2) The *behaviour* of `pkg-watcher`, however, is specified here.  
3) From now on, all configuration of Chromebooks ought be done through packages that are installed by this package.  


# Installation

```
raco pkg install --deps search-auto https://github.com/thoughtstem/kata-installer.git
```

This has the effect of installing various packages, and also installing pkg-watcher, which keeps those packages up to date.

# Updating

After installing, you shouldn't ever have to update this package explicitly (e.g. with `raco pkg update kata-installer`). 

Instead, you would update `kata-installer`'s master branch and then let `pkg-watcher` update it in one of its two ways:

1) Wait for a Chromebook user to open DrRacket (triggering priority updates).  (NOTE: This can be used to install new packages, which can then be used to install or update other packages.  Whatever we want.  Just remember the cost -- there will be a period of unusability in DrRacket.  Users will see a temporary pkg lock error.)
2) Run `raco update-watched-packages`

As for the rest of the packages installed by `kata-installer`, they are not priority packages.  So they can only be updated with `raco update-watched-packages`, which will pull from the packages' respective master branches.  We'll use this method for all planned updates.
