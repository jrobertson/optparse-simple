require 'rexml/document'
include REXML

class OptParseSimple

  def initialize(filename, args)
    doc = Document.new(File.open(filename,'r').read)
    
    # -- bind any loose value to their argument
    xpath = 'records/option/summary[switch != "" and value != ""]'
    options = XPath.match(doc.root, xpath)
        .map {|node|  %w(switch alias)
          .map{|x| node.text(x)}.compact}
        .flatten
    args.map!.with_index do |x,i|
      next unless x or i < args.length - 1
      (x += '=' + args[i+1]; args[i+1] = nil) if options.include?(x)
      x
    end
    args.compact!        
    # -- end of bind any loose value to their argument
    
    @options = XPath.match(doc.root, 'records/option[summary/switch!=""]')

    switches = @options.map do |option| 
      switch = option.text('summary/switch')
      switch[0] == '-' ? switch : nil
    end    

    switches.compact!

    # split the argument switches if grouped e.g. -ltr
    args.map! do |arg|

      if arg[/^\-[a-zA-Z]+$/] and switches.grep(/#{arg}/).empty? then
        arg[1..-1].scan(/./).map {|x| '-' + x} 
      else
        arg
      end
    end

    args.flatten!

    a1 = options_match(@options[0], args).flatten.each_slice(2).map {|x| x if x[0]}.compact
    options_remaining = XPath.match(doc.root, 'records/option/summary[switch=""]/name/text()')
    a2 = args.zip(options_remaining).map(&:reverse)
    if a2.map(&:first).all? then
      @h = Hash[*(a1+a2).map{|x,y| [x.to_s.to_sym, y]}.flatten]
    else
      invalid_option = a2.detect {|x,y| x.nil? }.last
      raise "invalid option: %s not recognised" % invalid_option
    end
  end

  def to_h()
    @h
  end

  private

  def options_match(option, args)

    switch, switch_alias = option.text('summary/switch'), option.text('summary/alias')
    switch_pattern = switch_alias ? "(%s|%s)" % [switch, switch_alias] : switch 
    switch_matched, arg_index = args.each_with_index.detect {|x,j| x[/^#{switch_pattern}/]}
    key, value = nil

    if switch_matched then

      value_pattern = option.text('summary/value')

      if value_pattern then

        # check for equal sign
        value = switch_matched[/\=(#{value_pattern})/,1]

        # check the next arg
        if value.nil? and args.length > 0 then

          next_arg = args[arg_index + 1] 

          # check to make sure it's not the next switch
          next_option = @options[1] if @options.length > 1

          if next_arg != next_option then
            # validate using the regex
            value = next_arg[/#{value_pattern}/]

            if value then
              args.delete_at(arg_index + 1)
            else
              raise option.text('records/error[last()]/summary/msg')
            end
          end

        else
          args.delete_at(arg_index)
        end      

      else
        args.delete_at(arg_index)
      end

      key = option.text('summary/name')
 
    elsif option.text('summary/mandatory').downcase == 'true' then

      raise option.text('records/error/summary/msg')

    end

    pair = [key, value]
    @options.shift
    next_pair = options_match(@options[0], args) if @options.length > 0

    [pair, next_pair]
  end

end
