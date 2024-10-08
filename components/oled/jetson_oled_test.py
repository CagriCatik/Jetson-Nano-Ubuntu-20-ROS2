import time
import busio
import digitalio
import board
import adafruit_ssd1306
from PIL import Image, ImageDraw, ImageFont

# Initialize I2C bus (you may need to adjust this depending on your Jetson's I2C bus number)
# The most common I2C bus on Jetson Nano is i2c-1
i2c = busio.I2C(board.SCL, board.SDA)

# Define reset pin (set to None if not used)
reset_pin = digitalio.DigitalInOut(board.D4)  # Change if necessary

# Initialize the SSD1306 display (128x64 resolution is common, adjust if necessary)
oled = adafruit_ssd1306.SSD1306_I2C(128, 64, i2c, reset=reset_pin)

# Clear the display
oled.fill(0)
oled.show()

# Create a blank image for drawing
image = Image.new('1', (oled.width, oled.height))

# Create a drawing object
draw = ImageDraw.Draw(image)

# Draw a black filled box to clear the image
draw.rectangle((0, 0, oled.width, oled.height), outline=0, fill=0)

# Load a font
font = ImageFont.load_default()

# Define some text to display
text = "Hello, Jetson OLED!"

# Get text size
(width, height) = draw.textsize(text, font=font)

# Calculate the position of the text
text_x = (oled.width - width) // 2
text_y = (oled.height - height) // 2

# Draw the text
draw.text((text_x, text_y), text, font=font, fill=255)

# Display image
oled.image(image)
oled.show()

# Keep the display on for a while
time.sleep(5)

# Clear the display again before exiting
oled.fill(0)
oled.show()
