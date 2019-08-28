Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA5A9FE83
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2019 11:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfH1Jc3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Aug 2019 05:32:29 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:56843 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfH1Jc3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Aug 2019 05:32:29 -0400
Received: by mail-pl1-f201.google.com with SMTP id v4so1191470plp.23
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2019 02:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VrSJG1qLRq08HkXyX6gIPsC7lVivMGhOydit43IGTq0=;
        b=TswDkIrTQgaJ9VzvD3+btGc/S/jYumeJyyBCresMJXTAFmHnVLJIYuxlphFpG9cpkx
         YqoDwWn2KVpKJJFzEPaWccZJzcNr7Is9Ezzxvv+cOfG38aUZp9XhIEbUEi46oN7zIskx
         P45XYZYD66WGu4AToy9tKGMS4XF5PcDcYEmOMJi9GRd8LzmGfoDY2cmEJ1wW18EjEToo
         GAkIVBe//tJiaOqHSTjHHJuxJ/q71ULikLsNnL3ZD1k/TEjMUQ90IJpydHIwx0GzQsjk
         dYWN0Y466D3C68ALXrcbyc87W4gd8f8yoL47v2flto9Gyu9tokI5tvQZIa9u9ue10lh5
         rfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VrSJG1qLRq08HkXyX6gIPsC7lVivMGhOydit43IGTq0=;
        b=gFhEkSzq6aaFPzn87SWYQgCepn4HEnW5IqZEZIO2l4OEEUN/kEAzhs7gdg7m9UM199
         N3lGemAz4CdPwBictj2Rd4xZcOmYpKsSd2UH0LIy4CTztR6TacrW5d/5zyQYqAuwYhxj
         BiNGdg/JheQy9NJbRqZ4SOsLsfmbqGNvdWLUgsSVgiw8i+H/9JHTpLIkXYxSFdZzetKe
         xfuUgV0EwJcSvhJOV+WC23AZFCpYfdTJ1IYDGA28ZtiJCnVL4/OxCvTkkdnC+DFaHJmt
         OhEGyUAptwsDQVqoKHQUbwkGkBJV5G5/dT+LiXSyDNgvGeH2SXwWTFAgdoUc9Qkdiwg4
         8baw==
X-Gm-Message-State: APjAAAUW45zvYnFYNTc4/X2mKkyU6VW1nuTxAn3vjvc3TyFrMfuLqYn7
        EVQETiX8OS4CrvORYrK38+IyrY6t3JyADf528hJniw==
X-Google-Smtp-Source: APXvYqyxnVF5mIbgiG1foc/RCXqDGnGXSIO4sJTjhf3Wj3DelUEERcjYM4JOBTHkNaE8vNKDz5SDoKCiBCP732mfcWYyAg==
X-Received: by 2002:a65:5c02:: with SMTP id u2mr2613932pgr.367.1566984747724;
 Wed, 28 Aug 2019 02:32:27 -0700 (PDT)
Date:   Wed, 28 Aug 2019 02:31:43 -0700
Message-Id: <20190828093143.163302-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v2] kunit: fix failure to build without printk
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org
Cc:     kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, frowand.list@gmail.com,
        sboyd@kernel.org, pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, Brendan Higgins <brendanhiggins@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Previously KUnit assumed that printk would always be present, which is
not a valid assumption to make. Fix that by removing call to
vprintk_emit, and calling printk directly.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/linux-kselftest/0352fae9-564f-4a97-715a-fabe016259df@kernel.org/T/#t
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/test.h | 11 ++++-----
 kunit/test.c         | 57 +++++---------------------------------------
 2 files changed, 11 insertions(+), 57 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 8b7eb03d4971..efad2eacd6ba 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -339,9 +339,8 @@ static inline void *kunit_kzalloc(struct kunit *test, size_t size, gfp_t gfp)
 
 void kunit_cleanup(struct kunit *test);
 
-void __printf(3, 4) kunit_printk(const char *level,
-				 const struct kunit *test,
-				 const char *fmt, ...);
+#define kunit_print_level(KERN_LEVEL, test, fmt, ...) \
+	printk(KERN_LEVEL "\t# %s: " fmt, (test)->name, ##__VA_ARGS__)
 
 /**
  * kunit_info() - Prints an INFO level message associated with @test.
@@ -353,7 +352,7 @@ void __printf(3, 4) kunit_printk(const char *level,
  * Takes a variable number of format parameters just like printk().
  */
 #define kunit_info(test, fmt, ...) \
-	kunit_printk(KERN_INFO, test, fmt, ##__VA_ARGS__)
+	kunit_print_level(KERN_INFO, test, fmt, ##__VA_ARGS__)
 
 /**
  * kunit_warn() - Prints a WARN level message associated with @test.
@@ -364,7 +363,7 @@ void __printf(3, 4) kunit_printk(const char *level,
  * Prints a warning level message.
  */
 #define kunit_warn(test, fmt, ...) \
-	kunit_printk(KERN_WARNING, test, fmt, ##__VA_ARGS__)
+	kunit_print_level(KERN_WARNING, test, fmt, ##__VA_ARGS__)
 
 /**
  * kunit_err() - Prints an ERROR level message associated with @test.
@@ -375,7 +374,7 @@ void __printf(3, 4) kunit_printk(const char *level,
  * Prints an error level message.
  */
 #define kunit_err(test, fmt, ...) \
-	kunit_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
+	kunit_print_level(KERN_ERR, test, fmt, ##__VA_ARGS__)
 
 /**
  * KUNIT_SUCCEED() - A no-op expectation. Only exists for code clarity.
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

