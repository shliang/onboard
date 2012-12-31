class Fb

  @graph = nil      # Facebook Graph API
  @profile = nil    # Hash
  @facebook = nil   # Boolean (is this a facebook account?)
  @friends = nil    # Array
  @feed = nil       # 
  
  @last_user = nil
  
  fbs = nil
  
  fbs = Array.new #HashWithIndifferentAccess
  
  def setup(user)
    
    return if @last_user == user
      
    if @graph.nil?
      s = user.services.find_by_provider(:facebook)
      # logger.info "~~~~~~~~~~~~~~~~~ fb#initialize  service: " + s.to_yaml
      if s
        @facebook = true
        @graph = Koala::Facebook::API.new(s.token)
        @profile = ::Hashie::Mash.new @graph.get_object("me")
        # logger.info "~~~~~~~~~~~~~~~~~ fb#initialize  @profile: " + @profile.to_yaml
        
        @friends = @graph.get_connections("me", "friends")
        # @graph.get_connections("me", "friends").each { |f| @friends << @graph.get_object(f['id']) }
        # logger.info "~~~~~~~~~~~~~~~~~ fb#initialize  friends: " + friends.class.to_s
        # logger.info "~~~~~~~~~~~~~~~~~ fb#initialize  friends: " + friends.to_yaml
  
        # @feed = @graph.get_connections("me", "feed")
        # logger.info "~~~~~~~~~~~~~~~~~ fb#initialize  feed: " + feed.to_yaml
        
        
      else
        @facebook = false
      end
    end
  end
  
  def graph
    @graph
  end
  
  def profile
    @profile
  end
  
  def friends
    @friends
  end
  
  def feed
    @feed
  end
  # 
  # 
  # 
  # def self.all
  #   # @fbs = [ {"id"=>"100001501410086_441554129237964", "from"=>{"name"=>"Alberto Fedregotti", "id"=>"100001501410086"}, "story"=>"Alberto Fedregotti likes Ponga.", "story_tags"=>{"0"=>[{"id"=>"100001501410086", "name"=>"Alberto Fedregotti", "offset"=>0, "length"=>18, "type"=>"user"}], "25"=>[{"id"=>"265167336895863", "name"=>"Ponga", "offset"=>25, "length"=>5, "type"=>"page"}]}, "picture"=>"https://fbcdn-@profile-a.akamaihd.net/h@profile-ak-snc7/372786_265167336895863_1792376175_n.jpg", "link"=>"http://www.@facebook.com/Pongacom?ref=stream", "name"=>"Ponga", "caption"=>"Website", "description"=>"Make pictures useful.", "icon"=>"https://fbstatic-a.akamaihd.net/rsrc.php/v2/yN/r/xC785tTCIQO.gif", "privacy"=>{"value"=>""}, "type"=>"link", "application"=>{"name"=>"Pages", "id"=>"2530096808"}, "created_time"=>"2012-12-07T00:33:07+0000", "updated_time"=>"2012-12-07T00:33:07+0000", "comments"=>{"count"=>0}}, {"id"=>"100001501410086_422325577827486", "from"=>{"name"=>"Alberto Fedregotti", "id"=>"100001501410086"}, "story"=>"Alberto Fedregotti and Georges El Khoury are now friends.", "story_tags"=>{"0"=>[{"id"=>"100001501410086", "name"=>"Alberto Fedregotti", "offset"=>0, "length"=>18, "type"=>"user"}], "23"=>[{"id"=>"2047665", "name"=>"Georges El Khoury", "offset"=>23, "length"=>17, "type"=>"user"}]}, "privacy"=>{"value"=>""}, "type"=>"status", "status_type"=>"approved_friend", "created_time"=>"2012-10-17T21:50:09+0000", "updated_time"=>"2012-10-17T21:50:09+0000", "comments"=>{"count"=>0}}, {"id"=>"100001501410086_406130616113649", "from"=>{"name"=>"Alberto Fedregotti", "id"=>"100001501410086"}, "story"=>"Alberto Fedregotti activated Facebook Mobile.", "story_tags"=>{"0"=>[{"id"=>"100001501410086", "name"=>"Alberto Fedregotti", "offset"=>0, "length"=>18, "type"=>"user"}]}, "privacy"=>{"value"=>""}, "type"=>"status", "application"=>{"name"=>"Mobile", "id"=>"1394457661837"}, "created_time"=>"2012-09-03T23:09:02+0000", "updated_time"=>"2012-09-03T23:09:02+0000", "comments"=>{"count"=>0}}, {"id"=>"100001501410086_378897218836989", "from"=>{"name"=>"Alberto Fedregotti", "id"=>"100001501410086"}, "story"=>"Alberto Fedregotti and John Doe are now friends.", "story_tags"=>{"0"=>[{"id"=>"100001501410086", "name"=>"Alberto Fedregotti", "offset"=>0, "length"=>18, "type"=>"user"}], "23"=>[{"id"=>"100002297919756", "name"=>"John Doe", "offset"=>23, "length"=>8, "type"=>"user"}]}, "privacy"=>{"value"=>""}, "type"=>"status", "status_type"=>"approved_friend", "created_time"=>"2012-06-24T00:36:38+0000", "updated_time"=>"2012-06-24T00:36:38+0000", "comments"=>{"count"=>0}}, {"id"=>"100001501410086_197269336999779", "from"=>{"name"=>"Alberto Fedregotti", "id"=>"100001501410086"}, "story"=>"Alberto Fedregotti changed his About Me.", "story_tags"=>{"0"=>[{"id"=>"100001501410086", "name"=>"Alberto Fedregotti", "offset"=>0, "length"=>18, "type"=>"user"}]}, "privacy"=>{"value"=>""}, "type"=>"status", "created_time"=>"2011-08-11T19:56:11+0000", "updated_time"=>"2011-08-11T19:56:11+0000", "comments"=>{"count"=>0}}, {"id"=>"100001501410086_197267057000007", "from"=>{"name"=>"Alberto Fedregotti", "id"=>"100001501410086"}, "story"=>"Alberto Fedregotti changed his Website.", "story_tags"=>{"0"=>[{"id"=>"100001501410086", "name"=>"Alberto Fedregotti", "offset"=>0, "length"=>18, "type"=>"user"}]}, "privacy"=>{"value"=>""}, "type"=>"status", "created_time"=>"2011-08-11T19:50:33+0000", "updated_time"=>"2011-08-11T19:50:33+0000", "comments"=>{"count"=>0}}, {"id"=>"100001501410086_197266813666698", "from"=>{"name"=>"Alberto Fedregotti", "id"=>"100001501410086"}, "story"=>"Alberto Fedregotti added Tennis to his favorite sports.", "story_tags"=>{"0"=>[{"id"=>"100001501410086", "name"=>"Alberto Fedregotti", "offset"=>0, "length"=>18, "type"=>"user"}], "25"=>[{"id"=>"105650876136555", "name"=>"Tennis", "offset"=>25, "length"=>6, "type"=>"page"}]}, "privacy"=>{"value"=>""}, "type"=>"status", "created_time"=>"2011-08-11T19:50:05+0000", "updated_time"=>"2011-08-11T19:50:05+0000", "comments"=>{"count"=>0}} ]
  #   fbs = [ {"id"=>"100001501410086", "name"=>"Alberto Fedregotti", "first_name"=>"Alberto", "last_name"=>"Fedregotti", "link"=>"http://www.@facebook.com/alberto.fedregotti", "username"=>"alberto.fedregotti", "hometown"=>{"id"=>"114952118516947", "name"=>"San Francisco, California"}, "location"=>{"id"=>"110843418940484", "name"=>"Seattle, Washington"}, "bio"=>"If people speak of me, do I exist?", "quotes"=>"\"The best way to predict the future is to invent it.\" Alan Kay", "sports"=>[{"id"=>"105650876136555", "name"=>"Tennis"}], "gender"=>"male", "email"=>"albertofedregotti@gmail.com", "timezone"=>-8, "locale"=>"en_US", "verified"=>true, "updated_time"=>"2012-11-11T23:01:20+0000"}  ]
  # end
  
  
  # %h1 Listing fbs
  # 
  #   %table
  #     %tr
  #       %th
  #       %th
  #       %th
  # 
  #     / - @fb.fbs.each do |fb|
  #     /   %tr= fb["id"]
  #     /   %tr= fb.class.to_s
  #     /   - fb.each_pair do |k,v|
  #     /     %br
  #     /     
  #     /     = k + ': ' + k.class.to_s
  #     /     = v.class.to_s + ': ' + v.inspect
  #       
  #       %br
  #       %br
  #   

  
end
