module SecretSanta
  class SecretSantaAssignmentError < StandardError; end

  class SecretSanta
    def initialize(employees, previous_assignments = {})
      raise SecretSantaAssignmentError, "Employees list cannot be empty" if employees.nil? || employees.empty?

      @employees = employees.shuffle
      @previous_assignments = previous_assignments || {}
    end

    def generate_assignments
      max_attempts = 20
      max_attempts.times do
        shuffled = @employees.shuffle
        assignment = {}

        @employees.each_with_index do |giver, idx|
          candidate = shuffled[idx]

          # Conflict check: self-assignment or past assignment
          if giver == candidate || @previous_assignments[giver.email]&.include?(candidate.email)
            break
          end

          assignment[giver] = candidate
        end

        return assignment if assignment.size == @employees.size
      end

      raise SecretSantaAssignmentError, "Unable to generate non-conflicting assignments after #{max_attempts} attempts."
    end
  end
end
