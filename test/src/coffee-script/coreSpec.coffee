describe 'Dummy', ->
  it 'is just a placeholder', ->
    expect(true).toBeTruthy()

describe 'Greet me.', ->
  it 'should greet me with my name', ->
    core = new Core()
    greeting = core.greet('me')
    expect(greeting).toEqual('Hello me!')
