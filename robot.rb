

 	## TABLE

class Table

 attr_accessor :initialize, :width, :height


 def initialize(width, height)

   @width =width

   @height =height

 end

 

 def apply_grid_value(table, width_or_height_string, new_table_width_or_height_value)

   if width_or_height_string == 'width'

     table.width = new_table_width_or_height_value

   elsif width_or_height_string == 'height'

     table.height = new_table_width_or_height_value

   end

 end

 

 def set_grid_value(table, width_or_height_string)

   if width_or_height_string == "height"

     puts "----------------------------------------------------"

   end

   puts "Please enter new table #{width_or_height_string} (units):"

   begin

     new_table_width_or_height_value = gets.chomp

     new_table_width_or_height_value == Integer(new_table_width_or_height_value)

     raise if (new_table_width_or_height_value.to_i < 2)

   rescue

       puts "Please enter a numeric value greater than 1:"

     retry

   else

     new_table_width_or_height_value = new_table_width_or_height_value.to_i

     apply_grid_value(table, width_or_height_string, (new_table_width_or_height_value - 1))

   end

 end

 

end

 

## ROBOT

class Robot

 attr_accessor :initialize, :move, :place, :x, :y, :f

 

 # def initialize(x, y, f)

 def initialize

   # puts "robot initialized"

   @x = x

   @y = y

   @f = f

 end

 

 def place(robot, table)

   def pre_place_co_ords(robot, table, robot_x_or_y)

     # puts "starting pre-place for #{robot_x_or_y}"

     robot_co_ord = nil

     begin

       robot_co_ord = gets.chomp

       robot_co_ord == Integer(robot_co_ord) # error No1 - they enter non number

       raise if (robot_co_ord.to_i > table.width && robot_x_or_y == "x") # error No2 - enter number outside of table constraints.

       raise if (robot_co_ord.to_i > table.height && robot_x_or_y == "y") # error No3 - enter number outside of table constraints.

       raise if (robot_co_ord.to_i < 0) # error No4 - enter number outside of table constraints.

     rescue

       if # error No2 - No4

         (robot_co_ord.to_i > table.width && robot_x_or_y == "x") ||

         (robot_co_ord.to_i > table.height && robot_x_or_y == "y") ||

         (robot_co_ord.to_i < 0)

         puts "The table starts at co-ordinates (0,0) and runs to (#{table.width},#{table.height})"

         puts "Please enter a valid number within these co-ordinates:"

       else # error No1

         puts "Please enter a valid number only:"

       end

       retry

     else

       if robot_x_or_y == "x"

         puts "----------------------------------------------------"

         robot.x = robot_co_ord.to_i

       elsif robot_x_or_y == "y"

         robot.y = robot_co_ord.to_i

       end

     end

   end

   puts "Please enter robot x co-ordinates (number):"

   pre_place_co_ords(robot, table, "x")

   puts "Please enter robot y co-ordinates (number):"

   pre_place_co_ords(robot, table, "y")

   def pre_place_direction(robot)

     puts "Please enter robot direction facing ('NORTH' - 'SOUTH' - 'EAST' - 'WEST')"

     begin

       robot_f = gets.chomp.to_s.upcase

       raise if (%w(NORTH SOUTH EAST WEST).include? robot_f) == false

     rescue

       puts 'Please enter "NORTH" -or- "SOUTH" -or- "EAST" -or- "WEST" only:'

       retry

     else

       robot.f = robot_f

     end

   end

   pre_place_direction(robot)

   puts "Your robot is placed at (#{robot.x}, #{robot.y}) and is facing #{robot.f}"

 end

 

  def picture

   puts '                                                    '

   puts '                        <|>                         '

   puts '                       _┴_                        '

   puts '                      |     |                       '

   puts '                     [| | | |]                      '

   puts '                      |  _  |                       '

   puts '                      |___|                       '

   puts '                __ _||_ ___                 '

   puts '               ()_)         (_()                '

   puts '              / / /|   ashwin   |\ \ \               '

   puts '             / / / |           | \ \ \              '

   puts '             (_) |____| (__)              '

   puts '             (_)   (__)   (__)              '

   puts '             (_)     (_)     (_)              '

   puts '             (_)      ||      (__)              '

   puts '             (_)  _/_\___   | |               '

   puts '              | |  |           |  | |               '

   puts '              | |  |____| /__\              '

   puts '             /_\  | |     | | /   \ \             '

   puts '            / /   \ | |     | | \   / /             '

   puts '            \ \   / | |     | |  \ / /              '

   puts '             \ \ / ()_)   (_()                    '

   puts '                   / /      \  \                    '

   puts '                  / /        \  \                   '

   puts '                / /_     _\  \_                 '

   puts '               |__|   |__|                '

   puts "----------------------------------------------------"

   puts "       CONGRATS ON FINDING THE EASTER EGG!!!        "

   puts "----------------------------------------------------"

 end

 

 def place3n(table)

   picture

   if table.width < 3 || table.height < 3

     puts "Oops, this secret command won't work while the table is that small."

     puts "This command will usually place the robot at (3,3) facing NORTH."

     puts "Try making the table at least 4 x 4 wide then run PPP again."

   else

     @x = 3

     @y = 3

     @f = "NORTH"

   end

 end

 

 def remove_from_table(robot)

   robot.x = nil

   robot.y = nil

   robot.f = nil

   puts "Your robot is being lifted off the table while it's being resized."

   puts "Make sure to PLACE your robot again before you resume playing."

 end

 

 @x_modifier = 0

 @y_modifier = 0

 

 def check_direction

   case

     when (@f == "NORTH")

       @x_modifier = 0

       @y_modifier = 1

     when (@f == "EAST")

       @x_modifier = 1

       @y_modifier = 0

     when (@f == "SOUTH")

       @x_modifier = 0

       @y_modifier = -1

     when (@f == "WEST")

       @x_modifier = -1

       @y_modifier = 0

     else

       exit

     end

   end

 

 def move(robot, table)

   check_direction

   if (robot.x + @x_modifier <= table.width && robot.x + @x_modifier >= 0 && robot.y + @y_modifier <= table.height && robot.y + @y_modifier >= 0)

     robot.x = robot.x + @x_modifier

     robot.y = robot.y + @y_modifier

     puts "Your robot has moved #{robot.f} by 1 place."

     puts "Your robot is now at co-ordinates (#{robot.x},#{robot.y})."

   else

     puts "STOP! Your robot is at the edge of the table! Turn your robot LEFT or RIGHT to continue playing."

     puts "Your robot is at co-ordinates (#{robot.x},#{robot.y}) and facing #{robot.f}."

     puts "Run the TABLE command for more information about your table."

   end

 end

 

 def turn_error_messages(robot)

   puts "Error, your Robot is direction value is '#{robot.f}', not NORTH -or- SOUTH -or- EAST -or- WEST"

   puts "Please try again - run the PLACE command to enter a correct direction."

 end

 

 def turn_left(robot)

   case

     when (robot.f == "NORTH")

       robot.f = "WEST"

     when (robot.f == "EAST")

       robot.f = "NORTH"

     when (robot.f == "SOUTH")

       robot.f = "EAST"

     when (robot.f == "WEST")

       robot.f = "SOUTH"

     else

       turn_error_messages(robot)

     end

 end

 

 def turn_right(robot)

   case

     when (robot.f == "NORTH")

       robot.f = "EAST"

     when (robot.f == "EAST")

       robot.f = "SOUTH"

     when (robot.f == "SOUTH")

       robot.f = "WEST"

     when (robot.f == "WEST")

       robot.f = "NORTH"

     else

       turn_error_messages(robot)

     end

 end

end

 

## PLAY

class Play

 def initialize

 end

 

 def divider_yellow

   puts "----------------------------------------------------"

 end

 

 def print_menu

   puts "----------------------------------------------------"

 

   puts "Choose an option: (case insensitive)"

   puts "MAKE"

   puts "PLACE"

   puts "MOVE"

   puts "LEFT"

   puts "RIGHT"

   puts "REPORT"

   divider_yellow

   puts "Bonus options:"

   puts "DESTROY - destroy the robot"

   puts "TABLE - view Table Information"

   puts "GRID - update the Table to a grid size of your choice"

   puts "EXIT - close the program"

   divider_yellow

   print "Your selection: "

   gets.chomp.to_s.upcase

 end

end

 

## TOY ROBOT

@robot = nil

play = Play.new

table = nil

 

while true

 begin

   unless @table

     @table = Table.new(4,4)

     table = @table

   end

   selection = play.print_menu

   case selection

   when "MAKE"

     unless @robot

       @robot = Robot.new

       puts "We have built your robot!"

       puts "Unique ID No. = #{@robot._id_}"

     else

       play.divider_yellow

       puts "You already have a robot!"

       puts "Unique ID No. = #{@robot._id_}"

     end

   when "DESTROY"

     if @robot

       @robot = nil

       play.divider_yellow

       puts "Your robot has been destroyed... aww..."

     else

       play.divider_yellow

       puts "You don't have a robot to destroy!"

     end

   when "PLACE"

     if @robot

       play.divider_yellow

       robot = @robot

       table = @table

       @robot.place(robot, table)

     else

       play.divider_yellow

       puts "Your robot doesn't exist yet. Please run MAKE first!"

     end

   when "PPP"

     if @robot.nil?

       @robot = Robot.new

     end

     table = @table

     @robot.place3n(table)

     puts "Your Robot details are as follows:"

     puts "Unique ID No. = #{@robot._id_}"

     if (@robot.x || @robot.y || @robot.f) != nil

       puts "Your robot is placed at (#{@robot.x},#{@robot.y})"

      end
                                                             