import HeaderSelect from '#/atoms/HeaderSelect'
import IconButton from '#/atoms/IconButton'

tag Header

	prop formattedDays
	prop formattedMonths
	prop formattedYears

	set date value
		#date = value
		emit('dateChange', value)
		setup()

	get date
		#date

	def setup
		getFormattedDays()
		getFormattedMonths()	
		getFormattedYears()

	def getMonthLastDayIndex otherDate=date
		new Date(otherDate.getFullYear(), otherDate.getMonth() + 1, 0).getDate()

	def getFormattedDays
		formattedDays = []
		let monthLastDayIndex = getMonthLastDayIndex()
		for dayIndex in [1 .. monthLastDayIndex]
			let formattedDay = new Date(0, 0, dayIndex)
				.toDateString()
				.substr(8, 2)
			formattedDays.push(formattedDay)

	def getFormattedMonths
		formattedMonths = [
			'January'
			'February'
			'March'
			'April'
			'May'
			'June'
			'July'
			'August'
			'September'
			'October'
			'November'
			'December'
		]

	def getFormattedYears
		formattedYears = []
		for yearIndex in [1900 .. 2100]
			let formattedYear = yearIndex.toString()
			formattedYears.push(formattedYear)

	def getDayIndex
		date.getDate()

	def getMonthIndex
		date.getMonth()

	def getYearIndex
		date.getFullYear()

	def getFormattedDay
		formattedDays[date.getDate() - 1]

	def getFormattedMonth
		formattedMonths[date.getMonth()]

	def getFormattedYear
		formattedYears[date.getFullYear() - 1900]	

	def prevDay
		date = new Date(getYearIndex(), getMonthIndex(), getDayIndex() - 1)

	def nextDay
		date = new Date(getYearIndex(), getMonthIndex(), getDayIndex() + 1)

	def changeDay e
		let selectedFormattedDay = e.detail
		let dayIndex = formattedDays.findIndex(do |formattedDay|
			formattedDay === selectedFormattedDay
		) + 1
		date = new Date(getYearIndex(), getMonthIndex(), dayIndex)

	def changeMonth e
		let selectedFormattedMonth = e.detail
		let monthIndex = formattedMonths.findIndex(do |formattedMonth|
			formattedMonth === selectedFormattedMonth
		)
		let newDate = new Date(getYearIndex(), monthIndex, 1)
		let selectedDay = getDayIndex()
		let newDateLastDayIndex = getMonthLastDayIndex(newDate)
		if selectedDay > newDateLastDayIndex
			newDate.setDate(newDateLastDayIndex)
		else
			newDate.setDate(selectedDay)
		date = newDate

	def changeYear e
		let selectedFormattedYear = e.detail
		let yearIndex = formattedYears.findIndex(do |formattedYear|
			formattedYear === selectedFormattedYear
		) + 1900
		let newDate = new Date(yearIndex, getMonthIndex(), 1)
		let selectedDay = getDayIndex()
		let newDateLastDayIndex = getMonthLastDayIndex(newDate)
		if selectedDay > newDateLastDayIndex
			newDate.setDate(newDateLastDayIndex)
		else
			newDate.setDate(selectedDay)
		date = newDate

	def render
		<self>
			<IconButton size="xl" @click=prevDay>
				<i[fs: 1rem].fas.fa-chevron-left>
			<div.date>
				<.select-container [w: 45px]>
					<HeaderSelect
						selectedOption=getFormattedDay()
						options=formattedDays
						@select=changeDay
					>
				<.select-container [w: 115px]>
					<HeaderSelect
						selectedOption=getFormattedMonth()
						options=formattedMonths
						@select=changeMonth
					>
				<.select-container [w: 61px]>
					<HeaderSelect
						selectedOption=getFormattedYear()
						options=formattedYears
						@select=changeYear
					>
			<IconButton size="xl" @click=nextDay>
				<i[fs: 1rem].fas.fa-chevron-right>

	css &
		display: flex
		background: blue4
		justify-content: space-between
		align-items: center
		.date
			justify-content: space-between
			display: flex
			.select-container
				margin: 0 1rem
				display: flex
				justify-content: center

export default Header