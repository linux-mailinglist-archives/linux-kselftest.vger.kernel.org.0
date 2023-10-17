Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E427CD055
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 01:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344275AbjJQXV5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 19:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjJQXV4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 19:21:56 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9D598;
        Tue, 17 Oct 2023 16:21:54 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c5cd27b1acso52523315ad.2;
        Tue, 17 Oct 2023 16:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697584914; x=1698189714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1B54c0LHR/V83+Kt54U5jvPsezVzBi7N33Dc1Oz6d2w=;
        b=dTqken3nEAlQtJkoFoYvE06ZQRxOWd/E1HpTEvzXz+Y4/26+JlFkc5jTNXixUKf8aD
         7Wzmlk4nY1mTdw373uz9I2Ommsa8LrdkcfW+4bsoXfXyLoCNbIluyX1R3hol/A9J3ZFB
         diZDzywXx5j4Pfsf3sDDouQhrh9jzCNwuomcXl2MCLLprGY+m30FXz6TpcwAmbk14gTc
         Gnaq63wgM6fiW6NGdDVCOJwhtE5Ua14BYpK6oOsLWJh7CXOsYn/kQ4tVNgztRbyh9/fL
         Yc2pfuBXjcl/eeJAra67nQiu3rqyX7oHtSUNzZOkp04hisGebnTKIvGWYdT/cgitayHV
         xUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697584914; x=1698189714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1B54c0LHR/V83+Kt54U5jvPsezVzBi7N33Dc1Oz6d2w=;
        b=sIkA8+cWfyrz3mnYEUVRDeksOaM4PV9yEZfxal0uaT28V7wTicGMBAueNZc6fGOjvc
         CrfjkDy12c7mdt9QcWCl/v6toQiGwZI5i+Hk0nP7jdjokHo23U8igf11fnsLuLSdHgOg
         jq4Hdf2i2EHb5e+bW/jzE2MHnojfIGfjenWE7bJ4s8+99leXNwWtnrotZGSKKK7hPaWd
         GBVnOtTMB5iUrUfg9WLW3cYAUafcY2UfqNo60d7tcr7IUZ1IpcFIlIOWqkrMNEqAR8CS
         199HvEZcbTgrokHnwTKMWcwYZR2+6ReZAcCZitRNxLp2pSVEBsZiTXp7fNaQQXehL7KM
         /lRw==
X-Gm-Message-State: AOJu0YzMOWQ3LzUwrTR4IeO3NEH3qttaXOOCI9zVb98I1NCRja2sfRB8
        HSk5lteT5bU1SJWNG2T32VQ=
X-Google-Smtp-Source: AGHT+IFlsuynVW7P3E7VqGOiwRobgD/7Wox9Yzl01kYjLi6Wndqfn1dtW4y8opjslMhleYXh+bTIaQ==
X-Received: by 2002:a17:903:1388:b0:1c9:aac5:df1a with SMTP id jx8-20020a170903138800b001c9aac5df1amr3209709plb.51.1697584913825;
        Tue, 17 Oct 2023 16:21:53 -0700 (PDT)
Received: from localhost (fwdproxy-prn-013.fbsv.net. [2a03:2880:ff:d::face:b00c])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902e5ce00b001b86492d724sm2120023plf.223.2023.10.17.16.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 16:21:53 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [PATCH v3 1/5] mm: list_lru: allow external numa node and cgroup tracking
Date:   Tue, 17 Oct 2023 16:21:48 -0700
Message-Id: <20231017232152.2605440-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017232152.2605440-1-nphamcs@gmail.com>
References: <20231017232152.2605440-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The interface of list_lru is based on the assumption that objects are
allocated on the correct node/memcg, with this change it is introduced the
possibility to explicitly specify numa node and memcgroup when adding and
removing objects. This is so that users of list_lru can track node/memcg
of the items outside of the list_lru, like in zswap, where the allocations
can be made by kswapd for data that's charged to a different cgroup.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/list_lru.h | 38 +++++++++++++++++++++++++++++++++++
 mm/list_lru.c            | 43 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index b35968ee9fb5..0f5f39cacbbb 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -89,6 +89,24 @@ void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *paren
  */
 bool list_lru_add(struct list_lru *lru, struct list_head *item);
 
+/**
+ * __list_lru_add: add an element to a specific sublist.
+ * @list_lru: the lru pointer
+ * @item: the item to be added.
+ * @memcg: the cgroup of the sublist to add the item to.
+ * @nid: the node id of the sublist to add the item to.
+ *
+ * This function is similar to list_lru_add(), but it allows the caller to
+ * specify the sublist to which the item should be added. This can be useful
+ * when the list_head node is not necessarily in the same cgroup and NUMA node
+ * as the data it represents, such as zswap, where the list_head node could be
+ * from kswapd and the data from a different cgroup altogether.
+ *
+ * Return value: true if the list was updated, false otherwise
+ */
+bool __list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
+		    struct mem_cgroup *memcg);
+
 /**
  * list_lru_del: delete an element to the lru list
  * @list_lru: the lru pointer
@@ -102,6 +120,18 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item);
  */
 bool list_lru_del(struct list_lru *lru, struct list_head *item);
 
+/**
+ * __list_lru_del: delete an element from a specific sublist.
+ * @list_lru: the lru pointer
+ * @item: the item to be deleted.
+ * @memcg: the cgroup of the sublist to delete the item from.
+ * @nid: the node id of the sublist to delete the item from.
+ *
+ * Return value: true if the list was updated, false otherwise.
+ */
+bool __list_lru_del(struct list_lru *lru, struct list_head *item, int nid,
+		    struct mem_cgroup *memcg);
+
 /**
  * list_lru_count_one: return the number of objects currently held by @lru
  * @lru: the lru pointer.
@@ -136,6 +166,14 @@ static inline unsigned long list_lru_count(struct list_lru *lru)
 void list_lru_isolate(struct list_lru_one *list, struct list_head *item);
 void list_lru_isolate_move(struct list_lru_one *list, struct list_head *item,
 			   struct list_head *head);
+/*
+ * list_lru_putback: undo list_lru_isolate.
+ *
+ * Since we might have dropped the LRU lock in between, recompute list_lru_one
+ * from the node's id and memcg.
+ */
+void list_lru_putback(struct list_lru *lru, struct list_head *item, int nid,
+		      struct mem_cgroup *memcg);
 
 typedef enum lru_status (*list_lru_walk_cb)(struct list_head *item,
 		struct list_lru_one *list, spinlock_t *lock, void *cb_arg);
diff --git a/mm/list_lru.c b/mm/list_lru.c
index a05e5bef3b40..63b75163c6ad 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -119,13 +119,22 @@ list_lru_from_kmem(struct list_lru *lru, int nid, void *ptr,
 bool list_lru_add(struct list_lru *lru, struct list_head *item)
 {
 	int nid = page_to_nid(virt_to_page(item));
+	struct mem_cgroup *memcg = list_lru_memcg_aware(lru) ?
+		mem_cgroup_from_slab_obj(item) : NULL;
+
+	return __list_lru_add(lru, item, nid, memcg);
+}
+EXPORT_SYMBOL_GPL(list_lru_add);
+
+bool __list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
+		    struct mem_cgroup *memcg)
+{
 	struct list_lru_node *nlru = &lru->node[nid];
-	struct mem_cgroup *memcg;
 	struct list_lru_one *l;
 
 	spin_lock(&nlru->lock);
 	if (list_empty(item)) {
-		l = list_lru_from_kmem(lru, nid, item, &memcg);
+		l = list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg));
 		list_add_tail(item, &l->list);
 		/* Set shrinker bit if the first element was added */
 		if (!l->nr_items++)
@@ -138,17 +147,27 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item)
 	spin_unlock(&nlru->lock);
 	return false;
 }
-EXPORT_SYMBOL_GPL(list_lru_add);
+EXPORT_SYMBOL_GPL(__list_lru_add);
 
 bool list_lru_del(struct list_lru *lru, struct list_head *item)
 {
 	int nid = page_to_nid(virt_to_page(item));
+	struct mem_cgroup *memcg = list_lru_memcg_aware(lru) ?
+		mem_cgroup_from_slab_obj(item) : NULL;
+
+	return __list_lru_del(lru, item, nid, memcg);
+}
+EXPORT_SYMBOL_GPL(list_lru_del);
+
+bool __list_lru_del(struct list_lru *lru, struct list_head *item, int nid,
+		    struct mem_cgroup *memcg)
+{
 	struct list_lru_node *nlru = &lru->node[nid];
 	struct list_lru_one *l;
 
 	spin_lock(&nlru->lock);
 	if (!list_empty(item)) {
-		l = list_lru_from_kmem(lru, nid, item, NULL);
+		l = list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg));
 		list_del_init(item);
 		l->nr_items--;
 		nlru->nr_items--;
@@ -158,7 +177,7 @@ bool list_lru_del(struct list_lru *lru, struct list_head *item)
 	spin_unlock(&nlru->lock);
 	return false;
 }
-EXPORT_SYMBOL_GPL(list_lru_del);
+EXPORT_SYMBOL_GPL(__list_lru_del);
 
 void list_lru_isolate(struct list_lru_one *list, struct list_head *item)
 {
@@ -175,6 +194,20 @@ void list_lru_isolate_move(struct list_lru_one *list, struct list_head *item,
 }
 EXPORT_SYMBOL_GPL(list_lru_isolate_move);
 
+void list_lru_putback(struct list_lru *lru, struct list_head *item, int nid,
+		      struct mem_cgroup *memcg)
+{
+	struct list_lru_one *list =
+		list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg));
+
+	if (list_empty(item)) {
+		list_add_tail(item, &list->list);
+		if (!list->nr_items++)
+			set_shrinker_bit(memcg, nid, lru_shrinker_id(lru));
+	}
+}
+EXPORT_SYMBOL_GPL(list_lru_putback);
+
 unsigned long list_lru_count_one(struct list_lru *lru,
 				 int nid, struct mem_cgroup *memcg)
 {
-- 
2.34.1
