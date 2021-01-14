tag SectionHeader

	attr size = "md"

	def render
		<self>
			<slot>

	css &
		display: flex
		align-items: center
		justify-content: space-between
		background: blue3
		color: white
		
		>> .title text-transform: uppercase

		&[size="lg"] >> .title
			padding-left: 1.125rem
			font-size: 1.125rem
		&[size="md"] >> .title
			padding-left: 1rem
			font-size: 1rem
		&[size="sm"] >> .title
			padding-left: .875rem
			font-size: .875rem

export default SectionHeader