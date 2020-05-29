Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B1B1E8872
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 May 2020 22:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgE2UEF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 May 2020 16:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbgE2UD7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 May 2020 16:03:59 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D82C03E969
        for <linux-kselftest@vger.kernel.org>; Fri, 29 May 2020 13:03:58 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o6so442249pgh.2
        for <linux-kselftest@vger.kernel.org>; Fri, 29 May 2020 13:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ur0tRoXDFgucIHCcDSOWNJgdTr4CPZcipEuAfudLDPs=;
        b=WExBOCKa/51JjvlYoHp9ASlcwtLNRpRKa8pS+Z8PisY4y16S1bwkNPZvmaFrXQ2XZx
         ejqQJS1fBSF7ohENJ1qHiiqpyj1YrhivQLx1DRdFbyeoT5TH4Cja0qj3rKU+T4QWFDKa
         WooH8sPPQLfkbzjb0NOudXvhGaXEPmZaQA4tU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ur0tRoXDFgucIHCcDSOWNJgdTr4CPZcipEuAfudLDPs=;
        b=ZCaLVxk8Cqwe8DgKS5UcA43QNHfpJ55ySxB/5rx/9c1kUyRQ+5dIert638Cb2+Nj6q
         JcyfP/IZICQuX48seqlk0G3h604dvmtNvPf48QWCWjRFjHVHEqJcrGENQiorfogP1Dnc
         cU1c3cS0ieVIv9IOBS7AlShD9RJT8hxrPpI80RAwJyHK/Aa4MU+P/TqaIJWO+CcyXquv
         MXpXNl/Bc5I13DmJxUu/uF4R3risDMMi7xrqXp6vRcKtRPS2QOu/o0BHZh3QMFQD0EcW
         3ra5tQgPr5TX2K788XrgVYT+ajVnnNMrh2tNA0mHjwoCe+5Z4INlyehBUmDywjYcv29p
         /BuA==
X-Gm-Message-State: AOAM5339fVSYL2sM5f+BYF3/6PFv/aHotniRy9Xx8rHcIrglCA7tuk2N
        H5UJsRl3b7K9EKZgo0p+11BH0A==
X-Google-Smtp-Source: ABdhPJycncKsGEo8qJO+uytPUmbryktBpqNRcCiN+8goKytec/Tpui9cWq+9vCo2nCvXAd8MEj2XKQ==
X-Received: by 2002:aa7:84da:: with SMTP id x26mr10167890pfn.24.1590782638413;
        Fri, 29 May 2020 13:03:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k11sm1110168pgq.10.2020.05.29.13.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 13:03:54 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] lkdtm: Make arch-specific tests always available
Date:   Fri, 29 May 2020 13:03:47 -0700
Message-Id: <20200529200347.2464284-5-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200529200347.2464284-1-keescook@chromium.org>
References: <20200529200347.2464284-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I'd like arch-specific tests to XFAIL when on a mismatched architecture
so that we can more easily compare test coverage across all systems.
Lacking kernel configs or CPU features count as a FAIL, not an XFAIL.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/bugs.c               | 34 ++++++++++++++-----------
 drivers/misc/lkdtm/lkdtm.h              |  2 --
 tools/testing/selftests/lkdtm/tests.txt |  1 +
 3 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index e1b43f615549..f3fde0759f2c 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -453,38 +453,42 @@ void lkdtm_DOUBLE_FAULT(void)
 #endif
 }
 
-#ifdef CONFIG_ARM64_PTR_AUTH
+#ifdef CONFIG_ARM64
 static noinline void change_pac_parameters(void)
 {
-	/* Reset the keys of current task */
-	ptrauth_thread_init_kernel(current);
-	ptrauth_thread_switch_kernel(current);
+	if (IS_ENABLED(CONFIG_ARM64_PTR_AUTH)) {
+		/* Reset the keys of current task */
+		ptrauth_thread_init_kernel(current);
+		ptrauth_thread_switch_kernel(current);
+	}
 }
+#endif
 
-#define CORRUPT_PAC_ITERATE	10
 noinline void lkdtm_CORRUPT_PAC(void)
 {
+#ifdef CONFIG_ARM64
+#define CORRUPT_PAC_ITERATE	10
 	int i;
 
+	if (!IS_ENABLED(CONFIG_ARM64_PTR_AUTH))
+		pr_err("FAIL: kernel not built with CONFIG_ARM64_PTR_AUTH\n");
+
 	if (!system_supports_address_auth()) {
-		pr_err("FAIL: arm64 pointer authentication feature not present\n");
+		pr_err("FAIL: CPU lacks pointer authentication feature\n");
 		return;
 	}
 
-	pr_info("Change the PAC parameters to force function return failure\n");
+	pr_info("changing PAC parameters to force function return failure...\n");
 	/*
-	 * Pac is a hash value computed from input keys, return address and
+	 * PAC is a hash value computed from input keys, return address and
 	 * stack pointer. As pac has fewer bits so there is a chance of
 	 * collision, so iterate few times to reduce the collision probability.
 	 */
 	for (i = 0; i < CORRUPT_PAC_ITERATE; i++)
 		change_pac_parameters();
 
-	pr_err("FAIL: %s test failed. Kernel may be unstable from here\n", __func__);
-}
-#else /* !CONFIG_ARM64_PTR_AUTH */
-noinline void lkdtm_CORRUPT_PAC(void)
-{
-	pr_err("FAIL: arm64 pointer authentication config disabled\n");
-}
+	pr_err("FAIL: survived PAC changes! Kernel may be unstable from here\n");
+#else
+	pr_err("XFAIL: this test is arm64-only\n");
 #endif
+}
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index 601a2156a0d4..8878538b2c13 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -31,9 +31,7 @@ void lkdtm_CORRUPT_USER_DS(void);
 void lkdtm_STACK_GUARD_PAGE_LEADING(void);
 void lkdtm_STACK_GUARD_PAGE_TRAILING(void);
 void lkdtm_UNSET_SMEP(void);
-#ifdef CONFIG_X86_32
 void lkdtm_DOUBLE_FAULT(void);
-#endif
 void lkdtm_CORRUPT_PAC(void);
 
 /* lkdtm_heap.c */
diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
index 92ca32143ae5..9d266e79c6a2 100644
--- a/tools/testing/selftests/lkdtm/tests.txt
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -14,6 +14,7 @@ STACK_GUARD_PAGE_LEADING
 STACK_GUARD_PAGE_TRAILING
 UNSET_SMEP CR4 bits went missing
 DOUBLE_FAULT
+CORRUPT_PAC
 UNALIGNED_LOAD_STORE_WRITE
 #OVERWRITE_ALLOCATION Corrupts memory on failure
 #WRITE_AFTER_FREE Corrupts memory on failure
-- 
2.25.1

