describe 'Dummy', ->
  it 'is just a placeholder', ->
    expect(true).toBeTruthy()

describe 'Greet me.', ->
  it 'should greet me with my name', ->
    core = new Core()
    greeting = core.greet 'me'
    expect(greeting).toEqual 'Hello me!'

describe 'Orphaned', ->
    it 'should create an Orphaned instance', ->
      orphaned = new Orphaned()
      expect(orphaned).toBeTruthy()
    it 'should have a printOrphanedNefsInDir() method', ->
      orphaned = new Orphaned()
      expect(orphaned.printOrphanedNefsInDir).toBeTruthy()
      expect(typeof orphaned.printOrphanedNefsInDir).toEqual 'function'
    it 'should find nothing if no files', ->
      orphaned = new Orphaned()
      orphanedNefs = orphaned.findOrphanedNefs []
      expect(orphanedNefs).toEqual []
    it 'should extract correct jpegShorts', ->
      orphaned = new Orphaned()
      jpegShorts = orphaned.extractJpegShorts ['aaa.jpg', 'bbb.jpg', 'aaa.nef', 'bbb.nef']
      expect(jpegShorts).toEqual(['aaa', 'bbb'])
    it 'should extract correct nefs', ->
      orphaned = new Orphaned()
      nefs = orphaned.extractNefs ['aaa.jpg', 'bbb.jpg', 'aaa.nef', 'bbb.nef']
      expect(nefs).toEqual(['aaa.nef', 'bbb.nef'])
    it 'shuold create a correct shortNef', ->
      orphaned = new Orphaned()
      shortNef = orphaned.shortNef 'aaa.nef'
      expect(shortNef).toEqual 'aaa'
    it 'should find nothing if same jpg and nef files', ->
      orphaned = new Orphaned()
      orphanedNefs = orphaned.findOrphanedNefs ['aaa.jpg', 'bbb.jpg', 'aaa.nef', 'bbb.nef']
      expect(orphanedNefs).toEqual []
