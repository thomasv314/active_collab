require 'active_collab/object'
class ActiveCollab::Task < ActiveCollab::Object 
  
  attr_accessor :id, :name, :permalink, :state, :visibility, :is_completed, 
    :comments_url, :comments_count, :is_locked, :subtasks_url,
    :total_subtasks, :open_subtasks, :completed_subtasks, :attachments_url,
    :attachments_count, :assignee_id, :delegated_by_id, :other_assignee_ids,
    :category_id, :label_id, :user_is_subscribed, :version, :priority, :due_on,
    :project_id, :milestone_id, :task_id

end
