#!/usr/bin/python3

import csv, fontforge, sass, shutil, os, hypertag
from zipfile import ZipFile
from dotenv import load_dotenv
from datetime import datetime, timezone

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

print('Building PodcastFont…')

load_dotenv()
base_url = os.getenv('BASE_URL')
if base_url is None:
	base_url = ""

contact_email = os.getenv('CONTACT_EMAIL')

version = "Version " + datetime.now(timezone.utc).strftime("%Y%m%d%H%M%S")

glyphs = []
font = fontforge.font()
font.encoding = 'UnicodeFull'
font.familyname = 'Podcast Font'
font.fontname = 'PodcastFont'
font.fullname = 'Podcast Font'
font.copyright = '(cc by-sa) Ad Aures - PodcastFont.com'

print('Creating folders…')
os.makedirs('../web/fonts', exist_ok=True)
os.makedirs('../web/svg/alphabet', exist_ok=True)
os.makedirs('../web/svg/directory', exist_ok=True)
os.makedirs('../web/svg/listener', exist_ok=True)
os.makedirs('../web/svg/misc', exist_ok=True)
os.makedirs('../web/svg/podcaster', exist_ok=True)
os.makedirs('../web/package', exist_ok=True)

print('Reading CSV files…')
read_csv_file('character-map/Alphabet.csv', font)
read_csv_file('character-map/PodcastFont.csv', font, glyphs)
read_csv_file('character-map/FontAwesome.csv', font, glyphs)
icons_map='$icons: ('+', '.join(map(lambda x: '"'+x['glyph_id']+'": "\\'+x['glyph_unicode']+'"', sorted(glyphs, key=lambda x: x['glyph_unicode'])))+');'

pages=[]
for file in os.listdir("./pages"):
	if file.endswith(".hy"):
		key=os.path.splitext(file)[0]
		pages.append({"layout":file, "html": key+".html", "title": key.replace('_',' ')})

print('Building static index.html page…')
with open('index.hy') as layout_file:
	with open('../web/index.html', 'w') as html_file:
		html_file.write(hypertag.HyperHTML().render(layout_file.read(), version=version, base_url=base_url, contact_email=contact_email, pages=pages, glyphs=sorted(glyphs, key=lambda x: x['glyph_name'].lower())))
	
for page in pages:
	print('Building static "'+page['title']+'" page…')
	with open("./pages/"+page['layout']) as page_file:
		with open('../web/'+page['html'], 'w') as html_file:
			html_file.write(hypertag.HyperHTML().render(page_file.read(), version=version, base_url=base_url, contact_email=contact_email, pages=pages))

print('Building PodcastFont.css Cascading Style Sheets…')
icons_map_filename='IconsMap.scss'
with open(icons_map_filename, 'w') as icons_map_file:
	icons_map_file.write(icons_map)
css_string=sass.compile(filename='PodcastFont.scss', output_style='nested')
with open('../web/css/PodcastFont.css', 'w') as css_file:
	css_file.write(css_string)
os.remove(icons_map_filename)

print('Generating OTF font file…')
font.generate('../web/fonts/PodcastFont.otf')
print('Generating TTF font file…')
font.generate('../web/fonts/PodcastFont.ttf')
print('Generating WOFF font file…')
font.generate('../web/fonts/PodcastFont.woff')
print('Generating WOFF2 font file…')
font.generate('../web/fonts/PodcastFont.woff2')

with open('version.txt', 'w') as version_file:
	version_file.write(version+"\n"+base_url)

print('Generating ZIP package file…')
with ZipFile('../web/package/podcastfont.zip', 'w') as zipObj:
   zipObj.write('../OFL.txt','OFL.TXT')	
   zipObj.write('../web/css/PodcastFont.css','css/PodcastFont.css')
   zipObj.write('../web/fonts/PodcastFont.otf','fonts/PodcastFont.otf')
   zipObj.write('../web/fonts/PodcastFont.ttf','fonts/PodcastFont.ttf')
   zipObj.write('../web/fonts/PodcastFont.woff','fonts/PodcastFont.woff')
   zipObj.write('../web/fonts/PodcastFont.woff2','fonts/PodcastFont.woff2')
   zipObj.write('version.txt','version.txt') 

os.remove('version.txt')

print('Done.')
