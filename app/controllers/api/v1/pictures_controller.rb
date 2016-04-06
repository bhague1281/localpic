class Api::V1::PicturesController < ApplicationController
  def index
    @pictures = Picture.all
    if @pictures
      render json: @pictures,
             each_serializer: PictureSerializer,
             root: "pictures"
    else
      @error = Error.new(:text => "404 not found",
                         :status => 404,
                         :url => request.url,
                         :method => request.method)
      render :json => @error.serializer
    end
  end

  def show
    if @picture
      render json: @picture,
             serializer: PictureSerializer,
             root: "picture"
    else
      @error = Error.new(:text => "404 not found",
                         :status => 404,
                         :url => request.url,
                         :method => request.method)
      render :json => @error.serializer
    end
  end

  def create
    @picture = Picture.new(picture_params)

    if @picture.save
      render json: @picture,
             serializer: PictureSerializer,
             meta: {
               status: 201,
               message: "201 Created",
               location: @picture
             },
             root: "picture"
    else
      @error = Error.new(:text => "500 Server Error",
                         :status => 500,
                         :url => request.url,
                         :method => request.method)
      render :json => @error.serializer
    end
  end

  def update
  end

  def delete
  end

  private

  def picture_params
    params.require(:picture).permit(:title, :image)
  end
end
