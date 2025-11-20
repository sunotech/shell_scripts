#!/bin/bash

# Usage: ./reduce_pdf_size.sh input.pdf [output.pdf]

# Check if Ghostscript is installed
if ! command -v gs >/dev/null 2>&1; then
  echo "Ghostscript (gs) is not installed."
  echo "To install on macOS: brew install ghostscript"
  echo "To install on Ubuntu/Debian: sudo apt-get install ghostscript"
  echo "To install on Arch: sudo pacman -S ghostscript"
  exit 1
fi

# Check for input parameter
if [ -z "$1" ]; then
  echo "Usage: $0 input.pdf [output.pdf]"
  exit 1
fi

input="$1"
echo "Input filename: $1" 
echo "Output filename: $2"

if [ -n "$2" ]; then
  output="$2"
else
  base="${input%.*}"
  ext="${input##*.}"
  output="${base}.reduced.${ext}"
fi

gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen \
   -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$output" "$input"

echo "Reduced PDF saved as: $output"