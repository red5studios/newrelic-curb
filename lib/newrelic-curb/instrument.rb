require 'curb'
require 'newrelic_rpm'

::Curl::Easy.class_eval do
  def host
    URI.parse((self.url.start_with?('http') ? '' : 'http://') + self.url).host
  end

  def perform_with_newrelic_trace(*args, &block)
    metrics = ["External/#{host}/Curl::Easy","External/#{host}/all","External/all"]
    if NewRelic::Agent::Instrumentation::MetricFrame.recording_web_transaction?
      metrics << "External/allWeb"
    else
      metrics << "External/allOther"
    end

    if self.headers['X-Request-Tracer']
      metrics << "External/#{host}/Curl::Easy/#{self.headers['X-Request-Tracer'].last}"
    end

    if self.class.respond_to?(:trace_execution_scoped)
      self.class.trace_execution_scoped metrics do
        perform_without_newrelic_trace(*args, &block)
      end
    else
      perform_without_newrelic_trace(*args, &block)
    end
  end
  alias perform_without_newrelic_trace perform
  alias perform perform_with_newrelic_trace
end