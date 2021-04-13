Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166B335DC2F
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Apr 2021 12:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243890AbhDMKIN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Apr 2021 06:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243700AbhDMKIM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Apr 2021 06:08:12 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE997C061756;
        Tue, 13 Apr 2021 03:07:52 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e7so6865968wrs.11;
        Tue, 13 Apr 2021 03:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IrJAk+UldH6qP01JSUzgiPrgZtp9nH0fv06TlY9Jo/g=;
        b=jJVA9nCOEP2FOKXHdaunw/29pRazbvTuu3ekgJ6BRJdlI+wntoIdK9fNhNVYbVKiMK
         11wF7frYuG6YuaF+k3RucHuPn6QD6GT/ngyzcxH1GRmhYkf5+tLRvgWGcqpYjiMomlSp
         piFiaQonPPpNcLuGYoG7ksSB4SO8nVTz3wrXUV1hUjp6ZoJgPyyPTH5fg/Xs5s0j+ldS
         1jNwTvo6HRrs8H2aD4jJ10s6Z2wPtOFAGboPfBTM3U2x+2j1JRrGvofndN6K/Kd3XCyn
         helA49HNM3cQlrHfW7MQcO4u1s7tacXURk2Y2ldo2GPpY/Cbw9mjQpQKh4bEFWFsWVmz
         UjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IrJAk+UldH6qP01JSUzgiPrgZtp9nH0fv06TlY9Jo/g=;
        b=ebVdh3YiiI6VuYJdEuSndGDSaSTMjTxQr1Wl4hYWAY7MXfyLYasTxT47b8zV5tXWWd
         gTzlPwN6sx/UyKOL+fCSKtZZXGXISRkCG4xsCGyLbL/XQHPlWctXnTsZiapXkqRyezzW
         wcf+pzUjqgrLmW+FVnUzuk8YbnqPzl7eO8teUE38fH+ZovloaUKP6bfyqfOeb2ywHw7h
         W/BXCY3t2zM5RizExaj4Zj9NLVOs9I35aIWsp1j+CDLZhYfHu3chGA/e2zN59qT9AWjS
         bSWMVvzPeCNusbj6dMepBI1IBr6vUywyBk9HeqInGpKNb4VkSCRHqXd246S/LSVOyki6
         Ib1A==
X-Gm-Message-State: AOAM531TC+TNZL7VcU3E8aKi78t9s6cVn2ecAT0pt51bl9pEGvrF756w
        gfooU6SD9CTUBe6IiL3+YDU=
X-Google-Smtp-Source: ABdhPJyj9RcsM9NsQ33efZgexwmUAO45OwieULPualI3iTJB8jeW+92OmdRnp7H/lAcG/94oPccqvw==
X-Received: by 2002:a5d:6983:: with SMTP id g3mr2989699wru.415.1618308471508;
        Tue, 13 Apr 2021 03:07:51 -0700 (PDT)
Received: from oliver-Z170M-D3H.cuni.cz ([2001:718:1e03:5128:35b3:1d60:e26d:e79b])
        by smtp.gmail.com with ESMTPSA id b1sm19621280wru.90.2021.04.13.03.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 03:07:51 -0700 (PDT)
From:   glittao@gmail.com
To:     brendanhiggins@google.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-mm@kvack.org, elver@google.com,
        dlatypov@google.com, Oliver Glitta <glittao@gmail.com>
Subject: [PATCH v4 3/3] slub: remove resiliency_test() function
Date:   Tue, 13 Apr 2021 12:07:47 +0200
Message-Id: <20210413100747.4921-3-glittao@gmail.com>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a5
In-Reply-To: <20210413100747.4921-1-glittao@gmail.com>
References: <20210413100747.4921-1-glittao@gmail.com>
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
index d7df8841d90a..c65e2c471a13 100644
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
 
@@ -4939,66 +4936,6 @@ static int list_locations(struct kmem_cache *s, char *buf,
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
@@ -5847,7 +5784,6 @@ static int __init slab_sysfs_init(void)
 	}
 
 	mutex_unlock(&slab_mutex);
-	resiliency_test();
 	return 0;
 }
 
-- 
2.31.1.272.g89b43f80a5

