#!/bin/bash

# ── Colour scheme ──────────────────────────────────────────────────────────
# ONE file, Josean-style. Uncomment exactly ONE scheme block, then reload:
#     sketchybar --reload
#     pkill -x borders && /opt/homebrew/bin/borders &
# These four colours drive the bar AND the window borders (bordersrc sources
# this file). Ghostty and everything drawn INSIDE the terminal stay on Mocha
# by design — only the bar and the border follow what you pick here.

# ── Oscura Midnight ─────────────────────────────────────────────────────────
# export BAR_COLOR=0xff050508
# export ITEM_BG_COLOR=0xff232323
# export ACCENT_COLOR=0xff54c0a3
# export BORDER_INACTIVE=0xff2c2c31

# ── Catppuccin Mocha ◀ ACTIVE ───────────────────────────────────────────────
export BAR_COLOR=0xff181825
export ITEM_BG_COLOR=0xff313244
export ACCENT_COLOR=0xffcba6f7
export BORDER_INACTIVE=0xff45475a

# ── Josean: Teal ───────────────────────────────────────────────────────────
# export BAR_COLOR=0xff001f30
# export ITEM_BG_COLOR=0xff003547
# export ACCENT_COLOR=0xff2cf9ed
# export BORDER_INACTIVE=0xff0f6b72

# ── Josean: Gray ───────────────────────────────────────────────────────────
# export BAR_COLOR=0xff101314
# export ITEM_BG_COLOR=0xff353c3f
# export ACCENT_COLOR=0xffffffff
# export BORDER_INACTIVE=0xff646666

# ── Josean: Purple ─────────────────────────────────────────────────────────
# export BAR_COLOR=0xff140c42
# export ITEM_BG_COLOR=0xff2b1c84
# export ACCENT_COLOR=0xffeb46f9
# export BORDER_INACTIVE=0xff5f2082

# ── Josean: Red ────────────────────────────────────────────────────────────
# export BAR_COLOR=0xff23090e
# export ITEM_BG_COLOR=0xff591221
# export ACCENT_COLOR=0xffff2453
# export BORDER_INACTIVE=0xff701226

# ── Josean: Blue ───────────────────────────────────────────────────────────
# export BAR_COLOR=0xff021254
# export ITEM_BG_COLOR=0xff093aa8
# export ACCENT_COLOR=0xff15bdf9
# export BORDER_INACTIVE=0xff094e8e

# ── Josean: Green ──────────────────────────────────────────────────────────
# export BAR_COLOR=0xff003315
# export ITEM_BG_COLOR=0xff008c39
# export ACCENT_COLOR=0xff1dfca1
# export BORDER_INACTIVE=0xff0a7946

# ── Josean: Orange ─────────────────────────────────────────────────────────
# export BAR_COLOR=0xff381c02
# export ITEM_BG_COLOR=0xff99440a
# export ACCENT_COLOR=0xfff97716
# export BORDER_INACTIVE=0xff7c3c09

# ── Josean: Yellow ─────────────────────────────────────────────────────────
# export BAR_COLOR=0xff2d2b02
# export ITEM_BG_COLOR=0xff8e7e0a
# export ACCENT_COLOR=0xfff7fc17
# export BORDER_INACTIVE=0xff747409

# ── Text + status colours (fixed, Mocha) ───────────────────────────────────
# Not part of the switchable schemes — these are the read colours the bar
# items use for labels and status glyphs. Left on Mocha so text stays legible
# against the dark bar regardless of which accent is active.
export WHITE=0xffcdd6f4   # primary text
export SUBTEXT=0xffbac2de # secondary text
export RED=0xfff38ba8
export GREEN=0xffa6e3a1
export YELLOW=0xfff9e2af

# ── Icons (Nerd Font / Font Awesome range) ────────────────────────
# ── Icons (Nerd Font / Font Awesome) ─────────────────────────────────
# Deliberately literal UTF-8 bytes: $ escapes would NOT be decoded by /bin/sh.

export ICON_SEPARATOR=
export ICON_CALENDAR=
export ICON_VOL_HIGH=
export ICON_VOL_MED=
export ICON_VOL_LOW=
export ICON_VOL_MUTE=
export ICON_BAT_FULL=
export ICON_BAT_3Q=
export ICON_BAT_HALF=
export ICON_BAT_1Q=
export ICON_BAT_EMPTY=
export ICON_BAT_CHARGING=
export ICON_CPU=
export ICON_MUSIC=
