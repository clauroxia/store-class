require "minitest/autorun"
require_relative "store"

class StoreTest < Minitest::Test
  def test_create_a_new_store
    incidents = INCIDENTS
    store = Store.new(incidents)
    assert_instance_of(Store, store)
  end

  def test_raise_error_empty_incidents
    incidents = ""

    assert_raises(StandardError) do
      Store.new(incidents)
    end
  end

  def test_raise_error_empty_date
    incidents = INCIDENTS
    date1 = ""
    date2 = "2022-04-22"
    store = Store.new(incidents)

    assert_raises(StandardError) do
      store.incident_status(date1, date2)
    end
  end
end
