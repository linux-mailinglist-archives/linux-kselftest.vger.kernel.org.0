Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259C63F0A7D
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Aug 2021 19:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbhHRRtp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Aug 2021 13:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbhHRRtn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Aug 2021 13:49:43 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8F3C0613A4
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Aug 2021 10:49:01 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id x16so2909518pfh.2
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Aug 2021 10:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RYJCfFwgTLyuPD5HR77kYnoCFym34pQ+lKwHk2HigNQ=;
        b=DRRazD/Lj0lQe7SKFOSNF+yyrxiPQmphxU1+ZbHAiEunTQgwzqDrE0lxBq37Ik2OaB
         EkLcCX6CmJWAcr10CNwJXfYWieOKu7hZcAwwx2JbkV9MAWh3S2hjNLpDVlHMA0iD8GER
         DIem9oEZAOsUDqlakoh4NGwiUI/fdFNDDLPBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RYJCfFwgTLyuPD5HR77kYnoCFym34pQ+lKwHk2HigNQ=;
        b=VtiByQk+NfdIVVGANy8D/3yoY+ylRQzgRE98M4DCElaZLbE6F3GqAD1+8P5pJaious
         x/1SSS8wuC+nTNqckh2Zhhm5VwUaksgE683pxZCS5RqzMZkOPMG0oUeO/UIYFMCiVDEs
         cX1bsFxfZ4pt59tXrAqEZMYeSBJiXeNWQNIim4iOQ22Q2nAo9r36YSPZRPaR2QcvyERt
         3P1nzREoqkS4EncB1wy9mO1a+/eRohJUN9I/PbQ8xfBTb7tl6oKXweGSjvEt5dCk6asY
         eVdNdqk/N9iDJTrr+8msSM+/kLvD2Bu7O+00eFL+qw/MRJPr1Pysjuyf0YvkeNVfv9G9
         abWA==
X-Gm-Message-State: AOAM532fBJu7xhkx6DIflj9f5/CLw3+zwY7yB40hwokMpugaVn2sStfy
        PeX+tVC+zZCovCOgF/c5HZJW1k3UgJlYhg==
X-Google-Smtp-Source: ABdhPJyVd0WLAE1TFxBtO8q9eyjM/fvvUT+s/DMV5lELpYUS0bwQ5590WkBuPRVTIjDlOyJH/jVUlQ==
X-Received: by 2002:a63:f946:: with SMTP id q6mr9928796pgk.42.1629308940542;
        Wed, 18 Aug 2021 10:49:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gd20sm400380pjb.42.2021.08.18.10.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 10:48:58 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        linux-kernel@vger.kernel.org, kernelci@groups.io,
        linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 2/4] lkdtm/fortify: Consolidate FORTIFY_SOURCE tests
Date:   Wed, 18 Aug 2021 10:48:53 -0700
Message-Id: <20210818174855.2307828-3-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818174855.2307828-1-keescook@chromium.org>
References: <20210818174855.2307828-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6095; h=from:subject; bh=UmwnZxO/xqyq4TgyADzfcD0MdjONqujpVInQIwTkiPA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHUgGN9h2kr69Q2znAyUZppgYv1pZU7wBWLrirpH1 BbYNZlGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYR1IBgAKCRCJcvTf3G3AJmLVEA CMDyWcAaZGvjBppMRE5YtyzLTZEl1BJVupmm4IuHd/R8ncLZP1SNTUV9xx+mSpJgo/z/CireZO3PB3 UpjxyJt7L+fx9bM9sFbeZwv4aFXyImq+/EXQAGHWSmgZwXfWDPC6ywRqtAxPj7YqSKKh69SchzGRMP Nx82lkoOASBdmM0zveU9zZfMzPeagyLXyjQp8y9Noed9Yx76iycpLsmCvqgMWogEi4MSut3KeDBUbm UIKnd8l+1kHQB8nOtaFG0WuLTIw1heXk1rw36qRSt216rAlrhZOg5JC8rBIzIC2oBNKEdFGtw8kZGx BSObXYHoQpCyURAdI/8cmtgNh3ftH0f7rTGuFM2eaCnGwPxIk9pgDCclcyqDMACev8CDsjZUk3zAHd p5aT5qKJwfPvZZ8RkDBM1yW7S4BqhECGHG5b2e3F46oiZnDfcWSk2328f765hRiorKx+RGJbXPWUTF qmGcK7PRy/M4lXbJirQU4c5z9qkuoVK7ePozHHmtHLMoItefHKNAs94oD/Nn7WkTzHyw9MEr79C4fM ePpvjMmdz+8wt+Gj3Wyo4/c3iTWuUa8ZqerPaDf3TD9FzSwxQ1Zy5h2YX7bRgryvVuq/CU0MuPS4HB NSU92eeCfWHuVPLWQLIeIlYXL/Qxfqji3LRyxg3MJRgytS065OLNGwsqDvJw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The FORTIFY_SOURCE tests were split between bugs.c and fortify.c. Move
tests into fortify.c, standardize their naming, add CONFIG hints, and
add them to the lkdtm selftests.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/bugs.c               | 50 -----------------------
 drivers/misc/lkdtm/core.c               |  4 +-
 drivers/misc/lkdtm/fortify.c            | 53 +++++++++++++++++++++++++
 drivers/misc/lkdtm/lkdtm.h              |  4 +-
 tools/testing/selftests/lkdtm/tests.txt |  2 +
 5 files changed, 59 insertions(+), 54 deletions(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 03171e412356..4282b625200f 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -507,53 +507,3 @@ noinline void lkdtm_CORRUPT_PAC(void)
 	pr_err("XFAIL: this test is arm64-only\n");
 #endif
 }
-
-void lkdtm_FORTIFY_OBJECT(void)
-{
-	struct target {
-		char a[10];
-	} target[2] = {};
-	int result;
-
-	/*
-	 * Using volatile prevents the compiler from determining the value of
-	 * 'size' at compile time. Without that, we would get a compile error
-	 * rather than a runtime error.
-	 */
-	volatile int size = 11;
-
-	pr_info("trying to read past the end of a struct\n");
-
-	result = memcmp(&target[0], &target[1], size);
-
-	/* Print result to prevent the code from being eliminated */
-	pr_err("FAIL: fortify did not catch an object overread!\n"
-	       "\"%d\" was the memcmp result.\n", result);
-}
-
-void lkdtm_FORTIFY_SUBOBJECT(void)
-{
-	struct target {
-		char a[10];
-		char b[10];
-	} target;
-	char *src;
-
-	src = kmalloc(20, GFP_KERNEL);
-	strscpy(src, "over ten bytes", 20);
-
-	pr_info("trying to strcpy past the end of a member of a struct\n");
-
-	/*
-	 * strncpy(target.a, src, 20); will hit a compile error because the
-	 * compiler knows at build time that target.a < 20 bytes. Use strcpy()
-	 * to force a runtime error.
-	 */
-	strcpy(target.a, src);
-
-	/* Use target.a to prevent the code from being eliminated */
-	pr_err("FAIL: fortify did not catch an sub-object overrun!\n"
-	       "\"%s\" was copied.\n", target.a);
-
-	kfree(src);
-}
diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index 9dda87c6b54a..dbdb0af7f68a 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -119,8 +119,6 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(UNSET_SMEP),
 	CRASHTYPE(CORRUPT_PAC),
 	CRASHTYPE(UNALIGNED_LOAD_STORE_WRITE),
-	CRASHTYPE(FORTIFY_OBJECT),
-	CRASHTYPE(FORTIFY_SUBOBJECT),
 	CRASHTYPE(SLAB_LINEAR_OVERFLOW),
 	CRASHTYPE(VMALLOC_LINEAR_OVERFLOW),
 	CRASHTYPE(WRITE_AFTER_FREE),
@@ -180,6 +178,8 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(USERCOPY_KERNEL),
 	CRASHTYPE(STACKLEAK_ERASING),
 	CRASHTYPE(CFI_FORWARD_PROTO),
+	CRASHTYPE(FORTIFIED_OBJECT),
+	CRASHTYPE(FORTIFIED_SUBOBJECT),
 	CRASHTYPE(FORTIFIED_STRSCPY),
 	CRASHTYPE(DOUBLE_FAULT),
 #ifdef CONFIG_PPC_BOOK3S_64
diff --git a/drivers/misc/lkdtm/fortify.c b/drivers/misc/lkdtm/fortify.c
index 0f51d31b57ca..d06458a4858e 100644
--- a/drivers/misc/lkdtm/fortify.c
+++ b/drivers/misc/lkdtm/fortify.c
@@ -8,6 +8,59 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 
+static volatile int fortify_scratch_space;
+
+void lkdtm_FORTIFIED_OBJECT(void)
+{
+	struct target {
+		char a[10];
+	} target[2] = {};
+	/*
+	 * Using volatile prevents the compiler from determining the value of
+	 * 'size' at compile time. Without that, we would get a compile error
+	 * rather than a runtime error.
+	 */
+	volatile int size = 11;
+
+	pr_info("trying to read past the end of a struct\n");
+
+	/* Store result to global to prevent the code from being eliminated */
+	fortify_scratch_space = memcmp(&target[0], &target[1], size);
+
+	pr_err("FAIL: fortify did not block an object overread!\n");
+	pr_expected_config(CONFIG_FORTIFY_SOURCE);
+}
+
+void lkdtm_FORTIFIED_SUBOBJECT(void)
+{
+	struct target {
+		char a[10];
+		char b[10];
+	} target;
+	volatile int size = 20;
+	char *src;
+
+	src = kmalloc(size, GFP_KERNEL);
+	strscpy(src, "over ten bytes", size);
+	size = strlen(src) + 1;
+
+	pr_info("trying to strcpy past the end of a member of a struct\n");
+
+	/*
+	 * memcpy(target.a, src, 20); will hit a compile error because the
+	 * compiler knows at build time that target.a < 20 bytes. Use a
+	 * volatile to force a runtime error.
+	 */
+	memcpy(target.a, src, size);
+
+	/* Store result to global to prevent the code from being eliminated */
+	fortify_scratch_space = target.a[3];
+
+	pr_err("FAIL: fortify did not block an sub-object overrun!\n");
+	pr_expected_config(CONFIG_FORTIFY_SOURCE);
+
+	kfree(src);
+}
 
 /*
  * Calls fortified strscpy to test that it returns the same result as vanilla
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index 6a30b60519f3..f2e61581c1ae 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -74,8 +74,6 @@ void lkdtm_STACK_GUARD_PAGE_TRAILING(void);
 void lkdtm_UNSET_SMEP(void);
 void lkdtm_DOUBLE_FAULT(void);
 void lkdtm_CORRUPT_PAC(void);
-void lkdtm_FORTIFY_OBJECT(void);
-void lkdtm_FORTIFY_SUBOBJECT(void);
 
 /* heap.c */
 void __init lkdtm_heap_init(void);
@@ -150,6 +148,8 @@ void lkdtm_STACKLEAK_ERASING(void);
 void lkdtm_CFI_FORWARD_PROTO(void);
 
 /* fortify.c */
+void lkdtm_FORTIFIED_OBJECT(void);
+void lkdtm_FORTIFIED_SUBOBJECT(void);
 void lkdtm_FORTIFIED_STRSCPY(void);
 
 /* powerpc.c */
diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
index 6a33dbea8491..09f7bfa383cc 100644
--- a/tools/testing/selftests/lkdtm/tests.txt
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -73,4 +73,6 @@ USERCOPY_KERNEL
 STACKLEAK_ERASING OK: the rest of the thread stack is properly erased
 CFI_FORWARD_PROTO
 FORTIFIED_STRSCPY
+FORTIFIED_OBJECT
+FORTIFIED_SUBOBJECT
 PPC_SLB_MULTIHIT Recovered
-- 
2.30.2

