User.where(email: 'user@email.com').first_or_create(first_name: 'John', last_name: 'Smith', birthdate: '1980-01-01', password: 'Testing123').confirm!
