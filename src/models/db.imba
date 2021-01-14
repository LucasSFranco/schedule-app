import Dexie from 'dexie'
import relationships from 'dexie-relationships'

const db = new Dexie("ScheduleAppDatabase", {addons: [relationships]})

db.version(1).stores({
	todos: '++id, description, completed, date',
	dateCaptions: '++id, captionId -> captions.id, date',
	timeIntervals: '++id, timeIntervalId, color, date',
	captions: '++id, color, description'
})

export default db