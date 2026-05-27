from PIL import Image, ImageDraw, ImageFont

# Load the original image
img = Image.open("match_me_splash.png").convert("RGB")
bg_color = (240, 242, 244)
text_color = (0, 82, 0)

# Crop the logo (X: 0-226, Y: 74-437)
logo = img.crop((0, 74, 226, 437))

# Resize the logo to be larger for a high-res output (scale by 4x)
scale = 4
logo_large = logo.resize((logo.width * scale, logo.height * scale), Image.Resampling.LANCZOS)

# Create a new square canvas (1800x1800 is great for profile pictures)
canvas_size = 1800
canvas = Image.new("RGB", (canvas_size, canvas_size), bg_color)

# Calculate positions to center everything vertically
# Total height = logo height + gap + text height
gap = 60
font_size = 100
font = ImageFont.truetype("/System/Library/Fonts/Supplemental/Arial Bold.ttf", font_size)

# Since getbbox or getsize might be needed, we can use an alternative
draw = ImageDraw.Draw(canvas)
text = "SPORTS MATCHING"

# For Pillow >= 8.0.0
left, top, right, bottom = draw.textbbox((0, 0), text, font=font)
text_width = right - left
text_height = bottom - top

total_content_height = logo_large.height + gap + text_height

start_y = (canvas_size - total_content_height) // 2

# Paste the logo
logo_x = (canvas_size - logo_large.width) // 2
canvas.paste(logo_large, (logo_x, start_y))

# Draw the text
text_x = (canvas_size - text_width) // 2
text_y = start_y + logo_large.height + gap

draw.text((text_x, text_y), text, fill=text_color, font=font)

# Save the exact replica
canvas.save("/Users/teerasaksupavaha/.gemini/antigravity/brain/0dc05a10-5c81-4402-a87c-df99d17ae015/sports_matching_exact.png", quality=100)
print("Saved exact replica to sports_matching_exact.png")
