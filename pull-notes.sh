# pull notes
chmod u+rx scripts/note
chmod u+rx scripts/notesync
curdir=$(pwd)
cd ~
git clone git@github.com:brenmous/notes .notes
cd "$curdir"
