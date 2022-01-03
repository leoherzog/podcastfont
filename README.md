# The Podcast Font ![Podcast Font](https://podcastfont.com/svg/podcaster/podcastfont.svg)

This project contains the source code for the [podcastfont.com](https://podcastfont.com/) website.  
It was designed as a 100% static website so that it can be easily cached by CDNs. 

If you need help *using* the website, please go to [podcastfont.com help page](https://podcastfont.com/Help.html).

## Licenses
This project is licensed under the [GNU Affero General Public License](https://www.gnu.org/licenses/agpl-3.0.en.html).

The generated font files are licensed under the [SIL Open Font License (OFL) ](https://scripts.sil.org/OFL).

## Feedback

You may open an issue if you want to [request an Icon](https://code.podlibre.org/podlibre/podcastfont/-/issues/new?issue[title]=Icon%20request:%20icon-name&issue[description]=Please%20provide%20SVG%20file%20and%20all%20useful%20information%20here.) or [report an error](https://code.podlibre.org/podlibre/podcastfont/-/issues/new?issue[title]=Error%20reporting:%20icon-name&issue[description]=Please%20provide%20all%20useful%20information%20here.).

## Generate the website

- Clone this repository,

```
$ git clone https://code.podlibre.org/podlibre/podcastfont.git
```

- Copy the `.env.example` file to `.env` and customize the values according to your needs,

```
# Edit this file, save it to .env, then rebuild the website.
BASE_URL=https://domain-name.tld/
CONTACT_EMAIL=name@domain-name.tld
```

- Create and/or edit `.hy` pages in  the `src/pages/` folder,
- go to the `src/` folder and run the `build.py` script,

```
src$ ./build.py 
Building PodcastFont…
Creating folders…
Reading CSV files…
Building static index.html page…
Building static "Help" page…
Building static "Legal Notice" page…
Building PodcastFont.css Cascading Style Sheets…
Generating OTF font file…
Generating TTF font file…
Generating WOFF font file…
Generating WOFF2 font file…
Compressed 71015 to 45697.
Generating ZIP package file…
Done.
```

- Upload the content of the `web/` folder to your web server.

## Requirements

- [python3-fontforge](https://fontforge.org/docs/scripting/python.html) (generates the font files),
- [python3-dotenv](https://pypi.org/project/python-dotenv/) (reads `.env` parameters),
- [hypertag-lang](http://hypertag.io/) (builds the HTML files),
- [libsass](https://pypi.org/project/libsass/) (builds the CSS files).

## Adding new glyphs

If you want to add new glyphs on your forked version, you jast have to:

- Create an SVG file and store it in the `src/svg/` folder,
- Add it to a CSV file inside the `character-map/` folder.  
The CSV file is `;` separated.  
Columns are:
  - `glyph_id`: must be unique, also the name of the SVG file (without `.svg` extension),
  - `glyph_category`: the category for this glyph, also the sub-folder name for SVG file,
  - `glyph_unicode`: the Unicode Hex number for this glyph,
  - `glyph_name`: the long name for this glyph,
  - `glyph_url`: if there is a website talking about this glyph, put it here,
  - `glyph_attributes`: attributes for this glyph (`,` separated)

Example:

| glyph_id | glyph_category | glyph_unicode | glyph_name | glyph_url | glyph_attributes |
| ------ | ------ | ------ | ------ | ------ | ------ |
| castopod | podcaster | eb06 | Castopod | https://castopod.org/ | podcasting20certifiedbadge,opensource |
| podcastindex | directory | eb51 | Podcast Index | https://podcastindex.org/ | podcasting20certifiedbadge,opensource |
| podnews | directory | eb52 | Podnews | https://podnews.net/ | podcasting20certifiedbadge |
| podcastaddict | listener | eb39 | Podcast Addict | https://podcastaddict.com/ | podcasting20certifiedbadge |

Note that there are several CSV files in the `character-map/` folder:

- `Alphabet.csv`: defines the usual characters “ABC…”
- `PodcastFont.csv`: defines the glyphs specific to the Podcast Font,
- `FontAwesome.csv`: defines the glyphs which already have a Unicode number at FontAwesome.com, so that we use the same Unicode number (but the SVG is different) and we avoid having the same glyph with different codes for different fonts.  
For Instance the `Apple Podcast` glyph is `f2ce` for both Podcast Font and FontAwesome, so if you switch from one font to the other you may get a slightly different icon but it will always represent the Apple Podcast icon.


