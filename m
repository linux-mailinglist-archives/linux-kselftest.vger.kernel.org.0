Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4969348806F
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jan 2022 02:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbiAHBXa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jan 2022 20:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbiAHBX3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jan 2022 20:23:29 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4A2C06173E
        for <linux-kselftest@vger.kernel.org>; Fri,  7 Jan 2022 17:23:29 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b144-20020a253496000000b0060bddc72114so15489269yba.4
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jan 2022 17:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xQZ4UQZIi2wKhWeNCsnm8irdkx9el1/PCTUWisxw+OQ=;
        b=JNKHAd9yjJBMtJUQ4LClV4CcQhS2izIKEFjaYRH6X+VvJ1d3rzgOwzhakZtbVTscGK
         y7Z0IcQ1jG7N5HKrXetukC+fh4uluyNwKI7YeOTV5ESukk+qGXxOBjKk5v9OoekzNNNy
         lAi9C+wv52tQ6TSC8VKnwFVFAX0ICAYFv8UzBME7602kc9FZUJbK8r7IAYYN0lDDEIjn
         jrh91XnS68u8s/u37NjOKkUmjGIhI4bxs7/Ga97ZA1DYRxfHwYDif5+ucZYLUY+U8ZfZ
         XuPG8ale7xrBBudlPkeay3+NQQtXnAi0DQG45OPo9maoPvcfgdRcYfxvIHsC1Kz/11VJ
         O4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xQZ4UQZIi2wKhWeNCsnm8irdkx9el1/PCTUWisxw+OQ=;
        b=iV7pirYbLXlWchmXVsihYeRM4RD/pSBqCWth0vj6zvjLSvVRKpWJMkO93oX2bbp+d2
         2gp6V+IwQC28VJEouQdGCjMHxQsicaKdy6SIngk+xLiNPtosrvQiUkWFzMJSguBPcuAO
         ct9mcfk2pSNjhfcoHECevw2yXcTlhP1rbhv7xhK9dijnPzaKarGwpe/xex4md+fAE+xD
         n4INdRihF/xCN1bwZiRSYo6uNt0cyc8P9ZGQI6pIPcuVMYBxVMiwLHloq8JSzzA5GPjd
         uc2wdO56+WyrRnKhezojVeygeRqpqtp8lk+PgB/eKbIKaR+sGIVf5cBtBSeS+cvgYQKA
         6Txw==
X-Gm-Message-State: AOAM530+IDfPZVE8aylmzuedPBZdaMWgUZUgnVd0Ju2GDcgwlR+ghGAj
        RvLKP4cRgr60F+oMgDJx8Ri3MnifwnBBFg==
X-Google-Smtp-Source: ABdhPJxMFgpNQJ28897IdObu3t1ppk49x/Uqzz+z4ZzUqGeH02YVRlaDgV9OrKEB/I0UL8dvVVvanAudrF781A==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:bf8a:7e90:eb70:9b2b])
 (user=dlatypov job=sendgmr) by 2002:a25:2e4c:: with SMTP id
 b12mr70062196ybn.569.1641605008613; Fri, 07 Jan 2022 17:23:28 -0800 (PST)
Date:   Fri,  7 Jan 2022 17:23:00 -0800
In-Reply-To: <20220108012304.1049587-1-dlatypov@google.com>
Message-Id: <20220108012304.1049587-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20220108012304.1049587-1-dlatypov@google.com>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
Subject: [PATCH 2/6] kunit: move check if assertion passed into the macros
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
and renames the function to kunit_failed_assertion().
I feel this a  bit easier to read and understand.

This has the potential upside of avoiding a function call that does
nothing most of the time (assuming your tests are passing) but comes
with the downside of generating a bit more code and branches.

This also means we don't have to initialize structs that we don't need,
which will become a tiny bit more expensive if we switch over to using
static variables to try and reduce stack usage. (There's runtime code
to check if the variable has been initialized yet or not).

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 include/kunit/test.h | 20 ++++++++++----------
 lib/kunit/test.c     | 13 ++++---------
 2 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index b26400731c02..690a28dfc795 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -770,18 +770,18 @@ void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
  */
 #define KUNIT_SUCCEED(test) do {} while (0)
 
-void kunit_do_assertion(struct kunit *test,
-			struct kunit_assert *assert,
-			bool pass,
-			const char *fmt, ...);
+void kunit_failed_assertion(struct kunit *test,
+			    struct kunit_assert *assert,
+			    const char *fmt, ...);
 
 #define KUNIT_ASSERTION(test, pass, assert_class, INITIALIZER, fmt, ...) do {  \
-	struct assert_class __assertion = INITIALIZER;			       \
-	kunit_do_assertion(test,					       \
-			   &__assertion.assert,				       \
-			   pass,					       \
-			   fmt,						       \
-			   ##__VA_ARGS__);				       \
+	if (!(pass)) {							       \
+		struct assert_class __assertion = INITIALIZER;		       \
+		kunit_failed_assertion(test,				       \
+				       &__assertion.assert,		       \
+				       fmt,				       \
+				       ##__VA_ARGS__);			       \
+	}								       \
 } while (0)
 
 
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index c7ed4aabec04..5ad671745483 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -275,16 +275,11 @@ static void __noreturn kunit_abort(struct kunit *test)
 	WARN_ONCE(true, "Throw could not abort from test!\n");
 }
 
-void kunit_do_assertion(struct kunit *test,
-			struct kunit_assert *assert,
-			bool pass,
-			const char *fmt, ...)
+void kunit_failed_assertion(struct kunit *test,
+			    struct kunit_assert *assert,
+			    const char *fmt, ...)
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
+EXPORT_SYMBOL_GPL(kunit_failed_assertion);
 
 void kunit_init_test(struct kunit *test, const char *name, char *log)
 {
-- 
2.34.1.575.g55b058a8bb-goog

