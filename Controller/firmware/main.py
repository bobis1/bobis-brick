# You import all the IOs of your board
import board
import analogio
from kmk.modules.mouse_keys import MouseKeys


# These are imports from the kmk library
from kmk.kmk_keyboard import KMKKeyboard
from kmk.scanners.keypad import KeysScanner
from kmk.keys import KC
from kmk.modules.macros import Press, Release, Tap, Macros
# This is the main instance of your keyboard
keyboard = KMKKeyboard()
keyboard.modules.append(MouseKeys())
# Add the macro extension
macros = Macros()
keyboard.modules.append(macros)

# Define your pins here!
PINS = [board.D3, board.D4, board.D2, board.D1, board.A0]

H1 = analogio.AnalogIn(A0)
V1 = analogio.AnalogIn(A1)
H2 = analogio.AnalogIn(A2)
V2 = analogio.AnalogIn(A3)

# Tell kmk we are not using a key matrix
keyboard.matrix = KeysScanner(
    pins=PINS,
    value_when_pressed=False,
)

# Here you define the buttons corresponding to the pins
# Look here for keycodes: https://github.com/KMKfw/kmk_firmware/blob/main/docs/en/keycodes.md
# And here for macros: https://github.com/KMKfw/kmk_firmware/blob/main/docs/en/macros.md
keyboard.keymap = [
    [KC.Q, KC.E, KC.R, KC.F,]
]

if H1.value > 0:
    keyboard.keymap[0].append(KC.D)
elif H1.value < 0:
    keyboard.keymap[0].append(KC.A)

if V1 != 0:
    keyboard.keymap[0].append(KC.W)


if H2.value > 0:
    keyboard.keymap[0].append(KC.RIGHT)
elif H2 < 0:
    keyboard.keymap[0].append(KC.LEFT)

if V2.value > 0:
    keyboard.keymap[0].append(KC.UP)
elif V2.value < 0:
    keyboard.keymap.append(KC.DOWN)

# Start kmk!
if __name__ == '__main__':
    keyboard.go()