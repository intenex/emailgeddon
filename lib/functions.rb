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