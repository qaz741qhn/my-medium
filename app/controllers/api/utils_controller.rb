class Api::UtilsController < Api::BaseController
  IMAGE_EXT = [".gif", ".jpeg", ".jpg", ".png", ".svg"]

  def upload_image
    f = params[:file]

    # 檢查圖片副檔名格式是否合格
    ext = File.extname(f.original_filename)
    raise "Not Allowed" unless IMAGE_EXT.include?(ext)

    # 使用create_after_upload方法：Returns a saved blob instance after the io has been uploaded to the service
    blob = ActiveStorage::Blob.create_after_upload!(
      io: f,
      filename: f.original_filename,
      content_type: f.content_type
    )

    # render超連結，讓前端的編輯器可使用此連結顯示圖片
    render json: { link: url_for(blob) }
  end

end
