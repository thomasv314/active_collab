require 'active_collab/project'

module ActiveCollab
	module API
		module Projects

			def projects
        projects_response = ac_get_request("/projects")
        if projects_response
          if projects_response.kind_of? Hash
            [ ActiveCollab::Project.new(projects_response, self) ]
          elsif projects_response.kind_of? Array
            puts "WOW WAT?: #{projects_response.class}"
            puts projects_response
            projects_response.collect do |project|
              ActiveCollab::Project.new(project, self)
            end
          else
            [] 
          end
        else
          false
        end
			end

      def project(id)
        project_response = ac_get_request("/projects/#{id}")
        if project_response
          ActiveCollab::Project.new(project_response)
        else
          false
        end
      end

    end
	end
end
