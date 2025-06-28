require 'csv'

module SecretSanta
  class AssignmentExporterError < StandardError; end

  class AssignmentExporter
    def self.export(assignments, output_path)
      raise AssignmentExporterError, "Assignments are empty" if assignments.nil? || assignments.empty?

      begin
        CSV.open(output_path, 'w') do |csv|
          csv << %w[Employee_Name Employee_EmailID Secret_Child_Name Secret_Child_EmailID]
          assignments.each do |giver, receiver|
            csv << [giver.name, giver.email, receiver.name, receiver.email]
          end
        end
      rescue Errno::EACCES => e
        raise AssignmentExporterError, "Permission denied to write to file: #{output_path}"
      rescue Errno::ENOENT => e
        raise AssignmentExporterError, "Output path does not exist: #{output_path}"
      rescue CSV::MalformedCSVError => e
        raise AssignmentExporterError, "Malformed CSV data: #{e.message}"
      rescue StandardError => e
        raise AssignmentExporterError, "Failed to export assignments: #{e.message}"
      end
    end
  end
end
