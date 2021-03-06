<quiz>


	<div class="container text-part">
		<div class="row">
			<div class="col-sm-12 col-md-7">
				<div each = {item, index in questionData}>
					<div class="question">
						<h5>{ item.question }</h5>
						<div class="form-check" each= { i in item.options }>
						  <input class="form-check-input" type="radio" name={"question" + index} id={index + i} value={i} ref = {"question" + index}>
						  <label class="form-check-label" for={index + i}>{ i }</label>
						</div>
						<button onclick={ showVideo } value={ item.buttonName }>Watch Back</button>
						<div each={ item in startPlay }>
							<iframe width="300" height="200" src={ item.link } frameborder="0" if={ item.value }></iframe>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-12 col-md-5" show={loadReview}>
				<h2 class="fadeIn">This is the explanation</h2>
				<p each = {i in reviews} class="fadeIn reviews">
					{ i }
				</p>
			</div>
		</div>
		<button class="btn btn-primary" type="button" name="button" data-toggle="modal" data-target="#exampleModal" onclick = {check}>Submit</button>
	</div>



	<modal result = {result}></modal>

	<script>

	var that = this;

	//that.startVideo = false;
		this.loadReview = false;
		this.reviews = '';

		this.startPlay = [
			{
				value: false,
				link: "https://www.youtube.com/embed/B-hQXZiXtNY?start=6"
			},
			{
				value: false,
				link: "https://www.youtube.com/embed/B-hQXZiXtNY?start=10"
			},
			{
				value: false,
				link: "https://www.youtube.com/embed/B-hQXZiXtNY?start=20"
			}
		];

		this.questionData = [
			{
				question: "1. Are the two boys really hipsters?",
				options: ["Yes they are, but they are not amish.",
				 "Yes they are, they are amish hipsters.",
				  "No, they are not hipsters."],
				correct: 3,
				explanation: "1.Hipsters are a subculture of men and women typically in their 20's and 30's that value independent thinking, counter-culture, progressive politics, an appreciation of art and indie-rock, creativity, intelligence, and witty banter. Max noticed what they wear was pretty different from others when  they come into the restaurant, and based on their age, she thought they are following a hipster trend.",
				buttonName: "first"
			},
			{
				question: "2.Why Max believes the two boys a new hipster trend?",
				options: ["They are hipsters.",
				"They are following a new hipster trend.",
				 "Max CANNOT believe they are real Amish."],
				correct: 3,
				explanation: "2.The Amish  are a group of traditionalist Christian church fellowships with Swiss Anabaptist origins. The Amish are known for simple living, plain dress, and reluctance to adopt many conveniences of modern technology. They are best known for their 19th century way of life, and they believe that some technologies will damage the community, so they avoid some “modern conveniences” such as cars, electricity and telephones. One more thing, Amish prefer to living in their own small communities and differ from other Americans in their dress, language, work, travel and education. That is why Max cannot believe they are real Amish.",
				buttonName: "second"
			},
			{
				question: "3. Why Max said “Haveth a set-eth in the booth-eth”?",
				options: ["She is speaking German-English accent because Amish community usually speak German.",
				"Max is speaking old English because she thinks Amish people speaks old English.",
				"Max always speaks like that."],
				correct: 2,
				explanation: "3.Most Old Order Amish speak Pennsylvania Dutch, and refer to non-Amish people as 'English', regardless of ethnicity. Some Amish who migrated to the United States in the 1850s speak a form of Bernese German or a Low Alemannic Alsatian dialect. But here, Max is just speaking like old English because she thinks Amish not only live a traditional way, they also speaks in a traditional way.",
				buttonName: "third"
			}
		];



		this.wrongAnswers = [];
		this.correctAnswers = [];
		this.answerExplanation = [];
		this.result = "";
		for(let i = 0; i< this.questionData.length; i++) {
			this.correctAnswers.push(this.questionData[i].options[this.questionData[i].correct-1]);
			this.answerExplanation.push(this.questionData[i].explanation);
		};

		this.check = function() {
			var values = [];
			for(i = 0; i < this.questionData.length; i++){
				var value = document.querySelector("[name = question" + i + "]:checked").value;
				values.push(value);
			};

			let count = 0;

			for(let i = 0; i < values.length; i++) {
				if(this.correctAnswers[i] === values[i]){
					count++;
				} else {
					this.wrongAnswers.push(i);
				};
			};

			if(count === 0){
				this.result= `Oh, you miss all the hahapoints! Your score is ${count} / ${this.correctAnswers.length}`
			}else if(count === 1){
				this.result= `Oh, you miss two hahapoints! Your score is ${count} / ${this.correctAnswers.length}`
			}else if(count === 2){
				this.result = `Yeah, you only miss one hahapoints! Your score is ${count} / ${this.correctAnswers.length}`
			}else if(count === 3){
				this.result = `Great! You get all the hahapoints! Your score is ${count} / ${this.correctAnswers.length}`
			};

			this.loadReview = true;
			this.reviews = this.answerExplanation;
			for(let i = 0; i < this.wrongAnswers; i++) {
				reviews[this.wrongAnswers[i]].classList.add("wrong")
			}

		};

		this.showVideo = function(event) {
			var x = event.target.value;
			//console.log(x)
			//console.log(that.startPlay[2].value)
			if(x = 'first'){
			that.startPlay[0].value = true
			this.update()= false//to prevent three buttons from updating at the same time
		}else if(x = 'second'){
			that.startPlay[1].value = true
			this.update()= false
		}else if(x = 'third'){
		 that.startPlay[2].value = true
		 this.update()= false;
			}
		};

		// this.showVideo = function(event) {
		// 	that.startVideo = true;
		// 	that.update();
		// };



		this.on('updated', function(){
			var reviews = document.querySelectorAll('.reviews');
			var questions = document.querySelectorAll('.question')
			for(let i = 0; i < this.reviews.length; i++) {
				reviews[i].classList.add('right')
				questions[i].classList.add('right')
			}

			for(let i = 0; i < this.wrongAnswers.length; i++) {
				reviews[this.wrongAnswers[i]].classList.add('wrong')
				questions[this.wrongAnswers[i]].classList.add('wrong')
			}
		})


	</script>

	<style>
	.question {
		margin: 20px 0;
	}

	.right {
		color: green;
	}

	.wrong {
		color: red;
	}

	</style>

</quiz>
