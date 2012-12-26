require 'active_collab/object'

class ActiveCollab::Project < ActiveCollab::Object::Record

  include ActiveCollab::Object::Saveable

  has_save_routes({
    :create => "/projects/add",
    :update => "/projects/:id/edit"
  })

  attr_accessor :id, :name, :permalink, :class, :verbose_type, :verbose_type_lowercase, :urls, :permissions, :created_on, :created_by_id, :updated_on, :updated_by_id, :state, :is_archived, :is_trashed, :completed_on, :completed_by_id, :is_completed, :avatar, :category_id, :label_id, :is_favorite, :custom_fields, :icon, :overview, :overview_formatted, :currency_code, :based_on, :status_verbose, :progress, :budget, :leader_id, :company_id 

  def tasks
    if !@client.nil?
      @client.tasks(self.id)
    else
      []
    end
  end

  def new_task
    ActiveCollab::Task.new(project_id: id)
  end

end
