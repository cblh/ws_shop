# encoding: utf-8
class UserController < ApplicationController
  before_action :authenticate_user!
  def edit_info
    @user = User.find_by(id: current_user.id)
  end

  def update_info
  end

  def sent_code
    @user = User.find_by(email: current_user.email)
    phone = user_info_params[:phone]
    new_code = 1234
    @user.update( phone: phone, code: new_code )
    @user.save


    # TODO 将API key写入config
    ChinaSMS.use :yunpian, password: '83bda118162228728f7193c194a9766c'
    tpl_params = { code: new_code, company: '微商平台'}
    # raise "开始验证"
    ChinaSMS.to phone, tpl_params, tpl_id: 1
    render :edit_info
  end

  def valid_phone
  end

  def user_info_params
    params[:user].permit(:phone, :code)
  end
end
