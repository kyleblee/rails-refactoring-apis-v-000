class GithubRepo

  attr_reader :name, :url

  def initialize(hash)
    unless hash.empty?
      @name = hash["name"]
      @url = hash["html_url"]
    end
  end

  def get_repos(token)
    response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{token}", 'Accept' => 'application/json'}
    JSON.parse(response.body)
  end

  def create_repo(name, token)
    Faraday.post "https://api.github.com/user/repos", {name: name}.to_json, {'Authorization' => "token #{token}", 'Accept' => 'application/json'}
  end

  def secure_access_token(github_client, github_secret, code)
    response = Faraday.post "https://github.com/login/oauth/access_token", {client_id: github_client, client_secret: github_secret, code: code}, {'Accept' => 'application/json'}
    access_hash = JSON.parse(response.body)
    access_hash["access_token"]
  end

  def set_username(token)
    user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{token}", 'Accept' => 'application/json'}
    user_json = JSON.parse(user_response.body)
    user_json["login"]
  end
end
