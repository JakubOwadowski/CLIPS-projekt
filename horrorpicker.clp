
;;;======================================================
;;;   Automotive Expert System
;;;
;;;     This expert system diagnoses some simple
;;;     problems with a car.
;;;
;;;     CLIPS Version 6.3 Example
;;;
;;;     For use with the Auto Demo Example
;;;======================================================

;;; ***************************
;;; * DEFTEMPLATES & DEFFACTS *
;;; ***************************

(deftemplate UI-state
   (slot id (default-dynamic (gensym*)))
   (slot display)
   (slot relation-asserted (default none))
   (slot response (default none))
   (multislot valid-answers)
   (slot state (default middle)))
   
(deftemplate state-list
   (slot current)
   (multislot sequence))
  
(deffacts startup
   (state-list))
   
;;;****************
;;;* STARTUP RULE *
;;;****************

(defrule system-banner ""

  =>
  
  (assert (UI-state (display WelcomeMessage)
                    (relation-asserted start)
                    (state initial)
                    (valid-answers))))

;;;***************
;;;* QUERY RULES *
;;;***************

(defrule How-old-are-you? ""

   (logical (start))

   =>

   (assert (UI-state (display How.old.are.you?)
                     (relation-asserted age)
                     (response Under.18)
                     (valid-answers Under.18 Above.18))))
   
(defrule Are-you-male-or-female? ""

   (logical (start) (age Under.18))

   =>

   (assert (UI-state (display Are.you.male.or.female?)
                     (relation-asserted sex)
                     (response Female)
                     (valid-answers Female Male))))
                     
(defrule Are-you-Catholic? ""

   (logical (start) (age Under.18) (sex Male))

   =>

   (assert (UI-state (display Are.you.Catholic?)
                     (relation-asserted faith)
                     (response No.)
                     (valid-answers No. Yes.))))

(defrule Are-you-frightened-of-the-dead-or-the-living? ""

   (logical (start) (age Above.18))

   =>

   (assert (UI-state (display Are.you.frightened.of.the.dead.or.the.living?)
                     (relation-asserted fright)
                     (response Have.you.seen.the.news.recently?.The.living,.no.matter.what.planet.they're.from.)
                     (valid-answers 
                     Have.you.seen.the.news.recently?.The.living,.no.matter.what.planet.they're.from.
                     Things.that.crawl.scare.me.more.than.anything.else.
                     I.don't.care.as.long.as.the.devil.isn't.involved.
                     I'm.frightened.of.the.dead.
                     I'm.afraid.of.anything.that's.a.little.bit.of.both.
                     ))))

(defrule What-are-your-feelings-about-dogs,-hairy-people,-or-hairy-dogs? ""

   (logical 
   	(start) 
   	(age Above.18)
   	(fright Have.you.seen.the.news.recently?.The.living,.no.matter.what.planet.they're.from.)
   )

   =>

   (assert (UI-state (display What.are.your.feelings.about.dogs,.hairy.people,.or.hairy.dogs?)
                     (relation-asserted hairy-opinion)
                     (response I.poop.my.pants.every.time.I.smell.Alpo.)
                     (valid-answers 
                     I.poop.my.pants.every.time.I.smell.Alpo.
                     Dogs.and/or.bearded.guys.are.cool.with.me.
                     ))))

(defrule Are-you-an-environmentalist? ""

   (logical 
   	(start) 
   	(age Above.18)
   	(fright Have.you.seen.the.news.recently?.The.living,.no.matter.what.planet.they're.from.)
   	(hairy-opinion I.poop.my.pants.every.time.I.smell.Alpo.)
   )

   =>

   (assert (UI-state (display Are.you.an.environmentalist?)
                     (relation-asserted environmentalist)
                     (response Every.day.is.Earth.Day.)
                     (valid-answers 
                     Every.day.is.Earth.Day.
                     Meh..I.do.my.part.but.don't.go.nuts.
                     ))))

(defrule Did-puberty-suck? ""

   (logical 
   	(start) 
   	(age Above.18)
   	(fright Have.you.seen.the.news.recently?.The.living,.no.matter.what.planet.they're.from.)
   	(hairy-opinion I.poop.my.pants.every.time.I.smell.Alpo.)
   	(environmentalist Meh..I.do.my.part.but.don't.go.nuts.)
   )

   =>

   (assert (UI-state (display Did.puberty.suck?)
                     (relation-asserted puberty-suckiness)
                     (response Yes.)
                     (valid-answers 
                     Yes.
                     It.wasn't.so.bad.
                     ))))
                     
(defrule If-visiting-the-UK,-which-would-you-rather-do? ""

   (logical 
   	(start) 
   	(age Above.18)
   	(fright Have.you.seen.the.news.recently?.The.living,.no.matter.what.planet.they're.from.)
   	(hairy-opinion I.poop.my.pants.every.time.I.smell.Alpo.)
   	(environmentalist Meh..I.do.my.part.but.don't.go.nuts.)
   	(puberty-suckiness It.wasn't.so.bad.)
   )

   =>

   (assert (UI-state (display If.visiting.the.UK,.which.would.you.rather.do?)
                     (relation-asserted UK-interest)
                     (response Picadilly.Circus,.maybe.an.adult.movie.theater.)
                     (valid-answers 
                     Picadilly.Circus,.maybe.an.adult.movie.theater.
                     A.countryside.castle.
                     A.battlefield.
                     ))))
                     
(defrule Are-you-worried-about-people-with-higher-intelligence? ""

   (logical 
   	(start) 
   	(age Above.18)
   	(fright Have.you.seen.the.news.recently?.The.living,.no.matter.what.planet.they're.from.)
   	(hairy-opinion Dogs.and/or.bearded.guys.are.cool.with.me.)
   )

   =>

   (assert (UI-state (display Are.you.worried.about.people.with.higher.intelligence?)
                     (relation-asserted intelligence-worry)
                     (response Not.really..Murdeous.maniacs,.on.the.other.hand...)
                     (valid-answers 
                     Not.really..Murdeous.maniacs,.on.the.other.hand...
                     Definitelly..Especially.when.they're.from.another.planet.
                     Definitelly..Especially.when.they're.working.in.a.lab.
                     ))))                     

(defrule Specifically,-you're-most-worried... ""

   (logical 
   	(start) 
   	(age Above.18)
   	(fright Have.you.seen.the.news.recently?.The.living,.no.matter.what.planet.they're.from.)
   	(hairy-opinion Dogs.and/or.bearded.guys.are.cool.with.me.)
   	(intelligence-worry Not.really..Murdeous.maniacs,.on.the.other.hand...)
   )

   =>

   (assert (UI-state (display Specifically,.you're.most.worried...)
                     (relation-asserted biggest-worry)
                     (response of.people.in.sweaters.)
                     (valid-answers 
                     of.people.in.sweaters.
                     of.people.who.take.Halloween.too.seriously.
                     of.overzealous.hockey.fans.
                     about.Texans.
                     of.movie.nerds.
                     of.vicious.androgynous.children.
                     )))) 

(defrule Does-the-circus-scare-you? ""

   (logical 
   	(start) 
   	(age Above.18)
   	(fright Have.you.seen.the.news.recently?.The.living,.no.matter.what.planet.they're.from.)
   	(hairy-opinion Dogs.and/or.bearded.guys.are.cool.with.me.)
   	(intelligence-worry Definitelly..Especially.when.they're.from.another.planet.)
   )

   =>

   (assert (UI-state (display Does.the.circus.scare.you?)
                     (relation-asserted circus-scary)
                     (response Not.really.)
                     (valid-answers 
                     Not.really.
                     Where.clowns.live?.Of.course
                     )))) 

(defrule Are-you-also-afraid-of-insects? ""

   (logical 
   	(start) 
   	(age Above.18)
   	(fright Have.you.seen.the.news.recently?.The.living,.no.matter.what.planet.they're.from.)
   	(hairy-opinion Dogs.and/or.bearded.guys.are.cool.with.me.)
   	(intelligence-worry Definitelly..Especially.when.they're.working.in.a.lab.)
   )

   =>

   (assert (UI-state (display Are.you.also.afraid.of.insects?)
                     (relation-asserted insect-scare)
                     (response I.hate.them.)
                     (valid-answers 
                     I.hate.them.
                     Things.I.swat.with.my.hand?.No.
                     )))) 

(defrule How-do-you-feel-about-people-having-sex-with-severed-re-animated-heads? ""

   (logical 
   	(start) 
   	(age Above.18)
   	(fright Have.you.seen.the.news.recently?.The.living,.no.matter.what.planet.they're.from.)
   	(hairy-opinion Dogs.and/or.bearded.guys.are.cool.with.me.)
   	(intelligence-worry Definitelly..Especially.when.they're.working.in.a.lab.)
   	(insect-scare Things.I.swat.with.my.hand?.No.)
   )

   =>

   (assert (UI-state (display How.do.you.feel.about.people.having.sex.with.severed.re-animated.heads?)
                     (relation-asserted kink)
                     (response I.love.seeing.people.do.that.thing.you.just.said.)
                     (valid-answers 
                     I.love.seeing.people.do.that.thing.you.just.said.
                     We're.talking.about.corpses..Show.a.little.decorum.
                     )))) 

(defrule How-many-legs-scare-you-the-most? ""

   (logical 
   	(start) 
   	(age Above.18)
   	(fright Things.that.crawl.scare.me.more.than.anything.else.)
   )

   =>

   (assert (UI-state (display How.many.legs.scare.you.the.most?)
                     (relation-asserted legs-ewww)
                     (response Eight.)
                     (valid-answers 
                     Eight.
                     Six.
                     Other.
                     )))) 

(defrule I-prefer-films-starring-the-members-of... ""

   (logical 
   	(start) 
   	(age Above.18)
   	(fright Things.that.crawl.scare.me.more.than.anything.else.)
   	(legs-ewww Eight.)
   )

   =>

   (assert (UI-state (display I.prefer.films.starring.the.members.of...)
                     (relation-asserted liked-cast)
                     (response The.cast.of.Star.Trek.)
                     (valid-answers 
                     The.cast.of.Star.Trek.
                     The.cast.of.Roseanne.
                     )))) 

(defrule Do-you-like-children? ""

   (logical 
   	(start) 
   	(age Above.18)
   	(fright I.don't.care.as.long.as.the.devil.isn't.involved.)
   )

   =>

   (assert (UI-state (display Do.you.like.children?)
                     (relation-asserted liking-children)
                     (response No.)
                     (valid-answers 
                     No.
                     I.love.the.cute.little.buggers.Especially.when.they're.babies
                     I.like.the.children.in.grade.school.
                     )))) 

(defrule Do-you-ever-want-to-eat-pea-soup-again? ""

   (logical 
   	(start) 
   	(age Above.18)
   	(fright I.don't.care.as.long.as.the.devil.isn't.involved.)
   	(liking-children I.like.the.children.in.grade.school.)
   )

   =>

   (assert (UI-state (display Do.you.ever.want.to.eat.pea.soup.again?)
                     (relation-asserted pea-soup-preference)
                     (response Yes,.I.love.pea.soup.)
                     (valid-answers 
                     Yes,.I.love.pea.soup.
                     Who.cares?
                     ))))      
                     
(defrule Do-you-care-if-they-have-a-body? ""

   (logical 
   	(start) 
   	(age Above.18)
   	(fright I'm.frightened.of.the.dead.)
   )

   =>

   (assert (UI-state (display Do.you.care.if.they.have.a.body?)
                     (relation-asserted like-body)
                     (response Yes..Bodies.is.how.they.eat.your.brains.)
                     (valid-answers 
                     Yes..Bodies.is.how.they.eat.your.brains.
                     Without.a.body.is.scarier.
                     ))))                        

(defrule Can-dogs-look-up? ""

   (logical 
   	(start) 
   	(age Above.18)
   	(fright I'm.frightened.of.the.dead.)
   	(like-body Yes..Bodies.is.how.they.eat.your.brains.)
   )

   =>

   (assert (UI-state (display Can.dogs.look.up?)
                     (relation-asserted can-dogs-look-up)
                     (response Yes.)
                     (valid-answers 
                     Yes.
                     What's.all.the.talk.with.dogs?.Let's.go.to.the.mall.
                     ))))      
(defrule Could-George-C.-Scott-protect-you? ""

   (logical 
   	(start) 
   	(age Above.18)
   	(fright I'm.frightened.of.the.dead.)
   	(like-body Without.a.body.is.scarier.)
   )

   =>

   (assert (UI-state (display Could.George.C..Scott.protect.you?)
                     (relation-asserted is-Scott-a-macho)
                     (response No.)
                     (valid-answers 
                     No.
                     Yes.
                     ))))  
                     
(defrule Christoper-Lee-was... ""

   (logical 
   	(start) 
   	(age Above.18)
   	(fright I'm.afraid.of.anything.that's.a.little.bit.of.both.)
   )

   =>

   (assert (UI-state (display Christoper.Lee.was...)
                     (relation-asserted opinion-on-CL)
                     (response a.legend.)
                     (valid-answers 
                     a.legend.
                     that.guy.who.played.Count.Dooku.
                     ))))           
                     
(defrule Do-you-like-hippies? ""

   (logical 
   	(start) 
   	(age Above.18)
   	(fright I'm.afraid.of.anything.that's.a.little.bit.of.both.)
   	(opinion-on-CL a.legend.)
   )

   =>

   (assert (UI-state (display Do.you.like.hippies?)
                     (relation-asserted opinion-on-hippies)
                     (response No.)
                     (valid-answers 
                     No.
                     The.real.horror.is.19th.century.virginal.women.
                     ))))   
                     
(defrule I-prefer-my-vampires... ""

   (logical 
   	(start) 
   	(age Above.18)
   	(fright I'm.afraid.of.anything.that's.a.little.bit.of.both.)
   	(opinion-on-CL that.guy.who.played.Count.Dooku.)
   )

   =>

   (assert (UI-state (display I.prefer.my.vampires...)
                     (relation-asserted vampire-preference)
                     (response silent.)
                     (valid-answers 
                     silent.
                     Eastern.European.
                     with.a.big.beehive.hairdo.
                     ))))                                                  
;;;****************
;;;* RESULTS      * 
;;;****************

(defrule answer-Twilight ""

   (logical (start) (age Under.18) (sex Female))
   
   =>

   (assert (UI-state (display Your.movie.is.Twilight)
                     (state final))))
                     
(defrule answer-Killer-Nun ""

   (logical (start) (age Under.18) (sex Male) (faith Yes))
   
   =>

   (assert (UI-state (display Your.movie.is.Killer.Nun)
                     (state final))))
                     
(defrule answer-Slaughter-Hotel ""

   (logical (start) (age Under.18) (sex Male) (faith No))
   
   =>

   (assert (UI-state (display Your.movie.is.Slaughter.Hotel)
                     (state final))))
                     
(defrule answer-Wolfen ""

   (logical
   (start) 
   	(age Above.18)
   	(fright Have.you.seen.the.news.recently?.The.living,.no.matter.what.planet.they're.from.)
   	(hairy-opinion I.poop.my.pants.every.time.I.smell.Alpo.)
   	(environmentalist Every.day.is.Earth.Day.)
   	
   )
   
   =>

   (assert (UI-state (display Your.movie.is.Wolfen)
                     (state final))))

(defrule answer-Ginger-Snaps ""

   (logical
   (start) 
   (age Above.18)
   (fright Have.you.seen.the.news.recently?.The.living,.no.matter.what.planet.they're.from.)
   (hairy-opinion I.poop.my.pants.every.time.I.smell.Alpo.)
   (environmentalist Meh..I.do.my.part.but.don't.go.nuts.)
   (puberty-suckiness Yes.)
   )
   
   =>

   (assert (UI-state (display Your.movie.is.Ginger.Snaps)
                     (state final))))

(defrule answer-An-American-Werewolf-in-London ""

   (logical
   (start) 
   	(age Above.18)
   	(fright Have.you.seen.the.news.recently?.The.living,.no.matter.what.planet.they're.from.)
   	(hairy-opinion I.poop.my.pants.every.time.I.smell.Alpo.)
   	(environmentalist Meh..I.do.my.part.but.don't.go.nuts.)
   	(puberty-suckiness It.wasn't.so.bad.)
   	(UK-interest Picadilly.Circus,.maybe.an.adult.movie.theater.)
   )
   
   =>

   (assert (UI-state (display Your.movie.is.An.American.Werewolf.in.London)
                     (state final))))
                     
(defrule answer-The-Wolf-Man ""

   (logical
   (start) 
   	(age Above.18)
   	(fright Have.you.seen.the.news.recently?.The.living,.no.matter.what.planet.they're.from.)
   	(hairy-opinion I.poop.my.pants.every.time.I.smell.Alpo.)
   	(environmentalist Meh..I.do.my.part.but.don't.go.nuts.)
   	(puberty-suckiness It.wasn't.so.bad.)
   	(UK-interest A.countryside.castle.)
   )
   
   =>

   (assert (UI-state (display Your.movie.is.The.Wolf.Man)
                     (state final))))                     

(defrule answer-Dog-Soldiers ""

   (logical
   (start) 
   	(age Above.18)
   	(fright Have.you.seen.the.news.recently?.The.living,.no.matter.what.planet.they're.from.)
   	(hairy-opinion I.poop.my.pants.every.time.I.smell.Alpo.)
   	(environmentalist Meh..I.do.my.part.but.don't.go.nuts.)
   	(puberty-suckiness It.wasn't.so.bad.)
   	(UK-interest A.battlefield.)
   )
   
   =>

   (assert (UI-state (display Your.movie.is.Dog.Soldiers)
                     (state final))))  
                     
(defrule answer-A-Nightmare-on-Elm-Street ""

   (logical
   (start) 
   	(start) 
   	(age Above.18)
   	(fright Have.you.seen.the.news.recently?.The.living,.no.matter.what.planet.they're.from.)
   	(hairy-opinion Dogs.and/or.bearded.guys.are.cool.with.me.)
   	(intelligence-worry Not.really..Murdeous.maniacs,.on.the.other.hand...)
   	(biggest-worry of.people.in.sweaters.)
   )
   
   =>

   (assert (UI-state (display Your.movie.is.A.Nightmare.on.Elm.Street)
                     (state final))))      
                     
(defrule answer-Halloween ""

   (logical
   (start) 
   	(start) 
   	(age Above.18)
   	(fright Have.you.seen.the.news.recently?.The.living,.no.matter.what.planet.they're.from.)
   	(hairy-opinion Dogs.and/or.bearded.guys.are.cool.with.me.)
   	(intelligence-worry Not.really..Murdeous.maniacs,.on.the.other.hand...)
   	(biggest-worry of.people.who.take.Halloween.too.seriously.)
   )
   
   =>

   (assert (UI-state (display Your.movie.is.Halloween)
                     (state final))))  
                     
(defrule answer-Friday,-the-13th ""

   (logical
   (start) 
   	(start) 
   	(age Above.18)
   	(fright Have.you.seen.the.news.recently?.The.living,.no.matter.what.planet.they're.from.)
   	(hairy-opinion Dogs.and/or.bearded.guys.are.cool.with.me.)
   	(intelligence-worry Not.really..Murdeous.maniacs,.on.the.other.hand...)
   	(biggest-worry of.overzealous.hockey.fans.)
   )
   
   =>

   (assert (UI-state (display Your.movie.is.Friday,.the.13th)
                     (state final))))                                                             

(defrule answer-The-Texas-Chainsaw-Massacre ""

   (logical
   (start) 
   	(start) 
   	(age Above.18)
   	(fright Have.you.seen.the.news.recently?.The.living,.no.matter.what.planet.they're.from.)
   	(hairy-opinion Dogs.and/or.bearded.guys.are.cool.with.me.)
   	(intelligence-worry Not.really..Murdeous.maniacs,.on.the.other.hand...)
   	(biggest-worry about.Texans.)
   )
   
   =>

   (assert (UI-state (display Your.movie.is.The.Texas.Chainsaw.Massacre)
                     (state final)))) 

(defrule answer-Scream ""

   (logical
   (start) 
   	(start) 
   	(age Above.18)
   	(fright Have.you.seen.the.news.recently?.The.living,.no.matter.what.planet.they're.from.)
   	(hairy-opinion Dogs.and/or.bearded.guys.are.cool.with.me.)
   	(intelligence-worry Not.really..Murdeous.maniacs,.on.the.other.hand...)
   	(biggest-worry of.movie.nerds.)
   )
   
   =>

   (assert (UI-state (display Your.movie.is.Scream)
                     (state final))))     
 
(defrule answer-Sleepaway-Camp ""

   (logical
   (start) 
   	(start) 
   	(age Above.18)
   	(fright Have.you.seen.the.news.recently?.The.living,.no.matter.what.planet.they're.from.)
   	(hairy-opinion Dogs.and/or.bearded.guys.are.cool.with.me.)
   	(intelligence-worry Not.really..Murdeous.maniacs,.on.the.other.hand...)
   	(biggest-worry of.vicious.androgynous.children.)
   )
   
   =>

   (assert (UI-state (display Your.movie.is.Sleepaway.Camp)
                     (state final))))                        

(defrule answer-Alien ""

   (logical 
   	(start) 
   	(age Above.18)
   	(fright Have.you.seen.the.news.recently?.The.living,.no.matter.what.planet.they're.from.)
   	(hairy-opinion Dogs.and/or.bearded.guys.are.cool.with.me.)
   	(intelligence-worry Definitelly..Especially.when.they're.from.another.planet.)
   	(circus-scary Not.really.)
   )
   
   =>

   (assert (UI-state (display Your.movie.is.Alien)
                     (state final)))) 

(defrule answer-Killer-Clowns-from-Outer-Space ""

   (logical
   	(start) 
   	(age Above.18)
   	(fright Have.you.seen.the.news.recently?.The.living,.no.matter.what.planet.they're.from.)
   	(hairy-opinion Dogs.and/or.bearded.guys.are.cool.with.me.)
   	(intelligence-worry Definitelly..Especially.when.they're.from.another.planet.)
   	(circus-scary Where.clowns.live?.Of.course)
   )
   
   =>

   (assert (UI-state (display Your.movie.is.Killer.Clowns.from.Outer.Space)
                     (state final)))) 

(defrule answer-The-Fly ""

   (logical
   	(start) 
   	(age Above.18)
   	(fright Have.you.seen.the.news.recently?.The.living,.no.matter.what.planet.they're.from.)
   	(hairy-opinion Dogs.and/or.bearded.guys.are.cool.with.me.)
   	(intelligence-worry Definitelly..Especially.when.they're.working.in.a.lab.)
   	(insect-scare I.hate.them.)
   )
   
   =>

   (assert (UI-state (display Your.movie.is.The.Fly)
                     (state final)))) 

(defrule answer-Re-Animator ""

   (logical
   	(start) 
   	(age Above.18)
   	(fright Have.you.seen.the.news.recently?.The.living,.no.matter.what.planet.they're.from.)
   	(hairy-opinion Dogs.and/or.bearded.guys.are.cool.with.me.)
   	(intelligence-worry Definitelly..Especially.when.they're.working.in.a.lab.)
   	(insect-scare Things.I.swat.with.my.hand?.No.)
   	(kink I.love.seeing.people.do.that.thing.you.just.said.)
   )
   
   =>

   (assert (UI-state (display Your.movie.is.Re-Animator)
                     (state final)))) 

(defrule answer-Frankenstein ""

   (logical
   	(start) 
   	(age Above.18)
   	(fright Have.you.seen.the.news.recently?.The.living,.no.matter.what.planet.they're.from.)
   	(hairy-opinion Dogs.and/or.bearded.guys.are.cool.with.me.)
   	(intelligence-worry Definitelly..Especially.when.they're.working.in.a.lab.)
   	(insect-scare Things.I.swat.with.my.hand?.No.)
   	(kink We're.talking.about.corpses..Show.a.little.decorum.)
   )
   
   =>

   (assert (UI-state (display Your.movie.is.Frankenstein)
                     (state final)))) 

(defrule answer-Kingdom-of-the-Spiders ""

   (logical
   	(start) 
   	(age Above.18)
   	(fright Things.that.crawl.scare.me.more.than.anything.else.)
   	(legs-ewww Eight.)
   	(liked-cast The.cast.of.Star.Trek.)
   )
   
   =>

   (assert (UI-state (display Your.movie.is.Kingdom.of.the.Spiders)
                     (state final)))) 

(defrule answer-Arachnophobia ""

   (logical
   	(start) 
   	(age Above.18)
   	(fright Things.that.crawl.scare.me.more.than.anything.else.)
   	(legs-ewww Eight.)
   	(liked-cast The.cast.of.Roseanne.)
   )
   
   =>

   (assert (UI-state (display Your.movie.is.Arachnophobia)
                     (state final)))) 
                     
(defrule answer-Them ""

   (logical
   	(start) 
   	(age Above.18)
   	(fright Things.that.crawl.scare.me.more.than.anything.else.)
   	(legs-ewww Six.)
   )
   
   =>

   (assert (UI-state (display Your.movie.is.Them)
                     (state final))))  

(defrule answer-The-Human-Centipede ""

   (logical
   	(start) 
   	(age Above.18)
   	(fright Things.that.crawl.scare.me.more.than.anything.else.)
   	(legs-ewww Other.)
   )
   
   =>

   (assert (UI-state (display Your.movie.is.The.Human.Centipede)
                     (state final))))  

(defrule answer-Häxan ""

   (logical
   	(start) 
   	(age Above.18)
   	(fright I.don't.care.as.long.as.the.devil.isn't.involved.)
   	(liking-children No.)
   )
   
   =>

   (assert (UI-state (display Your.movie.is.Häxan)
                     (state final))))  

(defrule answer-Rosmary's-baby ""

   (logical
   	(start) 
   	(age Above.18)
   	(fright I.don't.care.as.long.as.the.devil.isn't.involved.)
   	(liking-children I.love.the.cute.little.buggers.Especially.when.they're.babies)
   )
   
   =>

   (assert (UI-state (display Your.movie.is.Rosmary's.baby)
                     (state final))))  
                     
(defrule answer-The-Omen ""

   (logical
   	(start) 
   	(age Above.18)
   	(fright I.don't.care.as.long.as.the.devil.isn't.involved.)
   	(liking-children I.like.the.children.in.grade.school.)
   	(pea-soup-preference Who.cares?)
   )
   
   =>

   (assert (UI-state (display Your.movie.is.The.Omen)
                     (state final))))                       
)
   
   
(defrule answer-The-Exorcist ""

   (logical
   	(start) 
   	(age Above.18)
   	(fright I.don't.care.as.long.as.the.devil.isn't.involved.)
   	(liking-children I.like.the.children.in.grade.school.)
   	(pea-soup-preference Yes,.I.love.pea.soup.)
   )
   
   =>

   (assert (UI-state (display Your.movie.is.The.Exorcist)
                     (state final))))                       
)

(defrule answer-Shaun-of-the-dead ""

   (logical
   	(start) 
   	(age Above.18)
   	(fright I'm.frightened.of.the.dead.)
   	(like-body Yes..Bodies.is.how.they.eat.your.brains.)
   	(can-dogs-look-up Yes. )
   )
   
   =>

   (assert (UI-state (display Your.movie.is.Shaun.of.the.dead)
                     (state final))))                       
)     	
                 	
(defrule answer-Dawn-of-the-dead ""

   (logical
   	(start) 
   	(age Above.18)
   	(fright I'm.frightened.of.the.dead.)
   	(like-body Yes..Bodies.is.how.they.eat.your.brains.)
   	(can-dogs-look-up What's.all.the.talk.with.dogs?.Let's.go.to.the.mall.   )
   )
   
   =>

   (assert (UI-state (display Your.movie.is.Dawn.of.the.dead)
                     (state final))))                       
)    	
                                    
(defrule answer-Poltergeist ""

   (logical
   	(start) 
   	(age Above.18)
   	(fright I'm.frightened.of.the.dead.)
   	(like-body Without.a.body.is.scarier.)
   	(is-Scott-a-macho No.)     
   )
   
   =>

   (assert (UI-state (display Your.movie.is.Poltergeist)
                     (state final))))                       
) 

(defrule answer-The-Changeling ""

   (logical
   	(start) 
   	(age Above.18)
   	(fright I'm.frightened.of.the.dead.)
   	(like-body Without.a.body.is.scarier.)
   	(is-Scott-a-macho Yes.)     
   )
   
   =>

   (assert (UI-state (display Your.movie.is.The.Changeling)
                     (state final))))                       
)   

(defrule answer-Dracula-A.D.-1972 ""

   (logical
   	(start) 
   	(age Above.18)
   	(fright I'm.afraid.of.anything.that's.a.little.bit.of.both.)
   	(opinion-on-CL a.legend.)
   	(opinion-on-hippies No.)     
   )
   
   =>

   (assert (UI-state (display Your.movie.is.Dracula.A.D..1972)
                     (state final))))                       
)   

(defrule answer-The-Horror-of-Dracula ""

   (logical
   	(start) 
   	(age Above.18)
   	(fright I'm.afraid.of.anything.that's.a.little.bit.of.both.)
   	(opinion-on-CL a.legend.)
   	(opinion-on-hippies The.real.horror.is.19th.century.virginal.women. )     
   )
   
   =>

   (assert (UI-state (display Your.movie.is.The.Horror.of.Dracula)
                     (state final))))                       
)    
 
(defrule answer-Nosferatu ""

   (logical
   	(start) 
   	(age Above.18)
   	(fright I'm.afraid.of.anything.that's.a.little.bit.of.both.)
   	(opinion-on-CL that.guy.who.played.Count.Dooku.)
   	(vampire-preference silent.)
   )
   
   =>

   (assert (UI-state (display Your.movie.is.Nosferatu)
                     (state final))))                       
)   
 
(defrule answer-Dracula-1931 ""

   (logical
   	(start) 
   	(age Above.18)
   	(fright I'm.afraid.of.anything.that's.a.little.bit.of.both.)
   	(opinion-on-CL that.guy.who.played.Count.Dooku.)
   	(vampire-preference Eastern.European.)
   )
   
   =>

   (assert (UI-state (display Your.movie.is.Dracula.1931)
                     (state final))))                       
)   
   	
(defrule answer-Dracula-1992 ""

   (logical
   	(start) 
   	(age Above.18)
   	(fright I'm.afraid.of.anything.that's.a.little.bit.of.both.)
   	(opinion-on-CL that.guy.who.played.Count.Dooku.)
   	(vampire-preference with.a.big.beehive.hairdo.)
   )
   
   =>

   (assert (UI-state (display Your.movie.is.Dracula.1992)
                     (state final))))                       
)    
                     
                          
                                                        
;;;*************************
;;;* GUI INTERACTION RULES *
;;;*************************

(defrule ask-question

   (declare (salience 5))
   
   (UI-state (id ?id))
   
   ?f <- (state-list (sequence $?s&:(not (member$ ?id ?s))))
             
   =>
   
   (modify ?f (current ?id)
              (sequence ?id ?s))
   
   (halt))

(defrule handle-next-no-change-none-middle-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id)

   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))
                      
   =>
      
   (retract ?f1)
   
   (modify ?f2 (current ?nid))
   
   (halt))

(defrule handle-next-response-none-end-of-chain

   (declare (salience 10))
   
   ?f <- (next ?id)

   (state-list (sequence ?id $?))
   
   (UI-state (id ?id)
             (relation-asserted ?relation))
                   
   =>
      
   (retract ?f)

   (assert (add-response ?id)))   

(defrule handle-next-no-change-middle-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id ?response)

   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))
     
   (UI-state (id ?id) (response ?response))
   
   =>
      
   (retract ?f1)
   
   (modify ?f2 (current ?nid))
   
   (halt))

(defrule handle-next-change-middle-of-chain

   (declare (salience 10))
   
   (next ?id ?response)

   ?f1 <- (state-list (current ?id) (sequence ?nid $?b ?id $?e))
     
   (UI-state (id ?id) (response ~?response))
   
   ?f2 <- (UI-state (id ?nid))
   
   =>
         
   (modify ?f1 (sequence ?b ?id ?e))
   
   (retract ?f2))
   
(defrule handle-next-response-end-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id ?response)
   
   (state-list (sequence ?id $?))
   
   ?f2 <- (UI-state (id ?id)
                    (response ?expected)
                    (relation-asserted ?relation))
                
   =>
      
   (retract ?f1)

   (if (neq ?response ?expected)
      then
      (modify ?f2 (response ?response)))
      
   (assert (add-response ?id ?response)))   

(defrule handle-add-response

   (declare (salience 10))
   
   (logical (UI-state (id ?id)
                      (relation-asserted ?relation)))
   
   ?f1 <- (add-response ?id ?response)
                
   =>
      
   (str-assert (str-cat "(" ?relation " " ?response ")"))
   
   (retract ?f1))   

(defrule handle-add-response-none

   (declare (salience 10))
   
   (logical (UI-state (id ?id)
                      (relation-asserted ?relation)))
   
   ?f1 <- (add-response ?id)
                
   =>
      
   (str-assert (str-cat "(" ?relation ")"))
   
   (retract ?f1))   

(defrule handle-prev

   (declare (salience 10))
      
   ?f1 <- (prev ?id)
   
   ?f2 <- (state-list (sequence $?b ?id ?p $?e))
                
   =>
   
   (retract ?f1)
   
   (modify ?f2 (current ?p))
   
   (halt))
   
