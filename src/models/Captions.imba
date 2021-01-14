import db from '~/db'

class Captions

	static def getCaptionsByDate date
		await db.dateCaptions.where({ date }).with(content: 'captionId')

	static def createCaption { color, description, date }
		console.log color, description, date
		let existingCaption = await db.captions.get({ color, description })
		if existingCaption != null
			await db.dateCaptions.add({ captionId: existingCaption.id, date })
			return
		let id = await db.captions.add({ color, description })
		await db.dateCaptions.add({ captionId: id, date })

	static def deleteCaption id
		let { captionId } = await db.dateCaptions.get(id) 
		let dateCaptionCaptionIdUsageCount = await db.dateCaptions.where({ captionId }).count()
		if dateCaptionCaptionIdUsageCount === 1
			await db.captions.delete( captionId )
		await db.dateCaptions.delete(id)

	static def getAllCaptions
		await db.captions.toArray()

export default Captions