context $version, $integrity, $base_url, $plausible_domain, $plausible_script_url, $contact_email, $pages
doctype
html lang="en"
	head
		meta charset="utf-8"
		link rel="icon" href="favicon.ico"
		link rel="stylesheet" href="{$base_url}releases/{$version}/css/PodcastFont.css" integrity="{$integrity}" crossorigin="anonymous"
		link rel="stylesheet" href="{$base_url}index.css"
		title | Help
		meta name="viewport" content="width=device-width, initial-scale=1"
		meta id="meta-application-name" name="application-name" content="The Podcast Font"
		meta id="meta-description" name="description" content="The Podcast Font provides all the icons you need for your podcast website, your podcast app or your podcast documents."
		script type="module" src="{$base_url}podcastfont.js"
		if $plausible_script_url is not None:
			/ <script defer data-domain="$plausible_domain" src="$plausible_script_url"></script>
			! <script>window.plausible = window.plausible || function() { (window.plausible.q = window.plausible.q || []).push(arguments) }</script>		
	body
		h1
			| Help
			i .pi .pi-help
		p
			| The Podcast Font is the font you need for all your podcasts!
		h2 | Quick Start
		p
			| If you want to use the Podcast Font on your website, just add the following HTML code in the <head> section of your pages:
			span .code .tooltip data-type="clipboard" data-clipboard-content='<link rel="stylesheet" href="{$base_url}releases/$version/css/PodcastFont.css" integrity="$integrity" crossorigin="anonymous" />' data-clipboard-analytics='"Copy CSS"'
				| <link rel="stylesheet" href="{$base_url}releases/$version/css/PodcastFont.css" integrity="$integrity" crossorigin="anonymous" />
				span .tooltiptext | Click to copy code
			| Or you can import it in your own CSS:
			span .code .tooltip data-type="clipboard" data-clipboard-content="@import url('{$base_url}releases/{$version}/css/PodcastFont.css');" data-clipboard-analytics='"Copy CSS"'
				| <style>
				br
				|   @import url('{$base_url}releases/{$version}/css/PodcastFont.css');
				br
				| </style>
				span .tooltiptext | Click to copy code
			| Then copy the code of the icon you want to insert and past it into your HTML code.
			br
			| For instance:
			span class="code" | <i class="pi pi-castopodhost"></i>
		h2 | Self Hosting
		p
			| For privacy, security, reliability and liability issues, we strongly recommend that you host all the CSS and font files on your own website or CDN.
			br
			| In order to do so, just download 
			a href="{$base_url}package/podcastfont.zip" data-analytics='"Download Package"' | Podcastfont zip package
			|, unzip it on your server / CDN and update the CSS file URL in the <head> section of your pages accordingly.
		p
			| You can even build and self-host a mirror of this whole website, but the CSS and font files are enough.
		h2 | On your personal computer
		p
			| If you want to use the Podcast Font on your local computer, just download the  
			a href="{$base_url}package/podcastfont.zip" data-analytics='"Download Package"'
				| Podcast Font package
			| , unzip it and install the Podcast Font (either OTF or TTF) by double-clicking on the file.
			br
			| Then simply copy the glyph you need and paste it into your document.
		h2 | More info
		p
			| You will find more information at
			a href="https://blog.castopod.org/the-podcast-font/"
				| blog.castopod.org
			| .
		h2 | Quiz
		p
			| The
			a href="/Quiz.html"
				| Podcast Quiz
			| is a tiny game for testing your podcasting knowledge. Please spread the word if you like it!
		h2 | Feedback
		p
			| You may open an issue if you want to
			a href="https://code.castopod.org/adaures/podcastfont/-/issues/new?issue[title]=Icon request: icon-name&issue[description]=Please provide SVG file and all useful information here." target="_blank" data-analytics='"Contact",{{"props":{{"Via":"Gitlab"}}}}'
				| request an Icon
			|  or 
			a href="https://code.castopod.org/adaures/podcastfont/-/issues/new?issue[title]=Error reporting: icon-name&issue[description]=Please provide all useful information here." target="_blank" data-analytics='"Contact",{{"props":{{"Via":"Gitlab"}}}}'
				| report an error
			| .
		h2 | Source Code
		p
			| All source code used to generate this website is available for download.
			br
			| For more informations please go to 
			a href="https://code.castopod.org/adaures/podcastfont" | The Podcast Font GIT repository
			| .
		div .footer
			a href="/" | Home
			for page in $pages:
				| · 
				a href="$page['html']" | $page['title']
			| · 
			a href="https://code.castopod.org/adaures/podcastfont/-/issues/new?issue[title]=Icon request: icon-name&issue[description]=Please provide SVG file and all useful information here." target="_blank" data-analytics='"Contact",{{"props":{{"Via":"Gitlab"}}}}'
				| Request an Icon
			| · 
			if $contact_email is not None:
				a href="mailto:$contact_email" data-analytics='"Contact",{{"props":{{"Via":"E-mail"}}}}'
					| Contact us								
			span .right
				| Version $version
