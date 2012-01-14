module Ruth
	class Engine
		def initialize
			@data = []
			@return = []
			@immediate = []
			@dictionary = []
      @prefix = 'ruth_'
			@state = :interpreting
			reset_compilation_target
			load_primitives
		end

		def make_word(name, options={}, &block)
			prefixed = prefix(name)
			self.class.send(:define_method, prefixed, &block)
			@immediate << prefixed if options[:immediate]
			@dictionary << prefixed
		end

		def interpret(tokens)
			@token_stream = tokens.each
			while token = next_token
				word = lookup(token)

				if word.nil?
					puts("#{token}?")
					break
				end

				case @state
				when :interpreting then execute(word)
				when :compiling then immediate?(word) ? execute(word) : compile(word)
				end
			end
		end

    private

		def next_token
			@token_stream.next rescue nil
		end

		def peek
			@token_strem.peek rescue nil
		end

		def lookup(token)
			prefixed = prefix(token)
			@dictionary.include?(prefixed) ? prefixed : number(token)
		end

		def prefix(name)
			"#{@prefix}#{name}"
		end

		def immediate?(word)
			@immediate.include?(word)
		end

		def execute(word)
			word.is_a?(Numeric) ? @data << word : send(word)
		end

		def compile(word)
			@compilation_target[:words] << word
		end

		def enter_compilation
			@state = :compiling
			reset_compilation_target
		end

		def exit_compilation
			@state = :interpreting
		end

		def reset_compilation_target
			@compilation_target = { :label => nil, :words => [] }
		end

		def number(token)
			Integer(token) rescue nil || Float(token) rescue nil
		end
	end
end
