import IconButton from '#/atoms/IconButton'
import SectionHeader from '#/molecules/SectionHeader'
import TodoSectionAddForm from '#/molecules/TodoSectionAddForm'

import Todos from '~/Todos'
import Todo from '~/Todo'

tag TodoSection

	prop todos = []
	prop todo
	prop showAddForm = false
	prop loading = true
	
	set date value
		#date = value
		todo = new Todo(date)
		showAddForm = false
		mount()

	get date
		#date

	def toggleShowAddForm
		showAddForm = !showAddForm
		todo = new Todo(date)

	def closeAddForm
		showAddForm = false

	def createTodo
		unless todo.validate()
			await Todos.createTodo(todo)
			todo = new Todo(date)
			closeAddForm()
			await getTodosByDate()
			render()

	def deleteTodo { id }
		await Todos.deleteTodo(id)
		await getTodosByDate()
		render()

	def toggleTodoCompletion { id }
		await Todos.toggleTodoCompletion(id)
		await getTodosByDate()
		render()

	def getTodosByDate
		todos = await Todos.getTodosByDate(date)

	def mount
		loading = true
		await getTodosByDate()
		loading = false
		imba.commit()
		render()

	def render
		<self>
			<SectionHeader>
				<.title> 'Todo'
				<IconButton
					color=(showAddForm ? "secondary" : "success")
					@click=toggleShowAddForm
				>
					<i.fas .fa-{showAddForm ? "times" : "plus-square"}>
			<TodoSectionAddForm .show=showAddForm todo=todo @create=createTodo>
			<.todo-list>
				if loading
					<.loading> <i.fas.fa-circle-notch.fa-spin>
				else
					if todos.length
						for todo in todos
							<.todo-item>
								<.check .active=todo.completed>
									<i.fas.fa-check @click=toggleTodoCompletion(todo)>
								<.text
									.completed=todo.completed
								> todo.description
								<.delete>
									<i.fas.fa-times @click=deleteTodo(todo)>
					else
						<.message>
							'There is nothing to do at the moment...'
							
	css &
		width: 100%
		position: relative
		.todo-list
			overflow-y: scroll
			height: calc(100% - 2.5rem)
			.todo-item
				tween: 250ms
				display: flex
				align-items: center
				.check
					display: flex
					justify-content: center
					align-items: center
					width: 2.5rem
					font-size: 1rem
					i
						cursor: pointer
						color: grey4 @hover: grey6
						tween: 250ms
					&.active i color: green4 @hover: green6
				.text 
					padding: .5rem
					color: grey5
					user-select: text	
					width: 100%
					font-weight: 400
					@selection
						background: blue3
						color: white
						text-decoration-color: white
					&.completed
						text-decoration: line-through
						text-decoration-color: green4
						text-decoration-thickness: 2px
				@nth-child(odd)
					background: blue1 @hover: blue2
				@nth-child(even)
					background: grey1 @hover: grey3
				.delete
					width: 2rem
					font-size: 1rem
					display: flex
					justify-content: center
					align-items: center
					tween: 250ms
					opacity: 0
					i
						cursor: pointer
						color: red4 @hover: red6
						tween: 250ms
				@hover .delete opacity: 1
			.message
				text-align: center
				color: grey5
				padding-top: calc(1rem + 16px)
			.loading
				padding-top: 1rem
				font-size: 3rem
				text-align: center
				color: blue2

export default TodoSection