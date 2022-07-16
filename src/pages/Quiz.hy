context $version, $integrity, $base_url, $plausible_domain, $plausible_script_url, $contact_email, $pages
doctype
html lang="en"
	head
		meta charset="utf-8"
		link rel="icon" href="podcastquiz.ico"
		link rel="stylesheet" href="{$base_url}releases/{$version}/css/PodcastFont.css" integrity="{$integrity}" crossorigin="anonymous"
		link rel="stylesheet" href="{$base_url}index.css"
		link rel="stylesheet" href="{$base_url}podcastquiz.css"
		title | The Podcast Quiz
		meta name="viewport" content="width=device-width, initial-scale=1"
		meta id="meta-application-name" name="application-name" content="The Podcast Quiz"
		meta id="meta-description" name="description" content="The Podcast Quiz is based on The Podcast Font which provides all the icons you need for your podcast website, your podcast app or your podcast documents."
		meta id="meta-keywords" name="keywords" content="podcast quiz, quiz, game, podcast icons, icons, vector icons, svg icons, free icons, icon font, webfont, desktop icons, svg"
		meta id="meta-item-name" itemprop="name" content="The Podcast Quiz"
		meta id="meta-item-description" itemprop="description" content="The Podcast Quiz is based on The Podcast Font which provides all the icons you need for your podcast website, your podcast app or your podcast documents."
		meta id="meta-item-image" itemprop="image" content="{$base_url}podcastquiz-cover.jpg"
		meta id="twt-card" name="twitter:card" content="summary"
		meta id="twt-site" name="twitter:site" content="@podcastfont"
		meta id="twt-title" name="twitter:title" content="The Podcast Font"
		meta id="twt-description" name="twitter:description" content="The Podcast Quiz is based on The Podcast Font which provides all the icons you need for your podcast website, your podcast app or your podcast documents."
		meta id="twt-creator" name="twitter:creator" content="@podcastfont"
		meta id="twt-image" name="twitter:image" content="{$base_url}podcastquiz-cover.jpg"
		meta id="og-title" property="og:title" content="The Podcast Font"
		meta id="og-type" property="og:type" content="website"
		meta id="og-url" property="og:url" content="{$base_url}"
		meta id="og-image" property="og:image" content="{$base_url}podcastquiz-cover.jpg"
		meta id="og-description" property="og:description" content="The Podcast Quiz is based on The Podcast Font which provides all the icons you need for your podcast website, your podcast app or your podcast documents."
		script type="module" src="{$base_url}podcastquiz.js"
		if $plausible_script_url is not None:
			/ <script defer data-domain="$plausible_domain" src="$plausible_script_url"></script>
			! <script>window.plausible = window.plausible || function() { (window.plausible.q = window.plausible.q || []).push(arguments) }</script>
	body
		h1
			| The Podcast Quiz
			i .pi .pi-podcastquiz			
		p .introblock
			| You know everything about podcasting, but can you recognize these 5 logos?!
		p
			| A new quiz everyday, come back tomorrow!
		div id="loading"
			i .pi .pi-buffering
			| Generating quiz, please wait…
		div id="quiz"
		button id="submitButton"
			i .pi .pi-celebrate
			| Get results		
		pre id="results"
		button id="copyButton"
			i .pi .pi-reshare
			| Copy my score	
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