// Copy contract address to clipboard
function copyToClipboard() {
    const contractAddress = document.getElementById('contract-address').textContent;

    navigator.clipboard.writeText(contractAddress).then(() => {
        const button = event.target;
        const originalText = button.textContent;

        button.textContent = 'Copied!';
        button.style.background = '#4caf50';

        setTimeout(() => {
            button.textContent = originalText;
            button.style.background = '';
        }, 2000);
    }).catch(err => {
        console.error('Failed to copy:', err);
        alert('Failed to copy. Please try again.');
    });
}

// Smooth scroll behavior enhancement
document.addEventListener('DOMContentLoaded', () => {
    // Add animation to elements on scroll
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, {
        threshold: 0.1
    });

    // Observe feature cards and steps
    document.querySelectorAll('.feature, .step, .timeline-item').forEach(el => {
        el.style.opacity = '0';
        el.style.transform = 'translateY(20px)';
        el.style.transition = 'opacity 0.6s ease-out, transform 0.6s ease-out';
        observer.observe(el);
    });

    // Mobile menu toggle (optional for future navbar expansion)
    const handleResponsive = () => {
        const navLinks = document.querySelector('.nav-links');
        if (window.innerWidth <= 768) {
            // Could add mobile menu functionality here
        }
    };

    handleResponsive();
    window.addEventListener('resize', handleResponsive);
});

// Update token info from token-config.json (if available)
async function loadTokenInfo() {
    try {
        // This would normally fetch your token config
        // For now, we'll use the placeholder values
        console.log('Token info loaded');
    } catch (error) {
        console.log('Token config not found (expected for static sites)');
    }
}

// Add some interactivity to buttons
document.addEventListener('DOMContentLoaded', () => {
    const buttons = document.querySelectorAll('a[class*="btn"], .dex-link, .social-icon');

    buttons.forEach(button => {
        button.addEventListener('mouseenter', function() {
            // Add subtle scale effect
            if (!this.classList.contains('social-icon')) {
                this.style.transform = 'scale(1.05)';
            }
        });

        button.addEventListener('mouseleave', function() {
            if (!this.classList.contains('social-icon')) {
                this.style.transform = 'scale(1)';
            }
        });
    });
});

// Track page metrics (optional analytics)
function trackEvent(eventName, eventData = {}) {
    // Replace with your analytics service (e.g., Google Analytics, Mixpanel)
    console.log(`Event: ${eventName}`, eventData);
}

// Track when users click "Buy Now"
document.addEventListener('DOMContentLoaded', () => {
    const buyButton = document.querySelector('a[href="#how-to-buy"]');
    if (buyButton) {
        buyButton.addEventListener('click', () => {
            trackEvent('buy_click');
        });
    }
});

// Social sharing functionality
function shareOnTwitter() {
    const tweetText = "Just discovered SolMint on Solana! 🚀 Launch your own token in minutes.";
    const url = encodeURIComponent(window.location.href);
    const twitterUrl = `https://twitter.com/intent/tweet?text=${encodeURIComponent(tweetText)}&url=${url}`;
    window.open(twitterUrl, '_blank');
}

// Scroll to top button (optional)
function createScrollToTopButton() {
    const button = document.createElement('button');
    button.id = 'scroll-to-top';
    button.innerHTML = '↑';
    button.style.cssText = `
        position: fixed;
        bottom: 30px;
        right: 30px;
        width: 50px;
        height: 50px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border: none;
        border-radius: 50%;
        cursor: pointer;
        font-size: 24px;
        display: none;
        z-index: 999;
        transition: all 0.3s;
    `;

    window.addEventListener('scroll', () => {
        if (window.scrollY > 300) {
            button.style.display = 'flex';
            button.style.alignItems = 'center';
            button.style.justifyContent = 'center';
        } else {
            button.style.display = 'none';
        }
    });

    button.addEventListener('click', () => {
        window.scrollTo({ top: 0, behavior: 'smooth' });
    });

    button.addEventListener('mouseenter', () => {
        button.style.transform = 'scale(1.1)';
    });

    button.addEventListener('mouseleave', () => {
        button.style.transform = 'scale(1)';
    });

    document.body.appendChild(button);
}

// Initialize scroll to top button when page loads
document.addEventListener('DOMContentLoaded', () => {
    createScrollToTopButton();
});

// Prevent multiple rapid clicks on copy button
let copyInProgress = false;

function safeCopyToClipboard() {
    if (copyInProgress) return;
    copyInProgress = true;

    setTimeout(() => {
        copyInProgress = false;
    }, 2000);

    copyToClipboard();
}

// Performance monitoring (optional)
if (window.performance && window.performance.timing) {
    window.addEventListener('load', () => {
        const pageLoadTime = window.performance.timing.loadEventEnd - window.performance.timing.navigationStart;
        console.log(`Page loaded in ${pageLoadTime}ms`);
        trackEvent('page_load_time', { time: pageLoadTime });
    });
}
