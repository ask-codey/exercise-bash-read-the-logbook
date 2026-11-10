# Exercise: Read the Logbook

Exercise code for the lesson **Exercise: Read the Logbook** in Bash in Depth on [ask-codey.com](https://www.ask-codey.com).

Gull Rock Light Station has a new keeper: you. The last keeper left a notice, a logbook nearly a thousand lines long, and a folder of supplies. Read them with `cat`, `less` and `file`, look up what you don't know with `--help`, `man` and `type`, and write what you find in `answers.txt`. A check script tells you which answers are right.

## Before you start

You need a terminal (the Terminal app on a Mac, Ubuntu on Linux or in WSL on Windows) and **bats**, the tool that runs the check. If `bats --version` doesn't print a version yet, install it:

```bash
sudo apt install bats       # Ubuntu, and Ubuntu in WSL
brew install bats-core      # a Mac, with Homebrew
```

## What's here

- `station/`: the notice, the logbook and the supplies folder. Read them; don't change them.
- `answers.txt`: eight questions, each with a numbered line for your answer. For you to finish.
- `check.bats`: checks your answers against the station folder. You don't need to change it.

## Run it

Open a terminal in this folder (the one with `answers.txt` in it), then start reading:

```bash
cd station
cat notice.txt
```

Open `answers.txt` in any text editor to write your answers, and save it after each one.

## Check your work

From this folder (not from inside `station`):

```bash
bats check.bats
```

At first almost every check fails: that is expected. Each answer you get right turns its check into a ✓. A failing check's message says which question it is and gives a hint.

## The rules

- Write each answer on its numbered line, after the `)`, like the example: `0) Gull Rock`.
- Write dates the way the logbook writes them, such as `March 3`.
- Write names and options without quotes.

## Tips

- `logbook.txt` is too long for `cat`. Open it with `less`: Space goes forward, `b` back, `/` searches, `n` finds the next match, `G` jumps to the end and `q` quits.
- Check what a file is with `file` before you open it.
- `--help` and `man` explain any command; `type` says whether a name is built into the shell.
- The up arrow and Ctrl+R bring back a command you've already typed.

## Hand it in

When it works, push your solution to a public repo of your own on GitHub, then paste that repo's address into **Submit your exercise** on the lesson page at [ask-codey.com](https://www.ask-codey.com). That's what completes the lesson. The lesson page shows the Git commands, step by step.
