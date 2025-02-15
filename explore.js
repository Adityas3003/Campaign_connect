document.querySelectorAll('.read-more-btn').forEach(button => {
    button.addEventListener('click', function () {
        const moreText = this.previousElementSibling;
        moreText.style.display = moreText.style.display === "block" ? "none" : "block";
        this.textContent = this.textContent === "Read More" ? "Read Less" : "Read More";
    });
});