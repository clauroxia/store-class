require "date"
require "time"

class Store
  def initialize(incidents)
    @incidents = incidents
  end

  def incident_status(date1, date2)
    open_cases = 0
    solved_cases = 0
    solution_time = []
    incidents_status = {}
    if date1 < date2
      solved_incidents = @incidents.find_all { |incident| incident[:status] == "solved" }
      solved_incidents.each do |solved_incident|
        next unless solved_incident[:date_solution] > date1 && solved_incident[:date_solution] < date2

        solved_cases += 1
        start_date = Date.parse(solved_incident[:date_incident])
        end_date = Date.parse(solved_incident[:date_solution])
        solution_time << (end_date - start_date).to_i
      end
      average_solution = (solution_time.sum / solution_time.size)

      open_incidents = @incidents.find_all { |incident| incident[:status] == "open" }
      open_incidents.each do |open_incident|
        next unless open_incident[:date_incident] > date1 && open_incident[:date_incident] < date2

        open_cases += 1
        start_date = Date.parse(open_incident[:date_incident])
        end_date = Date.today
        solution_time << (end_date - start_date).to_i
      end
      solution_time.sort!

      incidents_status[:open_cases] = open_cases
      incidents_status[:closed_cases] = solved_cases
      incidents_status[:average_solution] = average_solution
      incidents_status[:maximum_solution] = solution_time[-1]
      puts incidents_status
    else
      puts "The minimum date (#{date1}), must be less than the maximum one (#{date2})"
    end
  end
end

incidents = [
  { description: "The floor in the fruit area is dirty",
    status: "solved",
    date_incident: "2022-03-17",
    date_solution: "2022-03-18" },
  { description: "The refrigerator from beverage area doesn't work",
    status: "open",
    date_incident: "2022-03-20" },
  { description: "The store's air conditioner needs maintenance",
    status: "open",
    date_incident: "2022-03-24" },
  { description: "A water leak is filtering unto a wall near to the bathroom",
    status: "solved",
    date_incident: "2022-04-05",
    date_solution: "2022-04-10" }
]

some_store = Store.new(incidents)
some_store.incident_status("2022-04-01", "2022-03-21")
