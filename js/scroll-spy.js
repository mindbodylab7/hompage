// ===============================================
// ===== Scroll Spy and Floating TOC JavaScript =====
// ===============================================

class ScrollSpyManager {
    constructor() {
        this.navLinks = document.querySelectorAll('#side-nav a, .mobile-nav-overlay a[href^="#"]');
        this.sections = document.querySelectorAll('section[id], details[id], article[id]');
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
        // Throttle scroll work with a short timeout to keep updates responsive.
        let scrollTimeout;
        window.addEventListener('scroll', () => {
            if (scrollTimeout) clearTimeout(scrollTimeout);
            scrollTimeout = setTimeout(() => this.handleScroll(), 16);
        });

        window.addEventListener('load', () => this.updateActiveSection());
        window.addEventListener('resize', () => this.handleResize());
    }

    initScrollSpy() {
        if (this.sections.length > 0 && this.navLinks.length > 0) {
            this.updateActiveSection();
        }
    }

    // Phase 3: keep visual TOC state and accessibility state in sync.
    setTocOpenState(isOpen) {
        if (!this.tocContainer) return;

        this.tocContainer.classList.toggle('is-open', isOpen);

        if (this.tocToggleButton) {
            this.tocToggleButton.setAttribute('aria-expanded', isOpen ? 'true' : 'false');
        }
    }

    initFloatingToc() {
        if (this.tocToggleButton && this.tocContainer) {
            this.setTocOpenState(this.tocContainer.classList.contains('is-open'));

            this.tocToggleButton.addEventListener('click', () => {
                const nextIsOpen = !this.tocContainer.classList.contains('is-open');
                this.setTocOpenState(nextIsOpen);
            });

            this.tocLinks.forEach(link => {
                link.addEventListener('click', () => {
                    this.setTocOpenState(false);
                });
            });

            document.addEventListener('keydown', (e) => {
                if (e.key !== 'Escape') return;
                if (!this.tocContainer.classList.contains('is-open')) return;

                this.setTocOpenState(false);
            });
        }
    }

    initSmoothScroll() {
        // Phase 2: protect bare hashes and preserve native skip-link behavior.
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', (e) => {
                const href = anchor.getAttribute('href');
                if (!href || href === '#' || href === '#main-content') return;

                let target;
                try {
                    target = document.querySelector(href);
                } catch (_error) {
                    return;
                }

                if (!target) return;

                e.preventDefault();

                const headerHeight = this.header ? this.header.offsetHeight : 0;
                const targetPosition = target.offsetTop - headerHeight - 20;

                window.scrollTo({
                    top: targetPosition,
                    behavior: 'smooth'
                });
            });
        });
    }

    handleScroll() {
        this.updateActiveSection();
    }

    handleResize() {
        if (window.innerWidth <= 1200 && this.tocContainer) {
            this.setTocOpenState(false);
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

        const lastSection = this.sections[this.sections.length - 1];
        if (lastSection && (window.innerHeight + window.scrollY >= document.body.offsetHeight - 50)) {
            currentSectionId = lastSection.getAttribute('id');
        }

        this.navLinks.forEach(link => {
            link.classList.remove('active');
            if (link.getAttribute('href') &&
                link.getAttribute('href').substring(1) === currentSectionId) {
                link.classList.add('active');
            }
        });
    }
}

document.addEventListener('DOMContentLoaded', () => {
    new ScrollSpyManager();
});
