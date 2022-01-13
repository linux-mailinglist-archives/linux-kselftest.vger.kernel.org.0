Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F9D48DC58
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jan 2022 17:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbiAMQ75 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jan 2022 11:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236952AbiAMQ7x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jan 2022 11:59:53 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5972C06161C
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jan 2022 08:59:52 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g7-20020a25bdc7000000b00611c616bc76so3388641ybk.5
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jan 2022 08:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=htEX0Gdel3WvnrwFTzCEywKa/by6HkwGkboy+SVwZjU=;
        b=r7xgrNXBkpxtb7Btc/Pz6rcxRHSntWOpNorE3R65+0/RZnrxZXubCJJGjB31cnpeFZ
         Bcjo0klWnDqTpZ5XDvmK+DhXWVbjW/iPbvoSLjZW4tsIrccSaKNTCyQLOgG3Grx43DQH
         X2j68HQV4XqPHVyIbPguwq4Wwbja8tpKvd+DWXb+NBX1X8l15HpiRL2DWK1hNp3EhfBI
         s7ISRX6gWiHeP12kFV3cN2JczdCRbFcry7x+YwCtEyU2F6us6yh+z0tc1D9RDafTZY0v
         CecQO0UlwUgfomVNMXBQqp/WR6VqQYKmObtYHGEqh0Or4eYDEpOam7lGlSCKh3epsTyV
         /6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=htEX0Gdel3WvnrwFTzCEywKa/by6HkwGkboy+SVwZjU=;
        b=4XEhU+ZyYZsCx5+PYkXo91mvbmJKZhANvLJuigxs9A9BYpneL8AxG/skyl+VPSPTBU
         B8UfM+g2Zd4q7aRSLu6HIIn8U3wCVUpINXrfmJr7X0oj7Cb2GvUiKNwbNt5Bpnf4Cumh
         ZTSanNlUun4FIIgEcYZcW83KDrEUoQnl9TH7NbyouCiAHGwb9w6jb9ihbABpxTlhc6gY
         WiGn+oLljWGFLtP+jkQYj43n6IuvqQnAuK2IWRPmAHIqC1KlVP3TX+QxOCdZP6BgG6Rk
         +s0qgFTtdYqXIHRx37nuwInNddKyxjy9klbfMNo2pGQ8E7losO14IzYmDkxlJnQSH0wP
         Yg5Q==
X-Gm-Message-State: AOAM530WvI0TZ1EG4faAKwdCwfsvnlMHXso3zQWR2NBDnKltjxU+fLEE
        N5/UA+5rNEmzn3/aMPwb2tfniNip9y8sFg==
X-Google-Smtp-Source: ABdhPJz2nhkjoOiJJsfBgAHqSQN3NqBVfT3Ry0IvLR7NIibiZ4/nhxW/IvzTIS4nUbhmF3d+ndZvUdPhsjPQgw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:1a70:cede:4191:24bc])
 (user=dlatypov job=sendgmr) by 2002:a5b:b8f:: with SMTP id
 l15mr7287490ybq.433.1642093192096; Thu, 13 Jan 2022 08:59:52 -0800 (PST)
Date:   Thu, 13 Jan 2022 08:59:27 -0800
In-Reply-To: <20220113165931.451305-1-dlatypov@google.com>
Message-Id: <20220113165931.451305-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20220113165931.451305-1-dlatypov@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH v3 2/6] kunit: move check if assertion passed into the macros
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        torvalds@linux-foundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently the code always calls kunit_do_assertion() even though it does
nothing when `pass` is true.

This change moves the `if(!(pass))` check into the macro instead
and renames the function to kunit_do_failed_assertion().
I feel this a bit easier to read and understand.

This has the potential upside of avoiding a function call that does
nothing most of the time (assuming your tests are passing) but comes
with the downside of generating a bit more code and branches. We try to
mitigate the branches by tagging them with `unlikely()`.

This also means we don't have to initialize structs that we don't need,
which will become a tiny bit more expensive if we switch over to using
static variables to try and reduce stack usage. (There's runtime code
to check if the variable has been initialized yet or not).

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
 include/kunit/test.h | 21 +++++++++++----------
 lib/kunit/test.c     | 13 ++++---------
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index b26400731c02..12cabd15449a 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -12,6 +12,7 @@
 #include <kunit/assert.h>
 #include <kunit/try-catch.h>
 
+#include <linux/compiler.h>
 #include <linux/container_of.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -770,18 +771,18 @@ void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
  */
 #define KUNIT_SUCCEED(test) do {} while (0)
 
-void kunit_do_assertion(struct kunit *test,
-			struct kunit_assert *assert,
-			bool pass,
-			const char *fmt, ...);
+void kunit_do_failed_assertion(struct kunit *test,
+			       struct kunit_assert *assert,
+			       const char *fmt, ...);
 
 #define KUNIT_ASSERTION(test, pass, assert_class, INITIALIZER, fmt, ...) do {  \
-	struct assert_class __assertion = INITIALIZER;			       \
-	kunit_do_assertion(test,					       \
-			   &__assertion.assert,				       \
-			   pass,					       \
-			   fmt,						       \
-			   ##__VA_ARGS__);				       \
+	if (unlikely(!(pass))) {					       \
+		struct assert_class __assertion = INITIALIZER;		       \
+		kunit_do_failed_assertion(test,				       \
+					  &__assertion.assert,		       \
+					  fmt,				       \
+					  ##__VA_ARGS__);		       \
+	}								       \
 } while (0)
 
 
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index c7ed4aabec04..3a52c321c280 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -275,16 +275,11 @@ static void __noreturn kunit_abort(struct kunit *test)
 	WARN_ONCE(true, "Throw could not abort from test!\n");
 }
 
-void kunit_do_assertion(struct kunit *test,
-			struct kunit_assert *assert,
-			bool pass,
-			const char *fmt, ...)
+void kunit_do_failed_assertion(struct kunit *test,
+			       struct kunit_assert *assert,
+			       const char *fmt, ...)
 {
 	va_list args;
-
-	if (pass)
-		return;
-
 	va_start(args, fmt);
 
 	assert->message.fmt = fmt;
@@ -297,7 +292,7 @@ void kunit_do_assertion(struct kunit *test,
 	if (assert->type == KUNIT_ASSERTION)
 		kunit_abort(test);
 }
-EXPORT_SYMBOL_GPL(kunit_do_assertion);
+EXPORT_SYMBOL_GPL(kunit_do_failed_assertion);
 
 void kunit_init_test(struct kunit *test, const char *name, char *log)
 {
-- 
2.34.1.703.g22d0c6ccf7-goog

