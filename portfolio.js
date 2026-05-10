// === Modal ===
document.querySelectorAll('.project-card[data-modal]').forEach((card) => {
  card.addEventListener('click', () => {
    const id = card.dataset.modal;
    const modal = document.getElementById(id);
    if (modal) modal.classList.add('open');
  });
});

document.querySelectorAll('.modal-close').forEach((btn) => {
  btn.addEventListener('click', (e) => {
    e.stopPropagation();
    btn.closest('.modal-overlay').classList.remove('open');
  });
});

document.querySelectorAll('.modal-overlay').forEach((overlay) => {
  overlay.addEventListener('click', (e) => {
    if (e.target === overlay) overlay.classList.remove('open');
  });
});

document.addEventListener('keydown', (e) => {
  if (e.key === 'Escape') {
    document.querySelectorAll('.modal-overlay.open').forEach((o) => o.classList.remove('open'));
  }
});

// === Scroll fade-in ===
const observer = new IntersectionObserver(
  (entries) => entries.forEach((e) => { if (e.isIntersecting) e.target.classList.add('visible'); }),
  { threshold: 0.1 }
);

document.querySelectorAll('.skill-card, .project-card, .about-grid, .contact-box, .info-item').forEach((el) => {
  el.classList.add('fade-in');
  observer.observe(el);
});

// === Active nav on scroll ===
const sections = document.querySelectorAll('section[id]');
const navLinks = document.querySelectorAll('.nav-links a');

new IntersectionObserver(
  (entries) => entries.forEach((e) => {
    if (e.isIntersecting) {
      navLinks.forEach((l) => l.classList.remove('active'));
      const a = document.querySelector(`.nav-links a[href="#${e.target.id}"]`);
      if (a) a.classList.add('active');
    }
  }),
  { threshold: 0.4 }
).observe(document.querySelectorAll ? sections[0] : sections);

sections.forEach((s) => {
  new IntersectionObserver(
    (entries) => entries.forEach((e) => {
      if (e.isIntersecting) {
        navLinks.forEach((l) => l.classList.remove('active'));
        const a = document.querySelector(`.nav-links a[href="#${e.target.id}"]`);
        if (a) a.classList.add('active');
      }
    }),
    { threshold: 0.4 }
  ).observe(s);
});
