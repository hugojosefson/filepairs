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
    it 'should find nothing if no files', ->
      orphaned = new Orphaned()
      orphanedNefs = orphaned.findOrphanedNefs []
      expect(orphanedNefs).toEqual {}
    it 'should extract correct jpegShorts in one directory', ->
      orphaned = new Orphaned()
      jpegShorts = orphaned.extractJpegShorts ['aaa.jpg', 'bbb.jpg', 'aaa.nef', 'bbb.nef']
      expect(jpegShorts).toEqual(['aaa', 'bbb'])
    it 'should extract correct jpegShorts in directory hierarchy', ->
      orphaned = new Orphaned()
      jpegShorts = orphaned.extractJpegShorts ['aaa.jpg', 'subdir/bbb.jpg', 'aaa.nef', 'bbb.nef']
      expect(jpegShorts).toEqual(['aaa', 'subdir/bbb'])
    it 'should extract correct nefs', ->
      orphaned = new Orphaned()
      nefs = orphaned.extractNefs ['aaa.jpg', 'subdir/bbb.jpg', 'aaa.nef', 'bbb.nef', 'bothinsameplace/ccc.jpg', 'bothinsameplace/ccc.nef']
      expect(nefs).toEqual(['aaa.nef', 'bbb.nef', 'bothinsameplace/ccc.nef'])
    it 'should create a correct shortNef from full filename', ->
      orphaned = new Orphaned()
      shortNef = orphaned.shortNef 'aaa.nef'
      expect(shortNef).toEqual 'aaa'
    it 'should create a correct shortNef from full path/filename', ->
      orphaned = new Orphaned()
      shortNef = orphaned.shortNef 'path/aaa.nef'
      expect(shortNef).toEqual 'aaa'
    it 'should find nothing if same jpg and nef files in root dir', ->
      orphaned = new Orphaned()
      orphanedNefs = orphaned.findOrphanedNefs ['aaa.jpg', 'bbb.jpg', 'aaa.nef', 'bbb.nef']
      expect(orphanedNefs).toEqual {}
    it 'should find nothing if same jpg and nef files in directory hierarchy', ->
      orphaned = new Orphaned()
      orphanedNefs = orphaned.findOrphanedNefs ['aaa.jpg', 'subdir/bbb.jpg', 'aaa.nef', 'subdir/bbb.nef', 'bothinsameplace/ccc.jpg', 'bothinsameplace/ccc.nef']
      expect(orphanedNefs).toEqual {}
    it 'should find nothing if same jpg and nef files in root dir, regardless of order', ->
      orphaned = new Orphaned()
      orphanedNefs = orphaned.findOrphanedNefs ['aaa.jpg', 'bbb.jpg', 'aaa.nef', 'ccc.nef', 'ccc.jpg', 'bbb.nef']
      expect(orphanedNefs).toEqual {}
    it 'should find nothing if same jpg and nef files in directory hierarchy, regardless of order', ->
      orphaned = new Orphaned()
      orphanedNefs = orphaned.findOrphanedNefs ['aaa.jpg', 'subdir/bbb.jpg', 'aaa.nef', 'bothinsameplace/ccc.nef', 'bothinsameplace/ccc.jpg', 'bbb.nef']
      expect(orphanedNefs).toEqual {}
    it 'should find nothing if one orphaned jpg', ->
      orphaned = new Orphaned()
      orphanedNefs = orphaned.findOrphanedNefs ['aaa.jpg', 'bbb.jpg', 'aaa.nef', 'ccc.nef', 'ccc.jpg']
      expect(orphanedNefs).toEqual {}
    it 'should find aaa.nef if aaa.jpg is deleted', ->
      orphaned = new Orphaned()
      orphanedNefs = orphaned.findOrphanedNefs ['bbb.jpg', 'aaa.nef', 'ccc.nef', 'ccc.jpg', 'bbb.nef']
      expect(orphanedNefs).toEqual {'aaa.nef': null}
    it 'should find all nefs if all jpg\'s are deleted', ->
      orphaned = new Orphaned()
      orphanedNefs = orphaned.findOrphanedNefs ['aaa.nef', 'ccc.nef', 'bbb.nef']
      expect(orphanedNefs).toEqual {
        'aaa.nef': null
        'ccc.nef': null
        'bbb.nef': null
      }
