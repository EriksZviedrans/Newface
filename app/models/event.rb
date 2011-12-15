class Event < ActiveRecord::Base
   belongs_to :user
 def self.getevents
  @users = User.all
  @users.each do |user|
         if(!user.facebookid.nil? and user.access_token.length > 5)
                @url_new_string = 'https://graph.facebook.com/'+user.facebookid.to_s+'/events?access_token='+user.access_token.to_s
                response = HTTParty.get(@url_new_string.to_str)
                            response['data'].each do |data|
                                events_url = 'https://graph.facebook.com/'+data['id'].to_s+'/?access_token='+user.access_token.to_s
                                event = HTTParty.get(events_url.to_str)
                                    if (event['privacy'] == 'OPEN')
                                      privacy = true
                                    else
                                      privacy = false
                                    end
                                    @event = Event.new(
                                      :user_id => user.id,
                                      :name => event['name'],
                                      :facebook_event_id => event['id'],
                                      :descritption => event['location'],
                                      :location => event['name'],
                                      :startTime => event['start_time'],
                                      :endTime => event['end_time'],
                                      :privacy => privacy
                                    )
                                    @exisit_event = Event.find_by_facebook_event_id(@event.facebook_event_id)
                                          if !@exisit_event.nil? and @exisit_event.facebook_event_id == @event.facebook_event_id
                                            puts "event #{@event.name} exist!"
                                          else
                                              if @event.save
                                                puts "event #{@event.name} saved!"
                                              else
                                                puts "event #{@event.name} didn't save!"
                                              end
                                          end
                            end
               end
          end
 end
end
