require 'Network'
require 'Observers/**/*'

class window.Facebook extends Network
	# Network name.
	network:   "Facebook"

	# List of observers.
	observers: []

	constructor: ->
		# Add observers.
		@observers.push new FacebookLikeObserver()
		@observers.push new FacebookPageLikeObserver()
		@observers.push new FacebookShareObserver()
		@observers.push new FacebookUpdateStatusObserver()
		@observers.push new FacebookUpdateStatusPictureObserver()
		@observers.push new FacebookFriendAcceptObserver()
		@observers.push new FacebookFriendIgnoreObserver()
		@observers.push new FacebookFriendAddObserver()
		@observers.push new FacebookUnfriendObserver()
		@observers.push new FacebookDeleteStatusObserver()
		@observers.push new FacebookChatTurnedOffObserver()
		@observers.push new FacebookChatActivatedObserver()
		@observers.push new FacebookHideActivityObserver()

	isOnNetwork: ->
		(window.location + "").indexOf("facebook.com") >= 0

	integrateIntoDOM: ->
		# Comment Status Observer.
		@integrateCommentStatusObserver()

		# Chat Submit Button Observer.
		@integrateChatSubmitButtonObserver()

		# Chat Textarea Observer.
		@integrateChatTextareaObserver()

	integrateCommentStatusObserver: ->
		# Get network name.
		name = @getNetworkName()

		# Set identifier.
		identifier = "textarea.UFIAddCommentInput"

		# Find all elements.
		$(identifier).each ->
			# Skip if already integrated.
			return if $(this).hasClass("rose-integrated")

			# Add integration class.
			$(this).addClass("rose-integrated")

			# Add event handler.
			$(this).on "keydown", (e) ->
				if e.which == 13 || e.keyCode == 13
					# Get comment text.
					content = $(this).val()

					# Get container.
					container = "status"
					if $(this).parents(".timelineUnitContainer").length
						container = "timeline"

					# Get Facebook like observer.
					likeObserver = new FacebookLikeObserver()

					# Get result of like observer.
					result = likeObserver.handleNode(this, container)

					if not result['found']
						return

					# Create interaction.
					interaction = {
						'type': 'commentstatus',
						'target': result['record']['object'],
						'object': {
							'type': "comment",
							'owner': FacebookUtilities.getUserID(),
							'id': content
						}
					}

					# Save interaction.
					Storage.addInteraction(interaction, name)

	integrateChatTextareaObserver: ->
		# Get network name.
		name = @getNetworkName()

		# Set identifier.
		identifier = ".fbDockChatTabFlyout textarea.uiTextareaAutogrow, #pagelet_web_messenger textarea"

		# Find all elements.
		$(identifier).each ->
			# Skip if already integrated.
			return if $(this).hasClass("rose-integrated")

			# Add integration class.
			$(this).addClass("rose-integrated")

			# Add event handler.
			$(this).on "keydown", (e) ->
				if e.which == 13 || e.keyCode == 13
					# Get recipient.
					recipient = DOM.findRelative $(this), {
						"#pagelet_web_messenger": "#webMessengerHeaderName",
						".fbDockChatTabFlyout":   "a.titlebarText"
					}

					# Strig tags.
					recipient = Utilities.stripTags(recipient) if recipient

					# Create interaction.
					interaction = {
						'type': 'chat',
						'object': {
							'type': 'message',
							'recipient': recipient
						},
						'proband': FacebookUtilities.getUserID()
					}

					# Save interaction.
					Storage.addInteraction(interaction, name)

	integrateChatSubmitButtonObserver: ->
		# Get network name.
		name = @getNetworkName()

		# Set identifier.
		identifier = "#pagelet_web_messenger .uiButtonConfirm input, div[role=dialog] button[type=submit]"

		# Find all elements.
		$(identifier).each ->
			# Skip if already integrated.
			return if $(this).hasClass("rose-integrated")

			# Add integration class.
			$(this).addClass("rose-integrated")

			# Add event handler.
			$(this).on "click", (e) ->
				# Get recipient.
				recipient = DOM.findRelative $(this), "#pagelet_web_messenger": "#webMessengerHeaderName"

				# Strig tags.
				recipient = Utilities.stripTags(recipient) if recipient

				# Create interaction.
				interaction = {
					'type': 'chat',
					'object': {
						'type': 'message',
						'recipient': recipient
					},
					'proband':       FacebookUtilities.getUserID()
				}

				# Save interaction.
				Storage.addInteraction(interaction, name)

	getNetworkName: ->
		@network