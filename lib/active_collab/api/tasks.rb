require 'active_collab/task'

module ActiveCollab
  module API
    module Tasks

      def tasks(project_id)
        response_tasks = ac_get_request("projects/#{project_id}/tasks")
        if response_tasks.kind_of?(Hash)
          ActiveCollab::Task.new(response_tasks)
        elsif response_tasks.kind_of?(Array)
          response_tasks.collect do |task|
            ActiveCollab::Task.new(task)
          end
        else
          response_tasks
        end
      end

    end
  end
end


