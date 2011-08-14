module ActiveAdmin

  # Shareable module to give a #display_on?(action) method
  # which returns true or false depending on an options hash.
  #
  # The options hash accepts:
  #
  # :only => :index
  # :only => [:index, :show]
  # :except => :index
  # :except => [:index, :show]
  #
  # call #normalize_display_options! after @options has been set
  # to ensure that the display options are setup correctly

  module OptionalDisplay
    def display_on?(action)
      if @options[:if]
        @display_if_block = @options[:if]
      end

      return @options[:only].include?(action.to_sym) if @options[:only]
      return !@options[:except].include?(action.to_sym) if @options[:except]
      true
    end

    def display_if_block
      @display_if_block || lambda { |_| true }
    end

    private

    def normalize_display_options!
      if @options[:only]
        @options[:only] = @options[:only].is_a?(Array) ? @options[:only] : [@options[:only]]
      end
      if @options[:except]
        @options[:except] = @options[:except].is_a?(Array) ? @options[:except] : [@options[:except]]
      end
    end
  end
end

