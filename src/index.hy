context $version, $integrity, $base_url, $plausible_domain, $plausible_script_url, $matomo_domain, $matomo_id, $contact_email, $pages, $glyphs
doctype
html lang="en"
	head
		meta charset="utf-8"
		link rel="icon" href="favicon.ico"
		link rel="stylesheet" href="{$base_url}releases/{$version}/css/PodcastFont.css" integrity="{$integrity}" crossorigin="anonymous"
		link rel="stylesheet" href="{$base_url}index.css"		
		title | The Podcast Font
		meta name="viewport" content="width=device-width, initial-scale=1"
		meta id="meta-application-name" name="application-name" content="The Podcast Font"
		meta id="meta-description" name="description" content="The Podcast Font provides all the icons you need for your podcast website, your podcast app or your podcast documents."
		meta id="meta-keywords" name="keywords" content="podcast icons, icons, vector icons, svg icons, free icons, icon font, webfont, desktop icons, svg"
		meta id="meta-item-name" itemprop="name" content="The Podcast Font"
		meta id="meta-item-description" itemprop="description" content="The Podcast Font provides all the icons you need for your podcast website, your podcast app or your podcast documents."
		meta id="meta-item-image" itemprop="image" content="{$base_url}podcastfont-cover.jpg"
		meta id="twt-card" name="twitter:card" content="summary"
		meta id="twt-site" name="twitter:site" content="@podcastfont"
		meta id="twt-title" name="twitter:title" content="The Podcast Font"
		meta id="twt-description" name="twitter:description" content="The Podcast Font provides all the icons you need for your podcast website, your podcast app or your podcast documents."
		meta id="twt-creator" name="twitter:creator" content="@podcastfont"
		meta id="twt-image" name="twitter:image" content="{$base_url}podcastfont-cover.jpg"
		meta id="og-title" property="og:title" content="The Podcast Font"
		meta id="og-type" property="og:type" content="website"
		meta id="og-url" property="og:url" content="{$base_url}"
		meta id="og-image" property="og:image" content="{$base_url}podcastfont-cover.jpg"
		meta id="og-description" property="og:description" content="The Podcast Font provides all the icons you need for your podcast website, your podcast app or your podcast documents."
		script type="module" src="{$base_url}podcastfont.js"
		if $plausible_script_url is not None:
			/ <script defer data-domain="$plausible_domain" src="$plausible_script_url"></script>
			! <script>window.plausible = window.plausible || function() { (window.plausible.q = window.plausible.q || []).push(arguments) }</script>
		if $matomo_domain is not None:
			script
				/ var _paq = window._paq = window._paq || [];
				/ _paq.push(["setDoNotTrack", true]);
				/ _paq.push(["disableCookies"]);
				/ _paq.push(['trackPageView']);
				/ _paq.push(['enableLinkTracking']);
				/ (function() {{ 
				/ 	var u="//$matomo_domain/";_paq.push(['setTrackerUrl', u+'matomo.php']);
				/ 	_paq.push(['setSiteId', '$matomo_id']);
				/ 	var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
				/ 	g.async=true; g.src=u+'matomo.js';
				/ 	s.parentNode.insertBefore(g,s); 
				/ }})();
	body
		if $matomo_domain is not None:
			/ <noscript><p><img src="//$matomo_domain/matomo.php?idsite=$matomo_id&amp;rec=1" style="border:0;" alt="" /></p></noscript>
		h1
			| The Podcast Font
			i .pi .pi-podcastfont
		div .help
			a href="Help.html"
				i .pi .pi-help
				| Help!
			| ·
			a href="package/podcastfont.zip" data-analytics='"Download Package"' data-track-content='""'
				i .pi .pi-download
				| Download				
		form action="javascript:void(0);"
			i .pi .pi-filter
			label for="filter" | Filter: 
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
				div class="box box-$glyph['glyph_category'] $glyph['glyph_box_attributes']" id="$glyph["glyph_unicode"].lower() $glyph['glyph_name'].lower()"
					span .glyph-unicode .tooltip data-type="clipboard" data-clipboard-content="$glyph["glyph_unicode"]" data-clipboard-analytics='"Glyphs",  {{"props":{{"Category":"$glyph['glyph_category']","Action":"Copy Unicode"}}}}'
						| $glyph["glyph_unicode"]
						span .tooltiptext | Click to copy $glyph["glyph_name"] Unicode value
					span .right
						for attribute in $glyph["glyph_attributes"]:
							i class="pi pi-$attribute icon-badge"
						i class="pi pi-$glyph["glyph_category"] icon-category"	
					h2 .glyph-name
						| $glyph['glyph_name']
						i .pi .pi-link .tooltip data-type="clipboard" data-clipboard-content="{$base_url}#$glyph["glyph_unicode"]" data-clipboard-analytics='"Glyphs",  {{"props":{{"Category":"$glyph['glyph_category']","Action":"Copy URL"}}}}'
							span .tooltiptext | Click to copy link to $glyph["glyph_name"]
					span .glyph-code .tooltip data-type="clipboard" data-clipboard-content='<i class="pi pi-{$glyph['glyph_id']}"></i>' data-clipboard-analytics='"Glyphs",  {{"props":{{"Category":"$glyph['glyph_category']","Action":"Copy HTML"}}}}'
						| <i class="pi pi-$glyph['glyph_id']"></i>
						span .tooltiptext | Click to copy $glyph["glyph_name"] HTML code
					span .glyph
						i class="pi pi-$glyph['glyph_id'] tooltip" data-type="clipboard" data-clipboard-content="$glyph['glyph']" data-clipboard-analytics='"Glyphs",  {{"props":{{"Category":"$glyph['glyph_category']","Action":"Copy Glyph"}}}}'
							span class="tooltiptext" | Click to copy $glyph["glyph_name"] glyph
					if $glyph['glyph_url']:
						span .glyph-link
							a href="$glyph['glyph_url']" target="_blank" rel="nofollow noopener" title="Click to open $glyph['glyph_url']" data-analytics='"Glyphs",  {{"props":{{"Category":"$glyph['glyph_category']","Action":"Open website"}}}}' data-track-content='""'
								i .pi .pi-external-link
					span .glyph-download
						a href="./svg/{$glyph['glyph_category']}/{$glyph['glyph_id']}.svg" title="Right-click “Save link as…” to download $glyph["glyph_name"] SVG file" data-analytics='"Glyphs",  {{"props":{{"Category":"$glyph['glyph_category']","Action":"Download SVG"}}}}' data-track-content='""'
							i .pi .pi-download
		div .footer
			a href="/" | Home
			for page in $pages:
				| · 
				a href="$page['html']" | $page['title']
			| · 
			a href="https://code.castopod.org/adaures/podcastfont/-/issues/new?issue[title]=Icon request: icon-name&issue[description]=Please provide SVG file and all useful information here." target="_blank" data-analytics='"Contact",{{"props":{{"Via":"Gitlab"}}}}' data-track-content='""'
				| Request an Icon
			| · 
			if $contact_email is not None:
				a href="mailto:$contact_email" data-analytics='"Contact",{{"props":{{"Via":"E-mail"}}}}' data-track-content='""'
					| Contact us								
			span .right
				| Version $version