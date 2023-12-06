Return-Path: <linux-kselftest+bounces-1319-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC63F8078D0
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 20:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065231C20DEE
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 19:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808CF47F6E;
	Wed,  6 Dec 2023 19:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azE5hY6d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB2E122;
	Wed,  6 Dec 2023 11:44:58 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5c2066accc5so81343a12.3;
        Wed, 06 Dec 2023 11:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701891898; x=1702496698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34Cie9O+2NEe6JD/tiGhw5O8IQAQcami9IqZS5J2OMw=;
        b=azE5hY6d7qYMc/I6yrPGUYSzyNOOxlobk2q2ie4iTlSPZ1WDvH4UcWU1GRaQsfBtUY
         d0E9GlSiIPA7dOYk/vZpL5E6HMyguWGZIDejbbqc83k6bNpK4OwRAZ+PZpTEa17ftw5s
         0I8ooyKPPJYz0jaXKAPPvs/5Ntp+jyoE7oZoV0AGlcBjeGLEDZR7jL98O2jIWFqhs9rE
         IWswcenJovCTh2PjtWXt9/VfkDHY2QDAzbXgPyp3YHrO3MBLco3O6vdTBdvwKjcUvxW7
         UhN9N8ULSidqvAiUSpv4AuHla/qBuWGbosvKfqCjSkAdnDdNYTNCBUswQgPnCE0NxtZp
         ALDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701891898; x=1702496698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=34Cie9O+2NEe6JD/tiGhw5O8IQAQcami9IqZS5J2OMw=;
        b=uf2Fo+nZC8uKlLesKJ7ILXBwWq3hQOzN6n5BXarnEjBkqqjkTIe/xoaVs5UpIH1wfv
         g2MDLsDcw9yaxx++77b0LmvuL2fCmYSEmtX8k/xwkRT8da2bn7h2yMf5fTFY7pHsWPic
         iNVyywFrtNNVHYZ0PUTyWzuZgU9owH1iagjKQWbqtPQjm/YnSG20YdHpNok2/4XEhFgN
         c2PUm1pVqG68SsLItBYJvTF8qW42FJ6RAHqfJ8Irr95YOJMg8F8rc4zok9OXo5x5Xfgo
         g5AeG5DwCJpn1Ed7kYlkJj3vIItfyUkpgp380oz9vXbStavT1SSZJYeYc8E9BzenZvC3
         /1Lg==
X-Gm-Message-State: AOJu0YywqzfiHQfukLAXcoESHKKcdv820cJhGX7/7rRbVOkul5FXSJqs
	Nzlr/IaDnX14xVM5IZ30VQU=
X-Google-Smtp-Source: AGHT+IGCtzIwuVYyOHM8v9z5Osc7F7Eb1bhTqHBysTeh63PqYeFOGQLL51YX7AuhnxO6tltAWmC3dg==
X-Received: by 2002:a05:6a20:be9e:b0:18f:97c:4f58 with SMTP id gf30-20020a056a20be9e00b0018f097c4f58mr993500pzb.100.1701891898163;
        Wed, 06 Dec 2023 11:44:58 -0800 (PST)
Received: from localhost (fwdproxy-prn-001.fbsv.net. [2a03:2880:ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id s9-20020a056a00178900b006ce91d27c72sm344920pfg.175.2023.12.06.11.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 11:44:57 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	cerasuolodomenico@gmail.com,
	yosryahmed@google.com,
	sjenning@redhat.com,
	ddstreet@ieee.org,
	vitaly.wool@konsulko.com,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeelb@google.com,
	muchun.song@linux.dev,
	chrisl@kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: [PATCH v8 6/6] zswap: shrinks zswap pool based on memory pressure (fix)
Date: Wed,  6 Dec 2023 11:44:56 -0800
Message-Id: <20231206194456.3234203-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130194023.4102148-7-nphamcs@gmail.com>
References: <20231130194023.4102148-7-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check shrinker enablement early, and use a less costly stat flushing.

Suggested-by: Yosry Ahmed <yosryahmed@google.com>
Suggested-by: Chengming Zhou <chengming.zhou@linux.dev>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zswap.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 27c749f6c1ba..d8ecd79120f3 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -596,13 +596,17 @@ static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
 	struct zswap_pool *pool = shrinker->private_data;
 	bool encountered_page_in_swapcache = false;
 
+	if (!zswap_shrinker_enabled) {
+		sc->nr_scanned = 0;
+		return SHRINK_STOP;
+	}
+
 	nr_protected =
 		atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_protected);
 	lru_size = list_lru_shrink_count(&pool->list_lru, sc);
 
 	/*
-	 * Abort if the shrinker is disabled or if we are shrinking into the
-	 * protected region.
+	 * Abort if we are shrinking into the protected region.
 	 *
 	 * This short-circuiting is necessary because if we have too many multiple
 	 * concurrent reclaimers getting the freeable zswap object counts at the
@@ -611,7 +615,7 @@ static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
 	 * objects (i.e the reclaimers will reclaim into the protected area of the
 	 * zswap LRU).
 	 */
-	if (!zswap_shrinker_enabled || nr_protected >= lru_size - sc->nr_to_scan) {
+	if (nr_protected >= lru_size - sc->nr_to_scan) {
 		sc->nr_scanned = 0;
 		return SHRINK_STOP;
 	}
@@ -633,8 +637,11 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(sc->nid));
 	unsigned long nr_backing, nr_stored, nr_freeable, nr_protected;
 
+	if (!zswap_shrinker_enabled)
+		return 0;
+
 #ifdef CONFIG_MEMCG_KMEM
-	cgroup_rstat_flush(memcg->css.cgroup);
+	mem_cgroup_flush_stats();
 	nr_backing = memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHIFT;
 	nr_stored = memcg_page_state(memcg, MEMCG_ZSWAPPED);
 #else
@@ -643,7 +650,7 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 	nr_stored = atomic_read(&pool->nr_stored);
 #endif
 
-	if (!zswap_shrinker_enabled || !nr_stored)
+	if (!nr_stored)
 		return 0;
 
 	nr_protected =
-- 
2.34.1

