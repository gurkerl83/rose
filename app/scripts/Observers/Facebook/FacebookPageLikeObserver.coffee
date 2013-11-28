class window.FacebookPageLikeObserver
	getIntegrationPatterns: ->
		[".PageLikeButton input[type=submit]"]

	getEventType: ->
		"click"

	getData: (obj) ->
		# Get name of page.
		page = $("#fbProfileCover").find("span[itemprop=name]").html()
		page = Utilities.hash(page)
		
		return {
			'page': oage,
			'type': 'pagelike'
		}
	
	getObserverType: ->
		"classic"