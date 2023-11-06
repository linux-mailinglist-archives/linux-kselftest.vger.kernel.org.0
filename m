Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C2E7E2BF0
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Nov 2023 19:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjKFScH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Nov 2023 13:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjKFScF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Nov 2023 13:32:05 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAD194;
        Mon,  6 Nov 2023 10:32:01 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6b7f0170d7bso4830518b3a.2;
        Mon, 06 Nov 2023 10:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699295521; x=1699900321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pFcPVumquKH2Gwm0GjVQh+sz7Zkp1krGgtTHD7g2j8=;
        b=ca7J0m4+FeW2BSo0iHzSMj32NeULDnNlks1SJlhQzvg/SJwnNWQopZ+QTnJLtN4loQ
         y+E0Gth4avWYzck0ZvA2H9iZm+8GrkyB8IWV/PNn6s0EvGszgmQrJ3OmoPsu3hEAZ6ln
         qRD8OuMNhv8mNJ6/EgOHBf/3n/mnrX3J+qIPlFsJ3lKW0Hu8dRvOuTeqjJkqilPOxZWF
         uxICFgt/gdNQ50WP6JMBPgQBoaJaW9k0FVc/qtkZ9DoliD/sZ0/IrC1DAeqY8aCgZttQ
         tQUvFEPfj9imMmg0+iynWGzkXHB3ucuQjRq1/K/DFzaDdMBWPXnrdwmjdfEFKiE+tr9H
         3KRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699295521; x=1699900321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pFcPVumquKH2Gwm0GjVQh+sz7Zkp1krGgtTHD7g2j8=;
        b=ntJAmGkJdmugb+Kka/qxFr0p77b4VyW3uFK8nDxQPBqf7+Q5zUJ04fBmt5QAUw4Dov
         MUwtFGNN/OcEHUtZfUYLg/lTIXOycOgHcvVBB1vTfEoOlCWiQAMPRBUCXJHWOyJphWWL
         fZF+JJf7bzRc5ic40zBhwo3wJiP5Xa7cZVnmsnbwH8DMlvmDEa9F0IpC25pAcZIzFQ0l
         iIICQEJvc7qV/rjwGrOBOwrIXjlUEQqD0GBxoYpPtrpUiZp9+ZwpyQAYSGIuO2BQm6aV
         154HVYETenqm5flZbl7O6mzShA1oMBPQnXI1VODhsovkTQm2+ZOtWqFF6YyZ01FsZr1d
         DoIg==
X-Gm-Message-State: AOJu0Ywpm6sKLWY5XwGdQtyz/TfFx8B46mctlvD3GpuAsyTld2QwOOuS
        TLCuxc9zxKBgcuqhELCOkHA=
X-Google-Smtp-Source: AGHT+IEdvmy59H9XmGUYA6zji1s0dbSLNLf3euz0dHvMncPHXmjFiDKaUu5rlouTtKERH+A68+5eVA==
X-Received: by 2002:a05:6a00:b42:b0:6be:30f1:45f8 with SMTP id p2-20020a056a000b4200b006be30f145f8mr37139393pfo.20.1699295521198;
        Mon, 06 Nov 2023 10:32:01 -0800 (PST)
Received: from localhost (fwdproxy-prn-007.fbsv.net. [2a03:2880:ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id p24-20020aa78618000000b006bf53a51e6dsm6119753pfn.179.2023.11.06.10.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 10:32:00 -0800 (PST)
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
Subject: [PATCH v5 1/6] list_lru: allows explicit memcg and NUMA node selection
Date:   Mon,  6 Nov 2023 10:31:54 -0800
Message-Id: <20231106183159.3562879-2-nphamcs@gmail.com>
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

The interface of list_lru is based on the assumption that the list node
and the data it represents belong to the same allocated on the correct
node/memcg. While this assumption is valid for existing slab objects LRU
such as dentries and inodes, it is undocumented, and rather inflexible
for certain potential list_lru users (such as the upcoming zswap
shrinker and the THP shrinker). It has caused us a lot of issues during
our development.

This patch changes list_lru interface so that the caller must explicitly
specify numa node and memcg when adding and removing objects. The old
list_lru_add() and list_lru_del() are renamed to list_lru_add_obj() and
list_lru_del_obj(), respectively.

It also extends the list_lru API with a new function, list_lru_putback,
which undoes a previous list_lru_isolate call. Unlike list_lru_add, it
does not increment the LRU node count (as list_lru_isolate does not
decrement the node count). list_lru_putback also allows for explicit
memcg and NUMA node selection.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 drivers/android/binder_alloc.c |  5 ++--
 fs/dcache.c                    |  8 +++---
 fs/gfs2/quota.c                |  6 ++---
 fs/inode.c                     |  4 +--
 fs/nfs/nfs42xattr.c            |  8 +++---
 fs/nfsd/filecache.c            |  4 +--
 fs/xfs/xfs_buf.c               |  6 ++---
 fs/xfs/xfs_dquot.c             |  2 +-
 fs/xfs/xfs_qm.c                |  2 +-
 include/linux/list_lru.h       | 46 +++++++++++++++++++++++++++++---
 mm/list_lru.c                  | 48 ++++++++++++++++++++++++++++------
 mm/workingset.c                |  4 +--
 12 files changed, 108 insertions(+), 35 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 138f6d43d13b..e80669d4e037 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -285,7 +285,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 
 		trace_binder_free_lru_start(alloc, index);
 
-		ret = list_lru_add(&binder_alloc_lru, &page->lru);
+		ret = list_lru_add_obj(&binder_alloc_lru, &page->lru);
 		WARN_ON(!ret);
 
 		trace_binder_free_lru_end(alloc, index);
@@ -848,7 +848,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 			if (!alloc->pages[i].page_ptr)
 				continue;
 
-			on_lru = list_lru_del(&binder_alloc_lru,
+			on_lru = list_lru_del_obj(&binder_alloc_lru,
 					      &alloc->pages[i].lru);
 			page_addr = alloc->buffer + i * PAGE_SIZE;
 			binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
@@ -1287,4 +1287,3 @@ int binder_alloc_copy_from_buffer(struct binder_alloc *alloc,
 	return binder_alloc_do_buffer_copy(alloc, false, buffer, buffer_offset,
 					   dest, bytes);
 }
-
diff --git a/fs/dcache.c b/fs/dcache.c
index 25ac74d30bff..482d1b34d88d 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -428,7 +428,8 @@ static void d_lru_add(struct dentry *dentry)
 	this_cpu_inc(nr_dentry_unused);
 	if (d_is_negative(dentry))
 		this_cpu_inc(nr_dentry_negative);
-	WARN_ON_ONCE(!list_lru_add(&dentry->d_sb->s_dentry_lru, &dentry->d_lru));
+	WARN_ON_ONCE(!list_lru_add_obj(
+			&dentry->d_sb->s_dentry_lru, &dentry->d_lru));
 }
 
 static void d_lru_del(struct dentry *dentry)
@@ -438,7 +439,8 @@ static void d_lru_del(struct dentry *dentry)
 	this_cpu_dec(nr_dentry_unused);
 	if (d_is_negative(dentry))
 		this_cpu_dec(nr_dentry_negative);
-	WARN_ON_ONCE(!list_lru_del(&dentry->d_sb->s_dentry_lru, &dentry->d_lru));
+	WARN_ON_ONCE(!list_lru_del_obj(
+			&dentry->d_sb->s_dentry_lru, &dentry->d_lru));
 }
 
 static void d_shrink_del(struct dentry *dentry)
@@ -1240,7 +1242,7 @@ static enum lru_status dentry_lru_isolate(struct list_head *item,
 		 *
 		 * This is guaranteed by the fact that all LRU management
 		 * functions are intermediated by the LRU API calls like
-		 * list_lru_add and list_lru_del. List movement in this file
+		 * list_lru_add_obj and list_lru_del_obj. List movement in this file
 		 * only ever occur through this functions or through callbacks
 		 * like this one, that are called from the LRU API.
 		 *
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 2f1328af34f4..72015594bc83 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -271,7 +271,7 @@ static struct gfs2_quota_data *gfs2_qd_search_bucket(unsigned int hash,
 		if (qd->qd_sbd != sdp)
 			continue;
 		if (lockref_get_not_dead(&qd->qd_lockref)) {
-			list_lru_del(&gfs2_qd_lru, &qd->qd_lru);
+			list_lru_del_obj(&gfs2_qd_lru, &qd->qd_lru);
 			return qd;
 		}
 	}
@@ -344,7 +344,7 @@ static void qd_put(struct gfs2_quota_data *qd)
 	}
 
 	qd->qd_lockref.count = 0;
-	list_lru_add(&gfs2_qd_lru, &qd->qd_lru);
+	list_lru_add_obj(&gfs2_qd_lru, &qd->qd_lru);
 	spin_unlock(&qd->qd_lockref.lock);
 }
 
@@ -1508,7 +1508,7 @@ void gfs2_quota_cleanup(struct gfs2_sbd *sdp)
 		lockref_mark_dead(&qd->qd_lockref);
 		spin_unlock(&qd->qd_lockref.lock);
 
-		list_lru_del(&gfs2_qd_lru, &qd->qd_lru);
+		list_lru_del_obj(&gfs2_qd_lru, &qd->qd_lru);
 		list_add(&qd->qd_lru, &dispose);
 	}
 	spin_unlock(&qd_lock);
diff --git a/fs/inode.c b/fs/inode.c
index 84bc3c76e5cc..f889ba8dccd9 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -462,7 +462,7 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
 	if (!mapping_shrinkable(&inode->i_data))
 		return;
 
-	if (list_lru_add(&inode->i_sb->s_inode_lru, &inode->i_lru))
+	if (list_lru_add_obj(&inode->i_sb->s_inode_lru, &inode->i_lru))
 		this_cpu_inc(nr_unused);
 	else if (rotate)
 		inode->i_state |= I_REFERENCED;
@@ -480,7 +480,7 @@ void inode_add_lru(struct inode *inode)
 
 static void inode_lru_list_del(struct inode *inode)
 {
-	if (list_lru_del(&inode->i_sb->s_inode_lru, &inode->i_lru))
+	if (list_lru_del_obj(&inode->i_sb->s_inode_lru, &inode->i_lru))
 		this_cpu_dec(nr_unused);
 }
 
diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
index 2ad66a8922f4..49aaf28a6950 100644
--- a/fs/nfs/nfs42xattr.c
+++ b/fs/nfs/nfs42xattr.c
@@ -132,7 +132,7 @@ nfs4_xattr_entry_lru_add(struct nfs4_xattr_entry *entry)
 	lru = (entry->flags & NFS4_XATTR_ENTRY_EXTVAL) ?
 	    &nfs4_xattr_large_entry_lru : &nfs4_xattr_entry_lru;
 
-	return list_lru_add(lru, &entry->lru);
+	return list_lru_add_obj(lru, &entry->lru);
 }
 
 static bool
@@ -143,7 +143,7 @@ nfs4_xattr_entry_lru_del(struct nfs4_xattr_entry *entry)
 	lru = (entry->flags & NFS4_XATTR_ENTRY_EXTVAL) ?
 	    &nfs4_xattr_large_entry_lru : &nfs4_xattr_entry_lru;
 
-	return list_lru_del(lru, &entry->lru);
+	return list_lru_del_obj(lru, &entry->lru);
 }
 
 /*
@@ -349,7 +349,7 @@ nfs4_xattr_cache_unlink(struct inode *inode)
 
 	oldcache = nfsi->xattr_cache;
 	if (oldcache != NULL) {
-		list_lru_del(&nfs4_xattr_cache_lru, &oldcache->lru);
+		list_lru_del_obj(&nfs4_xattr_cache_lru, &oldcache->lru);
 		oldcache->inode = NULL;
 	}
 	nfsi->xattr_cache = NULL;
@@ -474,7 +474,7 @@ nfs4_xattr_get_cache(struct inode *inode, int add)
 			kref_get(&cache->ref);
 			nfsi->xattr_cache = cache;
 			cache->inode = inode;
-			list_lru_add(&nfs4_xattr_cache_lru, &cache->lru);
+			list_lru_add_obj(&nfs4_xattr_cache_lru, &cache->lru);
 		}
 
 		spin_unlock(&inode->i_lock);
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 9c62b4502539..82352c100b49 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -322,7 +322,7 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
 static bool nfsd_file_lru_add(struct nfsd_file *nf)
 {
 	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
-	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru)) {
+	if (list_lru_add_obj(&nfsd_file_lru, &nf->nf_lru)) {
 		trace_nfsd_file_lru_add(nf);
 		return true;
 	}
@@ -331,7 +331,7 @@ static bool nfsd_file_lru_add(struct nfsd_file *nf)
 
 static bool nfsd_file_lru_remove(struct nfsd_file *nf)
 {
-	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru)) {
+	if (list_lru_del_obj(&nfsd_file_lru, &nf->nf_lru)) {
 		trace_nfsd_file_lru_del(nf);
 		return true;
 	}
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 9e7ba04572db..9c2654a8d24b 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -169,7 +169,7 @@ xfs_buf_stale(
 
 	atomic_set(&bp->b_lru_ref, 0);
 	if (!(bp->b_state & XFS_BSTATE_DISPOSE) &&
-	    (list_lru_del(&bp->b_target->bt_lru, &bp->b_lru)))
+	    (list_lru_del_obj(&bp->b_target->bt_lru, &bp->b_lru)))
 		atomic_dec(&bp->b_hold);
 
 	ASSERT(atomic_read(&bp->b_hold) >= 1);
@@ -1047,7 +1047,7 @@ xfs_buf_rele(
 		 * buffer for the LRU and clear the (now stale) dispose list
 		 * state flag
 		 */
-		if (list_lru_add(&bp->b_target->bt_lru, &bp->b_lru)) {
+		if (list_lru_add_obj(&bp->b_target->bt_lru, &bp->b_lru)) {
 			bp->b_state &= ~XFS_BSTATE_DISPOSE;
 			atomic_inc(&bp->b_hold);
 		}
@@ -1060,7 +1060,7 @@ xfs_buf_rele(
 		 * was on was the disposal list
 		 */
 		if (!(bp->b_state & XFS_BSTATE_DISPOSE)) {
-			list_lru_del(&bp->b_target->bt_lru, &bp->b_lru);
+			list_lru_del_obj(&bp->b_target->bt_lru, &bp->b_lru);
 		} else {
 			ASSERT(list_empty(&bp->b_lru));
 		}
diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index ac6ba646624d..49f619f5aa96 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -1064,7 +1064,7 @@ xfs_qm_dqput(
 		struct xfs_quotainfo	*qi = dqp->q_mount->m_quotainfo;
 		trace_xfs_dqput_free(dqp);
 
-		if (list_lru_add(&qi->qi_lru, &dqp->q_lru))
+		if (list_lru_add_obj(&qi->qi_lru, &dqp->q_lru))
 			XFS_STATS_INC(dqp->q_mount, xs_qm_dquot_unused);
 	}
 	xfs_dqunlock(dqp);
diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
index 94a7932ac570..67d0a8564ff3 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -171,7 +171,7 @@ xfs_qm_dqpurge(
 	 * hits zero, so it really should be on the freelist here.
 	 */
 	ASSERT(!list_empty(&dqp->q_lru));
-	list_lru_del(&qi->qi_lru, &dqp->q_lru);
+	list_lru_del_obj(&qi->qi_lru, &dqp->q_lru);
 	XFS_STATS_DEC(dqp->q_mount, xs_qm_dquot_unused);
 
 	xfs_qm_dqdestroy(dqp);
diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index b35968ee9fb5..5ef217443299 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -75,6 +75,8 @@ void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *paren
  * list_lru_add: add an element to the lru list's tail
  * @list_lru: the lru pointer
  * @item: the item to be added.
+ * @memcg: the cgroup of the sublist to add the item to.
+ * @nid: the node id of the sublist to add the item to.
  *
  * If the element is already part of a list, this function returns doing
  * nothing. Therefore the caller does not need to keep state about whether or
@@ -87,12 +89,28 @@ void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *paren
  *
  * Return value: true if the list was updated, false otherwise
  */
-bool list_lru_add(struct list_lru *lru, struct list_head *item);
+bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
+		    struct mem_cgroup *memcg);
 
 /**
- * list_lru_del: delete an element to the lru list
+ * list_lru_add_obj: add an element to the lru list's tail
+ * @list_lru: the lru pointer
+ * @item: the item to be added.
+ *
+ * This function is similar to list_lru_add(), but the NUMA node and the
+ * memcg of the sublist is determined by @item list_head. This assumption is
+ * valid for slab objects LRU such as dentries, inodes, etc.
+ *
+ * Return value: true if the list was updated, false otherwise
+ */
+bool list_lru_add_obj(struct list_lru *lru, struct list_head *item);
+
+/**
+ * list_lru_del: delete an element from the lru list
  * @list_lru: the lru pointer
  * @item: the item to be deleted.
+ * @memcg: the cgroup of the sublist to delete the item from.
+ * @nid: the node id of the sublist to delete the item from.
  *
  * This function works analogously as list_lru_add in terms of list
  * manipulation. The comments about an element already pertaining to
@@ -100,7 +118,21 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item);
  *
  * Return value: true if the list was updated, false otherwise
  */
-bool list_lru_del(struct list_lru *lru, struct list_head *item);
+bool list_lru_del(struct list_lru *lru, struct list_head *item, int nid,
+		    struct mem_cgroup *memcg);
+
+/**
+ * list_lru_del_obj: delete an element from the lru list
+ * @list_lru: the lru pointer
+ * @item: the item to be deleted.
+ *
+ * This function is similar to list_lru_del(), but the NUMA node and the
+ * memcg of the sublist is determined by @item list_head. This assumption is
+ * valid for slab objects LRU such as dentries, inodes, etc.
+ *
+ * Return value: true if the list was updated, false otherwise.
+ */
+bool list_lru_del_obj(struct list_lru *lru, struct list_head *item);
 
 /**
  * list_lru_count_one: return the number of objects currently held by @lru
@@ -136,6 +168,14 @@ static inline unsigned long list_lru_count(struct list_lru *lru)
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
index a05e5bef3b40..fcca67ac26ec 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -116,21 +116,19 @@ list_lru_from_kmem(struct list_lru *lru, int nid, void *ptr,
 }
 #endif /* CONFIG_MEMCG_KMEM */
 
-bool list_lru_add(struct list_lru *lru, struct list_head *item)
+bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
+		    struct mem_cgroup *memcg)
 {
-	int nid = page_to_nid(virt_to_page(item));
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
-			set_shrinker_bit(memcg, nid,
-					 lru_shrinker_id(lru));
+			set_shrinker_bit(memcg, nid, lru_shrinker_id(lru));
 		nlru->nr_items++;
 		spin_unlock(&nlru->lock);
 		return true;
@@ -140,15 +138,25 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item)
 }
 EXPORT_SYMBOL_GPL(list_lru_add);
 
-bool list_lru_del(struct list_lru *lru, struct list_head *item)
+bool list_lru_add_obj(struct list_lru *lru, struct list_head *item)
 {
 	int nid = page_to_nid(virt_to_page(item));
+	struct mem_cgroup *memcg = list_lru_memcg_aware(lru) ?
+		mem_cgroup_from_slab_obj(item) : NULL;
+
+	return list_lru_add(lru, item, nid, memcg);
+}
+EXPORT_SYMBOL_GPL(list_lru_add_obj);
+
+bool list_lru_del(struct list_lru *lru, struct list_head *item, int nid,
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
@@ -160,6 +168,16 @@ bool list_lru_del(struct list_lru *lru, struct list_head *item)
 }
 EXPORT_SYMBOL_GPL(list_lru_del);
 
+bool list_lru_del_obj(struct list_lru *lru, struct list_head *item)
+{
+	int nid = page_to_nid(virt_to_page(item));
+	struct mem_cgroup *memcg = list_lru_memcg_aware(lru) ?
+		mem_cgroup_from_slab_obj(item) : NULL;
+
+	return list_lru_del(lru, item, nid, memcg);
+}
+EXPORT_SYMBOL_GPL(list_lru_del_obj);
+
 void list_lru_isolate(struct list_lru_one *list, struct list_head *item)
 {
 	list_del_init(item);
@@ -175,6 +193,20 @@ void list_lru_isolate_move(struct list_lru_one *list, struct list_head *item,
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
diff --git a/mm/workingset.c b/mm/workingset.c
index 11045febc383..7d3dacab8451 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -631,12 +631,12 @@ void workingset_update_node(struct xa_node *node)
 
 	if (node->count && node->count == node->nr_values) {
 		if (list_empty(&node->private_list)) {
-			list_lru_add(&shadow_nodes, &node->private_list);
+			list_lru_add_obj(&shadow_nodes, &node->private_list);
 			__inc_lruvec_kmem_state(node, WORKINGSET_NODES);
 		}
 	} else {
 		if (!list_empty(&node->private_list)) {
-			list_lru_del(&shadow_nodes, &node->private_list);
+			list_lru_del_obj(&shadow_nodes, &node->private_list);
 			__dec_lruvec_kmem_state(node, WORKINGSET_NODES);
 		}
 	}
-- 
2.34.1
