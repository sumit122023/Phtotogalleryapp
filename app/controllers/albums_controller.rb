class AlbumsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_album, only: [:show, :edit, :update, :destroy]

    def index
        # @albums = Album.all
    @albums = Album.where(published: true)
      end
      def show
        @album = Album.find(params[:id])
      end
      
      def new
        @album = Album.new
      end
      def user_albums
        @user = User.find(params[:user_id])
        @albums = @user.albums
      end

      def create
        # @album = Album.new(album_params)
        @album = current_user.albums.new(album_params)
        if @album.save
          process_tags
          redirect_to @album
        else
          render :new, status: :unprocessable_entity
        end
      end

      def edit
        @album = Album.find(params[:id])
      end
    
      def update
        @album = Album.find(params[:id])
    
        if @album.update(album_params)
          process_tags
          redirect_to @album
        else
          render :edit, status: :unprocessable_entity
        end
      end

      def destroy
        @album = Album.find(params[:id])
        @album.destroy
    
        redirect_to root_path, status: :see_other
      end
    
      def delete_image
        @album = Album.find(params[:id])
       image_attachment = @album.images.find(params[:image_id])
       image_attachment.purge 
       redirect_to @album, alert: "image attachment deleted."
      end

      private

      def set_album
        @album = Album.find(params[:id])
      end

      def process_tags
        tag_names = params[:album][:tag_names].split(',').map(&:strip)
        tag_names.each do |tag_name|
          tag = Tag.find_or_create_by(name: tag_name)
          @album.tags << tag unless @album.tags.include?(tag)
        end
      end   
end
private
def album_params
  params.require(:album).permit(:name, :description, :price, :published, :cover_image, :tag_ids, images: [])
end