context $version, $base_url, $contact_email, $pages, $glyphs

html
	head
		meta charset="utf-8"
		meta name="description" content="Podcast Font provides all the icons you need for your podcast!"
		link rel="icon" href="favicon.ico"
		link rel="stylesheet" href="{$base_url}css/PodcastFont.css"
		link rel="stylesheet" href="{$base_url}css/index.css"
		script type="module" src="{$base_url}js/podcastfont.js"
		title | The Podcast Font
	body
		h1 | The Podcast Font 
		div .help
			a href="Help.html"
				i .pi .pi-help
				| Help!
			| ·
			a href="package/podcastfont.zip"
				i .pi .pi-download
				| Download				
		form
			i .pi .pi-search
			| Filter: 
			input .filter #filter type="text"
			| ⋮ 
			span .nowrap
				input type="checkbox" #podcasting20certified
				label for="podcasting20certified"
					| Podcasting 2.0
					i class="pi pi-podcasting20certifiedbadge"
			| ⋮ 
			span .nowrap
				input type="checkbox" #opensource
				label for="opensource"
					| Open-Source
					i class="pi pi-opensource"
			| ⋮ 
			span .nowrap
				input type="checkbox" #listener
				label for="listener"
					| For listeners
					i class="pi pi-listener"
			| ·
			span .nowrap
				input type="checkbox" #podcaster
				label for="podcaster"
					| For podcasters
					i class="pi pi-podcaster"
			| · 
			span .nowrap
				input type="checkbox" #directory
				label for="directory"
					| Directories
					i class="pi pi-directory"				
			| · 
			span .nowrap
				input type="checkbox" #misc
				label for="misc"
					| Miscellaneous
					i class="pi pi-misc"	
		div .boxes
			for glyph in $glyphs:
				div class="box box-$glyph['glyph_category'] $glyph['glyph_box_attributes']" id="$glyph['glyph_name'].lower()"
					span .glyph-unicode .tooltip data-type="clipboard" data-clipboard-content="$glyph["glyph_unicode"]"
						| $glyph["glyph_unicode"]
						span .tooltiptext | Click to copy $glyph["glyph_name"] Unicode value
					span .right
						for attribute in $glyph["glyph_attributes"]:
							i class="pi pi-$attribute icon-badge"
						i class="pi pi-$glyph["glyph_category"] icon-category"	
					h2 .glyph-name
						| $glyph['glyph_name']
					span .glyph-code .tooltip data-type="clipboard" data-clipboard-content='<i class="pi pi-{$glyph['glyph_id']}"></i>'
						| <i class="pi pi-$glyph['glyph_id']"></i>
						span .tooltiptext | Click to copy $glyph["glyph_name"] HTML code
					span .glyph
						i class="pi pi-$glyph['glyph_id'] tooltip" data-type="clipboard" data-clipboard-content="$glyph['glyph']"
							span class="tooltiptext" | Click to copy $glyph["glyph_name"] glyph
					if $glyph['glyph_url']:
						span .glyph-link
							a .tooltip href="$glyph['glyph_url']" target="_blank" rel="nofollow noopener"
								i .pi .pi-external-link .tooltip
								span .tooltiptext | Click to open $glyph['glyph_url']
					span .glyph-download
						a .tooltip href="./svg/{$glyph['glyph_category']}/{$glyph['glyph_id']}.svg"
							i .pi .pi-download
							span .tooltiptext | Right-click “Save link as…” to download $glyph["glyph_name"] SVG file

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
				| $version