Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCBD520A6DC
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jun 2020 22:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407192AbgFYUhT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 Jun 2020 16:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407172AbgFYUhK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 Jun 2020 16:37:10 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87870C08C5DD
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jun 2020 13:37:10 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d66so3583318pfd.6
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jun 2020 13:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SR6ATnMcWEmdUOJ6DbZTTEtf2IDw/YJ2aizPOaBcct0=;
        b=Z+l6GdwkOd72fTNtHvSsdUn7TKOnxeeN7JeN5GTZo8cfHL+0EpGVAWRA45M5x8Hay9
         Lnc4QZpwTo9P293mTeHnToaY5IkuFtejak/F2BeOdZtxIjYSRQA4mtnSRz2SIXFr5yFi
         52pcgmThTn6s0zv2SlhZdkY8mLePuLr8ATAGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SR6ATnMcWEmdUOJ6DbZTTEtf2IDw/YJ2aizPOaBcct0=;
        b=N3OLcJljcKmcK2bI+nuBCYjh8iOez9w9A03OvXPD45VRPuil3CM36EX1lTMcJyo/8L
         Eo4GfmP0VoXTEbzVzJOXkZL00wmTurZva7iTRl0SwLMJiAV1SlfUsYeX7sxCbgyU8B8V
         eVAyaI6WZDWt8yHw3cK8FLsoWoYIXcex5rCbo3AKbYdHamLpUl811meRuXMpiWy7G4M2
         T094N4P8HHpLuZn5RzpY/0ysFowG9XY05201g0d0HiHMO2yYT8GwS/D1ZPQKZLgjaefO
         bmxNe7Zb+bfljIQywWRIwemDA03TyVffERYoQyTbX/lR1oWPpyr2nc7hzmp63JoYKllY
         +eUA==
X-Gm-Message-State: AOAM530dwGmoC6q1mrckFdnkj5diLE/g/DCIvA/uVcPBRfM2RaYXA+xD
        /ZvSXJ4+MP6HKaG3ZV8TJ9i31w==
X-Google-Smtp-Source: ABdhPJytLKN5EnbcLgkC49A0EERl56GpicC+cP7LwdDwUZOYrAuRO1Lb7t+7poX/m1wym1e0HyEqFA==
X-Received: by 2002:a62:a218:: with SMTP id m24mr2510238pff.156.1593117430052;
        Thu, 25 Jun 2020 13:37:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q6sm23903896pff.163.2020.06.25.13.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 13:37:07 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH drivers/misc v2 1/4] lkdtm: Avoid more compiler optimizations for bad writes
Date:   Thu, 25 Jun 2020 13:37:01 -0700
Message-Id: <20200625203704.317097-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625203704.317097-1-keescook@chromium.org>
References: <20200625203704.317097-1-keescook@chromium.org>
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
Fixes: 9ae113ce5faf ("lkdtm: add tests for additional page permissions")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/bugs.c     | 11 +++++------
 drivers/misc/lkdtm/perms.c    | 22 +++++++++++++++-------
 drivers/misc/lkdtm/usercopy.c |  7 +++++--
 3 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 736675f0a246..08c70281c380 100644
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

