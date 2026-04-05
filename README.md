# macEyeDo

A macOS menu bar app that combines a pair of animated eyes with a lightweight calendar and todo list.

The eyes follow your mouse cursor and blink naturally — and they turn red when you have unfinished tasks, with intensity indicating urgency: the closer the deadline, the redder the eyes.

## Features

- **Animated eyes** in the menu bar, inspired by the classic Unix `xeyes`
- **Calendar** with ISO week numbers, always showing the current month on open
- **Todo list** — click any day to add, check off, or delete items
- **Urgency indicator** — eye whites shift from white to red based on how soon the nearest open todo is due (today = full red, 4 days away = faint tint)
- Days with open todos are marked with a subtle dot; past days with unfinished items show a red dot

## Installation

### Requirements

- macOS 13 or later
- Xcode Command Line Tools (`xcode-select --install`)

### Build from source

```bash
git clone https://github.com/SN0371/macEyeDo.git
cd macEyeDo
swift build -c release
```

### Run

```bash
.build/release/maceyedo &
```

The eyes appear in your menu bar immediately. Left-click to open the calendar, right-click to quit.

### Run at login (optional)

```bash
cp .build/release/maceyedo /usr/local/bin/maceyedo
```

Then go to **System Settings → General → Login Items** and add the `maceyedo` binary.
