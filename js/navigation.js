// ===============================================
// ===== 네비게이션 관련 JavaScript =====
// ===============================================

class NavigationManager {
    constructor() {
        this.hamburgerMenu = document.getElementById('hamburgerMenu');
        this.mobileNavOverlay = document.getElementById('mobileNavOverlay');
        this.closeMenu = document.getElementById('closeMenu');
        this.init();
    }

    init() {
        this.bindEvents();
    }

    bindEvents() {
        if (this.hamburgerMenu && this.mobileNavOverlay && this.closeMenu) {
            this.hamburgerMenu.addEventListener('click', () => this.openMobileMenu());
            this.closeMenu.addEventListener('click', () => this.closeMobileMenu());
            this.mobileNavOverlay.addEventListener('click', (e) => this.handleOverlayClick(e));
            
            // 모바일 링크 클릭시 메뉴 닫기
            const allMobileLinks = this.mobileNavOverlay.querySelectorAll('a');
            allMobileLinks.forEach(link => {
                link.addEventListener('click', () => this.closeMobileMenu());
            });
        }

        // ESC 키로 메뉴 닫기
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape' && this.mobileNavOverlay?.classList.contains('active')) {
                this.closeMobileMenu();
            }
        });

        // 리사이즈 이벤트 처리
        window.addEventListener('resize', () => {
            if (window.innerWidth >= 768) {
                this.closeMobileMenu();
            }
        });
    }

    openMobileMenu() {
        this.mobileNavOverlay.classList.add('active');
        document.body.style.overflow = 'hidden';
    }

    closeMobileMenu() {
        this.mobileNavOverlay.classList.remove('active');
        document.body.style.overflow = '';
    }

    handleOverlayClick(event) {
        if (event.target === this.mobileNavOverlay) {
            this.closeMobileMenu();
        }
    }
}

// 초기화
document.addEventListener('DOMContentLoaded', () => {
    new NavigationManager();
});