# Quick Installation Guide - Tetris for Agon Light 2

## What You Need
- Agon Light 2 microcomputer with latest firmware
- SD card (4GB+ recommended, FAT32 formatted)
- VGA monitor
- PS/2 or USB keyboard

## Step-by-Step Installation

### 1. Prepare Your SD Card
- Format your SD card as FAT32 if not already done
- Copy `tetris.bas` to the root directory of your SD card

### 2. Optional: Auto-Start Setup
If you want Tetris to automatically start when you boot your Agon:
- Rename `autorun.txt` to `autoexec.txt`
- Copy it to the root directory of your SD card

### 3. Boot Your Agon
- Insert the SD card into your Agon Light 2
- Connect your monitor and keyboard  
- Power on the Agon
- Wait for it to boot to the BBC BASIC prompt

### 4. Manual Loading (if not using autoexec.txt)
At the BBC BASIC prompt, type:
```
LOAD "tetris.bas"
RUN
```

### 5. Start Playing!
- Use arrow keys or WASD to control pieces
- Space bar for hard drop
- P to pause
- ESC to quit

## Troubleshooting

### Problem: "Bad program" error
**Solution**: Ensure you have the latest Agon firmware (MOS 2.10.1+ and VDP 2.3.1+)

### Problem: File not found
**Solution**: 
- Check that `tetris.bas` is in the SD card root directory
- Verify the SD card is properly inserted
- Try: `*DIR` to list files and confirm the file is there

### Problem: Graphics look wrong
**Solution**: 
- Type `MODE 8` before loading the game
- Check your VGA monitor connection
- Ensure you're using a compatible monitor

### Problem: No sound
**Solution**:
- Check audio cable connections
- Verify volume settings on your monitor/speakers
- Sound is optional - game will work without it

## File Structure
Your SD card should look like this:
```
/
├── tetris.bas         (required - the game)
├── autoexec.txt       (optional - auto-start)
└── (other files...)
```

## Firmware Requirements
- **MOS (Operating System)**: 2.10.1 or newer
- **VDP (Video/Audio Processor)**: 2.3.1 or newer

Check your firmware version by typing `*HELP` at the BBC BASIC prompt.

## Getting Help
If you need more help:
1. Check the main README.md file
2. Visit the Agon Light community forums
3. Ensure your hardware setup matches the requirements

---

**Have fun playing Tetris on your retro computer!**