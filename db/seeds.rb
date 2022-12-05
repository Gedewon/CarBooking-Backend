# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Car.create!(name: 'Blue Bmw', image: 'https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg', amount: 22_500 ,car_type:'lux',brand:'tesla',color:'red')
Car.create!(name: 'Red Alfa Romeo C4 ', image: 'https://images.pexels.com/photos/210019/pexels-photo-210019.jpeg', amount: 18_500,car_type:'lux',brand:'tesla',color:'red')
Car.create!(name: 'Yellow Chevroelt ', image: 'https://images.pexels.com/photos/575386/pexels-photo-575386.jpeg', amount: 37_500,car_type:'lux',brand:'tesla',color:'red')
Car.create!(name: 'Black Ferrari', image: 'https://images.pexels.com/photos/9596562/pexels-photo-9596562.jpeg', amount: 19_600,car_type:'lux',brand:'tesla',color:'red')
Car.create!(name: 'Sports Car', image: 'https://images.pexels.com/photos/4674337/pexels-photo-4674337.jpeg', amount: 44_700,car_type:'lux',brand:'tesla',color:'red')

User.create!(name:'Gedewon',image_url:'https://avatars.githubusercontent.com/u/56429354?v=4',role:'admin',email:'gedewon.hayle.9@gmail.com',password:'123123',password_confirmation:'123123',date_of_birth:' Tue, 05 Dec 1922')