Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D50A1E886B
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 May 2020 22:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbgE2UD6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 May 2020 16:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbgE2UD5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 May 2020 16:03:57 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF713C08C5C9
        for <linux-kselftest@vger.kernel.org>; Fri, 29 May 2020 13:03:56 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f3so359911pfd.11
        for <linux-kselftest@vger.kernel.org>; Fri, 29 May 2020 13:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vXTP+Se3yIkI89g0fJMXKoRVrwz9jV/dqS5u7kTh71Q=;
        b=VPgK1V3rIm4BlNL5hqOzmeohFPABby5m3eGxopvMpWetPiBdEcGHarpgNR+dnCw0Ny
         kSe2vNhV0z6xnNbk2UwU0B9SwLQv77vtCZxpc2+nJDdA3Q049p8qQf7yAjs+AqX+VD5D
         WrIDkfmJbTtLGI2e6dzvxtepyKV05RrfK3QJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vXTP+Se3yIkI89g0fJMXKoRVrwz9jV/dqS5u7kTh71Q=;
        b=HQHSsn5Y+cirzvrn4T0x3QUu4/vKPngskfSP2hHaTyU7mGo9x9sStGA0WIRS8MXNUt
         jiZVrwxd2WBepNvilGLhfs7zN1XOFx79Ktm8E0jExLoz8jI54kCILxrd3NRBMq7v32Zz
         sN3lcKLaynMZATdU8Y8CVo8KdpHhwquaMldb1498jzvo4+xnz3jdOdO8YlMVRiOUAr0H
         OMmjJUAieHDejvSApVO1WDnNTrqGyMKI7B676vIAgNnFVlBT5o9h5FpIuEDKd2wps/NQ
         +mLyr6eQgf15wPYjPVR573pMsjWXUU1g6aHb2k9XRX5Qpr7BtEI1EHlUKh/KVH6fXqUl
         rzhw==
X-Gm-Message-State: AOAM5315cFOJ2mbDljbk0H1+uWyD8M8Dupy/bJgLWv6AuEZmfrzI24//
        mzihX00GTToYZ/x4ggB3WPhcyA==
X-Google-Smtp-Source: ABdhPJyJkBv8iIf1rq426lHNwLKpFw8q0Jijlp/SCR9ZTcH0YZavXIhM9djXjjmTqKlfIGl9B4LNdA==
X-Received: by 2002:aa7:9096:: with SMTP id i22mr10330016pfa.250.1590782636345;
        Fri, 29 May 2020 13:03:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p19sm4775093pff.116.2020.05.29.13.03.54
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
Subject: [PATCH 1/4] lkdtm: Avoid more compiler optimizations for bad writes
Date:   Fri, 29 May 2020 13:03:44 -0700
Message-Id: <20200529200347.2464284-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200529200347.2464284-1-keescook@chromium.org>
References: <20200529200347.2464284-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It seems at least Clang is able to throw away writes it knows are
destined for read-only memory, which makes things like the WRITE_RO test
fail, as the write gets elided. Instead, force the variable to be
volatile, and make similar changes through-out other tests in an effort
to avoid needing to repeat fixing these kinds of problems. Also includes
pr_err() calls in failure paths so that kernel logs are more clear in
the failure case.

Reported-by: Prasad Sodagudi <psodagud@codeaurora.org>
Suggested-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/bugs.c     | 11 +++++------
 drivers/misc/lkdtm/perms.c    | 22 +++++++++++++++-------
 drivers/misc/lkdtm/usercopy.c |  7 +++++--
 3 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 886459e0ddd9..e1b43f615549 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -118,9 +118,8 @@ noinline void lkdtm_CORRUPT_STACK(void)
 	/* Use default char array length that triggers stack protection. */
 	char data[8] __aligned(sizeof(void *));
 
-	__lkdtm_CORRUPT_STACK(&data);
-
-	pr_info("Corrupted stack containing char array ...\n");
+	pr_info("Corrupting stack containing char array ...\n");
+	__lkdtm_CORRUPT_STACK((void *)&data);
 }
 
 /* Same as above but will only get a canary with -fstack-protector-strong */
@@ -131,9 +130,8 @@ noinline void lkdtm_CORRUPT_STACK_STRONG(void)
 		unsigned long *ptr;
 	} data __aligned(sizeof(void *));
 
-	__lkdtm_CORRUPT_STACK(&data);
-
-	pr_info("Corrupted stack containing union ...\n");
+	pr_info("Corrupting stack containing union ...\n");
+	__lkdtm_CORRUPT_STACK((void *)&data);
 }
 
 void lkdtm_UNALIGNED_LOAD_STORE_WRITE(void)
@@ -248,6 +246,7 @@ void lkdtm_ARRAY_BOUNDS(void)
 
 	kfree(not_checked);
 	kfree(checked);
+	pr_err("FAIL: survived array bounds overflow!\n");
 }
 
 void lkdtm_CORRUPT_LIST_ADD(void)
diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index 62f76d506f04..2dede2ef658f 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -57,6 +57,7 @@ static noinline void execute_location(void *dst, bool write)
 	}
 	pr_info("attempting bad execution at %px\n", func);
 	func();
+	pr_err("FAIL: func returned\n");
 }
 
 static void execute_user_location(void *dst)
@@ -75,20 +76,22 @@ static void execute_user_location(void *dst)
 		return;
 	pr_info("attempting bad execution at %px\n", func);
 	func();
+	pr_err("FAIL: func returned\n");
 }
 
 void lkdtm_WRITE_RO(void)
 {
-	/* Explicitly cast away "const" for the test. */
-	unsigned long *ptr = (unsigned long *)&rodata;
+	/* Explicitly cast away "const" for the test and make volatile. */
+	volatile unsigned long *ptr = (unsigned long *)&rodata;
 
 	pr_info("attempting bad rodata write at %px\n", ptr);
 	*ptr ^= 0xabcd1234;
+	pr_err("FAIL: survived bad write\n");
 }
 
 void lkdtm_WRITE_RO_AFTER_INIT(void)
 {
-	unsigned long *ptr = &ro_after_init;
+	volatile unsigned long *ptr = &ro_after_init;
 
 	/*
 	 * Verify we were written to during init. Since an Oops
@@ -102,19 +105,21 @@ void lkdtm_WRITE_RO_AFTER_INIT(void)
 
 	pr_info("attempting bad ro_after_init write at %px\n", ptr);
 	*ptr ^= 0xabcd1234;
+	pr_err("FAIL: survived bad write\n");
 }
 
 void lkdtm_WRITE_KERN(void)
 {
 	size_t size;
-	unsigned char *ptr;
+	volatile unsigned char *ptr;
 
 	size = (unsigned long)do_overwritten - (unsigned long)do_nothing;
 	ptr = (unsigned char *)do_overwritten;
 
 	pr_info("attempting bad %zu byte write at %px\n", size, ptr);
-	memcpy(ptr, (unsigned char *)do_nothing, size);
+	memcpy((void *)ptr, (unsigned char *)do_nothing, size);
 	flush_icache_range((unsigned long)ptr, (unsigned long)(ptr + size));
+	pr_err("FAIL: survived bad write\n");
 
 	do_overwritten();
 }
@@ -193,9 +198,11 @@ void lkdtm_ACCESS_USERSPACE(void)
 	pr_info("attempting bad read at %px\n", ptr);
 	tmp = *ptr;
 	tmp += 0xc0dec0de;
+	pr_err("FAIL: survived bad read\n");
 
 	pr_info("attempting bad write at %px\n", ptr);
 	*ptr = tmp;
+	pr_err("FAIL: survived bad write\n");
 
 	vm_munmap(user_addr, PAGE_SIZE);
 }
@@ -203,19 +210,20 @@ void lkdtm_ACCESS_USERSPACE(void)
 void lkdtm_ACCESS_NULL(void)
 {
 	unsigned long tmp;
-	unsigned long *ptr = (unsigned long *)NULL;
+	volatile unsigned long *ptr = (unsigned long *)NULL;
 
 	pr_info("attempting bad read at %px\n", ptr);
 	tmp = *ptr;
 	tmp += 0xc0dec0de;
+	pr_err("FAIL: survived bad read\n");
 
 	pr_info("attempting bad write at %px\n", ptr);
 	*ptr = tmp;
+	pr_err("FAIL: survived bad write\n");
 }
 
 void __init lkdtm_perms_init(void)
 {
 	/* Make sure we can write to __ro_after_init values during __init */
 	ro_after_init |= 0xAA;
-
 }
diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
index e172719dd86d..b833367a45d0 100644
--- a/drivers/misc/lkdtm/usercopy.c
+++ b/drivers/misc/lkdtm/usercopy.c
@@ -304,19 +304,22 @@ void lkdtm_USERCOPY_KERNEL(void)
 		return;
 	}
 
-	pr_info("attempting good copy_to_user from kernel rodata\n");
+	pr_info("attempting good copy_to_user from kernel rodata: %px\n",
+		test_text);
 	if (copy_to_user((void __user *)user_addr, test_text,
 			 unconst + sizeof(test_text))) {
 		pr_warn("copy_to_user failed unexpectedly?!\n");
 		goto free_user;
 	}
 
-	pr_info("attempting bad copy_to_user from kernel text\n");
+	pr_info("attempting bad copy_to_user from kernel text: %px\n",
+		vm_mmap);
 	if (copy_to_user((void __user *)user_addr, vm_mmap,
 			 unconst + PAGE_SIZE)) {
 		pr_warn("copy_to_user failed, but lacked Oops\n");
 		goto free_user;
 	}
+	pr_err("FAIL: survived bad copy_to_user()\n");
 
 free_user:
 	vm_munmap(user_addr, PAGE_SIZE);
-- 
2.25.1

