// ===============================================
// ===== 스크롤 스파이 및 플로팅 목차 JavaScript =====
// ===============================================

class ScrollSpyManager {
    constructor() {
        this.navLinks = document.querySelectorAll('#side-nav a, .mobile-nav-overlay a[href^="#"]');
        this.sections = document.querySelectorAll('section[id], div[id]');
        this.header = document.querySelector('header');
        this.tocContainer = document.getElementById('floating-toc-container');
        this.tocToggleButton = document.getElementById('toc-toggle-button');
        this.tocLinks = document.querySelectorAll('#side-nav a');
        
        this.init();
    }

    init() {
        this.bindEvents();
        this.initScrollSpy();
        this.initFloatingToc();
        this.initSmoothScroll();
    }

    bindEvents() {
        // 스크롤 이벤트 (쓰로틀링 적용)
        let scrollTimeout;
        window.addEventListener('scroll', () => {
            if (scrollTimeout) clearTimeout(scrollTimeout);
            scrollTimeout = setTimeout(() => this.handleScroll(), 16); // 60fps
        });

        window.addEventListener('load', () => this.updateActiveSection());
        window.addEventListener('resize', () => this.handleResize());
    }

    initScrollSpy() {
        if (this.sections.length > 0 && this.navLinks.length > 0) {
            this.updateActiveSection();
        }
    }

    initFloatingToc() {
        if (this.tocToggleButton && this.tocContainer) {
            this.tocToggleButton.addEventListener('click', () => {
                this.tocContainer.classList.toggle('is-open');
            });

            this.tocLinks.forEach(link => {
                link.addEventListener('click', () => {
                    this.tocContainer.classList.remove('is-open');
                });
            });

            // ESC 키로 목차 닫기
            document.addEventListener('keydown', (e) => {
                if (e.key === 'Escape' && this.tocContainer.classList.contains('is-open')) {
                    this.tocContainer.classList.remove('is-open');
                }
            });
        }
    }

    initSmoothScroll() {
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', (e) => {
                e.preventDefault();
                const target = document.querySelector(anchor.getAttribute('href'));
                if (target) {
                    const headerHeight = this.header ? this.header.offsetHeight : 0;
                    const targetPosition = target.offsetTop - headerHeight - 20;
                    
                    window.scrollTo({
                        top: targetPosition,
                        behavior: 'smooth'
                    });
                }
            });
        });
    }

    handleScroll() {
        this.updateActiveSection();
    }

    handleResize() {
        // 데스크톱에서 모바일로 전환시 플로팅 목차 닫기
        if (window.innerWidth <= 1200 && this.tocContainer) {
            this.tocContainer.classList.remove('is-open');
        }
    }

    updateActiveSection() {
        const headerOffset = this.header ? this.header.offsetHeight + 20 : 80;
        let currentSectionId = '';
        const scrollPosition = window.scrollY + headerOffset;

        this.sections.forEach(section => {
            if (section.offsetTop <= scrollPosition && 
                (section.offsetTop + section.offsetHeight) > scrollPosition) {
                currentSectionId = section.getAttribute('id');
            }
        });

        // 마지막 섹션 처리
        const lastSection = this.sections[this.sections.length - 1];
        if (lastSection && (window.innerHeight + window.scrollY >= document.body.offsetHeight - 50)) {
            currentSectionId = lastSection.getAttribute('id');
        }

        // 활성 링크 업데이트
        this.navLinks.forEach(link => {
            link.classList.remove('active');
            if (link.getAttribute('href') && 
                link.getAttribute('href').substring(1) === currentSectionId) {
                link.classList.add('active');
            }
        });
    }
}

// 초기화
document.addEventListener('DOMContentLoaded', () => {
    new ScrollSpyManager();
});