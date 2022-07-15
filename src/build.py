#!/usr/bin/python3

import csv, json, fontforge, sass, shutil, os, hypertag, hashlib, qrcode, qrcode.image.svg
from zipfile import ZipFile
from dotenv import load_dotenv
from datetime import datetime, timezone
from base64 import b64encode
from jsmin import jsmin
from urllib.parse import urlparse

def read_csv_file(csv_filename, font, glyphs=None):
	with open(csv_filename) as csv_file:
		csv_reader = csv.reader(csv_file, delimiter=';')
		for row in csv_reader:
			glyph_id,glyph_category,glyph_unicode,glyph_name,glyph_url,glyph_attributes=row
			svg_source_filename='svg/'+glyph_category+'/'+glyph_id+'.svg'
			shutil.copy2(svg_source_filename, '../web/'+svg_source_filename)
			glyph=font.createChar(int(glyph_unicode,base=16), glyph_id)
			glyph.importOutlines(svg_source_filename)
			if glyphs is not None:
				if glyph_attributes == '':
					glyph_attribute_array = []
				else:
					glyph_attribute_array = glyph_attributes.split(',')
				glyphs.append({"glyph_id": glyph_id, "glyph": chr(int(glyph_unicode, base=16)), "glyph_category":glyph_category, "glyph_unicode": glyph_unicode, "glyph_name": glyph_name, "glyph_url": glyph_url, "glyph_attributes": glyph_attribute_array, "glyph_box_attributes": ' '.join(map(lambda x: 'box-'+x, glyph_attribute_array))})


version = datetime.now(timezone.utc).strftime("%Y%m%d%H%M")
release_folder = '../web/releases/'+version

print('Building PodcastFont Version '+version+'…')

load_dotenv()
base_url = os.getenv('BASE_URL')
if base_url is None:
	base_url = ""
contact_email = os.getenv('CONTACT_EMAIL')
font_copyright = os.getenv('FONT_COPYRIGHT')
plausible_script_url = os.getenv('PLAUSIBLE_SCRIPT_URL')
plausible_domain = None
if plausible_script_url is not None:
	plausible_domain=urlparse(base_url).netloc

glyphs = []
font = fontforge.font()
font.encoding = 'UnicodeFull'
font.familyname = 'Podcast Font'
font.fontname = 'PodcastFont'
font.fullname = 'Podcast Font'
font.version = version
if font_copyright is not None:
	font.copyright = font_copyright

print('Generating QRcode SVG…')
qr = qrcode.QRCode(version=1, error_correction=qrcode.constants.ERROR_CORRECT_L, box_size=20, border=2, image_factory=qrcode.image.svg.SvgPathImage)
qr.add_data(version)
img = qr.make_image()
img.save('svg/misc/qrcode.svg')

print('Creating folders…')
os.makedirs('../web/svg/alphabet', exist_ok=True)
os.makedirs('../web/svg/directory', exist_ok=True)
os.makedirs('../web/svg/listener', exist_ok=True)
os.makedirs('../web/svg/misc', exist_ok=True)
os.makedirs('../web/svg/podcaster', exist_ok=True)
os.makedirs('../web/package', exist_ok=True)
os.makedirs(release_folder+'/fonts', exist_ok=True)
os.makedirs(release_folder+'/css', exist_ok=True)

print('Reading CSV files…')
read_csv_file('character-map/Alphabet.csv', font)
read_csv_file('character-map/PodcastFont.csv', font, glyphs)
read_csv_file('character-map/FontAwesome.csv', font, glyphs)
icons_map='$icons: ('+', '.join(map(lambda x: '"'+x['glyph_id']+'": "\\'+x['glyph_unicode']+'"', sorted(glyphs, key=lambda x: x['glyph_unicode'])))+');'
quizdata=list(map(lambda x: {'id': x['glyph_id'],'name': x['glyph_name']}, sorted(filter(lambda x: x['glyph_category']!='misc' or x['glyph_attributes'].count('podcasting20certifiedbadge')>0, glyphs), key=lambda x: x['glyph_id'])))


print('Building PodcastFont.css Cascading Style Sheets…')
icons_map_filename='IconsMap.scss'
with open(icons_map_filename, 'w') as icons_map_file:
	icons_map_file.write(icons_map)
css_string=sass.compile(filename='PodcastFont.scss', output_style='compressed')
with open(release_folder+'/css/PodcastFont.css', 'w') as css_file:
	css_file.write(css_string)
os.remove(icons_map_filename)

hash_object = hashlib.sha384(str(css_string).encode('utf-8'))
integrity='sha384-'+b64encode(hash_object.digest()).decode('utf-8')

pages=[]
for file in os.listdir("./pages"):
	if file.endswith(".hy"):
		key=os.path.splitext(file)[0]
		pages.append({"layout":file, "html": key+".html", "title": key.replace('_',' ')})

print('Building static index.html page…')
with open('index.hy') as layout_file:
	with open('../web/index.html', 'w') as html_file:
		html_file.write(hypertag.HyperHTML().render(layout_file.read(), version=version, integrity=integrity, base_url=base_url, plausible_domain=plausible_domain, plausible_script_url=plausible_script_url, contact_email=contact_email, pages=pages, glyphs=sorted(glyphs, key=lambda x: x['glyph_name'].lower())))

print('Writing quizdata.json…')
with open('../web/quizdata.json', 'w') as quiz_js_file:
	json.dump(quizdata, quiz_js_file)

print('Minifying podcastquiz.js…')
with open('podcastquiz.js') as js_file:
    minified_js = jsmin(js_file.read())
    with open('../web/podcastquiz.js', 'w') as minified_js_file:
      minified_js_file.write(minified_js)

print('Minifying podcastfont.js…')
with open('podcastfont.js') as js_file:
    minified_js = jsmin(js_file.read())
    with open('../web/podcastfont.js', 'w') as minified_js_file:
      minified_js_file.write(minified_js)

for page in pages:
	print('Building static "'+page['title']+'" page…')
	with open("./pages/"+page['layout']) as page_file:
		with open('../web/'+page['html'], 'w') as html_file:
			html_file.write(hypertag.HyperHTML().render(page_file.read(), version=version, integrity=integrity, base_url=base_url, plausible_domain=plausible_domain, plausible_script_url=plausible_script_url, contact_email=contact_email, pages=pages))

print('Generating OTF font file…')
font.generate(release_folder+'/fonts/PodcastFont.otf')
print('Generating TTF font file…')
font.generate(release_folder+'/fonts/PodcastFont.ttf')
print('Generating WOFF font file…')
font.generate(release_folder+'/fonts/PodcastFont.woff')
print('Generating WOFF2 font file…')
font.generate(release_folder+'/fonts/PodcastFont.woff2')

with open('version.txt', 'w') as version_file:
	version_file.write(version+"\n"+base_url)

print('Generating ZIP package file…')
with ZipFile('../web/package/podcastfont.zip', 'w') as zipObj:
   zipObj.write('../OFL.txt','OFL.TXT')	
   zipObj.write(release_folder+'/css/PodcastFont.css','css/PodcastFont.css')
   zipObj.write(release_folder+'/fonts/PodcastFont.otf','fonts/PodcastFont.otf')
   zipObj.write(release_folder+'/fonts/PodcastFont.ttf','fonts/PodcastFont.ttf')
   zipObj.write(release_folder+'/fonts/PodcastFont.woff','fonts/PodcastFont.woff')
   zipObj.write(release_folder+'/fonts/PodcastFont.woff2','fonts/PodcastFont.woff2')
   zipObj.write('version.txt','version.txt') 

os.remove('version.txt')

print('Done.')
