require 'httpclient'
require 'json'

def find_email(email)
    login_url = 'https://rapportive.com/login_status?user_email=' + email
    profile_url = 'https://profiles.rapportive.com/contacts/email/' + email
    
    # create a new instance of the HTTPClient
    c = HTTPClient.new
    # connect to rapportive to get the session token
    # Parsing JSON to ruby hash: http://stackoverflow.com/a/5410713/674794
    begin
        login_result = JSON.parse(c.get_content(login_url))
        session_token = login_result['session_token']
        # set an external header value to pass in the session_token
        ext_header = {'X-Session-Token' => session_token}
        
        # send result with the session_id token in the header and an empty query
        # note that can also use c.get() instead of c.get_content, but then have to JSON.parse() the result.body separately
        profile_result = JSON.parse(c.get_content(profile_url, '', ext_header))
        # all contact info is saved under the attribute 'contact'
        contact_info = profile_result['contact']
        
        person = Hash.new
        person['name'] = contact_info['name']
        person['email'] = email
        # save each job in the hash person['jobs'] with the company name as the key and the job title as the value
        person['jobs'] = Hash.new
        contact_info['occupations'].each do |job|
            company = job['company']
            person['jobs'][company] = job['job_title']
        end
        # save each social media site in the hash person['sites'] with the site name as the key and the url as the value
        person['sites'] = Hash.new
        contact_info['memberships'].each do |site|
            key = site['site_name']
            person['sites'][key] = site['profile_url']
        end
    
        return person
    rescue HTTPClient::BadResponseError
        return "Invalid email!"
    end
end