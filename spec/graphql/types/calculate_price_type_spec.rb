
require "rails_helper"

RSpec.describe  do

	describe Types::CalculatePriceType do
	  subject { described_class }
	 	 it { is_expected.to have_a_field(:price).of_type('Float!') }
	 	 it { is_expected.to have_a_field(:currency).of_type('String!') }
	  	it { is_expected.to have_a_field(:type).of_type('String!') }
	 end
end