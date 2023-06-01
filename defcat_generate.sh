#!/bin/bash

files=("INCAR" "POTCAR" "KPOINTS")
missing_files=()

for file in "${files[@]}"; do
  if [ ! -f "$file" ]; then
    missing_files+=("$file")
  fi
done

if [ ${#missing_files[@]} -gt 0 ]; then
  echo "The following required files are missing:"
  for missing_file in "${missing_files[@]}"; do
    echo "  - $missing_file"
  done
  exit 1
else
  echo "All required files are present."
fi

for dir in */*; do
  if [ -d "$dir" ]; then
    case "$dir" in
      *"/Unperturbed"*|*"/Rattled"*|*"%"*)
        echo "Copying files to $dir"
        for file in "${files[@]}"; do
          cp "$file" "$dir"
        done
        ;;
    esac
  fi
done


echo "Files successfully copied to the specified subdirectories."

modify_INCAR() {
  keyword="$1"
  value="$2"
  subdir="$3"

  find "$subdir" -type f -name 'INCAR' -print0 | while IFS= read -r -d $'\0' file; do
    sed -i -E "s/([[:space:]]*${keyword}[[:space:]]*=[[:space:]]*)([^[:space:]]+)/\1${value}/" "$file"
    echo "Modified $file: Set ${keyword} to ${value}"
  done
}

read -p "Enter NELECT_baseline (integer) for the neutral charge state: " nelect_baseline

if ! [[ "$nelect_baseline" =~ ^[0-9]+$ ]]; then
  echo "Invalid input. Please enter an integer value for NELECT_baseline."
  exit 1
fi

for d in ./*; do
  if [ -d "$d" ]; then
    subdir_num="${d##*_}"
    new_nelect=$((nelect_baseline - subdir_num))
    modify_INCAR "NELECT" "$new_nelect" "$d"
  fi
done

