class Invite < ActiveRecord::Base
  belongs_to :event
  
  def self.getinvite
    @users = User.all
      @users.each do |user|
          @events = user.event
           @events.each do |event|
           @url_new_string = 'https://graph.facebook.com/'+event.facebook_event_id.to_s+'/invited?access_token='+user.access_token.to_s
            response = HTTParty.get(@url_new_string.to_str)
                            response['data'].each do |data|
                            @invite = Invite.new(
                                :facebook_event_id => event.facebook_event_id.to_s,
                                :name => data['name'],
                                :rsvp_status => data['rsvp_status']
                              )
                            @invite_exsist = Invite.find_by_facebook_event_id_and_name(event.facebook_event_id.to_s,data['name'])
                                if !@invite_exsist.nil?
                                  if (@invite_exsist.facebook_event_id.to_s == event.facebook_event_id.to_s && @invite_exsist.name == data['name'])
                                    puts "Invite exist!"
                                    else
                                        if @invite.save
                                           puts "To #{data['name']} sends invite to #{event.name} event!"
                                        else
                                           puts "This didn't send!"
                                        end
                                  end
                                else
                                   if @invite.save
                                       puts "To #{data['name']} sends invite to #{event.name} event!"
                                   else
                                       puts "This didn't send!"
                                   end
                                end
                            end
           end
      end
  end
end
