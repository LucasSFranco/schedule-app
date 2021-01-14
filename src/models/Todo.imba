class Todo

	constructor _date
		description = ''
		completed = false
		date = _date

	def validate
		let isInvalid = false

		unless description
			isInvalid ||= true

		return isInvalid

export default Todo