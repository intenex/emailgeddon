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
end