Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF29AA77B5
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2019 02:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfIDABC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Sep 2019 20:01:02 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:54341 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfIDABC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Sep 2019 20:01:02 -0400
Received: by mail-qt1-f202.google.com with SMTP id c13so4247138qtp.21
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Sep 2019 17:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=s3xXkj7MNmSx3MhxXe3TXn8jKvM3DQL0wnAOF4bIi5s=;
        b=oEhAtAiH1DTO2KE5wzvhiBbW/wHfBTS6oa8DE1A/IssVwGGSnPWja09Q3ATPeBpyj5
         OmgkgYBjpU8Iifu6/Dc2XNWl0E3Inekz3GLU5maYWfLNoeUAHfuvC3ht0XCAuFk9uaL6
         aNoyUt3m/IbjtM0Gtu/f4eV/PXyVRWp2GbSlOaDhBO7VGD6nowBnzmhpc0gPVTnkU3t0
         urwc20SHncFGEsyeKL3sF4H7UXSCJjredE8DO1pzekFsYi+1hdrCGoQdNC6LTUoAHIRm
         4ki+JyYI8dsEgIp7U+MgXe3diBe+cv6rth4DjC2QTT+1mey+72NMCddANf6LA0WiD91J
         c/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=s3xXkj7MNmSx3MhxXe3TXn8jKvM3DQL0wnAOF4bIi5s=;
        b=QYG+N6RjWxUf1cQMqJmtEvIm7ysx8NMnrpOg9CO32mPYe+1Fwc8HFXnNdAaVLKLD8E
         5lWmBPZHNvVXZvtvUWQ0kXgtUjvkQvyfhUSfyTGgeUOxlqdaSMytjXi6u95Mp1/g0irz
         2yKiGSgxHrez0QFiUAGkVfHaFcTPULnwW2Me+MHiiuomXfbGUeMZ0+wpXpWAQwh9ZL7x
         P51Je0NpbEjBUW8Z+lnKGSrRjjYTlKJJqBXtnt6hlYmaxEBffAIJ5fAUYb0JK7IuBrBf
         p5IyYOF/foCRHTxQEnUSZcV9LHaXQc3wnDqlb8OstSJZcOcWjd5DxyyqK8OKoS5O122r
         ARvg==
X-Gm-Message-State: APjAAAVnSKmqO87+d1C6NYVuSt/4u2sxBnKabmOUytf+LQiFaFs1mOZ7
        eiPyBTXy5pzbJMdvQDZfnSfau60vANt1zSS40o5oRw==
X-Google-Smtp-Source: APXvYqz1LMWBYSl51gYkbOAlajtUCBBk7N0+17zCZlUyyj6MLko2YOVBiEvAKLgv1ye/93ojwRjec2Um7HBNPtQwoHZQUw==
X-Received: by 2002:a0c:e94e:: with SMTP id n14mr6585676qvo.234.1567555260842;
 Tue, 03 Sep 2019 17:01:00 -0700 (PDT)
Date:   Tue,  3 Sep 2019 17:00:56 -0700
Message-Id: <20190904000056.247583-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v4] kunit: fix failure to build without printk
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org
Cc:     kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, frowand.list@gmail.com,
        sboyd@kernel.org, pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, Brendan Higgins <brendanhiggins@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Joe Perches <joe@perches.com>, Tim.Bird@sony.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Previously KUnit assumed that printk would always be present, which is
not a valid assumption to make. Fix that by removing call to
vprintk_emit, and calling printk directly.

This fixes a build error[1] reported by Randy.

For context this change comes after much discussion. My first stab[2] at
this was just to make the KUnit logging code compile out; however, it
was agreed that if we were going to use vprintk_emit, then vprintk_emit
should provide a no-op stub, which lead to my second attempt[3]. In
response to me trying to stub out vprintk_emit, Sergey Senozhatsky
suggested a way for me to remove our usage of vprintk_emit, which led to
my third attempt at solving this[4].

In my third version of this patch[4], I completely removed vprintk_emit,
as suggested by Sergey; however, there was a bit of debate over whether
Sergey's solution was the best. The debate arose due to Sergey's version
resulting in a checkpatch warning, which resulted in a debate over
correct printk usage. Joe Perches offered an alternative fix which was
somewhat less far reaching than what Sergey had suggested and
importantly relied on continuing to use %pV. Much of the debated
centered around whether %pV should be widely used, and whether Sergey's
version would result in object size bloat. Ultimately, we decided to go
with Sergey's version.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Link[1]: https://lore.kernel.org/linux-kselftest/c7229254-0d90-d90e-f3df-5b6d6fc0b51f@infradead.org/
Link[2]: https://lore.kernel.org/linux-kselftest/20190827174932.44177-1-brendanhiggins@google.com/
Link[3]: https://lore.kernel.org/linux-kselftest/20190827234835.234473-1-brendanhiggins@google.com/
Link[4]: https://lore.kernel.org/linux-kselftest/20190828093143.163302-1-brendanhiggins@google.com/
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Joe Perches <joe@perches.com>
Cc: Tim.Bird@sony.com
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Reviewed-by: Petr Mladek <pmladek@suse.com>
---

Sorry for the long commit message, but given the long discussion (and
some of the confusion that occurred in the discussion), it seemed
appropriate to summarize the discussion around this patch up to this
point (especially since one of the proposed patches was under a separate
patch subject).

Changes Since v3:

Renamed kunit_print_level to kunit_printk, and changed the KERN_LEVEL
macro parameter (in kunit_printk) to lvl, as suggested by Joe.

---
 include/kunit/test.h |  5 ++--
 kunit/test.c         | 57 +++++---------------------------------------
 2 files changed, 8 insertions(+), 54 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 8b7eb03d4971..dba48304b3bd 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -339,9 +339,8 @@ static inline void *kunit_kzalloc(struct kunit *test, size_t size, gfp_t gfp)
 
 void kunit_cleanup(struct kunit *test);
 
-void __printf(3, 4) kunit_printk(const char *level,
-				 const struct kunit *test,
-				 const char *fmt, ...);
+#define kunit_printk(lvl, test, fmt, ...) \
+	printk(lvl "\t# %s: " fmt, (test)->name, ##__VA_ARGS__)
 
 /**
  * kunit_info() - Prints an INFO level message associated with @test.
diff --git a/kunit/test.c b/kunit/test.c
index b2ca9b94c353..c83c0fa59cbd 100644
--- a/kunit/test.c
+++ b/kunit/test.c
@@ -16,36 +16,12 @@ static void kunit_set_failure(struct kunit *test)
 	WRITE_ONCE(test->success, false);
 }
 
-static int kunit_vprintk_emit(int level, const char *fmt, va_list args)
-{
-	return vprintk_emit(0, level, NULL, 0, fmt, args);
-}
-
-static int kunit_printk_emit(int level, const char *fmt, ...)
-{
-	va_list args;
-	int ret;
-
-	va_start(args, fmt);
-	ret = kunit_vprintk_emit(level, fmt, args);
-	va_end(args);
-
-	return ret;
-}
-
-static void kunit_vprintk(const struct kunit *test,
-			  const char *level,
-			  struct va_format *vaf)
-{
-	kunit_printk_emit(level[1] - '0', "\t# %s: %pV", test->name, vaf);
-}
-
 static void kunit_print_tap_version(void)
 {
 	static bool kunit_has_printed_tap_version;
 
 	if (!kunit_has_printed_tap_version) {
-		kunit_printk_emit(LOGLEVEL_INFO, "TAP version 14\n");
+		pr_info("TAP version 14\n");
 		kunit_has_printed_tap_version = true;
 	}
 }
@@ -64,10 +40,8 @@ static size_t kunit_test_cases_len(struct kunit_case *test_cases)
 static void kunit_print_subtest_start(struct kunit_suite *suite)
 {
 	kunit_print_tap_version();
-	kunit_printk_emit(LOGLEVEL_INFO, "\t# Subtest: %s\n", suite->name);
-	kunit_printk_emit(LOGLEVEL_INFO,
-			  "\t1..%zd\n",
-			  kunit_test_cases_len(suite->test_cases));
+	pr_info("\t# Subtest: %s\n", suite->name);
+	pr_info("\t1..%zd\n", kunit_test_cases_len(suite->test_cases));
 }
 
 static void kunit_print_ok_not_ok(bool should_indent,
@@ -87,9 +61,7 @@ static void kunit_print_ok_not_ok(bool should_indent,
 	else
 		ok_not_ok = "not ok";
 
-	kunit_printk_emit(LOGLEVEL_INFO,
-			  "%s%s %zd - %s\n",
-			  indent, ok_not_ok, test_number, description);
+	pr_info("%s%s %zd - %s\n", indent, ok_not_ok, test_number, description);
 }
 
 static bool kunit_suite_has_succeeded(struct kunit_suite *suite)
@@ -133,11 +105,11 @@ static void kunit_print_string_stream(struct kunit *test,
 		kunit_err(test,
 			  "Could not allocate buffer, dumping stream:\n");
 		list_for_each_entry(fragment, &stream->fragments, node) {
-			kunit_err(test, fragment->fragment);
+			kunit_err(test, "%s", fragment->fragment);
 		}
 		kunit_err(test, "\n");
 	} else {
-		kunit_err(test, buf);
+		kunit_err(test, "%s", buf);
 		kunit_kfree(test, buf);
 	}
 }
@@ -504,20 +476,3 @@ void kunit_cleanup(struct kunit *test)
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

