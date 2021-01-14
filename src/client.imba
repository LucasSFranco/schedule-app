import '@/styles'

import Header from '#/organisms/Header'
import TodoSection from '#/organisms/TodoSection'
import ScheduleSection from '#/organisms/ScheduleSection'

tag App	

	prop date

	def setup
		let currYear = new Date().getFullYear()
		let currMonth = new Date().getMonth()
		let currDay = new Date().getDate()
		date = new Date(currYear, currMonth, currDay)
	
	def changeDate e
		date = e.detail

	def render
		<self>
			<.container>
				<Header date=date @dateChange=changeDate>	
				<.wrapper>					
					<TodoSection date=date>		
					<ScheduleSection date=date>

	css &
		display: flex
		width: 100vw
		height: 100vh
		padding: 2.5vw
		user-select: none
		.container
			size: 100%
			box-shadow: lg
			.wrapper
				display: flex
				height: calc(100% - 3.5rem)

imba.mount <App>
