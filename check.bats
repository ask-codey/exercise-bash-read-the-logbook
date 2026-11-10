#!/usr/bin/env bats
# Checks your answers in answers.txt against the station folder itself.
# Run it from this folder with:  bats check.bats
# You don't need to change this file.

setup() {
  cd "$BATS_TEST_DIRNAME"
}

# The answer written after "N)" in answers.txt, without spaces or quotes at either end.
answer() {
  grep -E "^$1\)" answers.txt | head -n 1 | sed -E "s/^$1\)[[:space:]]*//; s/[[:space:]]+\$//; s/^[\"']//; s/[\"']\$//"
}

# The same, in lower case with single spaces, for answers where capitals and spacing don't matter.
plain() {
  answer "$1" | tr '[:upper:]' '[:lower:]' | tr -s ' '
}

# Fails with a message when question N has no answer yet.
need() {
  if [[ -z "$(answer "$1")" ]]; then
    echo "Question $1 has no answer yet. Write it after \"$1)\" in answers.txt."
    return 1
  fi
}

# The date line ("April 9") of each logbook entry, worked out from the logbook itself, in lower case.
DATE='^[A-Z][a-z]+ [0-9]+$'

@test "the station folder is still here" {
  if [[ ! -f station/logbook.txt || ! -f station/notice.txt ]]; then
    echo "The station folder, its logbook.txt or its notice.txt is missing. Download the exercise again to get it back."
    return 1
  fi
}

@test "1) who wrote the notice" {
  need 1
  want="$(grep -E '^- ' station/notice.txt | tail -n 1 | sed -E 's/^- //; s/,.*//' | tr '[:upper:]' '[:lower:]')"
  if [[ "$(plain 1)" != "$want" ]]; then
    echo "Question 1: \"$(answer 1)\" isn't the name that signs the notice yet. Read it with cat and look at the last line."
    return 1
  fi
}

@test "2) the first time the logbook mentions a whale" {
  need 2
  want="$(awk -v d="$DATE" '$0 ~ d {date=$0} /whale/ {print date; exit}' station/logbook.txt | tr '[:upper:]' '[:lower:]')"
  if [[ "$(plain 2)" != "$want" ]]; then
    echo "Question 2: \"$(answer 2)\" isn't the first whale yet. In less, type /whale and press Enter, then look at the date line just above the match."
    return 1
  fi
}

@test "3) the last time the logbook mentions a whale" {
  need 3
  want="$(awk -v d="$DATE" '$0 ~ d {date=$0} /whale/ {last=date} END {print last}' station/logbook.txt | tr '[:upper:]' '[:lower:]')"
  if [[ "$(plain 3)" != "$want" ]]; then
    echo "Question 3: \"$(answer 3)\" isn't the last whale yet. After a search in less, n jumps to the next match. Keep pressing it until there are no more."
    return 1
  fi
}

@test "4) the date of the last entry" {
  need 4
  want="$(awk -v d="$DATE" '$0 ~ d {date=$0} END {print date}' station/logbook.txt | tr '[:upper:]' '[:lower:]')"
  if [[ "$(plain 4)" != "$want" ]]; then
    echo "Question 4: \"$(answer 4)\" isn't the last entry's date yet. In less, G (Shift+g) jumps to the end of the file."
    return 1
  fi
}

@test "5) how many lines the logbook has" {
  need 5
  want="$(awk 'END {print NR}' station/logbook.txt)"
  if [[ "$(answer 5)" != "$want" ]]; then
    echo "Question 5: \"$(answer 5)\" isn't the number of lines yet. wc counts lines; wc --help shows which option counts only lines."
    return 1
  fi
}

@test "6) the file in supplies that isn't text" {
  need 6
  a="$(answer 6)"
  if [[ ! -f "station/supplies/$a" ]] || file -b "station/supplies/$a" | grep -q text; then
    echo "Question 6: \"$a\" isn't the file that isn't text. Run file on every file in station/supplies and read what it says about each."
    return 1
  fi
}

@test "7) the head option that sets how many lines it prints" {
  need 7
  a="$(answer 7)"
  want="$(sed -n '1,3p' station/logbook.txt)"
  got="$(head "$a" 3 station/logbook.txt 2>/dev/null || true)"
  if [[ "$a" != -* || "$got" != "$want" ]]; then
    echo "Question 7: head \"$a\" 3 doesn't print the first 3 lines yet. In man head, look under OPTIONS for the one that mentions lines. Write the option only, starting with -."
    return 1
  fi
}

@test "8) the command that's built into the shell" {
  need 8
  a="$(plain 8)"
  case "$a" in
    cat|less|file|history) ;;
    *) echo "Question 8: write one of cat, less, file or history."; return 1 ;;
  esac
  if [[ "$(type -t "$a")" != "builtin" ]]; then
    echo "Question 8: \"$a\" is a program file, so it has a manual page. type tells you which of the four is a shell builtin."
    return 1
  fi
}
