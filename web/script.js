// Interactive features can be added here
document.querySelectorAll('.file-item').forEach(item => {
    item.addEventListener('click', function() {
        document.querySelectorAll('.file-item').forEach(i => i.classList.remove('selected'));
        this.classList.add('selected');
    });
});

// Smooth scroll simulation
const contentScroll = document.querySelector('.content-scroll');
if (contentScroll) {
    let isDown = false;
    let startY;
    let scrollTop;

    contentScroll.addEventListener('mousedown', (e) => {
        isDown = true;
        startY = e.pageY - contentScroll.offsetTop;
        scrollTop = contentScroll.scrollTop;
    });

    contentScroll.addEventListener('mouseleave', () => {
        isDown = false;
    });

    contentScroll.addEventListener('mouseup', () => {
        isDown = false;
    });

    contentScroll.addEventListener('mousemove', (e) => {
        if (!isDown) return;
        e.preventDefault();
        const y = e.pageY - contentScroll.offsetTop;
        const walk = (y - startY) * 1;
        contentScroll.scrollTop = scrollTop - walk;
    });
}

// Button interactions
document.querySelectorAll('.pill, .nav-btn, .header-icons button').forEach(btn => {
    btn.addEventListener('click', function() {
        this.style.opacity = '0.7';
        setTimeout(() => {
            this.style.opacity = '1';
        }, 100);
    });
});
