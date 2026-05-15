# Agonpad — User Guide

Agonpad is a simple text editor for your Agon Light 2 microcomputer, written in BBC BASIC. It lets you write notes, jot down ideas, or scribble code — right on the retro hardware, no frills attached.

## Getting Started

Make sure `agonpad.bas` is on your SD card. From BBC BASIC, just type:

```basic
CHAIN "agonpad.bas"
```

The editor will start with a clean screen, ready for typing. You'll see the current time and "AGONPAD" in the top bar.

## Writing Text

Just start typing. Characters appear at the cursor position. When you reach the end of a line, press **Enter** to start a new one.

The editor holds up to 100 lines, each up to 79 characters wide.

## Controls

| Key | What it does |
|---|---|
| **Type anything** | Inserts text at the cursor |
| **Enter** | Starts a new line |
| **Backspace** | Deletes the character before the cursor |
| **Ctrl + S** | Saves your work to `AGONPAD.TXT` |
| **Ctrl + Q** | Quits the editor |

## Saving Your Work

Press **Ctrl + S** at any time. Your text is saved to a file called `AGONPAD.TXT` on your SD card. You'll see a "SAVED!" confirmation flash in the top bar so you know it worked.

## Quitting

Press **Ctrl + Q** to exit. The screen clears and you're back in BBC BASIC, ready for your next adventure.

## Example Session

```
CHAIN "agonpad.bas"

  (type)   Grocery list
  (Enter)
  (type)   - Milk
  (Enter)
  (type)   - Eggs
  (Enter)
  (type)   - Bread
  (Ctrl + S)   (see "SAVED!" appear)
  (Ctrl + Q)   (back at BASIC prompt)
```

After quitting, `AGONPAD.TXT` will contain:

```
Grocery list
- Milk
- Eggs
- Bread
```

## Tips

- The clock updates every few seconds — handy for keeping track of time.
- If the screen fills up, older lines scroll away to make room for new ones.
- Everything is saved as plain text, so you can read it on any computer.

## What It Can't Do (Yet)

Agonpad is deliberately simple. There's no cursor keys, no insert mode, no search, and no file loading. Think of it as a digital notepad — great for quick notes, not for writing the next great novel. If you need more, the source is all there waiting to be tinkered with.
