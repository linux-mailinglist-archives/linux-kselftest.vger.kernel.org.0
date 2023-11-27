Return-Path: <linux-kselftest+bounces-659-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 845D17FAA60
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 20:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7D071C20CC4
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 19:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C626B405C9;
	Mon, 27 Nov 2023 19:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCKQBSnj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63B710CB;
	Mon, 27 Nov 2023 11:37:06 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2859551886cso2466944a91.2;
        Mon, 27 Nov 2023 11:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701113826; x=1701718626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yk3Ra7LxPSTcjlQasqmaE6aQE/pvNfDE/tLSZ7yZw8U=;
        b=LCKQBSnjW4kVZH+ox4SLDtgl76dXgqYdAsE0wo3eAtKfvZnwUsAZygTSJevp6exVgV
         IC4qIjlhn3L6y809RYqttPJCMsGvP3LbZkynMyKcH2Vnpz+nijqSWU2ZVjKQmCaFySFR
         zYFuT2AkPqJC0qhpiVJy0q/lvLPxVSRXGpHdzFqmP/7xbwHAjt3YA5nrJA5CY5acT4w6
         ASceD2DT6AaArhHzt/tLzStasehBWXi19ZgbGshv5YiW6ZO8cmUyC3uODc29/8blYkH/
         +4A4fdlJv+A4Nyztzf7DfZDRZaKbEzY/8L3GgsdLWRQHiQWjEkdDcgLn6EObuifJHw3/
         bWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701113826; x=1701718626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yk3Ra7LxPSTcjlQasqmaE6aQE/pvNfDE/tLSZ7yZw8U=;
        b=M7MSEaK+4OYtyhwJr9jOf9ZNJedXXsuTCnVqbpWtBOiBGd0FXiYYqVYXaNXHbKbllh
         famKvmA4cq2Qpr9CH3emAMBDIV5RAMSft2Yc1qYOzpQ18Z1gZwi3oyd+M7JwG4bhoLge
         Y83SOuduhnvTPG8coRsI4OijwfseWlBFhw+A1ZkT2IR9ANPujM/1kUtD9GHMlRplQgIf
         GfwGqFl33TYXHZouUmaTqXxEsA0E2QJ+yxiATFkGPS0L+3lrX8h9y0/Vd6hmRLwwT+Ld
         /wmWsKkJH8C4+iGWLNv4T6Ey09kdelU0r3EO3xomY0VSxwRRkUzeMRX44RluNHiDG4GN
         c3KQ==
X-Gm-Message-State: AOJu0YxtCGaLx9M1N2Z0+BQ8sPX0TL94WcI3nN+AmmN85e5B7fWmC1R/
	PGjEX47QWoTM/rYv2XPc7Hw=
X-Google-Smtp-Source: AGHT+IESo6RUTEUw2quoScohVLKJzp+po5d5yitAfhgPXdhC6sxqbbGd5iWNr4rtvNf8otQ+V25FDw==
X-Received: by 2002:a17:90b:3b92:b0:285:a72f:966f with SMTP id pc18-20020a17090b3b9200b00285a72f966fmr8454941pjb.46.1701113826185;
        Mon, 27 Nov 2023 11:37:06 -0800 (PST)
Received: from localhost (fwdproxy-prn-026.fbsv.net. [2a03:2880:ff:1a::face:b00c])
        by smtp.gmail.com with ESMTPSA id a21-20020a17090ad81500b002851e283c21sm7822831pjv.12.2023.11.27.11.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 11:37:05 -0800 (PST)
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
Subject: [PATCH v6 2/6] memcontrol: allows mem_cgroup_iter() to check for onlineness
Date: Mon, 27 Nov 2023 11:36:59 -0800
Message-Id: <20231127193703.1980089-3-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127193703.1980089-1-nphamcs@gmail.com>
References: <20231127193703.1980089-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new zswap writeback scheme requires an online-only memcg hierarchy
traversal. Add a new parameter to mem_cgroup_iter() to check for
onlineness before returning.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/memcontrol.h |  4 ++--
 mm/memcontrol.c            | 17 ++++++++++-------
 mm/shrinker.c              |  4 ++--
 mm/vmscan.c                | 26 +++++++++++++-------------
 4 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 7bdcf3020d7a..86adce081a08 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -832,7 +832,7 @@ static inline void mem_cgroup_put(struct mem_cgroup *memcg)
 
 struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *,
 				   struct mem_cgroup *,
-				   struct mem_cgroup_reclaim_cookie *);
+				   struct mem_cgroup_reclaim_cookie *, bool online);
 void mem_cgroup_iter_break(struct mem_cgroup *, struct mem_cgroup *);
 void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 			   int (*)(struct task_struct *, void *), void *arg);
@@ -1381,7 +1381,7 @@ static inline struct lruvec *folio_lruvec_lock_irqsave(struct folio *folio,
 static inline struct mem_cgroup *
 mem_cgroup_iter(struct mem_cgroup *root,
 		struct mem_cgroup *prev,
-		struct mem_cgroup_reclaim_cookie *reclaim)
+		struct mem_cgroup_reclaim_cookie *reclaim, bool online)
 {
 	return NULL;
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 564aa8f25b71..a1f051adaa15 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -221,14 +221,14 @@ enum res_type {
  * be used for reference counting.
  */
 #define for_each_mem_cgroup_tree(iter, root)		\
-	for (iter = mem_cgroup_iter(root, NULL, NULL);	\
+	for (iter = mem_cgroup_iter(root, NULL, NULL, false);	\
 	     iter != NULL;				\
-	     iter = mem_cgroup_iter(root, iter, NULL))
+	     iter = mem_cgroup_iter(root, iter, NULL, false))
 
 #define for_each_mem_cgroup(iter)			\
-	for (iter = mem_cgroup_iter(NULL, NULL, NULL);	\
+	for (iter = mem_cgroup_iter(NULL, NULL, NULL, false);	\
 	     iter != NULL;				\
-	     iter = mem_cgroup_iter(NULL, iter, NULL))
+	     iter = mem_cgroup_iter(NULL, iter, NULL, false))
 
 static inline bool task_is_dying(void)
 {
@@ -1115,6 +1115,7 @@ struct mem_cgroup *get_mem_cgroup_from_current(void)
  * @root: hierarchy root
  * @prev: previously returned memcg, NULL on first invocation
  * @reclaim: cookie for shared reclaim walks, NULL for full walks
+ * @online: skip offline memcgs
  *
  * Returns references to children of the hierarchy below @root, or
  * @root itself, or %NULL after a full round-trip.
@@ -1129,7 +1130,8 @@ struct mem_cgroup *get_mem_cgroup_from_current(void)
  */
 struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 				   struct mem_cgroup *prev,
-				   struct mem_cgroup_reclaim_cookie *reclaim)
+				   struct mem_cgroup_reclaim_cookie *reclaim,
+				   bool online)
 {
 	struct mem_cgroup_reclaim_iter *iter;
 	struct cgroup_subsys_state *css = NULL;
@@ -1199,7 +1201,8 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 		 * is provided by the caller, so we know it's alive
 		 * and kicking, and don't take an extra reference.
 		 */
-		if (css == &root->css || css_tryget(css)) {
+		if (css == &root->css || (!online && css_tryget(css)) ||
+				css_tryget_online(css)) {
 			memcg = mem_cgroup_from_css(css);
 			break;
 		}
@@ -1812,7 +1815,7 @@ static int mem_cgroup_soft_reclaim(struct mem_cgroup *root_memcg,
 	excess = soft_limit_excess(root_memcg);
 
 	while (1) {
-		victim = mem_cgroup_iter(root_memcg, victim, &reclaim);
+		victim = mem_cgroup_iter(root_memcg, victim, &reclaim, false);
 		if (!victim) {
 			loop++;
 			if (loop >= 2) {
diff --git a/mm/shrinker.c b/mm/shrinker.c
index dd91eab43ed3..54f5d3aa4f27 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -160,7 +160,7 @@ static int expand_shrinker_info(int new_id)
 	new_size = shrinker_unit_size(new_nr_max);
 	old_size = shrinker_unit_size(shrinker_nr_max);
 
-	memcg = mem_cgroup_iter(NULL, NULL, NULL);
+	memcg = mem_cgroup_iter(NULL, NULL, NULL, false);
 	do {
 		ret = expand_one_shrinker_info(memcg, new_size, old_size,
 					       new_nr_max);
@@ -168,7 +168,7 @@ static int expand_shrinker_info(int new_id)
 			mem_cgroup_iter_break(NULL, memcg);
 			goto out;
 		}
-	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
+	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL, false)) != NULL);
 out:
 	if (!ret)
 		shrinker_nr_max = new_nr_max;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index d8c3338fee0f..9a65ee3a1bb7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -397,10 +397,10 @@ static unsigned long drop_slab_node(int nid)
 	unsigned long freed = 0;
 	struct mem_cgroup *memcg = NULL;
 
-	memcg = mem_cgroup_iter(NULL, NULL, NULL);
+	memcg = mem_cgroup_iter(NULL, NULL, NULL, false);
 	do {
 		freed += shrink_slab(GFP_KERNEL, nid, memcg, 0);
-	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
+	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL, false)) != NULL);
 
 	return freed;
 }
@@ -3935,7 +3935,7 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
 	if (!min_ttl || sc->order || sc->priority == DEF_PRIORITY)
 		return;
 
-	memcg = mem_cgroup_iter(NULL, NULL, NULL);
+	memcg = mem_cgroup_iter(NULL, NULL, NULL, false);
 	do {
 		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
 
@@ -3945,7 +3945,7 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
 		}
 
 		cond_resched();
-	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)));
+	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL, false)));
 
 	/*
 	 * The main goal is to OOM kill if every generation from all memcgs is
@@ -5037,7 +5037,7 @@ static void lru_gen_change_state(bool enabled)
 	else
 		static_branch_disable_cpuslocked(&lru_gen_caps[LRU_GEN_CORE]);
 
-	memcg = mem_cgroup_iter(NULL, NULL, NULL);
+	memcg = mem_cgroup_iter(NULL, NULL, NULL, false);
 	do {
 		int nid;
 
@@ -5061,7 +5061,7 @@ static void lru_gen_change_state(bool enabled)
 		}
 
 		cond_resched();
-	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)));
+	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL, false)));
 unlock:
 	mutex_unlock(&state_mutex);
 	put_online_mems();
@@ -5164,7 +5164,7 @@ static void *lru_gen_seq_start(struct seq_file *m, loff_t *pos)
 	if (!m->private)
 		return ERR_PTR(-ENOMEM);
 
-	memcg = mem_cgroup_iter(NULL, NULL, NULL);
+	memcg = mem_cgroup_iter(NULL, NULL, NULL, false);
 	do {
 		int nid;
 
@@ -5172,7 +5172,7 @@ static void *lru_gen_seq_start(struct seq_file *m, loff_t *pos)
 			if (!nr_to_skip--)
 				return get_lruvec(memcg, nid);
 		}
-	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)));
+	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL, false)));
 
 	return NULL;
 }
@@ -5195,7 +5195,7 @@ static void *lru_gen_seq_next(struct seq_file *m, void *v, loff_t *pos)
 
 	nid = next_memory_node(nid);
 	if (nid == MAX_NUMNODES) {
-		memcg = mem_cgroup_iter(NULL, memcg, NULL);
+		memcg = mem_cgroup_iter(NULL, memcg, NULL, false);
 		if (!memcg)
 			return NULL;
 
@@ -5798,7 +5798,7 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 	struct mem_cgroup *target_memcg = sc->target_mem_cgroup;
 	struct mem_cgroup *memcg;
 
-	memcg = mem_cgroup_iter(target_memcg, NULL, NULL);
+	memcg = mem_cgroup_iter(target_memcg, NULL, NULL, false);
 	do {
 		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
 		unsigned long reclaimed;
@@ -5855,7 +5855,7 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 				   sc->nr_scanned - scanned,
 				   sc->nr_reclaimed - reclaimed);
 
-	} while ((memcg = mem_cgroup_iter(target_memcg, memcg, NULL)));
+	} while ((memcg = mem_cgroup_iter(target_memcg, memcg, NULL, false)));
 }
 
 static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
@@ -6522,12 +6522,12 @@ static void kswapd_age_node(struct pglist_data *pgdat, struct scan_control *sc)
 	if (!inactive_is_low(lruvec, LRU_INACTIVE_ANON))
 		return;
 
-	memcg = mem_cgroup_iter(NULL, NULL, NULL);
+	memcg = mem_cgroup_iter(NULL, NULL, NULL, false);
 	do {
 		lruvec = mem_cgroup_lruvec(memcg, pgdat);
 		shrink_active_list(SWAP_CLUSTER_MAX, lruvec,
 				   sc, LRU_ACTIVE_ANON);
-		memcg = mem_cgroup_iter(NULL, memcg, NULL);
+		memcg = mem_cgroup_iter(NULL, memcg, NULL, false);
 	} while (memcg);
 }
 
-- 
2.34.1

