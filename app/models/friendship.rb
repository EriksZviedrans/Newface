class Friendship < ActiveRecord::Base
  def self.getfriendships
      @users = User.all
      @users.each do |user|
         if(!user.facebookid.nil? and user.access_token.length > 5)
                @url_new_string = 'https://graph.facebook.com/'+user.facebookid.to_s+'/friends?access_token='+user.access_token.to_s
                response = HTTParty.get(@url_new_string.to_str)
                            response['data'].each do |data|
                              id_user = user.id
                              friend = User.find_by_facebookid(data['id'].to_s)
                              @friendship = Friendship.new(
                                :id_user => id_user,
                                :id_friend => friend.id
                              )
                              @exsist_friends = Friendship.find_by_id_user_and_id_friend(id_user, friend)
                              if !@exsist_friends.nil?
                                if (@exsist_friends.id_user == id_user and @exsist_friends.id_friend == friend.id) or (@exsist_friends.id_user == friend.id and @exsist_friends.id_friend == id_user)
                                  puts "Friends exist!"
                                else
                                  if @friendship.save
                                       puts "#{user.fullname} and #{friend.fullname} are friends!"
                                   else
                                       puts "This didn't save!"
                                   end
                                end
                              else 
                                   if @friendship.save
                                       puts "#{user.fullname} and #{friend.fullname} are friends!"
                                   else
                                       puts "This didn't save!"
                                   end
                              end   
                            end
               end
          end
    
  end
end
