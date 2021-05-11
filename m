Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8CB437AA3B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 May 2021 17:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbhEKPIs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 May 2021 11:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbhEKPIr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 May 2021 11:08:47 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F96AC061574;
        Tue, 11 May 2021 08:07:40 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id di13so23292263edb.2;
        Tue, 11 May 2021 08:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZgYR93SVlkZvr4CY4psIFUBV0csM+Pz5TRJ2BUW6nyE=;
        b=kOfx24HFIAVv/9kfO93eFL1VvmJmbedCagku5RyckBUYmLR0pgPSmY7yRzBHNeuvjQ
         x0YZq1vcYIThEkrH/VRgOtjETT/kNC/24+1kG72uleNJ22FeQYfVE9Ze3gsftAtVciSB
         nAHMUJn60apoVeGuHLCfQsFB8jIIbdEQFZN319a7zTkmucr08vXHnHrohtPxhabK3W85
         pRVPDc0Dke45g582uBQI2cxBdIrqSCxc86cH6RqpMQdwRVkkp9YpNo2VMeC7FMPyi4YS
         V3xs44Yoja2PKzzezLwGzwU1v6aq+VMEe/gVxIBa1YJVyhEnO1pfaGa6HQsw7SdrJfpf
         +yaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZgYR93SVlkZvr4CY4psIFUBV0csM+Pz5TRJ2BUW6nyE=;
        b=UIU6WRXIUKRc1X7sTF1tkdcmfPgg+c3sy/tcOC9eFwPa1ZDB64G/viN7/E8X73sCHI
         9amhNi+KhwGcj0kxaGaLPZFpDX73SzuPFrJ6iP7aQQciGaMSb7v0ac2yaz5dX/nzXdNo
         O0jIXBEKZE5XtgERW+oPHkvrpaDxcEfNiE7Kw3cGzX9V5e9naWBLrwW1JAKt56fAd2Fm
         MTyb0b1kg2TF3CfB6wFJVIGhbGfEWOIhzzpwvyGX0mq993kEJijhCdIpmGKsxIJ9qqC8
         FIEW4t7Kyc8nim/BW6YGXmCMbJZoP8+SBkZFUPrGFpoPLp8wng1yLLqlKbla0N9H4vYI
         vL5w==
X-Gm-Message-State: AOAM532pyG39NrNOPuw88infcpIBrMSCbsaAskYy8dVEvHhfJq0f7NjL
        9rx2/gvoRCqszcCJkhsdrLw=
X-Google-Smtp-Source: ABdhPJwHvw9QPdqWyTP/JMTfmGKd2iHBsGvPyidkRWB7T8/N9sQ1cOkYhMqECV2EJU/Tnwghnpm+Pg==
X-Received: by 2002:a05:6402:7d1:: with SMTP id u17mr37103727edy.312.1620745659302;
        Tue, 11 May 2021 08:07:39 -0700 (PDT)
Received: from localhost.localdomain (ispc-static-34.84-47-111.telekom.sk. [84.47.111.34])
        by smtp.gmail.com with ESMTPSA id lr15sm11872709ejb.107.2021.05.11.08.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 08:07:38 -0700 (PDT)
From:   glittao@gmail.com
To:     brendanhiggins@google.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-mm@kvack.org, elver@google.com,
        dlatypov@google.com, Oliver Glitta <glittao@gmail.com>
Subject: [PATCH v5 3/3] slub: remove resiliency_test() function
Date:   Tue, 11 May 2021 17:07:34 +0200
Message-Id: <20210511150734.3492-3-glittao@gmail.com>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a5
In-Reply-To: <20210511150734.3492-1-glittao@gmail.com>
References: <20210511150734.3492-1-glittao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Oliver Glitta <glittao@gmail.com>

Function resiliency_test() is hidden behind #ifdef
SLUB_RESILIENCY_TEST that is not part of Kconfig, so nobody
runs it.

This function is replaced with KUnit test for SLUB added
by the previous patch "selftests: add a KUnit test for SLUB
debugging functionality".

Signed-off-by: Oliver Glitta <glittao@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: David Rientjes <rientjes@google.com>
---
 mm/slub.c | 64 -------------------------------------------------------
 1 file changed, 64 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 985fd6ef033c..88e2c1847698 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -154,9 +154,6 @@ static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
  * - Variable sizing of the per node arrays
  */
 
-/* Enable to test recovery from slab corruption on boot */
-#undef SLUB_RESILIENCY_TEST
-
 /* Enable to log cmpxchg failures */
 #undef SLUB_DEBUG_CMPXCHG
 
@@ -4951,66 +4948,6 @@ static int list_locations(struct kmem_cache *s, char *buf,
 }
 #endif	/* CONFIG_SLUB_DEBUG */
 
-#ifdef SLUB_RESILIENCY_TEST
-static void __init resiliency_test(void)
-{
-	u8 *p;
-	int type = KMALLOC_NORMAL;
-
-	BUILD_BUG_ON(KMALLOC_MIN_SIZE > 16 || KMALLOC_SHIFT_HIGH < 10);
-
-	pr_err("SLUB resiliency testing\n");
-	pr_err("-----------------------\n");
-	pr_err("A. Corruption after allocation\n");
-
-	p = kzalloc(16, GFP_KERNEL);
-	p[16] = 0x12;
-	pr_err("\n1. kmalloc-16: Clobber Redzone/next pointer 0x12->0x%p\n\n",
-	       p + 16);
-
-	validate_slab_cache(kmalloc_caches[type][4]);
-
-	/* Hmmm... The next two are dangerous */
-	p = kzalloc(32, GFP_KERNEL);
-	p[32 + sizeof(void *)] = 0x34;
-	pr_err("\n2. kmalloc-32: Clobber next pointer/next slab 0x34 -> -0x%p\n",
-	       p);
-	pr_err("If allocated object is overwritten then not detectable\n\n");
-
-	validate_slab_cache(kmalloc_caches[type][5]);
-	p = kzalloc(64, GFP_KERNEL);
-	p += 64 + (get_cycles() & 0xff) * sizeof(void *);
-	*p = 0x56;
-	pr_err("\n3. kmalloc-64: corrupting random byte 0x56->0x%p\n",
-	       p);
-	pr_err("If allocated object is overwritten then not detectable\n\n");
-	validate_slab_cache(kmalloc_caches[type][6]);
-
-	pr_err("\nB. Corruption after free\n");
-	p = kzalloc(128, GFP_KERNEL);
-	kfree(p);
-	*p = 0x78;
-	pr_err("1. kmalloc-128: Clobber first word 0x78->0x%p\n\n", p);
-	validate_slab_cache(kmalloc_caches[type][7]);
-
-	p = kzalloc(256, GFP_KERNEL);
-	kfree(p);
-	p[50] = 0x9a;
-	pr_err("\n2. kmalloc-256: Clobber 50th byte 0x9a->0x%p\n\n", p);
-	validate_slab_cache(kmalloc_caches[type][8]);
-
-	p = kzalloc(512, GFP_KERNEL);
-	kfree(p);
-	p[512] = 0xab;
-	pr_err("\n3. kmalloc-512: Clobber redzone 0xab->0x%p\n\n", p);
-	validate_slab_cache(kmalloc_caches[type][9]);
-}
-#else
-#ifdef CONFIG_SYSFS
-static void resiliency_test(void) {};
-#endif
-#endif	/* SLUB_RESILIENCY_TEST */
-
 #ifdef CONFIG_SYSFS
 enum slab_stat_type {
 	SL_ALL,			/* All slabs */
@@ -5859,7 +5796,6 @@ static int __init slab_sysfs_init(void)
 	}
 
 	mutex_unlock(&slab_mutex);
-	resiliency_test();
 	return 0;
 }
 
-- 
2.31.1.272.g89b43f80a5

