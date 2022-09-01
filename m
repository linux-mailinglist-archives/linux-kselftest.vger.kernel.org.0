Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9BA5A8EF1
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Sep 2022 08:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbiIAG7h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 02:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbiIAG7f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 02:59:35 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8234A120334
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Aug 2022 23:59:21 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c66so6389899pfc.10
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Aug 2022 23:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=xYFfyHD1RFDP4AJmjNoTHOrZhyKAtKo+QsQqKyJN3oU=;
        b=XSmAs/VdvPt1L89oP6IwazVnWBIN+a1h4Ns4rwKMHcOeDh0ackRWr26X4tAED7gx2l
         5blIfVFN0S2xCzOwp0BbVQ19nULcqqnLE2vuPNKp9TvIr0Grj+kPytOA3G+CUZlgjt7E
         4he92MoNhnTpwqq64UtbpgAy6BcuHZEoFI8xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=xYFfyHD1RFDP4AJmjNoTHOrZhyKAtKo+QsQqKyJN3oU=;
        b=3ReRXFjTCukMDheG3Dl0v7XIVCFSKRImSU5xJbOVOIY9u/Bak7UGPR5HdfQh9jRQy3
         TTqAHyQDng3KWtjwpojrVW164RMw9t1se97lL/5M66MuNGCvHpGV5KyVGd0+TKUSs+5R
         X9KxuxT/1zg1jgTe7PHUaipTuoeHL2sCpIFvMKzNZg1u5mKv55IRVpFI8QVFHaoZA/88
         LwEItkbsKpHzSy4XmCoaEHBscUqwFFr0Pcr0hh/lYUlPbRzd3prwLA1qnQcAEhAouF3z
         S5MiqmuRcYvTxJ0Ly3r4hLmBpXUKa6Xj1AsO+99YPtsB7VgWI2VbWI/T42XSNe1wHIC8
         trPA==
X-Gm-Message-State: ACgBeo0J9fvmyacxIj+PCwHa1LCvqWJV+ZyMcA6/5KiXg+3QPzy7EHRM
        YvcflsSTSWbCVuod3lcrerk2cQ==
X-Google-Smtp-Source: AA6agR4LEiVZMQQRnQvEdW2n9bb9YQvtrCipJM9dDVtZ9Rv/9ayJTt9S25Wf5gapVvxroYsJgUr4hQ==
X-Received: by 2002:a63:6c42:0:b0:3fe:465:7a71 with SMTP id h63-20020a636c42000000b003fe04657a71mr24973379pgc.101.1662015559068;
        Wed, 31 Aug 2022 23:59:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902dacd00b00174d4fabe76sm4817868plx.214.2022.08.31.23.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 23:59:17 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 2/2] lkdtm: Update tests for memcpy() run-time warnings
Date:   Wed, 31 Aug 2022 23:59:14 -0700
Message-Id: <20220901065914.1417829-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220901065914.1417829-1-keescook@chromium.org>
References: <20220901065914.1417829-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6007; h=from:subject; bh=IUZVdxvxMIlH+Jar34T6ukh1akodoplD+BZw40+sie0=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjEFhCriO8rPE7BLGJP/5HmYqPff+d086juOOW7NOq 9FW0xZWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYxBYQgAKCRCJcvTf3G3AJg/jD/ 9XzCIlv1K4/cB0L3iCzihH3aB1mjNOPS4P5dNlJ5HW5HEYKycGrlMM0sxqwmOE83L6WDSMkv1uXAE3 7ih8fHyySD+v/Z70/4yAx+1FBdXxZPbn5qadFE+68n7f9gYYh9iBCMy32nyuqiSZT+UomB4vVHHEVi +DCoYfNSuoQL4jpswA/IOQuNHYnFTK26pciQ48Sj3SHepddAHK1yyLGCSbsS14aQ79a2YwU4B+ovGf Mw/6NJw7ApAefccLF493ET8/RBeJHoD06Bx9/Uf1A2TdLmgD6XorkY6OpUYv+pFp/qOtARKfFBoyR7 2rIkJjnWops7tgvb7DK2X7pZB5YmosIzpQYPmkMnNDif/4f4RtBKXMLNOSPWUn4Y0e0W7eK+zNbm3s GXbaM0SKIwRiexVGztSWqe8F3dnXEhqszygD7ie545+mDVSU30biu1c9flplndlFkE3FXRTM/ltdwc S6WRLffAaMVgR9NtIW5kyvhBCtCw/vv/acKxiUGq5R0m5i/oUWk873waMe3lqwFNF/nqe5EwPs6yRk g+ibZPHsXWFWcCQlqKOvXPZs3x5ZX4s4FIx8uJQlLpI1NxbOZIAFCjWDwCwnUGD+oOQpogBG5e5YMP ca5++Z9nJR8ryxF+Yull2mLouOBXEWkMYbb5jZiCTevwwQa1oqLDqYqlZ4Lw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Clarify the LKDTM FORTIFY tests, and add tests for the mem*() family of
functions, now that run-time checking is distinct.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/fortify.c            | 96 +++++++++++++++++++++----
 tools/testing/selftests/lkdtm/tests.txt |  8 ++-
 2 files changed, 88 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/lkdtm/fortify.c b/drivers/misc/lkdtm/fortify.c
index 080293fa3c52..015927665678 100644
--- a/drivers/misc/lkdtm/fortify.c
+++ b/drivers/misc/lkdtm/fortify.c
@@ -10,28 +10,31 @@
 
 static volatile int fortify_scratch_space;
 
-static void lkdtm_FORTIFIED_OBJECT(void)
+static void lkdtm_FORTIFY_STR_OBJECT(void)
 {
 	struct target {
 		char a[10];
-	} target[2] = {};
+		int foo;
+	} target[3] = {};
 	/*
 	 * Using volatile prevents the compiler from determining the value of
 	 * 'size' at compile time. Without that, we would get a compile error
 	 * rather than a runtime error.
 	 */
-	volatile int size = 11;
+	volatile int size = 20;
+
+	pr_info("trying to strcmp() past the end of a struct\n");
 
-	pr_info("trying to read past the end of a struct\n");
+	strncpy(target[0].a, target[1].a, size);
 
 	/* Store result to global to prevent the code from being eliminated */
-	fortify_scratch_space = memcmp(&target[0], &target[1], size);
+	fortify_scratch_space = target[0].a[3];
 
-	pr_err("FAIL: fortify did not block an object overread!\n");
+	pr_err("FAIL: fortify did not block a strncpy() object write overflow!\n");
 	pr_expected_config(CONFIG_FORTIFY_SOURCE);
 }
 
-static void lkdtm_FORTIFIED_SUBOBJECT(void)
+static void lkdtm_FORTIFY_STR_MEMBER(void)
 {
 	struct target {
 		char a[10];
@@ -44,7 +47,7 @@ static void lkdtm_FORTIFIED_SUBOBJECT(void)
 	strscpy(src, "over ten bytes", size);
 	size = strlen(src) + 1;
 
-	pr_info("trying to strncpy past the end of a member of a struct\n");
+	pr_info("trying to strncpy() past the end of a struct member...\n");
 
 	/*
 	 * strncpy(target.a, src, 20); will hit a compile error because the
@@ -56,7 +59,72 @@ static void lkdtm_FORTIFIED_SUBOBJECT(void)
 	/* Store result to global to prevent the code from being eliminated */
 	fortify_scratch_space = target.a[3];
 
-	pr_err("FAIL: fortify did not block an sub-object overrun!\n");
+	pr_err("FAIL: fortify did not block a strncpy() struct member write overflow!\n");
+	pr_expected_config(CONFIG_FORTIFY_SOURCE);
+
+	kfree(src);
+}
+
+static void lkdtm_FORTIFY_MEM_OBJECT(void)
+{
+	int before[10];
+	struct target {
+		char a[10];
+		int foo;
+	} target = {};
+	int after[10];
+	/*
+	 * Using volatile prevents the compiler from determining the value of
+	 * 'size' at compile time. Without that, we would get a compile error
+	 * rather than a runtime error.
+	 */
+	volatile int size = 20;
+
+	memset(before, 0, sizeof(before));
+	memset(after, 0, sizeof(after));
+	fortify_scratch_space = before[5];
+	fortify_scratch_space = after[5];
+
+	pr_info("trying to memcpy() past the end of a struct\n");
+
+	pr_info("0: %zu\n", __builtin_object_size(&target, 0));
+	pr_info("1: %zu\n", __builtin_object_size(&target, 1));
+	pr_info("s: %d\n", size);
+	memcpy(&target, &before, size);
+
+	/* Store result to global to prevent the code from being eliminated */
+	fortify_scratch_space = target.a[3];
+
+	pr_err("FAIL: fortify did not block a memcpy() object write overflow!\n");
+	pr_expected_config(CONFIG_FORTIFY_SOURCE);
+}
+
+static void lkdtm_FORTIFY_MEM_MEMBER(void)
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
+	pr_info("trying to memcpy() past the end of a struct member...\n");
+
+	/*
+	 * strncpy(target.a, src, 20); will hit a compile error because the
+	 * compiler knows at build time that target.a < 20 bytes. Use a
+	 * volatile to force a runtime error.
+	 */
+	memcpy(target.a, src, size);
+
+	/* Store result to global to prevent the code from being eliminated */
+	fortify_scratch_space = target.a[3];
+
+	pr_err("FAIL: fortify did not block a memcpy() struct member write overflow!\n");
 	pr_expected_config(CONFIG_FORTIFY_SOURCE);
 
 	kfree(src);
@@ -67,7 +135,7 @@ static void lkdtm_FORTIFIED_SUBOBJECT(void)
  * strscpy and generate a panic because there is a write overflow (i.e. src
  * length is greater than dst length).
  */
-static void lkdtm_FORTIFIED_STRSCPY(void)
+static void lkdtm_FORTIFY_STRSCPY(void)
 {
 	char *src;
 	char dst[5];
@@ -136,9 +204,11 @@ static void lkdtm_FORTIFIED_STRSCPY(void)
 }
 
 static struct crashtype crashtypes[] = {
-	CRASHTYPE(FORTIFIED_OBJECT),
-	CRASHTYPE(FORTIFIED_SUBOBJECT),
-	CRASHTYPE(FORTIFIED_STRSCPY),
+	CRASHTYPE(FORTIFY_STR_OBJECT),
+	CRASHTYPE(FORTIFY_STR_MEMBER),
+	CRASHTYPE(FORTIFY_MEM_OBJECT),
+	CRASHTYPE(FORTIFY_MEM_MEMBER),
+	CRASHTYPE(FORTIFY_STRSCPY),
 };
 
 struct crashtype_category fortify_crashtypes = {
diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
index 65e53eb0840b..607b8d7e3ea3 100644
--- a/tools/testing/selftests/lkdtm/tests.txt
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -75,7 +75,9 @@ USERCOPY_KERNEL
 STACKLEAK_ERASING OK: the rest of the thread stack is properly erased
 CFI_FORWARD_PROTO
 CFI_BACKWARD call trace:|ok: control flow unchanged
-FORTIFIED_STRSCPY
-FORTIFIED_OBJECT
-FORTIFIED_SUBOBJECT
+FORTIFY_STRSCPY detected buffer overflow
+FORTIFY_STR_OBJECT detected buffer overflow
+FORTIFY_STR_MEMBER detected buffer overflow
+FORTIFY_MEM_OBJECT detected buffer overflow
+FORTIFY_MEM_MEMBER detected field-spanning write
 PPC_SLB_MULTIHIT Recovered
-- 
2.34.1

