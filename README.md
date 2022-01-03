# The Podcast Font ![Podcast Font](https://podcastfont.com/svg/podcaster/podcastfont.svg)

This project contains the source code for the [podcastfont.com](https://podcastfont.com/) website.  
It was designed as a 100% static website so that it can be easily cached by CDNs. 

If you need help *using* the website, please go to [podcastfont.com help page](https://podcastfont.com/Help.html).

## To generate the website:

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
- go to the `src/` folder and run the `build.py` script.

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

## Requirements:

- [python3-fontforge](https://fontforge.org/docs/scripting/python.html) (generates the font files),
- [python3-dotenv](https://pypi.org/project/python-dotenv/) (reads `.env` parameters),
- [hypertag-lang](http://hypertag.io/) (builds the HTML file),
- [libsass](https://pypi.org/project/libsass/) (builds the CSS files).
