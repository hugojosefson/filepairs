describe 'Dummy', ->
  it 'is just a placeholder', ->
    expect(true).toBeTruthy()

describe 'Greet me.', ->
  it 'should greet me with my name', ->
    core = new Core()
    greeting = core.greet('me')
    expect(greeting).toEqual('Hello me!')

describe 'Orphaned', ->
    it 'should create an Orphaned instance', ->
      orphaned = new Orphaned()
      expect(orphaned).toBeTruthy()
    it 'should have a go() method', ->
      orphaned = new Orphaned()
      expect(orphaned.go).toBeTruthy()
      expect(typeof orphaned.go).toEqual('function')
