module GreenhouseIoc

  class Kernel

    def initialize

      create_components
      do_ioc_wiring

    end

    def create_components

      # List all 'ioc' properties
      ioc_properties=ioc_properties self

      #
      # Create class instance for each 'IoC' property
      # and assign to 'IoC' property
      #
      # NOTE: Naming convention in use: e.g. setIoc_game_state: -> GameState.new
      ioc_properties.each do |setter_method_name|
        property_name=setter_method_name.gsub("setIoc_","").gsub(":","")

        # turn 'game_state' into 'GameState'
        # note: requires 'bubble-wrap' gem
        #class_name=property_name.camelize
        # note: doesn't require 'bubble-wrap' gem
        class_name=property_name.split('_').map {|w| w.capitalize}.join

        # create instance of the component (GameState.new)
        c=Object.const_get(class_name)

        begin
          property_value=c.new
          # assign instance of the component to 'IoC' property
          self.send("#{setter_method_name}",property_value)
        rescue
          puts "ERROR: Greenhouse: Unable to create instance of #{class_name}. Is a no-argument initializer provided?"
        end

      end

    end

    def do_ioc_wiring

        # List all 'IoC' properties
        ioc_properties=ioc_properties self

        #
        # Extract component names from 'IoC' property names
        # e.g. setIoc_game_state -> game_state
        components=ioc_properties.map{|e| e.gsub("setIoc_","ioc_").gsub(":","")}

        #
        # Wire each 'IoC' component with
        # all required IoC dependencies
        components.each{|c| wire_component self.send(c)}

    end

    def wire_component(component)

      # List all 'IoC' properties of the component
      ioc_properties=ioc_properties component

      #
      # Wire each 'IoC' property with instance of a component
      # NOTE: Naming convention in use: e.g. setIoc_game_state: -> instance of GameState
      ioc_properties.each do |setter_method_name|
          property_name=setter_method_name.gsub("setIoc_","").gsub(":","")
          ioc_property_name = "ioc_#{property_name}"
          property_value=nil
          begin
            property_value=self.send(ioc_property_name)
          rescue NoMethodError=>e
            puts "ERROR: Greenhouse: Instance of '#{property_name.camelize}' class is not assigned to #{ioc_property_name}'."
          end

          if property_value
            begin
              component.send("#{setter_method_name}",property_value)
            rescue NoMethodError=>e
              puts "ERROR: Greenhouse: Unable to set '#{ioc_property_name}' property on '#{component.class}' component. No such method."
            end
          end

      end
    end

    def ioc_properties(ioc_object)
      ioc_object.methods.select{|e| setter_method_name=e.to_s; setter_method_name.start_with?"setIoc_" and setter_method_name.end_with?":" }
    end

    def all_ioc_component_names
      ioc_properties self
    end

  end
  
end