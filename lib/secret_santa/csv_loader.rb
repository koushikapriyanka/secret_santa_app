require 'csv'

module SecretSanta
  class CsvLoader
    class CsvLoaderError < StandardError; end

    def self.load_employees(file_path)
      raise CsvLoaderError, "Input file not found: #{file_path}" unless File.exist?(file_path)

      begin
        employees = CSV.read(file_path, headers: true, encoding: 'bom|utf-8').map do |row|
          if row['Employee_Name'].nil? || row['Employee_EmailID'].nil?
            raise CsvLoaderError, "Invalid row in employees CSV: #{row.inspect}"
          end
          Employee.new(row['Employee_Name'], row['Employee_EmailID'])
        end

        if employees.empty?
          raise CsvLoaderError, "No employee records found in file: #{file_path}"
        end

        employees
      rescue CSV::MalformedCSVError => e
        raise CsvLoaderError, "Malformed CSV at #{file_path}: #{e.message}"
      rescue => e
        raise CsvLoaderError, "Unexpected error loading employees from #{file_path}: #{e.message}"
      end
    end

    def self.load_previous_assignments(file_path)
      return {} unless File.exist?(file_path)

      begin
        CSV.read(file_path, headers: true).each_with_object({}) do |row, memo|
          if row['Employee_EmailID'].nil? || row['Secret_Child_EmailID'].nil?
            warn "Skipping invalid assignment row: #{row.inspect}"
            next
          end

          memo[row['Employee_EmailID']] ||= []
          memo[row['Employee_EmailID']] << row['Secret_Child_EmailID']
        end
      rescue CSV::MalformedCSVError => e
        raise CsvLoaderError, "Malformed previous assignments CSV at #{file_path}: #{e.message}"
      rescue => e
        raise CsvLoaderError, "Unexpected error loading previous assignments: #{e.message}"
      end
    end
  end
end
