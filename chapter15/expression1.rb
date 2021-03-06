require 'find'

class Expression
   # Common expression code
end


class All < Expression

   def evaluate(dir)
      results = []
      Find.find(dir) do |p|
         next unless File.file?(p)
         results << p
      end
      results
   end

end


class FileName < Expression

   def initialize(pattern)
      @pattern = pattern
   end


   def evaluate(dir)
      results = []
      Find.find(dir) do |p|
         next unless File.file?(p)
         name = File.basename(p)
         results << p if File.fnmatch(@pattern, name)
      end
      results
   end

end


class Bigger < Expression

   def initialize(size)
      @size = size
   end


   def evaluate(dir)
      results = []
      Find.find(dir) do |p|
         next unless File.file?(p)
         results << p if (File.size(p) > @size)
      end
      results
   end

end


class Writable

   def evaluate(dir)
      results = []
      Find.find(dir) do |p|
         next unless File.file?(p)
         results << p if File.writable?(p)
      end
      results
   end

end


# Logical operators

class Not < Expression

   def initialize(expression)
      @expression = expression
   end


   def evaluate(dir)
      All.new.evaluate(dir) - @expression.evaluate(dir)
   end

end


class Or < Expression

   def initialize(expression1, expression2)
      @expression1 = expression1
      @expression2 = expression2
   end


   def evaluate(dir)
      (@expression1.evaluate(dir) + @expression2.evaluate(dir)).sort.uniq
   end

end


class And < Expression

   def initialize(expression1, expression2)
      @expression1 = expression1
      @expression2 = expression2
   end


   def evaluate(dir)
      @expression1.evaluate(dir) & @expression2.evaluate(dir)
   end

end
