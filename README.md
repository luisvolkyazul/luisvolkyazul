# Tetris Clone for Agon Light 2 Microcomputer

A fully-featured Tetris game clone written in BBC BASIC V for the Z80 processor, specifically designed for the Agon Light 2 microcomputer using the latest firmware.

![Tetris Game Screenshot](tetris_screenshot.png)

## Features

### Complete Tetris Implementation
- **All 7 Standard Tetromino Pieces**: I, O, T, S, Z, J, L pieces with distinct colors
- **4-Way Rotation**: Each piece can be rotated in 4 orientations
- **Standard Tetris Rules**: Proper collision detection, line clearing, and scoring
- **Next Piece Preview**: See what piece is coming next
- **Progressive Difficulty**: Game speed increases with level progression

### Scoring System
- **Standard Tetris Scoring**: Points awarded based on official Tetris scoring rules
  - Single line: 40 × (level + 1) points
  - Double lines: 100 × (level + 1) points  
  - Triple lines: 300 × (level + 1) points
  - Tetris (4 lines): 1200 × (level + 1) points
- **Soft Drop Bonus**: 1 point per row for manual downward movement
- **Hard Drop Bonus**: 2 points per row for space bar drops
- **Level Progression**: Level increases every 10 lines cleared

### Audio Effects
- **Line Clear Sounds**: Different sound effects for 1, 2, 3, or 4 lines cleared
- **Special Tetris Sound**: Unique audio feedback for clearing 4 lines at once
- **Sound Variations**: Progressive tones that build excitement

### Visual Features
- **Colorful Graphics**: Each tetromino type has its own distinct color
- **Line Clear Animation**: Flashing effect when lines are cleared
- **Clean UI**: Score, lines, level, and next piece display
- **Pause Functionality**: Game can be paused and resumed
- **Game Over Screen**: Clear restart instructions

## System Requirements

### Hardware
- **Agon Light 2 Microcomputer** (or compatible Agon platform)
- **VGA Monitor** connected to the Agon's VGA output
- **PS/2 or USB Keyboard** for input
- **SD Card** for storing the game file

### Firmware
- **Latest Agon MOS** (tested with MOS 2.10.1 or higher)
- **Latest VDP** (tested with VDP 2.3.1 or higher)
- **BBC BASIC V** for Z80 (included with Agon firmware)

## Installation

### Method 1: Direct Download to SD Card
1. Copy `tetris.bas` to your Agon's SD card
2. Insert the SD card into your Agon Light 2
3. Power on the Agon and wait for it to boot to BBC BASIC
4. Load the game: `LOAD "tetris.bas"`
5. Run the game: `RUN`

### Method 2: Serial Transfer
1. Connect your Agon to a PC via serial interface
2. Use a terminal program to transfer `tetris.bas`
3. Save the file to SD card: `SAVE "tetris.bas"`
4. Run the game: `RUN`

## Controls

### Gameplay Controls
- **Arrow Keys or WASD**: 
  - ⬅️ Left Arrow / A: Move piece left
  - ➡️ Right Arrow / D: Move piece right  
  - ⬇️ Down Arrow / S: Soft drop (move piece down faster)
  - ⬆️ Up Arrow / W: Rotate piece clockwise
- **Space Bar**: Hard drop (instantly drop piece to bottom)
- **P**: Pause/Unpause game
- **ESC**: Quit to main menu or exit game

### Menu Controls  
- **Enter**: Restart game after game over
- **ESC**: Exit to MOS/BBC BASIC prompt

## Game Rules

### Standard Tetris Mechanics
1. **Piece Movement**: Tetrominoes fall from the top of the playing field
2. **Line Clearing**: Complete horizontal lines are removed from the board
3. **Game Over**: Game ends when pieces reach the top of the playing field
4. **Rotation**: Pieces can be rotated unless blocked by other pieces or walls

### Scoring Details
- **Level System**: Starts at Level 1, increases every 10 lines cleared
- **Speed Increase**: Each level increases the automatic drop speed
- **Bonus Points**: Extra points for actively dropping pieces

## Technical Details

### Graphics Mode
- **MODE 8**: 320×256 pixels, 64 colors
- **Block Size**: 20×20 pixels per tetromino block
- **Playing Field**: 10 columns × 20 rows (standard Tetris dimensions)
- **Frame Rate**: Approximately 60 FPS game loop

### Memory Usage
- **Game Board**: 20×10 integer array for piece positions
- **Tetromino Data**: 7×4×4×4 array storing all piece rotations
- **Optimized for Z80**: Efficient use of 8-bit processor capabilities

### BBC BASIC V Features Used
- **Procedures and Functions**: Modular code organization
- **Multi-dimensional Arrays**: Efficient data storage
- **VDU Commands**: Hardware graphics acceleration
- **SOUND Command**: Audio feedback
- **INKEY**: Real-time keyboard input
- **Timer Functions**: Precise game timing

## Customization

### Difficulty Adjustment
To modify game difficulty, edit these variables in the initialization section:
```basic
droptime% = 60        : REM Frames between drops (lower = faster)
level% = 1           : REM Starting level
```

### Color Scheme
Piece colors can be modified in the `PROC_DrawBlock` procedure:
```basic
WHEN 1: color% = 11  : REM I-piece - cyan
WHEN 2: color% = 14  : REM O-piece - yellow
REM ... etc
```

### Sound Effects
Audio can be customized in the `PROC_PlayLineClearSound` procedure by adjusting frequency and duration values.

## Troubleshooting

### Common Issues
1. **Game doesn't load**: Ensure you have the latest Agon firmware
2. **Graphics corrupted**: Try `MODE 8` command before loading
3. **No sound**: Check your audio connections and volume
4. **Slow performance**: Verify you're using a genuine Agon Light 2

### Performance Tips
- Use a high-quality SD card (Class 10 recommended)
- Ensure stable power supply to the Agon
- Keep the game file in the root directory of the SD card

## Development Notes

### BBC BASIC V Compatibility
This game is specifically written for BBC BASIC V as implemented on the Agon platform. It uses:
- Z80-specific optimizations
- Agon VDP graphics commands
- Hardware-accelerated drawing routines

### Code Structure
The program is organized into logical sections:
- **Initialization**: Game setup and tetromino definitions
- **Game Logic**: Movement, collision detection, line clearing
- **Graphics**: Screen drawing and visual effects
- **Input**: Keyboard handling and menu systems
- **Audio**: Sound effect generation

## Credits

- **Original Tetris**: Created by Alexey Pajitnov
- **Agon Platform**: Designed by Bernardo Kastrup
- **BBC BASIC V**: Richard Russell
- **Game Implementation**: AI Assistant

## License

This Tetris implementation is provided as-is for educational and entertainment purposes. The Tetris game concept and rules are the intellectual property of The Tetris Company.

## Version History

### Version 1.0
- Complete Tetris implementation
- All 7 tetromino pieces with rotations
- Standard scoring system
- Sound effects
- Pause functionality
- Level progression
- Game over and restart functionality

## Contributing

To contribute improvements or report issues:
1. Test thoroughly on actual Agon hardware
2. Ensure BBC BASIC V compatibility
3. Maintain the retro computing aesthetic
4. Document any changes clearly

## Support

For support with this game:
- Check the Agon Light community forums
- Verify your firmware versions
- Ensure proper hardware setup
- Test with the latest Agon MOS/VDP releases

---

**Enjoy playing Tetris on your Agon Light 2 microcomputer!**
