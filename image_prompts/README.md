# TooltipCard Image Prompts

هذا المجلد يحتوي على prompts لتوليد صور توضيحية وإعلانية وتوثيقية لأداة TooltipCard.

## المقاسات المستهدفة

| النسبة | الاستخدام | الأبعاد المقترحة |
|--------|----------|------------------|
| **16:9** | Banners, YouTube, LinkedIn, Documentation | 1920×1080, 1280×720 |
| **4:5** | Instagram, Facebook, Mobile, Stories | 1080×1350, 800×1000 |

## الملفات

| الملف | المحتوى | عدد الـ Prompts |
|------|---------|-----------------|
| `01_hero_banner.md` | صور البانر الرئيسية للموقع والسوشيال | 2 |
| `02_feature_showcase.md` | عرض الميزات (Positioning, Triggers, Modal, Beak) | 4 |
| `03_use_cases.md` | حالات الاستخدام (Dashboard, E-Commerce, Chat, Forms) | 4 |
| `04_documentation.md` | صور التوثيق (API, Quick Start, Theme, Reference) | 4 |
| `05_social_media.md` | صور السوشيال ميديا (IG, Twitter, Stories, YouTube) | 4 |
| `06_app_store.md` | صور المتاجر (Pub.dev, GitHub, Comparison, Demo) | 4 |
| `07_promotional.md` | صور ترويجية (Conference, Newsletter, Release, Testimonial) | 4 |
| `08_technical_diagrams.md` | رسوم تقنية (Widget Tree, Positioning, Events, Layers) | 4 |

**المجموع: 30 prompt**

## كيفية الاستخدام

### مع أدوات AI Image Generation

يمكن استخدام هذه الـ prompts مع:
- **Midjourney**: `/imagine [prompt]`
- **DALL-E 3**: Copy the prompt directly
- **Stable Diffusion**: Use with appropriate model
- **Adobe Firefly**: Paste in text prompt field

### نصائح للحصول على أفضل النتائج

1. **أضف تفاصيل تقنية**: `--ar 16:9` أو `--ar 4:5` لـ Midjourney
2. **استخدم Style Modifiers**: `high quality, professional, UI design, clean`
3. **أضف Negative Prompts**: `no text errors, no distortion, clean edges`
4. **جرب Seeds مختلفة**: للحصول على تنويعات

### مثال للاستخدام مع Midjourney

```
/imagine [محتوى الـ prompt] --ar 16:9 --v 6 --style raw --q 2
```

## Color Palette

الألوان الرسمية للعلامة التجارية:

| اللون | Hex | الاستخدام |
|------|-----|----------|
| Primary Purple | `#7C3AED` | العناصر الرئيسية |
| Deep Purple | `#5B21B6` | الخلفيات الداكنة |
| Indigo | `#4F46E5` | التدرجات |
| White | `#FFFFFF` | الخلفيات الفاتحة |
| Dark | `#1F1F23` | الوضع الداكن |

## الخطوط المقترحة

- **العناوين**: Inter Bold, SF Pro Display
- **النصوص**: Inter Regular, Roboto
- **الكود**: JetBrains Mono, Fira Code

---

**ملاحظة**: هذه الـ prompts مصممة لتوليد صور بجودة احترافية تتناسب مع هوية TooltipCard البصرية.
