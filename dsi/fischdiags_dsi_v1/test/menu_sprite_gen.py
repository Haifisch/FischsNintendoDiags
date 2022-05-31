from PIL import Image
from PIL import ImageDraw
from PIL import ImageFont
import numpy
iconTitles = ["GFX", "SFX", "MEM", "FS", "CONTROLS", "WIRELESS", "POWER", "ABOUT"]

fontName = "IBMPlexMono-Regular.ttf"

	


def makeIcon(iconTitle, color):
	print("building icon image for \""+iconTitle+"\", color => "+color)
	# Open an Image
	img = Image.new('RGBA', (64, 64), color = 0xFF00FF)
	draw = ImageDraw.Draw(img)
	# Draw a rounded rectangle
	draw.rounded_rectangle((2, 0, 60, 60), fill=color, outline="black", width=2, radius=4)
	fontSize = 1
	font = ImageFont.truetype(fontName, fontSize)
	w, h = draw.textsize(iconTitle)
	print(w, h)
	while w < 64:
		fontSize = fontSize + 1
		font = ImageFont.truetype(fontName, fontSize)
		w, h = draw.textsize(iconTitle, font=font)
		print(w, h)
		#print("fontSize => "+str(fontSize))
	fontSize -= 4;
	print("ideal font size => "+str(fontSize))
	font = ImageFont.truetype(fontName, fontSize)
	w, h = draw.textsize(iconTitle, font=font)
	position = ((64-w)/2, (64-h)/2)
	draw.text((32,32), iconTitle, (255, 255, 255), anchor="mm", font=font)
	# Save the edited image
	
	return img

for iconTitle in iconTitles:
	left = makeIcon(iconTitle, "blue")
	right = makeIcon(iconTitle, "red")
	result = Image.new('RGBA', (128, 64))
	result.paste(im=left, box=(0, 0))
	result.paste(im=right, box=(64, 0))
	final = result.convert("P", colors=16)
	result.save("menu_"+iconTitle.lower()+"_btn.bmp")
