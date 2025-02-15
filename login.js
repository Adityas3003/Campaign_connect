forgot = document.querySelector(".forgot-pass");
loginBox = document.querySelector(".login-container");
forgotBox = document.querySelector(".forgotBlock");
submitBtn =document.querySelector(".forSub");

forgot.onclick = () => {
  console.log("Clicked");
  loginBox.classList.add("block");//hide
  forgotBox.classList.add("visible")//block
};

submitBtn.onclick = ()=> {
  console.log("Submit");
  loginBox.classList.remove('block');//block
  forgotBox.classList.remove('visible');//hide
}
