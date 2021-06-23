Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98F53B21EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jun 2021 22:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhFWUmN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Jun 2021 16:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhFWUmJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Jun 2021 16:42:09 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B38C061787
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Jun 2021 13:39:51 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id v13so1780126ple.9
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Jun 2021 13:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9CbW/Yfm4YOVx5TLgcAG255DFJHXdYOCCgKp2CMgl9c=;
        b=dunBoi+rvP55ibjO4aMmp3PEcqi6plGzD3RKUIy2JY6icM4NLoCwMdjkH3bSpJGEZL
         rXBy87J/BsJRIb8BKC6N9nIa5pdSEtVsj9Jt2Eu2c7ibgdf7VysPOSGq2GGofBeJdmkV
         iHok836cmLjkdFjQnvhcnR9i+SLiV5yPdY7UI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9CbW/Yfm4YOVx5TLgcAG255DFJHXdYOCCgKp2CMgl9c=;
        b=gLj3SvH/Sz/1sOafc0qdqv5FdBp1FxCxPQCtj9U6qyor4i32Q6+238QZjG91PEae+F
         le8x1fZIMaBEkuBvcpNZmNV/DveXnOXQY8iieUWSZjruevUWY/cpNNY0jlDSsmiRxA5Q
         bomunswmE/PQwNGwtAE50eITrRqeI2MyaRwywYw5ZAXXIfDIkcSMRMb1miqmM8zd5BDK
         Xe9XofrkSff547eCCX5h0nVdGHF1HfQGjR7kgpzQwtLzHb4mxbCWtl2QinFtT4Gjs0kp
         hO2JUNSJgk34FJ+4meFjGjDZiNp374CsU8/eJNpBwfFjtjbQujXXpIRX/4z3Nn16vSCi
         Ub1A==
X-Gm-Message-State: AOAM530ddXuMOySH3kRMa3vVXFNB2dtEtTPaX3JBmKumb2prq70yzOcG
        gTmGWwKXnivLoB0aDdF0Sg0O4KruGlBlRA==
X-Google-Smtp-Source: ABdhPJwt4bDW3fWxEAD6L43dOhtIQeD8GcbmXS575cFZ1n3sB6Aw0rEr0X01RYvfSmd5imUhk+B7Xw==
X-Received: by 2002:a17:90a:4410:: with SMTP id s16mr1427889pjg.25.1624480791179;
        Wed, 23 Jun 2021 13:39:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u1sm630574pfu.160.2021.06.23.13.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 13:39:48 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        kernelci@groups.io, linux-kselftest@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 9/9] lkdtm/heap: Add init_on_alloc tests
Date:   Wed, 23 Jun 2021 13:39:36 -0700
Message-Id: <20210623203936.3151093-10-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210623203936.3151093-1-keescook@chromium.org>
References: <20210623203936.3151093-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4448; h=from:subject; bh=kzB2kajsXBcnoqdrRcymGnm8fdce7wFUEweva8HvKLM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBg05wH5VR4lDW7Qn91KFyY0Hf6dSvabN6SXZM7fu6f PsdQeJCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYNOcBwAKCRCJcvTf3G3AJrtiEA CoREcu/vUQ2ed0GVO1Y3dypJDMih0UI4I5eduqeIitcrzItlcyUt0VyMnXcja+eI5KhvKJre/DEV6N JAmsX7/8fMHcIlJvDAVMxb5mzgFTyAQcwIOMVW9W+3r+UUHZS6kGdX0In5GjM0oGTDphSkDw7LVQbY wxTSCuoFvaX6JGRwtwTKCmf0yOxkYuSUmjJHP3vbzw8rycqrSTvpffy2vHVdG5lfncP2QvUbJhkroR YqXt+Y08bdkpdIS99ztaIPadsdcCWvdRG1KoGTSmnFHwfm11MhRoZPD2AzUKCn99c2adU25UgJoQQu IfWiqZ/0JUuO4YJACqa63gUv3lttKXM6Y0RLOyzPSZrdfG6fMJRbyK2BDNNBneDaeJOogvG+FWcLkT yX9ISCyG4xyhfgsPYQ37Dzftv2T9rWsCzn6IQbFefHbwjFbUTlG27if6rc8uiaQbPCh7g50faN26Kq OSqEkA5KwA251CpX+KiNd2JlxtXfTFtnSQKbVawsGGExVvDlLeuE+uZU9gps0EYtL4Rx8vGAiCMyOM 7kaI1WNW2RzpRc+2bK5fHt8rVn0HI3LFcHoX2pTX1ee//VbjPmF4EWsZsI7fVrgoTto7tM+Z+mOTU4 aF8WROfsOAjSNjtvkwi9P3oHmKdtILwXEN+5HFG/zWLAj0/J+i31bg6ZSiig==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add SLAB and page allocator tests for init_on_alloc. Testing for
init_on_free was already happening via the poisoning tests.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/core.c               |  2 +
 drivers/misc/lkdtm/heap.c               | 65 +++++++++++++++++++++++++
 drivers/misc/lkdtm/lkdtm.h              |  2 +
 tools/testing/selftests/lkdtm/config    |  1 +
 tools/testing/selftests/lkdtm/tests.txt |  2 +
 5 files changed, 72 insertions(+)

diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index c185ae4719c3..9dda87c6b54a 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -127,6 +127,8 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(READ_AFTER_FREE),
 	CRASHTYPE(WRITE_BUDDY_AFTER_FREE),
 	CRASHTYPE(READ_BUDDY_AFTER_FREE),
+	CRASHTYPE(SLAB_INIT_ON_ALLOC),
+	CRASHTYPE(BUDDY_INIT_ON_ALLOC),
 	CRASHTYPE(SLAB_FREE_DOUBLE),
 	CRASHTYPE(SLAB_FREE_CROSS),
 	CRASHTYPE(SLAB_FREE_PAGE),
diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
index a3bb0577ed8b..3d9aae5821a0 100644
--- a/drivers/misc/lkdtm/heap.c
+++ b/drivers/misc/lkdtm/heap.c
@@ -174,6 +174,71 @@ void lkdtm_READ_BUDDY_AFTER_FREE(void)
 	kfree(val);
 }
 
+void lkdtm_SLAB_INIT_ON_ALLOC(void)
+{
+	u8 *first;
+	u8 *val;
+
+	first = kmalloc(512, GFP_KERNEL);
+	if (!first) {
+		pr_info("Unable to allocate 512 bytes the first time.\n");
+		return;
+	}
+
+	memset(first, 0xAB, 512);
+	kfree(first);
+
+	val = kmalloc(512, GFP_KERNEL);
+	if (!val) {
+		pr_info("Unable to allocate 512 bytes the second time.\n");
+		return;
+	}
+	if (val != first) {
+		pr_warn("Reallocation missed clobbered memory.\n");
+	}
+
+	if (memchr(val, 0xAB, 512) == NULL) {
+		pr_info("Memory appears initialized (%x, no earlier values)\n", *val);
+	} else {
+		pr_err("FAIL: Slab was not initialized\n");
+		pr_expected_config_param(CONFIG_INIT_ON_ALLOC_DEFAULT_ON, "init_on_alloc");
+	}
+	kfree(val);
+}
+
+void lkdtm_BUDDY_INIT_ON_ALLOC(void)
+{
+	u8 *first;
+	u8 *val;
+
+	first = (u8 *)__get_free_page(GFP_KERNEL);
+	if (!first) {
+		pr_info("Unable to allocate first free page\n");
+		return;
+	}
+
+	memset(first, 0xAB, PAGE_SIZE);
+	free_page((unsigned long)first);
+
+	val = (u8 *)__get_free_page(GFP_KERNEL);
+	if (!val) {
+		pr_info("Unable to allocate second free page\n");
+		return;
+	}
+
+	if (val != first) {
+		pr_warn("Reallocation missed clobbered memory.\n");
+	}
+
+	if (memchr(val, 0xAB, PAGE_SIZE) == NULL) {
+		pr_info("Memory appears initialized (%x, no earlier values)\n", *val);
+	} else {
+		pr_err("FAIL: Slab was not initialized\n");
+		pr_expected_config_param(CONFIG_INIT_ON_ALLOC_DEFAULT_ON, "init_on_alloc");
+	}
+	free_page((unsigned long)val);
+}
+
 void lkdtm_SLAB_FREE_DOUBLE(void)
 {
 	int *val;
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index e491bc571808..6a30b60519f3 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -86,6 +86,8 @@ void lkdtm_WRITE_AFTER_FREE(void);
 void lkdtm_READ_AFTER_FREE(void);
 void lkdtm_WRITE_BUDDY_AFTER_FREE(void);
 void lkdtm_READ_BUDDY_AFTER_FREE(void);
+void lkdtm_SLAB_INIT_ON_ALLOC(void);
+void lkdtm_BUDDY_INIT_ON_ALLOC(void);
 void lkdtm_SLAB_FREE_DOUBLE(void);
 void lkdtm_SLAB_FREE_CROSS(void);
 void lkdtm_SLAB_FREE_PAGE(void);
diff --git a/tools/testing/selftests/lkdtm/config b/tools/testing/selftests/lkdtm/config
index 849799bcfa95..013446e87f1f 100644
--- a/tools/testing/selftests/lkdtm/config
+++ b/tools/testing/selftests/lkdtm/config
@@ -5,3 +5,4 @@ CONFIG_FORTIFY_SOURCE=y
 CONFIG_HARDENED_USERCOPY=y
 # CONFIG_HARDENED_USERCOPY_FALLBACK is not set
 CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
+CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
index 30080cc15623..846cfd508d3c 100644
--- a/tools/testing/selftests/lkdtm/tests.txt
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -21,6 +21,8 @@ VMALLOC_LINEAR_OVERFLOW
 READ_AFTER_FREE call trace:|Memory correctly poisoned
 #WRITE_BUDDY_AFTER_FREE Corrupts memory on failure
 READ_BUDDY_AFTER_FREE call trace:|Memory correctly poisoned
+SLAB_INIT_ON_ALLOC Memory appears initialized
+BUDDY_INIT_ON_ALLOC Memory appears initialized
 SLAB_FREE_DOUBLE
 SLAB_FREE_CROSS
 SLAB_FREE_PAGE
-- 
2.30.2

