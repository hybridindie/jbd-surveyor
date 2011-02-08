require 'rails/generators'
require 'rails/generators/migration'
#require 'rails/generators/resource_helpers' 
require 'rails/generators/active_record'

class SurveyorGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  #include Rails::Generators::ResourceHelpers

  def self.source_root
    @source_root ||= File.join(File.dirname(__FILE__), 'templates')
  end

  def self.next_migration_number(dirname)
    ActiveRecord::Generators::Base.next_migration_number(dirname)
    # orm = Rails.configuration.generators.options[:rails][:orm]
    #  require "rails/generators/#{orm}"
    #     "#{orm.to_s.camelize}::Generators::Base".constantize.next_migration_number(dirname)
   # debugger
   # if ActiveRecord::Base.timestamped_migrations
      # Time.now.utc.strftime("%Y%m%d%H%M%S")
    # else
      # "%.3d" % (current_migration_number(dirname) + 1)
    # end
  end 

  def create_migrations
    ordered_migrations = [ "create_surveys", "create_survey_sections", 
      "create_questions", "create_question_groups", "create_answers",   
      "create_response_sets", "create_responses", 
      "create_dependencies", "create_dependency_conditions", 
      "create_validations", "create_validation_conditions", 
      "add_display_order_to_surveys", "add_correct_answer_id_to_questions",
      "add_index_to_response_sets", "add_index_to_surveys", 
      "add_unique_indicies", "add_section_id_to_responses", "add_default_value_to_answers"]

    ordered_migrations.each do |migration| 
      migration_template "migrate/#{migration}.rb", "db/migrate/#{migration}.rb" 
     end

    # Dir.new(File.join(SurveyorGenerator.source_root , 'migrate')).entries.sort.each do |migration|
    #   migration_template "migrate/#{migration}", "db/migrate/#{migration}" unless File.directory?(migration)
    # end

  end

  def copy_some_assets
    copy_dir('assets/images', 'public/images/surveyor')
    copy_dir('assets/javascripts', 'public/javascripts/surveyor')
    copy_dir('assets/stylesheets', 'public/stylesheets/surveyor')

    # Dir.new(File.join(SurveyorGenerator.source_root , 'assets')).entries.each do |asset|
    #   copy_file asset, "public/#{asset}" unless File.directory?(asset)

    # end
   #copy_dir('assets
    copy_file "assets/stylesheets/sass/surveyor.sass", "public/stylesheets/sass/surveyor.sass"
 end

  def copy_locales
    copy_dir('locales', 'config/locales')
  end

  def copy_sample_surveys
    copy_dir("surveys")
    empty_directory "surveys/fixtures"
  end

  def show_readme
    readme "README" if behavior == :invoke
  end

  private

  #source dir is relative to the template dir target_dir relative to the rails root
  def copy_dir(source_dir, target_dir = nil)
    target_dir = source_dir if target_dir.nil?
    Dir.new(File.join(SurveyorGenerator.source_root , source_dir)).entries.each do |file_name|
      file = File.join(source_dir, file_name)
      file_full_path = File.join(SurveyorGenerator.source_root, file)
      # debugger if file.include? "images"
      copy_file file, "#{target_dir}/#{file_name}" unless File.directory?(file_full_path)
    end
  end
end
