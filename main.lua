function love.load()
    love.physics.setMeter(32)
    
    world = love.physics.newWorld(0, 9.8 * 128, true);
    
    objects = {}
    balls = {}
    
    objects.ground = {}
    objects.ground.body = love.physics.newBody(world, love.graphics.getWidth() / 2, (love.graphics.getHeight() - 10))
    objects.ground.shape = love.physics.newRectangleShape(love.graphics.getWidth(), 20)
    objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape)
    
    objects.rightwall = {}
    objects.rightwall.body = love.physics.newBody(world, -1, love.graphics.getHeight() / 2)
    objects.rightwall.shape = love.physics.newRectangleShape(2, love.graphics.getHeight())
    objects.rightwall.fixture = love.physics.newFixture(objects.rightwall.body, objects.rightwall.shape)
    
    objects.rightwall = {}
    objects.rightwall.body = love.physics.newBody(world, love.graphics.getWidth() + 1, love.graphics.getHeight() / 2)
    objects.rightwall.shape = love.physics.newRectangleShape(2, love.graphics.getHeight())
    objects.rightwall.fixture = love.physics.newFixture(objects.rightwall.body, objects.rightwall.shape)
    
    objects.spike = {}
    objects.spike.body = love.physics.newBody(world, 90, love.graphics.getHeight())
    objects.spike.shape = love.physics.newRectangleShape(5, 100)
    objects.spike.fixture = love.physics.newFixture(objects.spike.body, objects.spike.shape)
    
    addBall(100, 0)
end

function addBall(x, y)
  local ball = {}
  ball.body = love.physics.newBody(world, x, y, "dynamic")
  ball.shape = love.physics.newCircleShape( 20)
  ball.fixture = love.physics.newFixture(ball.body, ball.shape, 1)
  ball.fixture:setRestitution(0.7)
  
  table.insert(objects, ball)
  table.insert(balls, ball)
end

function love.update(dt)
    world:update(dt)   
end


function love.draw()  
  love.graphics.print("hello", 0, 0)

  love.graphics.setColor(0, 255, 0)
  love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))
  
  love.graphics.polygon("fill", objects.spike.body:getWorldPoints(objects.spike.shape:getPoints()))
    
  love.graphics.setColor(0, 255, 255)
  
  for i,ball in ipairs(balls) do
    love.graphics.circle("fill", ball.body:getX(), ball.body:getY(), ball.shape:getRadius())
  end
end

function love.keypressed(key, unicode)
  if key == 'b' then
    addBall()
  end
  
 end
 
function love.mousepressed(x, y, button)
  addBall(x, y)
end

function love.mousereleased(x, y, button)
  love.mouse.setGrab(false)
end

