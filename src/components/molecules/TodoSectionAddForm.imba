import Button from '#/atoms/Button'

tag TodoSectionAddForm

	prop todo

	def createTodo
		emit('create')

	def render
		<self>
			<textarea
				placeholder="Write here something to do..."
				rows="5"
				bind=todo.description
			>
			<Button color="success" @click=createTodo>
				<i.fas.fa-plus-square>
				'Add'

	css &
		width: 100%
		box-shadow: lg
		display: none
		flex-direction: column
		position: absolute
		textarea
			resize: none
			outline: none
			overflow-y: auto
			padding: .5rem
			font-size: .875rem
			color: grey8 @placeholder: grey4
			@selection
				background: blue3
				color: white
				text-decoration-color: white
		&.show
			display: flex

export default TodoSectionAddForm