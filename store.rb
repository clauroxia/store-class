require_relative "incidents"
require "date"

class Store
  def initialize(incidents)
    raise StandardError, "incidents can't be empty" if incidents.empty?

    @incidents = incidents
    @time_incidents = []
  end

  def incident_status(date1, date2)
    raise StandardError, "date1 and date2 can't be empty" if date1.empty? || date2.empty?

    incidents_report = {}
    if date1 < date2
      incidents_report[:open_cases] = cases_incidents("open", date1, date2)
      incidents_report[:closed_cases] = cases_incidents("solved", date1, date2)
      incidents_report[:average_solution] = average_time.nil? ? 0 : average_time
      incidents_report[:maximum_solution] = maximum_time.nil? ? 0 : maximum_time
      print_incidents(incidents_report)
    else
      puts "The first date (#{date1}), must be less than the second one (#{date2})"
    end
  end

  def print_incidents(incidents_detail)
    puts incidents_detail
  end

  def cases_incidents(status_incident, date1, date2)
    cases = 0
    type_incidents = @incidents.find_all { |incident| incident[:status] == status_incident }
    case status_incident
    when "solved"
      type_incidents.each do |type_incident|
        if type_incident[:date_solution] > date1 && type_incident[:date_solution] < date2
          cases += 1
          @solution_time = range_time(type_incident)
        end
      end

    when "open"
      @open_incidents = []
      type_incidents.each do |type_incident|
        if type_incident[:date_incident] > date1 && type_incident[:date_incident] < date2
          cases += 1
          @open_incidents.push(type_incident)
        end
      end
    end
    cases
  end

  def range_time(type_incident)
    start_date = Date.parse(type_incident[:date_incident])
    end_date = type_incident[:date_solution].nil? ? Date.today : Date.parse(type_incident[:date_solution])
    @time_incidents << (end_date - start_date).to_i
  end

  def average_time
    @solution_time.sum / @solution_time.size unless @solution_time.nil?
  end

  def maximum_time
    @open_incidents.each do |open_incident|
      range_time(open_incident)
    end
    @time_incidents.sort!
    @time_incidents[-1] unless @time_incidents.nil?
  end
end

some_store = Store.new(INCIDENTS)
some_store.incident_status("2022-03-01", "2022-03-30")
