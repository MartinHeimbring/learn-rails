class Visitor < ActiveRecord::Base
  has_no_table
  column :email, :string
  validates_presence_of :email
   validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  
  def subscribe
    mailchimp = Gibbon::API.new
    result = mailchimp.lists.subscribe({
      :id => ENV["MAILCHIMP_LIST_ID"], 
      :email => {:email => self.email}, 
      :merge_vars => {:FNAME => 'First Name', :LNAME => 'Last Name'}, 
      :double_optin => false,
      :update_existing => true,
      :send_welcome => true
      })    
  end
end