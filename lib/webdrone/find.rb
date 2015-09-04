module Webdrone
  class Browser
    def find
      @find ||= Find.new self
    end
  end

  class Find
    attr_accessor :a0

    def initialize(a0)
      @a0 = a0
    end

    def id(id)
      @a0.driver.find_element :id, id
    end

    def link(text, n: 1, all: false, visible: true)
      items = @a0.driver.find_elements :xpath, XPath::HTML.link(text).to_s
      choose(items, n, all, visible)
    end

    def button(text, n: 1, all: false, visible: true)
      items = @a0.driver.find_elements :xpath, XPath::HTML.button(text).to_s
      choose(items, n, all, visible)
    end

    def on(text, n: 1, all: false, visible: true)
      items = @a0.driver.find_elements :xpath, XPath::HTML.link_or_button(text).to_s
      choose(items, n, all, visible)
    end
    
    protected
    def choose(list, n, all, visible)
      list = list.select do |x|
        if visible == true
          x.displayed?
        elsif visible == false
          not x.displayed?
        else
          true
        end
      end
      if all
        list
      elsif n == 1
        list.first
      else
        list[n + 1]
      end
    end
  end
end