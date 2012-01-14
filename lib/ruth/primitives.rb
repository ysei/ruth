module Ruth
	class Engine
		def load_primitives
			make_word 'exit' do
				Kernel.exit
			end

      make_word 'words' do
        puts available_words.join(' ')
      end

			make_word '.ds' do
				puts(@data.to_s)
			end

			make_word '.' do
				puts(@data.pop)
			end

			make_word '+' do
				@data << @data.pop + @data.pop
			end

			make_word '-' do
				a, b = @data.pop, @data.pop
				@data << a - b
			end

			make_word '*' do
				@data << @data.pop * @data.pop
			end

			make_word '/' do
				a, b = @data.pop, @data.pop
				@data << a / b
			end

			make_word ':' do
				enter_compilation
				@return << ':'
				@compilation_target[:label] = next_token
			end

			make_word ';', :immediate => true do
				exit_compilation
				raise 'No matching : for ;' unless @return.pop == ':'
				immediate = peek == 'immediate'
				make_word @compilation_target[:label], :immediate => immediate do
					@compilation_target[:words].each { |word| execute(word) }
				end
			end
		end

    private

    def available_words
      @dictionary.map { |prefixed| prefixed.gsub(@prefix, '') }
    end
	end
end
