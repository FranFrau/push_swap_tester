# push_swap_tester

# `WARNING`
This script is made by me and frudello. See if and where it fails, understand what the testers tell's you.

## Installation

clone the repo from github into your push_swap folder then execute it
```sh
./tester.sh list
```
## Arguments

| Tests | Description |
| ------ | ---- |
| list | Show all commands |
| makefile | This is a simple test that check if it compile |
| errors | This is a simple test that check if the student print the error on stderr |
| 3 | This is a test for 3 numbers with a 3 moves limits (read the correction sheet) |
| 5 | This is a test for 5 numbers with a 12 moves limits (read the correction sheet) |
| 100 | This is a test for 100 numbers with a default value of 700 moves limits |
| 500 | This is a test for 500 numbers with a default value of 5500 moves limits |
| clear | Delete this folder |
| norme | Shows any errors in the norm |
| showerrors | Shows any errors during the tests |

## Usage

You can use the script just with "sh tester.sh" or with the arguments like this:
```sh
sh tester.sh list
sh tester.sh 100
sh tester.sh 3
```
You can also edit some paramether on 100 and 500 moves:
```sh
sh tester.sh 100 <nmoves> <ntest>
sh tester.sh 500 default <ntest>
```
`<nmoves>` is the moves limits counter\
`<ntest>` is the total of test that it made
# `WARNING`
This script is made by me and frudello. See if and where it fails, understand what the testers tell's you.\
<a href="https://github.com/frudello">frudello</a>