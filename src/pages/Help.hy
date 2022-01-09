context $version, $integrity, $base_url, $contact_email, $pages
doctype
html lang="en"
	head
		meta charset="utf-8"
		link rel="icon" href="favicon.ico"
		link rel="stylesheet" href="{$base_url}releases/{$version}/css/PodcastFont.css" integrity="{$integrity}" crossorigin="anonymous"
		link rel="stylesheet" href="{$base_url}index.css"
		title | Help
		meta id="meta-application-name" name="application-name" content="The Podcast Font"
		meta id="meta-description" name="description" content="The Podcast Font provides all the icons you need for your podcast website, your podcast app or your podcast documents."
	body
		h1 | Help
		p
			| The Podcast Font is the font you need for all your podcasts!
		h2 | Quick Start
		p
			| If you want to use the Podcast Font on your website, just add the following HTML code in the <head> section of your pages:
			span .code | <link rel="stylesheet" href="{$base_url}releases/$version/css/PodcastFont.css" integrity="$integrity" crossorigin="anonymous" />
			| Or you can import it in your own CSS:
			span .code
				| <style>
				br
				|   @import url('{$base_url}releases/{$version}/css/PodcastFont.css');
				br
				| </style>
			| Then copy the code of the icon you want to insert and past it into your HTML code.
			br
			| For instance:
			span class="code" | <i class="pi pi-castopodhost"></i>
		h2 | Self Hosting
		p
			| For privacy, security, reliability and liability issues, we strongly recommend that you host all the CSS and font files on your own website or CDN.
			br
			| In order to do so, just download 
			a href="{$base_url}package/podcastfont.zip" | Podcastfont zip package
			|, unzip it on your server / CDN and update the CSS file URL in the <head> section of your pages accordingly.
		p
			| You can even build and self-host a mirror of this whole website, but the CSS and font files are enough.
		h2 | On your personal computer
		p
			| If you want to use the Podcast Font on your local computer, just download the  
			a href="{$base_url}package/podcastfont.zip" 
				| Podcast Font package
			| , unzip it and install the Podcast Font (either OTF or TTF) by double-clicking on the file.
			br
			| Then simply copy the glyph you need and paste it into your document.
		h2 | More info
		p
			| You will find more information at
			a href="https://podlibre.org/the-podcast-font/"
				| podlibre.org
			| .
		h2 | Feedback
		p
			| You may open an issue if you want to
			a href="https://code.podlibre.org/podlibre/podcastfont/-/issues/new?issue[title]=Icon request: icon-name&issue[description]=Please provide SVG file and all useful information here." target="_blank"
				| request an Icon
			|  or 
			a href="https://code.podlibre.org/podlibre/podcastfont/-/issues/new?issue[title]=Error reporting: icon-name&issue[description]=Please provide all useful information here." target="_blank"
				| report an error
			| .
		h2 | Source Code
		p
			| All source code used to generate this website is available for download.
			br
			| For more informations please go to 
			a href="https://code.podlibre.org/podlibre/podcastfont" | The Podcast Font GIT repository
			| .
		div .footer
			a href="/" | Home
			for page in $pages:
				| · 
				a href="$page['html']" | $page['title']
			| · 
			a href="https://code.podlibre.org/podlibre/podcastfont/-/issues/new?issue[title]=Icon request: icon-name&issue[description]=Please provide SVG file and all useful information here." target="_blank"
				| Request an Icon
			| · 
			if $contact_email is not None:
				a href="mailto:$contact_email"
					| Contact us								
			span .right
				| Version $version
