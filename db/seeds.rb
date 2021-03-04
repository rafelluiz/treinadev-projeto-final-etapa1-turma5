# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

3.times do |i|
  collab_example = Collaborator.create!(email: "example#{i}@example.com",password: '123456')
  collab_cia = Collaborator.create!(email: "cia#{i}@cia.com",password: '123456')

  Job.create!(title: "Programador #{collab_example.company.name} #{i}",
              description: 'Estamos a procura de um profissional...',
              starting_salary_range: 1000,final_salary_range: 2000,level: i,
              requirements: 'Experiência de 2 anos na função',expiration_date: '23/11/2021',
              total_job: 4,company: collab_example.company)

  Job.create!(title: "Programador #{collab_cia.company.name} #{i}",
              description: 'Estamos a procura de um profissional...',
              starting_salary_range: 1000,final_salary_range: 2000,level: i,
              requirements: 'Experiência de 2 anos na função',expiration_date: '23/11/2021',
              total_job: 4,company: collab_cia.company)


  Candidate.create!(email: "example#{i}@gmail.com",password: '123456',full_name:"example#{i} de Tal",
    social_name:"example#{i}", cpf:'111.111.111-11', telephone:'3197861234',
    biography:'Conclui bacharel em sistemas de ....')
  Candidate.create!(email: "cia#{i}@yahoo.com",password: '123456',full_name:"yahoo#{i} de Tal",
                    social_name:"yahoo#{i}", cpf:'111.111.111-11', telephone:'3197861234',
                    biography:'Conclui bacharel em sistemas de ....')
  Candidate.create!(email: "bhargava#{i}@hotmail.com",password: '123456',full_name:"hotmail#{i} de Tal",
                    social_name:"hotmail#{i}", cpf:'111.111.111-11', telephone:'3197861234',
                    biography:'Conclui bacharel em sistemas de ....')

end

Company.find_by(email_domain: 'example.com').update!(site: 'www.example.com')
Company.find_by(email_domain: 'cia.com').update!(site: 'www.cia.com')

Job.find(1).apply!(Candidate.find(1))
Job.find(1).apply!(Candidate.find(2))
Job.find(2).apply!(Candidate.find(4))
Job.find(3).apply!(Candidate.find(4))
Job.find(5).apply!(Candidate.find(1))
Job.find(5).apply!(Candidate.find(3))
Job.find(5).apply!(Candidate.find(6))