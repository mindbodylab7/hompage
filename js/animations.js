// ===============================================
// ===== 애니메이션 및 인터랙션 JavaScript =====
// ===============================================

class AnimationManager {
    constructor() {
        this.animatedContents = document.querySelectorAll('.story-panel-content, .info-panel-content');
        this.init();
    }

    init() {
        this.initScrollAnimations();
        this.initInteractions();
    }

    initScrollAnimations() {
        if (this.animatedContents.length > 0) {
            if ('IntersectionObserver' in window) {
                this.setupIntersectionObserver();
            } else {
                // 폴백: IntersectionObserver를 지원하지 않는 브라우저
                this.animatedContents.forEach(content => {
                    content.classList.add('is-visible');
                });
            }
        }
    }

    setupIntersectionObserver() {
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('is-visible');
                    observer.unobserve(entry.target); // 한 번만 애니메이션
                }
            });
        }, { 
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px' // 약간 일찍 트리거
        });

        this.animatedContents.forEach(content => {
            observer.observe(content);
        });
    }

    initInteractions() {
        // 예약 버튼 클릭 추적
        const bookingButtons = document.querySelectorAll('.btn-modern-ghost');
        bookingButtons.forEach(button => {
            button.addEventListener('click', () => {
                this.trackEvent('booking', 'consultation_booking');
            });
        });

        // 채팅 버블 클릭 추적
        const chatBubble = document.querySelector('.chat-bubble');
        if (chatBubble) {
            chatBubble.addEventListener('click', () => {
                this.trackEvent('chat', 'chat_consultation');
            });
        }

        // 카드 호버 효과 개선
        document.querySelectorAll('.program-card').forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-8px)';
            });
            
            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(-5px)';
            });
        });
    }

    trackEvent(category, label) {
        // Google Analytics 이벤트 추적 (GTM이 로드된 경우)
        if (typeof gtag !== 'undefined') {
            gtag('event', 'click', {
                'event_category': category,
                'event_label': label
            });
        }

        // 콘솔에 로그 (개발용)
        console.log(`Event tracked: ${category} - ${label}`);
    }
}

// 초기화
document.addEventListener('DOMContentLoaded', () => {
    new AnimationManager();
});