class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    @topic = @comment.topic
    @notification = @comment.notifications.build(user_id: @topic.user_id)

    respond_to do |format|
      if @comment.save
        format.html {redirect_to topic_path(@topic), notice: "コメントを投稿しました。"}
        format.js {render :index}
        unless @comment.topic.user_id == current_user.id
          pusher_comment(@comment)
        end
        pusher_notification_count(@comment)
      else
        format.html {render :new}
      end
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to topic_path(@topic)
    else
      render :edit
    end
  end

  def destroy
    respond_to do |format|
      if @comment.destroy
        format.html {redirect_to topic_path(@topic), notice: 'コメントを削除しました。'}
        format.js {render :index}
      end
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:topic_id, :content)
    end

    def set_comment
      @comment = Comment.find(params[:id])
      @topic = @comment.topic
    end

    def pusher_comment(comment)
      Pusher.trigger("user_#{comment.topic.user_id}_channel", "comment_created", {
        message: 'あなたの投稿にコメントがありました'
      })
    end

    def pusher_notification_count(comment)
      Pusher.trigger("user_#{comment.topic.user_id}_channel", 'notification_created', {
        unread_counts: Notification.where(user_id: comment.topic.user.id, read: false).count
      })
    end
end
