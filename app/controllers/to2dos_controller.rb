class To2dosController < ApplicationController
  respond_to :html, :json
 
  # GET /to2dos
  # GET /to2dos.json
  def index
    @to2dos = To2do.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @to2dos }
    end
  end

  # GET /to2dos/1
  # GET /to2dos/1.json
  def show
    @to2do = To2do.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @to2do }
    end
  end

  # GET /to2dos/new
  # GET /to2dos/new.json
  def new
    @to2do = To2do.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @to2do }
    end
  end

  # GET /to2dos/1/edit
  def edit
    @to2do = To2do.find(params[:id])
  end

  # POST /to2dos
  # POST /to2dos.json
  def create
    @to2do = To2do.new(params[:to2do])

    respond_to do |format|
      if @to2do.save
        format.html { redirect_to @to2do, notice: 'To2do was successfully created.' }
        format.json { render json: @to2do, status: :created, location: @to2do }
      else
        format.html { render action: "new" }
        format.json { render json: @to2do.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /to2dos/1
  # PUT /to2dos/1.json
  def update
    @to2do = To2do.find(params[:id])

    respond_with @to2do
  end

  # DELETE /to2dos/1
  # DELETE /to2dos/1.json
  def destroy
    @to2do = To2do.find(params[:id])
    @to2do.destroy

    respond_with @to2do
  end
end
