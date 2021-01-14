tag Button

	attr size = "md"
	attr color = "primary"
	attr full

	def render
		<self>
			<slot>

	css &
		color: white
		text-align: center
		text-transform: uppercase
		tween: 250ms
		cursor: pointer
		white-space: nowrap
		display: inline-block
		
		>> i margin-right: .5rem

		&[color="primary"]   background: blue4   @hover: blue5
		&[color="secondary"] background: grey5   @hover: grey6
		&[color="success"]   background: green4  @hover: green5
		&[color="warning"]   background: yellow4 @hover: yellow5
		&[color="danger"]    background: red4    @hover: red5

		&[size="xl"] font-size: 1.125rem padding: .75rem 1.5rem
		&[size="lg"] font-size: 1rem     padding: .625rem 1.25rem
		&[size="md"] font-size: .875rem  padding: .5rem 1rem
		&[size="sm"] font-size: .75rem   padding: .375rem .75rem
		&[size="xs"] font-size: .625rem  padding: .25rem .5rem

		&[full] width: 100%

export default Button