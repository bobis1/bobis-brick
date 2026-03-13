import board
import digitalio
import analogio
import time
import usb_hid
from adafruit_hid.keyboard import Keyboard
from adafruit_hid.keycode import Keycode

# Initialize the HID keyboard
kbd = Keyboard(usb_hid.devices)

# --- Pin Setup Based on PCB Routing ---
# SW1=D4, SW4=D5, SW3=D6, SW2=D9
button_pins = [board.D4, board.D5, board.D6, board.D9]
# Map to your game's spells: Q, E, R, F
button_keys = [Keycode.Q, Keycode.E, Keycode.R, Keycode.F]

buttons = []
for pin in button_pins:
    btn = digitalio.DigitalInOut(pin)
    btn.direction = digitalio.Direction.INPUT
    btn.pull = digitalio.Pull.UP # Assuming switches pull to GND
    buttons.append(btn)

# Left Joystick (U3) mapped to A2 and A3
joy_y = analogio.AnalogIn(board.A2)
joy_x = analogio.AnalogIn(board.A3)

# Joystick Deadzones
# 16-bit analog values range from 0 to 65535. Center is ~32768.
THRESHOLD_LOW = 20000
THRESHOLD_HIGH = 45000

# Dictionary to track key states so we don't spam USB HID reports
key_states = {
    Keycode.W: False,
    Keycode.A: False,
    Keycode.D: False,
    Keycode.Q: False,
    Keycode.E: False,
    Keycode.R: False,
    Keycode.F: False,
}

def update_key(keycode, condition_is_met):
    """Presses or releases a key only when its state changes."""
    if condition_is_met and not key_states[keycode]:
        kbd.press(keycode)
        key_states[keycode] = True
    elif not condition_is_met and key_states[keycode]:
        kbd.release(keycode)
        key_states[keycode] = False

# --- Main Game Loop ---
while True:
    # 1. Read Switches (Active LOW, so 'not btn.value' means pressed)
    update_key(Keycode.Q, not buttons[0].value) # SW1
    update_key(Keycode.E, not buttons[1].value) # SW4
    update_key(Keycode.R, not buttons[2].value) # SW3
    update_key(Keycode.F, not buttons[3].value) # SW2

    # 2. Read Joystick
    x_val = joy_x.value
    y_val = joy_y.value

    # 3. Map X-Axis to A (Left) and D (Right)
    update_key(Keycode.A, x_val < THRESHOLD_LOW)
    update_key(Keycode.D, x_val > THRESHOLD_HIGH)

    # 4. Map Y-Axis to W (Jump)
    # Note: Depending on pot orientation, pushing UP might be < LOW or > HIGH. 
    # Swap the threshold here if pushing UP doesn't trigger the jump.
    update_key(Keycode.W, y_val < THRESHOLD_LOW)

    # Small delay to debounce and prevent CPU pegging
    time.sleep(0.01)