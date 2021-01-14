class Caption

	constructor _date
		color = "#cbd5e0"
		description = ''
		date = _date

	def validate
		let isInvalid = false

		unless color !== "#ffffff"
			isInvalid ||= true

		unless description
			isInvalid ||= true

		return isInvalid

export default Caption