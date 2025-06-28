namespace :secret_santa do
  desc "Run Secret Santa assignment"
  task run: :environment do
    include ::SecretSanta

    begin
      input_path = Rails.root.join('data/employees.csv')
      previous_path = Rails.root.join('data/last_year.csv')
      output_path = Rails.root.join('data/output_assignments.csv')

      employees = SecretSanta::CsvLoader.load_employees(input_path)
      previous_assignments = SecretSanta::CsvLoader.load_previous_assignments(previous_path)

      generator = SecretSanta::SecretSanta.new(employees, previous_assignments)
      assignments = generator.generate_assignments

      SecretSanta::AssignmentExporter.export(assignments, output_path)
      puts "Secret Santa assignments generated at: #{output_path}"

    rescue SecretSanta::CsvLoaderError => e
      puts "CSV Loading Error: #{e.message}"
    rescue SecretSanta::SecretSantaAssignmentError => e
      puts "Assignment Generation Error: #{e.message}"
    rescue SystemCallError => e
      puts "File System Error: #{e.message}"
    rescue StandardError => e
      puts "Unexpected Error: #{e.class} - #{e.message}"
      puts e.backtrace.join("\n")
    end
  end
end
