Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6839F1DE
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2019 19:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbfH0Rtr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Aug 2019 13:49:47 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:56050 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbfH0Rtr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Aug 2019 13:49:47 -0400
Received: by mail-pf1-f202.google.com with SMTP id 22so15139294pfn.22
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Aug 2019 10:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kBdnxSxfNrFWkVEGyrNiJF2qYM16TCNtAyDwbg8s3Rk=;
        b=HOn/Th1QKNcSzNR3M0ivHvPiRM2bzQGo8BrsuGTsP0yVKcaY9EThjCVmrGsqv68SRl
         08AFZc+Ve9nLv+iuxMWWoQ8TfuoczhlgUagEpq4zf93CTKd5WfjAM71R3eFW1bl8x2kv
         a/If01mUOn+T/zWriHxXPvCBW8ssCgL7q7AQF+09Dzd8dYLWrmJQrx6Fr4RYWfa9nqr4
         fHQiDDcS7vc9ks9Y0T0YBiDTEyShWi/5rmpo4XF6r+rl1EdZOn8wwU5cJSG0qA+IYNtL
         7DxPEE9WqIzJhTBvuCB2Y9gMYcXYLFadNIklLwxHR7pfGvIJdBAaoSAsh5dWfLh2K7W1
         Ihjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kBdnxSxfNrFWkVEGyrNiJF2qYM16TCNtAyDwbg8s3Rk=;
        b=ClX+BuA0oxCpJyIR1pUabe1OVtPhA8sk4+5fCbl9MkR1Tm4amyENND9k2Kl89HNOG0
         +O0acm79gKvpYbmcwJ43Xkfwj3r4qku+tcFZLoseOfRqq/7Wuu4zrauwa6EXSbvXV8sn
         gKnAqdfXXaU53mjwM07Tw01qHrKG++4fW5QRSJ6t615+oVypHSJbDXlZzPxgFSaIASPx
         lmo1UWb2sUn/cWM1pbIZBYC09xuihZ+I/zeUiwwJ42uRv1oAv8G38DFzPrn8KHjJ596W
         t1B/DWmMnmtSIHH773ZSsvYiM1PhQ4LvhtBQKp3b8J/7lmLeYEnmE2Jp+wtqBvHb7woM
         YFtw==
X-Gm-Message-State: APjAAAU+LdAQS/N/q+gKAqUpgd3pYmOyXcsRNWKNIEb4a2YWSsBCybpw
        ENISvNVx6uRn49yi5ZRT5KSQSme3ZuLhxn/wFZ7DFA==
X-Google-Smtp-Source: APXvYqzuY3DB3JPKTCk1lSTX1WmoxGNBIKvHThp1bwIkRjN5dpabp0rDjmzoCO0QjJ5fmhmmeC4w2szCM4IP8kr+EoqdCg==
X-Received: by 2002:a63:595d:: with SMTP id j29mr22734669pgm.134.1566928186602;
 Tue, 27 Aug 2019 10:49:46 -0700 (PDT)
Date:   Tue, 27 Aug 2019 10:49:32 -0700
Message-Id: <20190827174932.44177-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v1] kunit: fix failure to build without printk
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org
Cc:     kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, frowand.list@gmail.com,
        sboyd@kernel.org, Brendan Higgins <brendanhiggins@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Previously KUnit assumed that printk would always be present, which is
not a valid assumption to make. Fix that by ifdefing out functions which
directly depend on printk core functions similar to what dev_printk
does.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/linux-kselftest/0352fae9-564f-4a97-715a-fabe016259df@kernel.org/T/#t
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/test.h |  7 +++++++
 kunit/test.c         | 41 ++++++++++++++++++++++++-----------------
 2 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 8b7eb03d4971..339af5f95c4a 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -339,9 +339,16 @@ static inline void *kunit_kzalloc(struct kunit *test, size_t size, gfp_t gfp)
 
 void kunit_cleanup(struct kunit *test);
 
+#ifdef CONFIG_PRINTK
 void __printf(3, 4) kunit_printk(const char *level,
 				 const struct kunit *test,
 				 const char *fmt, ...);
+#else
+static inline void __printf(3, 4) kunit_printk(const char *level,
+					       const struct kunit *test,
+					       const char *fmt, ...)
+{}
+#endif
 
 /**
  * kunit_info() - Prints an INFO level message associated with @test.
diff --git a/kunit/test.c b/kunit/test.c
index b2ca9b94c353..0aa1caf07a6b 100644
--- a/kunit/test.c
+++ b/kunit/test.c
@@ -16,6 +16,7 @@ static void kunit_set_failure(struct kunit *test)
 	WRITE_ONCE(test->success, false);
 }
 
+#ifdef CONFIG_PRINTK
 static int kunit_vprintk_emit(int level, const char *fmt, va_list args)
 {
 	return vprintk_emit(0, level, NULL, 0, fmt, args);
@@ -40,6 +41,29 @@ static void kunit_vprintk(const struct kunit *test,
 	kunit_printk_emit(level[1] - '0', "\t# %s: %pV", test->name, vaf);
 }
 
+void kunit_printk(const char *level,
+		  const struct kunit *test,
+		  const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	kunit_vprintk(test, level, &vaf);
+
+	va_end(args);
+}
+#else /* CONFIG_PRINTK */
+static inline int kunit_printk_emit(int level, const char *fmt, ...)
+{
+	return 0;
+}
+#endif /* CONFIG_PRINTK */
+
 static void kunit_print_tap_version(void)
 {
 	static bool kunit_has_printed_tap_version;
@@ -504,20 +528,3 @@ void kunit_cleanup(struct kunit *test)
 		kunit_resource_free(test, resource);
 	}
 }
-
-void kunit_printk(const char *level,
-		  const struct kunit *test,
-		  const char *fmt, ...)
-{
-	struct va_format vaf;
-	va_list args;
-
-	va_start(args, fmt);
-
-	vaf.fmt = fmt;
-	vaf.va = &args;
-
-	kunit_vprintk(test, level, &vaf);
-
-	va_end(args);
-}
-- 
2.23.0.187.g17f5b7556c-goog

