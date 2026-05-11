# استخدام نسخة أحدث وأخف من Ubuntu
FROM ubuntu:22.04

# تثبيت الحزم وتحديث النظام في أمر واحد لتصغير حجم الصورة
RUN apt-get update && \
    apt-get install -y shellinabox sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# إنشاء مستخدم جديد (أفضل من الرووت) وتعيين كلمة سر له
# سنسميه 'admin' وكلمة السر 'admin'
RUN useradd -m -s /bin/bash admin && \
    echo 'admin:admin' | chpasswd && \
    adduser admin sudo

# تغيير كلمة سر الرووت أيضاً للاحتياط
RUN echo 'root:root' | chpasswd

# إعداد Shellinabox ليعمل بدون تشفير SSL (لأن المنصة هي اللي توفر SSL)
# وتغيير البورت ليكون 7860 (متوافق مع Hugging Face وأغلب الاستضافات)
EXPOSE 7860

# تشغيل الخدمة مع إعدادات تسمح بالوصول من المتصفح
CMD ["/usr/bin/shellinaboxd", "-t", "--no-beep", "-p", "7860", "-s", "/:LOGIN"]
