Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E2748B781
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jan 2022 20:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237684AbiAKTmo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jan 2022 14:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237090AbiAKTmn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jan 2022 14:42:43 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7C8C061748
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jan 2022 11:42:43 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id k130-20020a255688000000b0060c3dcae580so38880ybb.6
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jan 2022 11:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7m9XYx4AzAS0+JhiVJNvVIbNeaQHgXtmefJJRSWs+Yo=;
        b=Z8rie0K5w5Y7can5kAE35T/Bx66u7zkzrOaWt9/TqCJJ3Jyc4/cSbGYgwlq61D9X8u
         kCHXaAxYjSXZ7Lr0fHY7QdaDM13DIT6MwAkYUFxndn474+hpJWHgy1aoprr2W2mw3bXM
         bHa/FjnIhHIg/efnpDrsRVlZVlCxisG5bDt88BQhHN/KCN7lw0BFdrjCXDYY8aJvr3LW
         /Wpc39lqrsrsvW4vBC8UM8NMveZcoAT+Jta4OzemN7sVeRoqQ40q0h4OvdhBaWE0kV5F
         TBZI9cuhUwUCrmYzWDZgI3tNnAPE3pXgRDu0x37AYwqfZPl9yG3Gi6eibKIESDM1UE+u
         /fXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7m9XYx4AzAS0+JhiVJNvVIbNeaQHgXtmefJJRSWs+Yo=;
        b=rI4/IzaGS+UiuVmtLrQF4iKt9E/7oHj1gTFINMmePvcb8JjoH5SU77V5Ctu3XngAUG
         8abDtw4rDznIOfUnTVC/ifcnVnBzaPNsz+I5idAg2r4HlptSxyyyXxIidldYk2Jp4Scy
         skfAkM/oEKUdz0xZwuIqHK97bgfEvWufzk7gHTfVu5iw5nQiQOcqu9YCEla8h+KODg8q
         Dl1C2E7avDlELYlxNwl9OSNXxXXG9JZ0eFSRzykXOjaeyjiCW30tR8YJ6HTYIeV5tvwQ
         c3+0ypaGsHMN8xFsI31OAqRMe+HyNxNWU514VhjDpzrtOiUaRPSZiD3J4mSQh1xCcWYi
         Qr6g==
X-Gm-Message-State: AOAM532OhjDYuXj0893C2RliUUiRazx1RJebKCdwvrMU3aBbubouaoo6
        0UmpdzdqR+sf2IoClRLPBcq4+uyTFV3WEg==
X-Google-Smtp-Source: ABdhPJy2qjNd99ZaZDSTzdjCMiTY7iugt1d+Mw4DC2/UQM79F+zzLtISUuTSZknSpbZbF4v+JMsruSz5rCsqpA==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:8c76:9de0:1a30:7de8])
 (user=dlatypov job=sendgmr) by 2002:a25:d34b:: with SMTP id
 e72mr8522778ybf.497.1641930162675; Tue, 11 Jan 2022 11:42:42 -0800 (PST)
Date:   Tue, 11 Jan 2022 11:42:27 -0800
In-Reply-To: <20220111194231.1797841-1-dlatypov@google.com>
Message-Id: <20220111194231.1797841-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20220111194231.1797841-1-dlatypov@google.com>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
Subject: [PATCH v2 2/6] kunit: move check if assertion passed into the macros
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
I feel this a  bit easier to read and understand.

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
2.34.1.575.g55b058a8bb-goog

