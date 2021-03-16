Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4304333D413
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Mar 2021 13:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhCPMlp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Mar 2021 08:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbhCPMlX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Mar 2021 08:41:23 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795A4C061756;
        Tue, 16 Mar 2021 05:41:22 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l11so10377269wrp.7;
        Tue, 16 Mar 2021 05:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FKA9LCaSzGqlDY+ma6Pbkwu97ws+JFck82rXUU4n3VI=;
        b=be6fZVZuK3yvPl4i1ZZ6jb7PBWRPcpFRTuwUepjnwS1EeHmOx/BmUerWkqsPFvZYlU
         B159Nay12NqnXO0CPRkBlV0F5goAkxUVKDEa7zAevv8mTL3qYPV+2wc81zQplR7OFcj9
         cxvWf71d6eHAaAYuzWhU3VPxJOz+tZLKpVk2nxMd9csDhsP6GAPkQRB/rG9i388B8FJn
         iJQxeRduiFHbzwaknNZPkH72PxI86u1zklNDInIEotyTnTU5BteNllaGMNw4uD5pJKUP
         kKwB64/sJV3PRqDCLTdSVZr9xOGTBr4yzkT3V/QQ2BWAljj2JQvXRypJzlwlsFsHexzL
         6rtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FKA9LCaSzGqlDY+ma6Pbkwu97ws+JFck82rXUU4n3VI=;
        b=Wo7LirqBlacI6Sn9g8dUeAs1uUpnebvfCVdIW+5x2qeSOgczASyMarklNl/uL7USve
         YH/6ZudzhTsc/AbrV/LKVJ+bh/ie9qHHzGAUwy6hW9t/FCsKGY6TKTz+zes/qCSil40H
         2O4imwCNc/DAYMA8cguMUu7DTNmY86k0ffZkcar1Enjjfos7Cn6IaOSAfe6g1y3v/6fV
         Hvi5wI4p6MblQWvnX73DGQMW5daPWQqmqshzApkFTC/3TUnjGsD/uAeliMUBJ037WQUn
         fmg/3c2xoyiDL+jr/z9Efq73Pyo5qZ8Msr20WaAjZlcu9yRTL45Gw661rH420UBFgjbA
         8ZIQ==
X-Gm-Message-State: AOAM5313SmuYBt5Xt8u2i9bqopiSMqmzn32T+ExIf/9X5kyz0Bk/epk/
        TDI89j3iuDEPg6kSbvXvzA0=
X-Google-Smtp-Source: ABdhPJxXBUubcBSE2HzU+/3aoiwzGywJKL9g6xjyBDBdp+2XYBerL0EbLrX8hHvqMOgpV59FNK3TBg==
X-Received: by 2002:a05:6000:1281:: with SMTP id f1mr4742194wrx.243.1615898481251;
        Tue, 16 Mar 2021 05:41:21 -0700 (PDT)
Received: from oliver-Z170M-D3H.cuni.cz ([2001:718:1e03:5128:e847:73bd:bb49:39d7])
        by smtp.gmail.com with ESMTPSA id o2sm3042159wme.16.2021.03.16.05.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 05:41:20 -0700 (PDT)
From:   glittao@gmail.com
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Oliver Glitta <glittao@gmail.com>
Subject: [PATCH 2/2] slub: remove resiliency_test() function
Date:   Tue, 16 Mar 2021 13:41:18 +0100
Message-Id: <20210316124118.6874-2-glittao@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210316124118.6874-1-glittao@gmail.com>
References: <20210316124118.6874-1-glittao@gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Oliver Glitta <glittao@gmail.com>

Function resiliency_test() is hidden behind #ifdef
SLUB_RESILIENCY_TEST that is not part of Kconfig, so nobody
runs it.

This function is replaced with kselftest for SLUB added
by the previous patch "selftests: add a kselftest for SLUB
debugging functionality".

Signed-off-by: Oliver Glitta <glittao@gmail.com>
---
 mm/slub.c | 64 -------------------------------------------------------
 1 file changed, 64 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index c00e2b263e03..bfeb9ecd56b4 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -153,9 +153,6 @@ static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
  * - Variable sizing of the per node arrays
  */
 
-/* Enable to test recovery from slab corruption on boot */
-#undef SLUB_RESILIENCY_TEST
-
 /* Enable to log cmpxchg failures */
 #undef SLUB_DEBUG_CMPXCHG
 
@@ -4910,66 +4907,6 @@ static int list_locations(struct kmem_cache *s, char *buf,
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
@@ -5819,7 +5756,6 @@ static int __init slab_sysfs_init(void)
 	}
 
 	mutex_unlock(&slab_mutex);
-	resiliency_test();
 	return 0;
 }
 
-- 
2.17.1

