module Ruth
	class Repl
    def self.run(engine=Engine.new)
      repl = Repl.new(engine)
      repl.run
    end

		def initialize(engine)
			@engine = engine
		end

		def run
			loop do
				print "ruth> "
				tokens = $stdin.gets.chomp.split(' ')
				@engine.interpret(tokens)
			end
		end
	end
end
