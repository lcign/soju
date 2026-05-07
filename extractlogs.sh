#!/bin/bash

DB="$1"
OUTDIR="$2"

# ----------------------------
# CHECK PARAMETRI OBBLIGATORI
# ----------------------------
if [ -z "$DB" ] || [ -z "$OUTDIR" ]; then
    echo "Usage: $0 database.sqlite output_folder"
    exit 1
fi

# ----------------------------
# CHECK FILE DB
# ----------------------------
if [ ! -f "$DB" ]; then
    echo "Error: file $DB non found"
    exit 1
fi

# ----------------------------
# VALIDAZIONE PATH OUTPUT
# ----------------------------
if [ "$OUTDIR" = "/" ] || [ "$OUTDIR" = "." ] || [ -z "$OUTDIR" ]; then
    echo "Error: invalid directory ($OUTDIR)"
    exit 1
fi

# ----------------------------
# GESTIONE CARTELLA ESISTENTE
# ----------------------------
if [ -d "$OUTDIR" ]; then
    echo "Directory '$OUTDIR' already exists!"

    read -p "Vuoi cancellarla e rigenerare i log? (s/n): " answer

    case "$answer" in
        s|S|y|Y)
            echo "Removing directory $OUTDIR..."
            rm -rf -- "$OUTDIR"
            ;;
        *)
            echo "Operation cancelled."
            exit 0
            ;;
    esac
fi

mkdir -p "$OUTDIR"

echo "Database: $DB"
echo "Output: $OUTDIR"

# ----------------------------
# ELABORAZIONE SQLITE → FILE
# ----------------------------
sqlite3 -noheader -separator $'\t' "$DB" \
"SELECT raw, time, sender, text FROM message;" | \
awk -F'\t' -v dir="$OUTDIR" '
{
    raw=$1
    time=$2
    sender=$3
    text=$4

    # filtro PRIVMSG #
    if (index(raw, "PRIVMSG #") == 0) next

    # estrazione canale
    split(raw, a, "#")
    split(a[2], b, " ")
    channel = b[1]

    file = dir "/" channel ".txt"

    # parsing timestamp ISO 8601
    date = time
    sub(/T.*/, "", date)

    t = time
    sub(/.*T/, "", t)
    sub(/\..*/, "", t)

    formatted = date " - [" t "] -"

    print formatted, sender, text >> file
}
'

echo "Files generated in: $OUTDIR"