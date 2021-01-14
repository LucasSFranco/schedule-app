import db from '~/db'

class Todos

	static def createTodo todo
		await db.todos.add(todo)

	static def getTodosByDate date
		await db.todos.where('date').equals(date).toArray()

	static def getTodo id
		await db.todos.get(id)

	static def deleteTodo id
		await db.todos.delete(id)

	static def toggleTodoCompletion id
		let { completed } = await this.getTodo(id)
		await db.todos.update(id, {completed: !completed})

export default Todos