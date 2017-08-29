module SayHi
  class Presenter < ViewElements::ViewElement

    def full_name
      "#{locals[:first_name]} #{locals[:last_name]}"
    end
  end
end
