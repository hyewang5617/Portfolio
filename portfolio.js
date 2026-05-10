// === Modal open/close ===
function openModal(id) {
  var modal = document.getElementById(id);
  if (modal) {
    modal.style.display = 'flex';
    document.body.style.overflow = 'hidden';
  }
}

function closeModal(overlay) {
  overlay.style.display = 'none';
  document.body.style.overflow = '';
}

// 프로젝트 카드 클릭 → 모달 열기
document.querySelectorAll('.project-card[data-modal]').forEach(function(card) {
  card.addEventListener('click', function() {
    openModal(card.getAttribute('data-modal'));
  });
});

// ✕ 버튼 클릭 → 닫기
document.querySelectorAll('.modal-close').forEach(function(btn) {
  btn.addEventListener('click', function(e) {
    e.stopPropagation();
    closeModal(btn.closest('.modal-overlay'));
  });
});

// 배경(overlay) 클릭 → 닫기
document.querySelectorAll('.modal-overlay').forEach(function(overlay) {
  overlay.addEventListener('click', function(e) {
    if (e.target === overlay) closeModal(overlay);
  });
});

// ESC 키 → 닫기
document.addEventListener('keydown', function(e) {
  if (e.key === 'Escape') {
    document.querySelectorAll('.modal-overlay').forEach(function(o) {
      if (o.style.display === 'flex') closeModal(o);
    });
  }
});

// === 스크롤 페이드인 ===
var fadeEls = document.querySelectorAll('.skill-card, .project-card, .about-grid, .contact-box, .info-item');

if ('IntersectionObserver' in window) {
  var fadeObserver = new IntersectionObserver(function(entries) {
    entries.forEach(function(entry) {
      if (entry.isIntersecting) {
        entry.target.classList.add('visible');
        fadeObserver.unobserve(entry.target);
      }
    });
  }, { threshold: 0.1 });

  fadeEls.forEach(function(el) {
    el.classList.add('fade-in');
    fadeObserver.observe(el);
  });
}

// === 네비게이션 활성화 ===
var sections = document.querySelectorAll('section[id]');
var navLinks = document.querySelectorAll('.nav-links a');

if ('IntersectionObserver' in window && sections.length) {
  var navObserver = new IntersectionObserver(function(entries) {
    entries.forEach(function(entry) {
      if (entry.isIntersecting) {
        navLinks.forEach(function(l) { l.classList.remove('active'); });
        var a = document.querySelector('.nav-links a[href="#' + entry.target.id + '"]');
        if (a) a.classList.add('active');
      }
    });
  }, { threshold: 0.4 });

  sections.forEach(function(s) { navObserver.observe(s); });
}
