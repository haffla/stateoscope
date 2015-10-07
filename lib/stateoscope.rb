require 'stateoscope/version'
require 'stateoscope/integrations'
require 'stateoscope/visualizer'

require 'stateoscope/railtie' if defined?(Rails)

module Stateoscope
  def self.visualize(klass, options = {})
    state_machine_name = options.fetch(:state_machine_name, nil)
    integration = Integrations.new_for(klass, state_machine_name)
    filename = options.fetch(:filename, filename_for(integration))
    Visualizer.new(integration.graph).output(filename)
  end

  def self.filename_for(integration)
    "#{integration.full_state_machine_name}-#{Time.now.utc.strftime('%Y%m%d%H%M%s')}"
  end
end
