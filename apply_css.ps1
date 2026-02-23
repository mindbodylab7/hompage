# PowerShell script to safely inject CSS modifications into index.html and styles.css
$indexFile = "c:\Users\chyon\Desktop\01.Project\00.Program\web_page\mindbodylab.kr\index.html"
$stylesFile = "c:\Users\chyon\Desktop\01.Project\00.Program\web_page\mindbodylab.kr\css\styles.css"

# Helper function to replace exact string content
function Replace-Exact ($File, $Target, $Replacement) {
    $content = [System.IO.File]::ReadAllText($File)
    if ($content.Contains($Target)) {
        $newContent = $content.Replace($Target, $Replacement)
        [System.IO.File]::WriteAllText($File, $newContent)
        return $true
    }
    return $false
}

# 1. Update index.html - Body Background
$targetBody = @"
        body {
            margin: 0;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Malgun Gothic', sans-serif;
            color: #333;
            line-height: 1.6;
            overflow-x: hidden;
            background-color: #fdfdfd;
            /* 전역 자연스러운 줄바꿈 설정 */
            word-break: keep-all;
            word-wrap: break-word;
            overflow-wrap: break-word;
        }
"@
$replaceBody = @"
        body {
            margin: 0;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Malgun Gothic', Roboto, Helvetica, Arial, sans-serif;
            color: #1d1d1f;
            line-height: 1.6;
            overflow-x: hidden;
            background-color: #f0f4f8;
            /* 애플 스타일 오로라/블러 배경 - 채도와 범위를 더 강하게 */
            background-image: 
                radial-gradient(circle at 10% 20%, rgba(186, 212, 255, 0.8) 0%, transparent 50%),
                radial-gradient(circle at 90% 60%, rgba(255, 204, 230, 0.8) 0%, transparent 60%),
                radial-gradient(circle at 50% 90%, rgba(199, 210, 254, 0.7) 0%, transparent 50%);
            background-attachment: fixed;
            /* 전역 자연스러운 줄바꿈 설정 */
            word-break: keep-all;
            word-wrap: break-word;
            overflow-wrap: break-word;
        }
"@
Replace-Exact $indexFile $targetBody $replaceBody

# 2. Update index.html - Header
$targetHeader = @"
        /* 헤더 - 즉시 표시 */
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 30px;
            background-color: #fff;
            border-bottom: 1px solid #eee;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            position: sticky;
            top: 0;
            width: 100%;
            box-sizing: border-box;
            z-index: 1000;
        }
"@
$replaceHeader = @"
        /* 헤더 - 즉시 표시 (Glassmorphism 적용) */
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 30px;
            background-color: rgba(255, 255, 255, 0.5); /* 투명도 더 낮춤 */
            backdrop-filter: blur(24px); /* 블러 더 강하게 */
            -webkit-backdrop-filter: blur(24px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.6);
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.05); /* 그림자 부각 */
            position: sticky;
            top: 0;
            width: 100%;
            box-sizing: border-box;
            z-index: 1000;
            transition: all 0.3s ease;
        }
"@
Replace-Exact $indexFile $targetHeader $replaceHeader

# 3. Update index.html - Hero
$targetHero = @"
        .new-hero {
            padding: 48px 20px 32px;
            text-align: center;
            background-color: #f9f9f9;
            color: #333;
        }
"@
$replaceHero = @"
        .new-hero {
            padding: 64px 20px 48px;
            text-align: center;
            background-color: transparent;
            color: #1d1d1f;
            position: relative;
        }
"@
Replace-Exact $indexFile $targetHero $replaceHero

# 4. Update index.html - Hero Buttons
$targetHeroBtns = @"
        .new-hero__btn {
            display: inline-flex;
            justify-content: center;
            align-items: center;
            padding: 14px 28px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 700;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.3s ease;
            min-height: 48px;
        }

        .new-hero__btn--primary {
            background-color: #333;
            color: #fff;
            border: 2px solid #333;
        }

        .new-hero__btn--primary:hover {
            background-color: #111;
            border-color: #111;
        }

        .new-hero__btn--ghost {
            background-color: transparent;
            color: #333;
            border: 2px solid #333;
        }

        .new-hero__btn--ghost:hover {
            background-color: #333;
            color: #fff;
        }
"@
$replaceHeroBtns = @"
        .new-hero__btn {
            display: inline-flex;
            justify-content: center;
            align-items: center;
            padding: 14px 28px;
            border-radius: 999px; /* 애플 스타일 Pill */
            font-size: 16px;
            font-weight: 700;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
            min-height: 48px;
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
        }

        .new-hero__btn--primary {
            background-color: rgba(29, 29, 31, 0.9);
            color: #fff;
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .new-hero__btn--primary:hover {
            background-color: rgba(0, 0, 0, 1);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }

        .new-hero__btn--ghost {
            background-color: rgba(255, 255, 255, 0.5);
            color: #1d1d1f;
            border: 1px solid rgba(255, 255, 255, 0.8);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        }

        .new-hero__btn--ghost:hover {
            background-color: rgba(255, 255, 255, 0.9);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
        }
"@
Replace-Exact $indexFile $targetHeroBtns $replaceHeroBtns

# 5. Update index.html - Trust Bar
$targetTrustBar = @"
        .trust-bar {
            background-color: #f7f9fc;
            border-bottom: 1px solid #e8ecf0;
            padding: 10px 20px;
        }
"@
$replaceTrustBar = @"
        .trust-bar {
            background-color: rgba(255, 255, 255, 0.25);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.5);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.02);
            padding: 10px 20px;
        }
"@
Replace-Exact $indexFile $targetTrustBar $replaceTrustBar

# 6. Update index.html - Conversion Core & Block
$targetCoreBlock = @"
        .conversion-core {
            padding: 8px 20px 28px;
            background: #fdfdfd;
        }

        .conversion-core__inner {
            max-width: 980px;
            margin: 0 auto;
            display: grid;
            gap: 14px;
        }

        .core-block {
            border: 1px solid #e5e7eb;
            border-radius: 16px;
            background: #fff;
            padding: 22px;
        }
"@
$replaceCoreBlock = @"
        .conversion-core {
            padding: 8px 20px 28px;
            background: transparent;
        }

        .conversion-core__inner {
            max-width: 980px;
            margin: 0 auto;
            display: grid;
            gap: 14px;
        }

        .core-block {
            border: 1px solid rgba(255, 255, 255, 0.8);
            border-radius: 20px;
            background: rgba(255, 255, 255, 0.45); /* 투명도 팍 낮춤 */
            backdrop-filter: blur(28px); /* 블러 세게 줌 */
            -webkit-backdrop-filter: blur(28px);
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.06); /* 입체감 */
            padding: 24px;
        }
"@
Replace-Exact $indexFile $targetCoreBlock $replaceCoreBlock

# 7. Update index.html - Core Diff Item
$targetCoreDiffItem = @"
        .core-diff-item {
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            padding: 14px;
            background: #fafafa;
        }
"@
$replaceCoreDiffItem = @"
        .core-diff-item {
            border: 1px solid rgba(255, 255, 255, 0.7);
            border-radius: 16px;
            padding: 16px;
            background: rgba(255, 255, 255, 0.3); /* 더 투명하게 */
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.04);
        }
"@
Replace-Exact $indexFile $targetCoreDiffItem $replaceCoreDiffItem

# 8. Update index.html - Core Track Chip
$targetCoreTrackChip = @"
        .core-track-chip {
            display: inline-flex;
            align-items: center;
            padding: 7px 12px;
            border-radius: 999px;
            border: 1px solid #d6dde6;
            background: #f8fafc;
            color: #334155;
            font-size: 13px;
            line-height: 1.3;
            font-weight: 600;
        }
"@
$replaceCoreTrackChip = @"
        .core-track-chip {
            display: inline-flex;
            align-items: center;
            padding: 7px 12px;
            border-radius: 999px;
            border: 1px solid rgba(255, 255, 255, 0.8);
            background: rgba(255, 255, 255, 0.6);
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            color: #334155;
            font-size: 13px;
            line-height: 1.3;
            font-weight: 600;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.02);
        }
"@
Replace-Exact $indexFile $targetCoreTrackChip $replaceCoreTrackChip

# 9. Update index.html - Core Track Card
$targetCoreTrackCard = @"
        .core-track-card {
            border: 1px solid #dbe2ea;
            border-radius: 12px;
            padding: 16px;
            background: #f8fbff;
        }
"@
$replaceCoreTrackCard = @"
        .core-track-card {
            border: 1px solid rgba(255, 255, 255, 0.9);
            border-radius: 16px;
            padding: 20px;
            background: rgba(248, 251, 255, 0.4);
            backdrop-filter: blur(18px);
            -webkit-backdrop-filter: blur(18px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.05);
        }
"@
Replace-Exact $indexFile $targetCoreTrackCard $replaceCoreTrackCard

# 10. Update index.html - Core Faq Item
$targetCoreFaqItem = @"
        .core-faq-item {
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            background: #fff;
        }
"@
$replaceCoreFaqItem = @"
        .core-faq-item {
            border: 1px solid rgba(255, 255, 255, 0.8);
            border-radius: 16px;
            background: rgba(255, 255, 255, 0.35);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.04);
            transition: all 0.3s ease;
        }
        .core-faq-item:hover {
            background: rgba(255, 255, 255, 0.6);
            transform: translateY(-2px);
        }
"@
Replace-Exact $indexFile $targetCoreFaqItem $replaceCoreFaqItem


# --- Styles.css Updates ---

# 1. Styles.css - Story Panel Dark
$targetStoryPanelDark = @"
#journey .story-panel.dark {
    background-color: #1f2428;
    color: #e8e8e8;
}

#journey .story-panel.light {
    background-color: #fdfdfd;
    color: #333;
}
"@
$replaceStoryPanelDark = @"
#journey .story-panel.dark {
    background-color: rgba(30, 41, 59, 0.6); /* 더 투명하게 */
    backdrop-filter: blur(32px); /* 블러 증가 */
    -webkit-backdrop-filter: blur(32px);
    border-top: 1px solid rgba(255, 255, 255, 0.15);
    border-bottom: 1px solid rgba(255, 255, 255, 0.15);
    color: #f8fafc;
}

#journey .story-panel.light {
    background-color: transparent;
    color: #1d1d1f;
}
"@
Replace-Exact $stylesFile $targetStoryPanelDark $replaceStoryPanelDark

# 2. Styles.css - Info Panel Dark
$targetInfoPanelDark = @"
.info-panel.dark {
    background-color: #1f2428;
    color: #e8e8e8;
}

.info-panel.light {
    background-color: #fdfdfd;
    color: #333;
}
"@
$replaceInfoPanelDark = @"
.info-panel.dark {
    background-color: rgba(30, 41, 59, 0.6); /* 더 투명하게 */
    backdrop-filter: blur(32px); /* 블러 증가 */
    -webkit-backdrop-filter: blur(32px);
    border-top: 1px solid rgba(255, 255, 255, 0.15);
    border-bottom: 1px solid rgba(255, 255, 255, 0.15);
    color: #f8fafc;
}

.info-panel.light {
    background-color: transparent;
    color: #1d1d1f;
}
"@
Replace-Exact $stylesFile $targetInfoPanelDark $replaceInfoPanelDark

# 3. Styles.css - Highlight Box Yellow
$targetHighlightBoxYellow = @"
.highlight-box-yellow {
    background-color: #fff9c4;
    border: 2px solid #f1c40f;
    border-radius: 12px;
    padding: 2rem;
    margin: 2rem 0;
}
"@
$replaceHighlightBoxYellow = @"
.highlight-box-yellow {
    background-color: rgba(255, 249, 196, 0.4); /* 더 투명하게 */
    backdrop-filter: blur(20px);
    -webkit-backdrop-filter: blur(20px);
    border: 1px solid rgba(241, 196, 15, 0.6);
    border-radius: 16px;
    padding: 2rem;
    margin: 2rem 0;
    box-shadow: 0 8px 32px rgba(241, 196, 15, 0.15);
}
"@
Replace-Exact $stylesFile $targetHighlightBoxYellow $replaceHighlightBoxYellow

# 4. Styles.css - Booking Widget
$targetBookingWidget = @"
.booking-widget {
    max-width: 600px;
    width: 100%;
    background-color: #fff;
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    padding: 16px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    flex-wrap: wrap;
    gap: 16px;
    box-sizing: border-box;
}
"@
$replaceBookingWidget = @"
.booking-widget {
    max-width: 600px;
    width: 100%;
    background-color: rgba(255, 255, 255, 0.45); /* 투명도 낮춤 */
    backdrop-filter: blur(24px);
    -webkit-backdrop-filter: blur(24px);
    border: 1px solid rgba(255, 255, 255, 0.9);
    border-radius: 16px;
    padding: 20px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    flex-wrap: wrap;
    gap: 16px;
    box-sizing: border-box;
    box-shadow: 0 10px 40px rgba(0, 0, 0, 0.08); /* 그림자 부각 */
}
"@
Replace-Exact $stylesFile $targetBookingWidget $replaceBookingWidget

# 5. Styles.css - Btn Modern Ghost
$targetBtnGhost = @"
.btn-modern-ghost {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    background-color: transparent;
    color: #333;
    padding: 12px 24px;
    border: 2px solid #333;
    border-radius: 8px;
    font-size: 16px;
    font-weight: 700;
    text-decoration: none;
    cursor: pointer;
    transition: all 0.3s ease;
}

.btn-modern-ghost:hover {
    background-color: #333;
    color: #fff;
}
"@
$replaceBtnGhost = @"
.btn-modern-ghost {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    background-color: rgba(255, 255, 255, 0.5);
    backdrop-filter: blur(8px);
    -webkit-backdrop-filter: blur(8px);
    color: #1d1d1f;
    padding: 12px 24px;
    border: 1px solid rgba(255, 255, 255, 0.8);
    border-radius: 999px;
    font-size: 16px;
    font-weight: 700;
    text-decoration: none;
    cursor: pointer;
    transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
}

.btn-modern-ghost:hover {
    background-color: rgba(255, 255, 255, 0.9);
    transform: translateY(-2px);
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
}
"@
Replace-Exact $stylesFile $targetBtnGhost $replaceBtnGhost

# 6. Styles.css - Chat Bubble
$targetChatBubble = @"
.chat-bubble {
    position: fixed;
    bottom: 20px;
    right: 20px;
    background-color: #ffeb3b;
    color: #333;
    width: 50px;
    height: 50px;
    border-radius: 50%;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 24px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    cursor: pointer;
    z-index: 100;
    transition: transform 0.3s ease;
}
"@
$replaceChatBubble = @"
.chat-bubble {
    position: fixed;
    bottom: 20px;
    right: 20px;
    background-color: rgba(255, 235, 59, 0.9);
    backdrop-filter: blur(8px);
    -webkit-backdrop-filter: blur(8px);
    color: #333;
    width: 50px;
    height: 50px;
    border-radius: 50%;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 24px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    cursor: pointer;
    z-index: 100;
    transition: transform 0.3s ease;
}
"@
Replace-Exact $stylesFile $targetChatBubble $replaceChatBubble

# 7. Styles.css - Consultation List
$targetConsultationList = @"
.consultation-list li {
    padding: 0.8rem 1rem;
    margin: 0.5rem 0;
    background-color: rgba(255, 255, 255, 0.1);
    border-radius: 8px;
    font-size: 1.1rem;
    font-weight: 500;
    border-left: 4px solid #59d4ff;
}
"@
$replaceConsultationList = @"
.consultation-list li {
    padding: 1rem 1.2rem;
    margin: 0.8rem 0;
    background-color: rgba(255, 255, 255, 0.15); /* 조금 더 선명하게 대비 */
    backdrop-filter: blur(16px);
    -webkit-backdrop-filter: blur(16px);
    border: 1px solid rgba(255, 255, 255, 0.3);
    border-radius: 12px;
    font-size: 1.1rem;
    font-weight: 500;
    border-left: 4px solid #59d4ff;
    box-shadow: 0 4px 16px rgba(0, 0, 0, 0.05);
}
"@
Replace-Exact $stylesFile $targetConsultationList $replaceConsultationList

# 8. Styles.css - Program Card
$targetProgramCard = @"
.program-card {
    background-color: rgba(255, 255, 255, 0.1);
    border-radius: 12px;
    padding: 2rem;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.program-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
}
"@
$replaceProgramCard = @"
.program-card {
    background-color: rgba(255, 255, 255, 0.2);
    backdrop-filter: blur(20px);
    -webkit-backdrop-filter: blur(20px);
    border: 1px solid rgba(255, 255, 255, 0.3);
    border-radius: 16px;
    padding: 2rem;
    transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.05);
}

.program-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 12px 40px rgba(0, 0, 0, 0.2);
    border-color: rgba(255, 255, 255, 0.5);
    background-color: rgba(255, 255, 255, 0.3);
}
"@
Replace-Exact $stylesFile $targetProgramCard $replaceProgramCard

# 9. Styles.css - Credentials
$targetCredentials = @"
.credentials {
    font-size: 1.1rem;
    line-height: 1.8;
    margin: 1.5rem 0;
    padding: 1.5rem;
    background-color: #f8f9fa;
    border-radius: 8px;
    border-left: 4px solid #007bff;
}
"@
$replaceCredentials = @"
.credentials {
  font-size: 1.1rem;
  line-height: 1.8;
  margin: 1.5rem 0;
  padding: 1.5rem;
  background-color: rgba(255, 255, 255, 0.3); /* 투명도 낮춤 */
  backdrop-filter: blur(20px); /* 블러 증가 */
  -webkit-backdrop-filter: blur(20px);
  border-radius: 16px;
  border: 1px solid rgba(255, 255, 255, 0.9);
  border-left: 6px solid #59d4ff;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.05);
}
"@
Replace-Exact $stylesFile $targetCredentials $replaceCredentials

# 10. Styles.css - Message
$targetMessage = @"
.message {
    font-size: 1.2rem;
    font-style: italic;
    line-height: 1.7;
    margin: 2rem 0;
    padding: 2rem;
    background-color: #e3f2fd;
    border-radius: 12px;
    color: #1565c0;
    font-weight: 500;
}
"@
$replaceMessage = @"
.message {
  font-size: 1.2rem;
  font-style: italic;
  line-height: 1.7;
  margin: 2rem 0;
  padding: 2rem;
  background-color: rgba(227, 242, 253, 0.4); /* 투명도 */
  backdrop-filter: blur(24px); /* 블러 증가 */
  -webkit-backdrop-filter: blur(24px);
  border: 1px solid rgba(255, 255, 255, 0.8);
  border-radius: 16px;
  color: #0f4c81;
  font-weight: 500;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.06);
}
"@
Replace-Exact $stylesFile $targetMessage $replaceMessage

Write-Host "Done applying patches!"
