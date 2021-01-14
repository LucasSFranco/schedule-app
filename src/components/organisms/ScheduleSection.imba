import Button from '#/atoms/Button'
import IconButton from '#/atoms/IconButton'
import SectionHeader from '#/molecules/SectionHeader'

import Captions from '~/Captions'
import Caption from '~/Caption'

import TimeIntervals from '~/TimeIntervals'
import TimeInterval from '~/TimeInterval'

tag ScheduleSection
	
	prop hours
	prop allNotDuplicatedCaptions = []
	prop caption
	prop captions = []
	prop timeInterval
	prop timeIntervals = []
	prop showCopyForm = false
	prop showDeleteButtons = false
	prop showAddForm = false
	prop selectedColor = null
	prop loading = true

	
	set date value
		#date = value
		caption = new Caption(date)
		showCopyForm = false
		showDeleteButtons = false
		showAddForm = false
		mount()

	get date
		#date

	def setup

		hours = []

		for i in [0 ... 24]
			let hour = new Date(0, 0, 0, i).toTimeString().substr(0, 5)
			hours.push(hour)

	def toggleShowCopyForm
		showCopyForm = !showCopyForm
		closeDeleteButtons()
		closeAddForm()

	def closeCopyForm
		showCopyForm = false

	def toggleShowDeleteButtons
		if captions.length
			showDeleteButtons = !showDeleteButtons
			closeAddForm()
			closeCopyForm()

	def closeDeleteButtons
		showDeleteButtons = false
	
	def toggleShowAddForm
		showAddForm = !showAddForm
		closeDeleteButtons()
		closeCopyForm()
		caption = new Caption(date)

	def closeAddForm
		showAddForm = false

	def autoSize e
		let textareaElement = e.target
		textareaElement.style.height = "auto"
		textareaElement.style.height = "{textareaElement.scrollHeight}px"

	def createCaption { color, description }
		if color and description
			caption.color = color
			caption.description = description
		unless caption.validate()
			await Captions.createCaption(caption)
			caption = new Caption(date)
			closeAddForm()
			await getCaptionsByDate()
			await getAllCaptions()
			render()

	def deleteCaption { id }
		console.log id
		await Captions.deleteCaption(id)
		await getCaptionsByDate()
		await getAllCaptions()
		unless captions.length
			closeDeleteButtons()
		render()
		
	def getCaptionsByDate
		captions = await Captions.getCaptionsByDate(date)

	def createTimeInterval timeIntervalId
		if selectedColor
			timeInterval = new TimeInterval(timeIntervalId, selectedColor, date)
			await TimeIntervals.createTimeInterval(timeInterval)
			await getTimeIntervals()
			render()
	
	def deleteTimeInterval { id }
		await TimeIntervals.deleteTimeInterval(id)
		await getTimeIntervals()
		render()

	def getTimeIntervals
		timeIntervals = await TimeIntervals.getTimeIntervals(date)

	def selectColor { color }
		if color === selectedColor
			selectedColor = null
		else
			selectedColor = color

	def getAllCaptions()
		allNotDuplicatedCaptions = await Captions.getAllCaptions()

	def mount
		loading = true
		await getCaptionsByDate()
		await getTimeIntervals()
		await getAllCaptions()
		loading = false
		imba.commit()
		render()

	def render
		<self> <div>
			<.caption>
				<SectionHeader size="sm">
					<.title> 'Caption'
					<div[d: flex]>
						<IconButton size="sm"
							color=(showAddForm ? "secondary" : "success")
							@click=toggleShowAddForm
						>
							<i.fas .fa-{showAddForm ? "times" : "plus-square"}>
						if allNotDuplicatedCaptions.length
							<IconButton size="sm"
								color=(showCopyForm ? "secondary" : "warning")
								@click=toggleShowCopyForm
							>
								<i.fas.fa-{showCopyForm ? "times" : "copy"}>
						<IconButton size="sm"
							color=(showDeleteButtons ? "secondary" : "danger")
							@click=toggleShowDeleteButtons
						>
							<i.fas.fa-{showDeleteButtons ? "times" : "trash-alt"}>
				<.container>
					if loading
						<.loading> <i.fas.fa-circle-notch.fa-spin>
					else
						if captions.length
							<.wrapper>
								for caption in captions
									<.row
										.selected=(selectedColor === caption.content.color)
										.show-delete=showDeleteButtons
									>
										<.color
											[bg: {caption.content.color}]
											@click=selectColor(caption.content)
										>
										<.description> caption.content.description
										<.delete>
											<i.fas.fa-times @click=deleteCaption(caption)>
						else
							<.message> 'There are no captions yet...'
					<.copy-form .show=showCopyForm>
						<.select>	
							<.scrollable-container>
								for uniqueCaption in allNotDuplicatedCaptions
									let selectedCaption = captions.find do |dateCaption|
										dateCaption.captionId === uniqueCaption.id
									if selectedCaption
										<.select-row.selected @click=deleteCaption(selectedCaption)>
											<.color[bg: {uniqueCaption.color}]>
											<.description> uniqueCaption.description
									else 
										<.select-row @click=createCaption(uniqueCaption)>
											<.color[bg: {uniqueCaption.color}]>
											<.description> uniqueCaption.description
					<.add-form .show=showAddForm>
						<.row>
							<input type="color" bind=caption.color>
							<textarea
								rows="1"
								placeholder="Write here a new caption..."
								@input=autoSize bind=caption.description
							>
						<Button color="success" size="sm" full
							@click=createCaption
						>
							<i.fas.fa-plus-square>
							'Add'
			<div[d: flex ml: 60px px: 15px bg: grey2 bd: grey4 bdb: none]> 
				for i in [10, 20, 30, 40, 50]
					<div[width: 30px height: 15px d: flex ai: center jc: center fs: .625rem c: grey5]> i
			<.table>
				let timeIntervalId = 0
				if loading
					<fragment>
						for hour in hours
							<.row>
								<.hour> hour
								for square in [1 .. 6]
									<.square>
				else
					<fragment>
						for hour in hours
							<.row>
								<.hour> hour
								for square in [1 .. 6]
									let timeInterval = timeIntervals.find do |timeInterval|
										timeInterval.timeIntervalId === timeIntervalId
									if timeInterval
										<.square
											[cursor: pointer bg: {timeInterval.color} o@hover: 1]
											@click=deleteTimeInterval(timeInterval)
										> 
									else
										<.square
											[o@hover: .5 bg@hover: {selectedColor}]
											[cursor: pointer]=selectedColor
											@click=createTimeInterval(timeIntervalId)
										> 
									timeIntervalId += 1
					
	css & > div
		display: flex
		flex-direction: column
		height: 100%
		padding: .5rem
		background: white
		overflow-y: auto
		.caption
			margin-bottom: .5rem	
			.container
				border: grey4
				border-top: none
				padding-top: .25rem
				.wrapper
					mb: .25rem
					.row
						display: flex
						padding: .25rem .5rem
						align-items: center
						position: relative
						color: grey5
						tween: 250ms
						&.selected
							bg: blue3/25
							c: grey6
							@after
								content: ''
								height: 100%
								position: absolute
								width: .25rem
								background: blue3
								right: 0
								top: 0
								opacity: 1
						.color
							background: red
							size: 20px
							tween: 150ms
							cursor: pointer
							@hover scale: 1.25
						.description
							lh: 20px
							user-select: text
							font-size: .875rem
							width: calc(100% - 28px)
							padding: 0 .25rem
							margin-left: .5rem
							@selection background: blue3 color: white
						.delete
							margin-left: .25rem
							font-size: .875rem
							display: none
							justify-content: center
							align-items: center
							tween: 250ms
							width: .875rem
							i
								cursor: pointer
								color: red4 @hover: red6
								tween: 250ms
						&.show-delete
							.description width: calc(100% - 46px)
							.delete display: flex
				.copy-form
					d: none
					&.show d: block
					.select 
						mx: .5rem
						mb: .5rem
						bd: grey4
						.scrollable-container
							overscroll-behavior: contain
							ofy: scroll
							height: 130px
							bg: white
							.select-row
								cursor: pointer
								d: flex
								px: .25rem
								py: .25rem
								tween: 250ms
								pos: relative
								c: grey5
								&.selected@after
									content: ''
									h: 100%
									pos: absolute
									w: .25rem
									bg: blue3
									r: 0
									t: 0
								@hover
									background: blue3/25
									color: grey6
								.color
									bg: blue
									size: 18px
								.description
									us: none
									fs: .7875rem
									pl: .25rem
									mx: .25rem
									width: calc(100% - 26px)
				.add-form
					display: none
					&.show display: block
					.row
						d: flex
						margin: 0 .5rem .5rem
						border-top: grey4
						padding-top: .5rem
						input[type="color"]
							margin-right: .5rem
							border: none
							size: 20px
							cursor: pointer
							outline: none
						input[type="color"]::-webkit-color-swatch-wrapper 
							padding: 0
						input[type="color"]::-webkit-color-swatch
							border: none
						textarea
							resize: none
							overflow: hidden
							outline: none
							width: calc(240px - 1.5rem - 22px)
							font-size: .875rem
							color: grey8 @placeholder: grey4
				.message
					color: grey5
					text-align: center
					padding-top: 10.5px
					padding-bottom: calc(.5rem + 10.5px)
					font-size: .875rem
				.loading
					font-size: 2rem
					text-align: center
					color: blue2
					margin-bottom: .5rem
		.table
			width: 242px 
			border: grey4
			.row
				display: flex	
				width: 100%
				@not(@first-of-type)
					.hour border-top: grey4 	
					.square border-top: grey2 	
				.hour
					display: flex
					align-items: center
					justify-content: center
					font-size: .875rem
					line-spacing: 2px
					background: blue1
					color: grey5
					width: 60px
					border-right: grey4
				.square
					o: .75
					size: 30px
					background: white
					tween: 250ms
					@not(@last-of-type) border-right: grey2

export default ScheduleSection