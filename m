Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543AE7E323D
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Nov 2023 01:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbjKGAb7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Nov 2023 19:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjKGAbz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Nov 2023 19:31:55 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF25F1BC;
        Mon,  6 Nov 2023 16:31:52 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b566bc6daaso3065100b6e.1;
        Mon, 06 Nov 2023 16:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699317112; x=1699921912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0WGY/AKCQE6ND37JA3v4q+xJaxjKD8rC8TyYg2oDtg=;
        b=kXi5j4PvnHRHpDvoYPCuO5niV0KTAwb4TtNVwRp02PQD0++Ls5T8GtgCxnfpuoxxVT
         TCyy77AyIXyFCwxzojDSy/Q1Hd/rc5PKKhgTqIbkYBVCS2CaBYRBSxHix69rAuBOhbTY
         OZhyDEsRjzAoFTCtfM5iMKFyD5FM7SqPvfykGiyaRPRclVdKYBbdRIbN8E8NvIB4S0Tx
         FyNuKjoeXWYsdDuNaVcUD2NUQiEJYBDQLYmJmNoIuJNWeImDtI51LBnwLtO6+lf6nNs7
         qwcvJr/AIA53s1sJr/Lbl7QPT61klltRGwPw6LuvLVRROxH+j/H5q6THe1NVi+Nwj0vY
         uZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699317112; x=1699921912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0WGY/AKCQE6ND37JA3v4q+xJaxjKD8rC8TyYg2oDtg=;
        b=mVRmMLBwlFWv7W+GZrTFinFFfiVX5AA2eq+dH0zzsA3dGmTxR53AsldsyRKk2VSuzn
         Rt+os4lySNYuNWRoPhq/kBG3WEaKx7JYXmSXmBrbL90ZTYnuYnIyPjYVAhOLKDBQxH7P
         PI8i5nKcPSmKWFbsGm3Q2Blsc8Di6z9WXnqLdpegRE7MArI/MaQu34vkdOulY5daVJF1
         ZBTwdQ8ZxuaSpfE1hasGITeIdGFD3ZN7urFq2TQhgxfcI3cFXhEOQm6gfjmklDG+AMoC
         IOtovpmCh5jRTQWW9MynMUDTtHYZXqDYTqHznJ/IiN83l7fqXuRBr7d6kYC3v+pyH4la
         J6ow==
X-Gm-Message-State: AOJu0Yzp+4yvHDID1lhxBKRxVNGxsX584B5wU42kgrbubf6CV3WwQ1sk
        izcrSdkTlW42sjpORtV4Xlg=
X-Google-Smtp-Source: AGHT+IFLDk2laxdyQ5ieeG3Edwclvst8+hE+8U16b+m5kSoKdpGwnzW/8zTX4A4zOu0NFtZPrk5Wxw==
X-Received: by 2002:a05:6808:210d:b0:3ac:aae1:6d64 with SMTP id r13-20020a056808210d00b003acaae16d64mr37640029oiw.2.1699317111933;
        Mon, 06 Nov 2023 16:31:51 -0800 (PST)
Received: from localhost (fwdproxy-prn-004.fbsv.net. [2a03:2880:ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id fb24-20020a056a002d9800b006c3488498bbsm3732085pfb.44.2023.11.06.16.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 16:31:51 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: [PATCH v5 3/6] zswap: make shrinking memcg-aware (fix)
Date:   Mon,  6 Nov 2023 16:31:51 -0800
Message-Id: <20231107003151.724860-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106183159.3562879-4-nphamcs@gmail.com>
References: <20231106183159.3562879-4-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Rename get_mem_cgroup_from_entry() to mem_cgroup_from_entry() and use
the zswap_pools_lock for next_shrink update.

Suggested-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zswap.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 2654b0d214cc..f1998dbd3519 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -174,7 +174,6 @@ struct zswap_pool {
 	struct hlist_node node;
 	char tfm_name[CRYPTO_MAX_ALG_NAME];
 	struct list_lru list_lru;
-	spinlock_t next_shrink_lock;
 	struct mem_cgroup *next_shrink;
 };
 
@@ -292,7 +291,7 @@ static void zswap_update_total_size(void)
 }
 
 /* should be called under RCU */
-static inline struct mem_cgroup *get_mem_cgroup_from_entry(struct zswap_entry *entry)
+static inline struct mem_cgroup *mem_cgroup_from_entry(struct zswap_entry *entry)
 {
 	return entry->objcg ? obj_cgroup_memcg(entry->objcg) : NULL;
 }
@@ -309,11 +308,9 @@ void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
 	/* lock out zswap pools list modification */
 	spin_lock(&zswap_pools_lock);
 	list_for_each_entry(pool, &zswap_pools, list) {
-		spin_lock(&pool->next_shrink_lock);
 		if (pool->next_shrink == memcg)
 			pool->next_shrink =
 				mem_cgroup_iter(NULL, pool->next_shrink, NULL, true);
-		spin_unlock(&pool->next_shrink_lock);
 	}
 	spin_unlock(&zswap_pools_lock);
 }
@@ -360,7 +357,7 @@ static void zswap_lru_add(struct list_lru *list_lru, struct zswap_entry *entry)
 	 * Similar reasoning holds for list_lru_del() and list_lru_putback().
 	 */
 	rcu_read_lock();
-	memcg = get_mem_cgroup_from_entry(entry);
+	memcg = mem_cgroup_from_entry(entry);
 	/* will always succeed */
 	list_lru_add(list_lru, &entry->lru, nid, memcg);
 	rcu_read_unlock();
@@ -372,7 +369,7 @@ static void zswap_lru_del(struct list_lru *list_lru, struct zswap_entry *entry)
 	struct mem_cgroup *memcg;
 
 	rcu_read_lock();
-	memcg = get_mem_cgroup_from_entry(entry);
+	memcg = mem_cgroup_from_entry(entry);
 	/* will always succeed */
 	list_lru_del(list_lru, &entry->lru, nid, memcg);
 	rcu_read_unlock();
@@ -386,7 +383,7 @@ static void zswap_lru_putback(struct list_lru *list_lru,
 	struct mem_cgroup *memcg;
 
 	rcu_read_lock();
-	memcg = get_mem_cgroup_from_entry(entry);
+	memcg = mem_cgroup_from_entry(entry);
 	spin_lock(lock);
 	/* we cannot use list_lru_add here, because it increments node's lru count */
 	list_lru_putback(list_lru, &entry->lru, nid, memcg);
@@ -806,13 +803,13 @@ static void shrink_worker(struct work_struct *w)
 
 	/* global reclaim will select cgroup in a round-robin fashion. */
 	do {
-		spin_lock(&pool->next_shrink_lock);
+		spin_lock(&zswap_pools_lock);
 		memcg = pool->next_shrink =
 			mem_cgroup_iter(NULL, pool->next_shrink, NULL, true);
 
 		/* full round trip */
 		if (!memcg) {
-			spin_unlock(&pool->next_shrink_lock);
+			spin_unlock(&zswap_pools_lock);
 			if (++failures == MAX_RECLAIM_RETRIES)
 				break;
 
@@ -824,7 +821,7 @@ static void shrink_worker(struct work_struct *w)
 		 * original reference is dropped by the zswap offlining callback.
 		 */
 		css_get(&memcg->css);
-		spin_unlock(&pool->next_shrink_lock);
+		spin_unlock(&zswap_pools_lock);
 
 		ret = shrink_memcg(memcg);
 		mem_cgroup_put(memcg);
@@ -898,7 +895,6 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 	INIT_WORK(&pool->shrink_work, shrink_worker);
 
 	zswap_pool_debug("created", pool);
-	spin_lock_init(&pool->next_shrink_lock);
 
 	return pool;
 
@@ -963,10 +959,10 @@ static void zswap_pool_destroy(struct zswap_pool *pool)
 	free_percpu(pool->acomp_ctx);
 	list_lru_destroy(&pool->list_lru);
 
-	spin_lock(&pool->next_shrink_lock);
+	spin_lock(&zswap_pools_lock);
 	mem_cgroup_put(pool->next_shrink);
 	pool->next_shrink = NULL;
-	spin_unlock(&pool->next_shrink_lock);
+	spin_unlock(&zswap_pools_lock);
 
 	for (i = 0; i < ZSWAP_NR_ZPOOLS; i++)
 		zpool_destroy_pool(pool->zpools[i]);
-- 
2.34.1
