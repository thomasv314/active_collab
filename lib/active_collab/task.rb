class ActiveCollab::Task

  attr_accessor :id, :name, :permalink, :state, :visibility, :is_completed, 
    :comments_url, :comments_count, :is_locked, :subtasks_url,
    :total_subtasks, :open_subtasks, :completed_subtasks, :attachments_url,
    :attachments_count, :assignee_id, :delegated_by_id, :other_assignee_ids,
    :category_id, :label_id, :user_is_subscribed, :version, :priority, :due_on,
    :project_id, :milestone_id, :task_id


  def initialize(hash = {})
    set_attributes(hash)
  end

  def set_attributes(hash)
    hash.each do |key, value|
      method = "#{key}="
      if self.class.method_defined? method
        self.send(method, value)
      end
    end
  end

  def saved?
    id.nil?
  end

  def self.from_hash(hash)
    task = ActiveCollab::Task.new(hash)
  end


end
