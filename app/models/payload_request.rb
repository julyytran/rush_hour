class PayloadRequest < ActiveRecord::Base
  validates :requested_at,
            :responded_in,
            :url_id,
            :ip_id,
            :event_name_id,
            :environment_id,
            :request_type_id,
            :referral_id,
            :resolution_id,
            presence: true

  belongs_to :url
  belongs_to :ip
  belongs_to :referral
  belongs_to :request_type
  belongs_to :resolution
  belongs_to :environment
  belongs_to :event_name
  belongs_to :client

  def self.average_response_time
    average(:responded_in)
  end

  def self.maximum_response_time
    maximum(:responded_in)
  end

  def self.minimum_response_time
    minimum(:responded_in)
  end

  # def self.most_frequent_request_type
  #   #WHAT IF THERE IS A TIE?
  #   all_verbs = []
  #   all.each do |payload_request|
  #     all_verbs << payload_request.request_type.verb
  #   end
  #   highest = all_verbs.group_by { |verb| verb}.map do |key, value|
  #     [key, value.count]
  #   end.max_by { |total| total[1] }
  #   highest[0]
  # end

  # def self.all_http_verbs
  #   #THIS METHOD ONLY STILL EXISTS BECAUSE IT'S USED IN THE URL VERSION
  #   verb_ids = pluck(:request_type_id)
  #   reqs = RequestType.find(verb_ids)
  #   reqs.map {|req| req[:verb]}
  # end

  # def self.all_urls_in_order
  #   group(:id).order('url_id ASC').map do |payload_request|
  #     payload_request.url.path
  #   end.group_by { |url| url }.map do |key, value|
  #     [key, value.count]
  #   end.sort_by { |key, value| value}.reverse.map { |totals| totals[0] }
  # end

  # def self.all_event_names
  #   #MESSAGE WHEN NONE ARE DEFINED
  #   group(:id).order('event_name_id ASC').map do |payload_request|
  #     payload_request.event_name.event
  #   end.group_by { |event| event }.map do |key, value|
  #     [key, value.count]
  #   end.sort_by { |key, value| value}.reverse.map { |totals| totals[0] }
  # end

  def self.all_browsers_in_order
    group(:id).order('environment_id ASC').map do |payload_request|
      payload_request.environment.browser
    end.group_by { |browser| browser }.map do |key, value|
      [key, value.count]
    end.sort_by { |key, value| value}.reverse.map { |totals| totals[0] }
  end

  def self.all_os_in_order
    group(:id).order('environment_id ASC').map do |payload_request|
      payload_request.environment.os
    end.group_by { |os| os }.map do |key, value|
      [key, value.count]
    end.sort_by { |key, value| value}.reverse.map { |totals| totals[0] }
  end

  # def self.all_screen_resolutions_in_order
  #   group(:id).order('environment_id ASC').map do |payload_request|
  #     "#{payload_request.resolution.width} x #{payload_request.resolution.height}"
  #   end.group_by { |browser| browser }.map do |key, value|
  #     [key, value.count]
  #   end.sort_by { |key, value| value}.reverse.map { |totals| totals[0] }
  # end
end
