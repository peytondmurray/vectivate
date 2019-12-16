# vectivate
## Easy peasy Python virtual environment activation

Navigating from your project directory to wherever the virtualenv is inside your project directory is annoying, so I wrote this script. It automatically finds any script named `activate` in any directory below `PWD`, checks that it is a valid virtualenv `activate` script, and sources it. If multiple virtual environments in the current directory, `vectivate` uses the one buried least-deep in the file tree.

## !!! Fair Warning !!!
This isn't a sophisticated script, as you can see for yourself. It would be easy to craft a malicious `activate` script, tricking `vectivate` into running arbitrary code. Reasonable precautions have been taken to validate that `activate` is a valid virtual environment activation script, but it's not bulletproof. _Especially_ don't ever run `vectivate` with `sudo`. You've been warned!

## Installation

Stick a link in `/usr/bin`, or wherever else you want on `PATH`:

```bash
# ln -s /path/to/vectivate.sh /usr/bin/vectivate
```

`vectivate` must be sourced to preserve the environment variables provided by a virtual environment's `activate` script. In your `.bashrc` (or wherever gets sourced when a terminal is opened) make either an alias

```bash
alias vectivate='source vectivate'
```

or, if you prefer a function:

```bash
vectivate() { source vectivate }
```
