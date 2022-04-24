require "minitest/autorun"
require_relative "store"

class StoreTest < Minitest::Test
  def setup
    super
    @incidents = INCIDENTS
    @time_incidents = []
  end

  def test_create_a_new_store
    store = Store.new(@incidents)

    assert_instance_of(Store, store)
    assert_equal(@time_incidents, [])
  end

  def test_raise_error_empty_incidents
    incidents = ""

    assert_raises(StandardError) do
      Store.new(incidents)
    end
  end

  def test_raise_error_empty_date
    date1 = ""
    date2 = "2022-04-30"
    store = Store.new(@incidents)

    assert_raises(StandardError) do
      store.incident_status(date1, date2)
    end
  end

  def test_date1_is_less_than_date2
    date1 = "2022-03-20"
    date2 = "2022-04-30"
    store = Store.new(@incidents)
    store.incident_status(date1, date2)

    assert(date1 < date2)
  end

  def test_open_cases
    @incidents.each do |incident|
      assert_nil(incident[:date_solution]) if incident[:status] == "open"
    end
  end
end
