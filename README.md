Simpel algoritm som avgör om en viss position på ett go-bräde har en sten som tillhör en levande grupp. I princip så kollar vi åt höger, upp, vänster och ner. Om det är en sten av fel färg returneras False, om det är en tom plats så returneras True, och om det är en plats ockuperad av en sten med samma färg så anropas allt igen rekursivt fast med den nya stenen i centrum.