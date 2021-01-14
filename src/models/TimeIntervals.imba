import db from '~/db'

class TimeIntervals

	static def getTimeIntervals date
		await db.timeIntervals.where('date').equals(date).toArray()

	static def createTimeInterval timeInterval
		await db.timeIntervals.add(timeInterval)

	static def deleteTimeInterval id
		await db.timeIntervals.delete(id)

export default TimeIntervals