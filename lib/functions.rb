def genEmails(first, last, domain)
    fullname = first + last + '@' + domain
    dfullname = first + '.' + last + '@' + domain
    full_name = first + '_' + last + '@' + domain
    flast = first[0] + last + '@' + domain
    dflast = first[0] + '.' + last + '@' + domain
    firstl = first + last[0] + '@' + domain
    dfirstl = first + '.' + last[0] + '@' + domain
    firstname = first + '@' + domain
    lastname = last + '@' + domain

    return name_dict = {'1_fullname' => fullname, '2_dfullname' => dfullname, '3_full_name' => full_name, '4_flast' => flast, '5_dflast' => dflast, '6_firstl' => firstl, '7_dfirstl' => dfirstl, '8_firstname' => firstname, '9_lastname' => lastname}
end