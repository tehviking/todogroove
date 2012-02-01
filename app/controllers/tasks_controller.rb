class TasksController < ApplicationController
  # GET /tasks
  # GET /tasks.xml
  def index
    # this sholud be Tasks for current_user (or redirect to login)
    @all_tasks = Task.where(:user_id => current_user.id).ordered_tasks.reject {|t| t.archived }
    @task = Task.new # for quick-add
    @estimated_pomodoros = 0
    @completed_pomodoros = 0

    # HACK: Task(1).tag('Home') is a totally different object than Task(2).tag('Home'). Uniquify here.
    @tag_counts = Hash.new(0)
    @all_tasks.each do |task|
      task.tags.each do |tag|
        @tag_counts[tag.slug] += 1
      end
    end
    @tags = @tag_counts.keys.map {|tag| Tag.new :name => tag }

    # HACK: this should be a proper sort...
    # TODO: see mongoid.org, need to do Task.where(tag: @tag) etc.
    @list_title, @tasks = if params[:tag]
                            [params[:tag], @all_tasks.reject {|task| !task.tags.map(&:slug).include?(params[:tag].downcase)}]
                          else
                            ['All', @all_tasks]
                          end
    @tasks.each do |task|
      @estimated_pomodoros += task.estimated_pomodoros
      @completed_pomodoros += task.completed_pomodoros
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasks }
    end
  end

  def sort
    params[:task].each_with_index do |id, index|
      task = Task.find(id)
      task.pos = index + 1
      task.save
    end
    
    render :nothing => true
  end

  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # GET /tasks/1/complete
  def complete
    if task = Task.find(params[:id])
      task.done = true
      task.save
    end
    redirect_to request.referer
  end

  # GET /tasks/1/uncomplete
  def uncomplete
    if task = Task.find(params[:id])
      task.done = false
      task.save
    end
    redirect_to request.referer
  end

  def tick_pom
    if task = Task.find(params[:id])
      task.completed_pomodoros += 1
      task.estimated_pomodoros = [task.completed_pomodoros, task.estimated_pomodoros].max
      task.save
    end
    redirect_to request.referer
  end

  def untick_pom
    if task = Task.find(params[:id])
      if task.completed_pomodoros > 0
        task.completed_pomodoros -= 1
      end
      task.save
    end
    redirect_to request.referer
  end

  def add_estimated_pom
    if task = Task.find(params[:id])
      task.estimated_pomodoros += 1
      task.save
    end
    redirect_to request.referer
  end

  def remove_estimated_pom
    if task = Task.find(params[:id])
      if task.estimated_pomodoros > 0
        task.estimated_pomodoros -= 1
        task.completed_pomodoros = [task.completed_pomodoros, task.estimated_pomodoros].min
      end
      task.save
    end
    redirect_to request.referer
  end

  # POST /tasks
  # POST /tasks.xml
  def create
    params[:task][:tags] = reify_tags(params[:task][:tags])

    @task = Task.new(params[:task])
    @task.user_id = current_user.id

    if @task.save
      redirect_to params[:redirect_to] ? tagged_tasks_url(params[:redirect_to]) : tasks_url
    else
      respond_to do |format|
        format.html { render :action => "new" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    @task = Task.find(params[:id])
    @task.tags = []
    params[:task][:tags] = reify_tags(params[:task][:tags])

    if @task.update_attributes(params[:task])
      redirect_to tasks_url
    else
      respond_to do |format|
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to(request.referer) }
      format.xml  { head :ok }
    end
  end
  
  def archive
    @task = Task.find(params[:id])
    @task.update_attribute :archived, true
    redirect_to request.referer
  end
  
  def unarchive
    @task = Task.find(params[:id])
    @task.update_attribute :archived, false
    redirect_to request.referer    
  end
  
  def archived
    @archived_tasks = Task.where(:archived => true)
  end
  
  private

  def reify_tags(tag_names="")
    tag_names ||= ""
    tag_names.split(/,/).map {|tag| Tag.new :name => tag.strip }
  end


end

