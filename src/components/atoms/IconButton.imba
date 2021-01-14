tag IconButton

	attr size = "md"
	attr color = "primary"

	def render
		<self>
			<slot>

	css &
		display: flex
		justify-content: center
		align-items: center
		cursor: pointer
		tween: 250ms
		color: white

		&[color="primary"]   background: blue4   @hover: blue5
		&[color="secondary"] background: grey5   @hover: grey6
		&[color="success"]   background: green4  @hover: green5
		&[color="warning"]   background: yellow4 @hover: yellow5
		&[color="danger"]    background: red4    @hover: red5

		&[size="xl"] size: 3.5rem font-size: 1.25rem
		&[size="lg"] size: 3rem   font-size: 1.125rem
		&[size="md"] size: 2.5rem font-size: 1rem
		&[size="sm"] size: 2rem   font-size: .875rem
		&[size="xs"] size: 1.5rem font-size: .75rem

export default IconButton