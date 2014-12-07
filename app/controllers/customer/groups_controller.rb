class Customer::GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy,:set_defalut_group]
    layout 'customerlayout'
  # GET /groups
  # GET /groups.json
  def index
    #@groups = Group.all
    @groups = User.find(session[:user_id]).groups
    
    @default_group_id=User.find(session[:user_id]).default_group_id
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    #@group = Group.new(group_params)
    @user = User.find(session[:user_id])
    
    @group = @user.groups.create(group_params)

    respond_to do |format|
      if true
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def set_default_group
  
    @user=User.find(session[:user_id])
    @user.default_group_id=params[:id]
    @user.save
    redirect_to groups_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
       params.require(:group).permit(:name, :description, :create_time, :status)
    end
end
