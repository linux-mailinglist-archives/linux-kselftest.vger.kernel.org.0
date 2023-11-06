Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B1C7E2BF1
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Nov 2023 19:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjKFScH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Nov 2023 13:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbjKFScG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Nov 2023 13:32:06 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1D1D4C;
        Mon,  6 Nov 2023 10:32:03 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cc131e52f1so45016945ad.0;
        Mon, 06 Nov 2023 10:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699295522; x=1699900322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeg4px5UubAcyDZsKdAVJT5jO+bA71pIdTPHzCJTR5Q=;
        b=CBjNIxI2JMFwnooSUXmYWVkYH/i4deUDr8Ax3bGmbb9dj/jmXcZHVTepwrHQWqu7Y4
         V/AYpIyuqKVuXnElt+heBkM7mdi+1zr64VXoXevN/4pidgZaeLQRYNf/Il9HWSkfIz8j
         aPpOWbp06oDrBvvl1M3HLBlWswcNji1Sw5xFQV7W2p+flQAz/rz3csxo7/nTuF5F1IE7
         gmJMrFVsyE+HjyOqH4DTTCWJmQf0nSd2nDU6KG4s5NNq+e+9QpsOItXcKlQGZHHb57dm
         kghbilMqVWyjbcYcWkRJNPYjToZJwrSfnPvqV5YVdZSewIkvikekXL6WEmbebxAZuOCI
         8TnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699295522; x=1699900322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aeg4px5UubAcyDZsKdAVJT5jO+bA71pIdTPHzCJTR5Q=;
        b=XgcnTCs8xzR2kfEtAS+Iu8Qyh1eFpG/3wqHUArA+u7QmK5qhvfmWRP2mABVbAnbDm/
         85Eno5GuBQf7o3qLuL38/v0fCvJJVWopFMicz1B8drIIYg1VHuRJrWhx65BmOjHmLVNh
         8e5YJmZoKCpWm//LOA1tXd93qCH59EEU/Uq/4rojeDJUvsrs4ozxJYMLTFmVj/QOMhZZ
         ZpoqG2/FyCy2Y8ByrZ00sFQwg2C23q36UZHgDm13t1yl4ifFtDEncEQyIV/WW4ADyU+k
         fiGp495tmWkjLuDJvsbrzY048amGoJ+4rqau4m2gNKSwl660WNytajk5ZeCLXHPlSpUE
         niWg==
X-Gm-Message-State: AOJu0Yy6gM/QYRA2FkiAaC8xRBnyR0/TAMFePHH2yarW2aLwIjcz0Ybl
        UtMFySbKgmfwMNLYyVcruKs=
X-Google-Smtp-Source: AGHT+IH8J6dzOa+acwIoDEAwJcVL40/FtAfyj5lkxXosODWxLZGIgiyQlQw11vmAE3oLLfcbhjqGJg==
X-Received: by 2002:a17:902:f54b:b0:1cc:5ce4:f657 with SMTP id h11-20020a170902f54b00b001cc5ce4f657mr336993plf.29.1699295522328;
        Mon, 06 Nov 2023 10:32:02 -0800 (PST)
Received: from localhost (fwdproxy-prn-015.fbsv.net. [2a03:2880:ff:f::face:b00c])
        by smtp.gmail.com with ESMTPSA id p9-20020a170902e74900b001c73701bd17sm6215465plf.4.2023.11.06.10.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 10:32:01 -0800 (PST)
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
Subject: [PATCH v5 2/6] memcontrol: allows mem_cgroup_iter() to check for onlineness
Date:   Mon,  6 Nov 2023 10:31:55 -0800
Message-Id: <20231106183159.3562879-3-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106183159.3562879-1-nphamcs@gmail.com>
References: <20231106183159.3562879-1-nphamcs@gmail.com>
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
index 6edd3ec4d8d5..55c85f952afd 100644
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
index 61c0c46c2d62..6f7fc0101252 100644
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
@@ -1139,6 +1139,7 @@ struct mem_cgroup *get_mem_cgroup_from_current(void)
  * @root: hierarchy root
  * @prev: previously returned memcg, NULL on first invocation
  * @reclaim: cookie for shared reclaim walks, NULL for full walks
+ * @online: skip offline memcgs
  *
  * Returns references to children of the hierarchy below @root, or
  * @root itself, or %NULL after a full round-trip.
@@ -1153,7 +1154,8 @@ struct mem_cgroup *get_mem_cgroup_from_current(void)
  */
 struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 				   struct mem_cgroup *prev,
-				   struct mem_cgroup_reclaim_cookie *reclaim)
+				   struct mem_cgroup_reclaim_cookie *reclaim,
+				   bool online)
 {
 	struct mem_cgroup_reclaim_iter *iter;
 	struct cgroup_subsys_state *css = NULL;
@@ -1223,7 +1225,8 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 		 * is provided by the caller, so we know it's alive
 		 * and kicking, and don't take an extra reference.
 		 */
-		if (css == &root->css || css_tryget(css)) {
+		if (css == &root->css || (!online && css_tryget(css)) ||
+				css_tryget_online(css)) {
 			memcg = mem_cgroup_from_css(css);
 			break;
 		}
@@ -1836,7 +1839,7 @@ static int mem_cgroup_soft_reclaim(struct mem_cgroup *root_memcg,
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
index 2cc0cb41fb32..065d29502580 100644
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
@@ -3931,7 +3931,7 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
 	if (!min_ttl || sc->order || sc->priority == DEF_PRIORITY)
 		return;
 
-	memcg = mem_cgroup_iter(NULL, NULL, NULL);
+	memcg = mem_cgroup_iter(NULL, NULL, NULL, false);
 	do {
 		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
 
@@ -3941,7 +3941,7 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
 		}
 
 		cond_resched();
-	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)));
+	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL, false)));
 
 	/*
 	 * The main goal is to OOM kill if every generation from all memcgs is
@@ -5033,7 +5033,7 @@ static void lru_gen_change_state(bool enabled)
 	else
 		static_branch_disable_cpuslocked(&lru_gen_caps[LRU_GEN_CORE]);
 
-	memcg = mem_cgroup_iter(NULL, NULL, NULL);
+	memcg = mem_cgroup_iter(NULL, NULL, NULL, false);
 	do {
 		int nid;
 
@@ -5057,7 +5057,7 @@ static void lru_gen_change_state(bool enabled)
 		}
 
 		cond_resched();
-	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)));
+	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL, false)));
 unlock:
 	mutex_unlock(&state_mutex);
 	put_online_mems();
@@ -5160,7 +5160,7 @@ static void *lru_gen_seq_start(struct seq_file *m, loff_t *pos)
 	if (!m->private)
 		return ERR_PTR(-ENOMEM);
 
-	memcg = mem_cgroup_iter(NULL, NULL, NULL);
+	memcg = mem_cgroup_iter(NULL, NULL, NULL, false);
 	do {
 		int nid;
 
@@ -5168,7 +5168,7 @@ static void *lru_gen_seq_start(struct seq_file *m, loff_t *pos)
 			if (!nr_to_skip--)
 				return get_lruvec(memcg, nid);
 		}
-	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)));
+	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL, false)));
 
 	return NULL;
 }
@@ -5191,7 +5191,7 @@ static void *lru_gen_seq_next(struct seq_file *m, void *v, loff_t *pos)
 
 	nid = next_memory_node(nid);
 	if (nid == MAX_NUMNODES) {
-		memcg = mem_cgroup_iter(NULL, memcg, NULL);
+		memcg = mem_cgroup_iter(NULL, memcg, NULL, false);
 		if (!memcg)
 			return NULL;
 
@@ -5794,7 +5794,7 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 	struct mem_cgroup *target_memcg = sc->target_mem_cgroup;
 	struct mem_cgroup *memcg;
 
-	memcg = mem_cgroup_iter(target_memcg, NULL, NULL);
+	memcg = mem_cgroup_iter(target_memcg, NULL, NULL, false);
 	do {
 		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
 		unsigned long reclaimed;
@@ -5844,7 +5844,7 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 				   sc->nr_scanned - scanned,
 				   sc->nr_reclaimed - reclaimed);
 
-	} while ((memcg = mem_cgroup_iter(target_memcg, memcg, NULL)));
+	} while ((memcg = mem_cgroup_iter(target_memcg, memcg, NULL, false)));
 }
 
 static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
@@ -6511,12 +6511,12 @@ static void kswapd_age_node(struct pglist_data *pgdat, struct scan_control *sc)
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
