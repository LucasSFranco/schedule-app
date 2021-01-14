tag HeaderSelect

	prop selectedOption
	prop options = []
	prop showDropdown = false

	def changeSelectedOption newSelectedOption
		emit('select', newSelectedOption)

	def toggleShowDropdown
		showDropdown = !showDropdown
		if showDropdown
			scrollToSelectedOption()

	def closeDropdown
		showDropdown = false

	def scrollToSelectedOption
		setTimeout(&, 0) do
			$scrollableContainerElement.scrollTop = $selectedOptionElement.offsetTop - 8
		render()

	def mount
		window.addEventListener('click', &) do |e|
			if self != e.target.closest('.select')
				closeDropdown()
				render()

	def render
		<self.select .show-dropdown=showDropdown>
			<.input @click=toggleShowDropdown> selectedOption
			<.dropdown>
				<$scrollableContainerElement.scrollable-container>
					for option in options
						if option === selectedOption
							<$selectedOptionElement.option.selected> option
						else
							<.option @click=changeSelectedOption(option)> option

	css &
		color: white
		position: relative
		font-size: 1rem
		.input
			padding: .25rem .75rem
			cursor: pointer
			text-transform: uppercase
			background@hover: blue5
			border-radius: sm
			tween: 250ms
		.dropdown
			top: calc(100% + 5px)
			left: 50% 
			x: -50%
			position: absolute
			box-shadow: lg
			padding: .5rem 0
			background: grey1
			border-radius: sm
			display: none
			z-index: 10
			.scrollable-container
				max-height: calc(25px * 5)
				overflow-y: auto
				scroll-behavior: smooth
				.option
					tween: 250ms
					color: grey8
					font-size: .875rem
					padding: .25rem 1rem
					cursor: pointer
					background@hover: blue3
					&.selected
						background: blue4
						cursor: default
		&.show-dropdown
			.input
				color: grey5
				box-shadow: lg
				background: grey1
			.dropdown
				display: block

export default HeaderSelect