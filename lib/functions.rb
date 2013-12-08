require 'httpclient'
require 'json'
require 'csv'

def genEmails(first, last, domain)
    fullname = first + last + '@' + domain
    pfullname = first + '.' + last + '@' + domain
    full_name = first + '_' + last + '@' + domain
    dfullname = first + '-' + last + '@' + domain
    flast = first[0] + last + '@' + domain
    pflast = first[0] + '.' + last + '@' + domain
    firstl = first + last[0] + '@' + domain
    pfirstl = first + '.' + last[0] + '@' + domain
    last_first = last + '_' + first + '@' + domain
    dlastfirst = last + '-' + first + '@' + domain
    lastfirst = last + first + '@' + domain
    firstname = first + '@' + domain
    lastname = last + '@' + domain
    fl = first[0] + last[0] + '@' + domain

    return name_dict = {'fullname' => fullname, 'pfullname' => pfullname,
                        'full_name' => full_name, 'dfullname' => dfullname,
                        'flast' => flast, 'pflast' => pflast,
                        'firstl' => firstl, 'pfirstl' => pfirstl,
                        'last_first' => last_first, 'dlastfirst' => dlastfirst,
                        'lastfirst' => lastfirst, 'firstname' => firstname,
                        'lastname' => lastname, 'fl' => fl}
end

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
    # unfortunately, tons of bad response errors, particularly with error code 429: Too Many Requests. Need to find a way around that...
    rescue HTTPClient::BadResponseError
        return "Invalid email!"
    end
end

def find_harvard(first, last)
    # from http://stackoverflow.com/a/13147323/674794
    file = File.join(Rails.root, 'lib', 'harvard.csv')
    # from http://stackoverflow.com/a/4410880/674794
    csv_text = File.read(file)
    # turn the CSV into a usable collection of arrays, one row per element of the array
    csv = CSV.parse(csv_text, :headers => true)
    # for each row in the array, if the first name and last name are the same as that passed in (case insensitive), then that row is a positive match for the person in question, so return that row
    csv.each do |row|
        if row[0].casecmp(first) == 0 && row[1].casecmp(last) == 0
            return row
        end
    end
    return []
end