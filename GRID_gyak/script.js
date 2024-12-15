function showModal() {
    document.getElementById("pizzaModal").style.display = "block";
}

// JavaScript a modális elrejtéséhez
function closeModal() {
    document.getElementById("pizzaModal").style.display = "none";
}

// Bezárás, ha a felhasználó a modális kívül kattint
window.onclick = function(event) {
    const modal = document.getElementById("pizzaModal");
    if (event.target === modal) {
        modal.style.display = "none";
    }
}
