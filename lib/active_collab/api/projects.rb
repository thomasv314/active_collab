require 'active_collab/project'

module ActiveCollab
	module API
		module Projects

			def projects
        projects_response = ac_get_request("/projects")
        if projects_response
          if projects_response.kind_of? Hash
            [ ActiveCollab::Project.new(projects_response, self) ]
          else projects_response.kind_of? Array
            projects_response.collect do |project|
              ActiveCollab::Project.new(project, self)
            end
          end
        else
          false
        end
			end

		end
	end
end
