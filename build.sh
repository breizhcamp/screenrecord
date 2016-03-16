#!/bin/bash -eu
set -o pipefail

# MacOS... just sucks
HERE="$(cd -P "$(dirname "${BASH_SOURCE[0]}" )" && pwd)"

DIST="$HERE"
TMP="$HERE/tmp"

download() {
  local url=$1; shift
  local target=$1; shift
  local sha1sum=$1; shift

  local fulltarget="$TMP/$target"
  if [[ -r "$fulltarget" ]]; then
    echo "$sha1sum $fulltarget" | sha1sum -c - && return
    echo "Checksum mismatch, downloading again"
    rm "$fulltarget"
  fi

  echo "Downloading '$url'"
  curl -fL "$url" -o "$fulltarget" && echo "$sha1sum $fulltarget" | sha1sum -c -
}

mkdir -p "$DIST/arch/osx64" "$DIST/arch/win32" "$DIST/arch/linux64"

mkdir -p "$TMP"

# OSX
if [[ ! -r "$DIST/arch/osx64/ffmpeg" ]]; then
  download "https://github.com/breizhcamp/ffmpeg-binaries/raw/34d1ed4cb14d713536a1e5e0d78e9036258f557d/osx64/ffmpeg" ffmpeg-3.0-osx 41d36ebaaf168c533f456fc95dd067cf6e3daf58
  cp "$TMP/ffmpeg-3.0-osx" "$DIST/arch/osx64/ffmpeg"
  chmod +x "$DIST/arch/osx64/ffmpeg"
fi

# Win32
if [[ ! -r "$DIST/arch/win32/VLCPortable" ]]; then
  download "http://files.framakey.org/stable/main/apps/VLCPortable_2.1.3-fr-r01.fmk.zip" VLCPortable_2.1.3-fr-r01.fmk.zip 1adcf0229a75decada2b9409c1424d57dfe54112
  unzip "$TMP/VLCPortable_2.1.3-fr-r01.fmk.zip" -d "$DIST/arch/win32"
fi

# Linux64
if [[ ! -r "$DIST/arch/linux64/ffmpeg" ]]; then
  download "http://johnvansickle.com/ffmpeg/releases/ffmpeg-release-64bit-static.tar.xz" ffmpeg-3.0-linux64.tar.xz 3bba9db5a0fb12f8b31884cefb69f0bf1c10cb99
  xzcat "$TMP/ffmpeg-3.0-linux64.tar.xz" | tar --strip-component=1 -xf - -C "$DIST/arch/linux64" ffmpeg-3.0-64bit-static/ffmpeg
fi
