Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27D2E121A4B
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2019 21:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfLPT5y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Dec 2019 14:57:54 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3679 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfLPT5x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Dec 2019 14:57:53 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5df7e1b70000>; Mon, 16 Dec 2019 11:57:43 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 16 Dec 2019 11:57:52 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 16 Dec 2019 11:57:52 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Dec
 2019 19:57:51 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Dec
 2019 19:57:49 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 16 Dec 2019 19:57:49 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5df7e1bc0005>; Mon, 16 Dec 2019 11:57:49 -0800
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Ralph Campbell" <rcampbell@nvidia.com>
Subject: [PATCH v5 1/2] mm/mmu_notifier: make interval notifier updates safe
Date:   Mon, 16 Dec 2019 11:57:32 -0800
Message-ID: <20191216195733.28353-2-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216195733.28353-1-rcampbell@nvidia.com>
References: <20191216195733.28353-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576526263; bh=J3LhIfw7yVe4CGsQOL/8sy3jH4+I/7xQySGjSIScxUE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=RGVVpU+ellKb70M29eYqsq92tHWWCKKXdGSxUhxG099Uq2Gn9nMK3mSsCu9YD/sWp
         Sf7LZLaxlgzWpH1BCnf3rceGPj+Ui1DUEm5RlU8gbfJBqK8T/nm/yTgKNwSmzYNarz
         /kbUr4yI2+24KgySElo2qo1ZNY+X+ZvxWpY1sRkE/+hOl93f2rqX7wgoXPoJiypWh3
         sXjywSsEl7V0fGTA28tfvrvzhSaSfH8iaSrUTV0P/bBUGZOR166HWs9Wd0WjcfKzjR
         5QlL54Utr9LNsPysqjbusiY5XCha1SCPGh20gkhRuYThQcDaS9dZdiYP8q5w3pgbm4
         o+qNnNCg3OdyA==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

mmu_interval_notifier_insert() and mmu_interval_notifier_remove() can't
be called safely from inside the invalidate() callback. This is fine for
devices with explicit memory region register and unregister calls but it
is desirable from a programming model standpoint to not require explicit
memory region registration. Regions can be registered based on device
address faults but without a mechanism for updating or removing the mmu
interval notifiers in response to munmap(), the invalidation callbacks
will be for regions that are stale or apply to different mmaped regions.

The invalidate() callback provides the necessary information (i.e.,
the event type MMU_NOTIFY_UNMAP) so add insert, remove, and update
functions that are safe to call from the invalidate() callback by
extending the work done in mn_itree_inv_end() to update the interval tree
when it is not being traversed.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 include/linux/mmu_notifier.h |  15 +++
 mm/mmu_notifier.c            | 196 ++++++++++++++++++++++++++++++-----
 2 files changed, 186 insertions(+), 25 deletions(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 9e6caa8ecd19..55fbefcdc564 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -233,11 +233,18 @@ struct mmu_notifier {
  * @invalidate: Upon return the caller must stop using any SPTEs within th=
is
  *              range. This function can sleep. Return false only if sleep=
ing
  *              was required but mmu_notifier_range_blockable(range) is fa=
lse.
+ * @release:	This function will be called when the mmu_interval_notifier
+ *		is removed from the interval tree. Defining this function also
+ *		allows mmu_interval_notifier_remove() and
+ *		mmu_interval_notifier_update() to be called from the
+ *		invalidate() callback function (i.e., they won't block waiting
+ *		for invalidations to finish.
  */
 struct mmu_interval_notifier_ops {
 	bool (*invalidate)(struct mmu_interval_notifier *mni,
 			   const struct mmu_notifier_range *range,
 			   unsigned long cur_seq);
+	void (*release)(struct mmu_interval_notifier *mni);
 };
=20
 struct mmu_interval_notifier {
@@ -246,6 +253,8 @@ struct mmu_interval_notifier {
 	struct mm_struct *mm;
 	struct hlist_node deferred_item;
 	unsigned long invalidate_seq;
+	unsigned long deferred_start;
+	unsigned long deferred_last;
 };
=20
 #ifdef CONFIG_MMU_NOTIFIER
@@ -299,7 +308,13 @@ int mmu_interval_notifier_insert_locked(
 	struct mmu_interval_notifier *mni, struct mm_struct *mm,
 	unsigned long start, unsigned long length,
 	const struct mmu_interval_notifier_ops *ops);
+int mmu_interval_notifier_insert_safe(
+	struct mmu_interval_notifier *mni, struct mm_struct *mm,
+	unsigned long start, unsigned long length,
+	const struct mmu_interval_notifier_ops *ops);
 void mmu_interval_notifier_remove(struct mmu_interval_notifier *mni);
+int mmu_interval_notifier_update(struct mmu_interval_notifier *mni,
+				 unsigned long start, unsigned long length);
=20
 /**
  * mmu_interval_set_seq - Save the invalidation sequence
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index f76ea05b1cb0..c303285750b2 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -129,6 +129,7 @@ static void mn_itree_inv_end(struct mmu_notifier_mm *mm=
n_mm)
 {
 	struct mmu_interval_notifier *mni;
 	struct hlist_node *next;
+	struct hlist_head removed_list;
=20
 	spin_lock(&mmn_mm->lock);
 	if (--mmn_mm->active_invalidate_ranges ||
@@ -144,21 +145,47 @@ static void mn_itree_inv_end(struct mmu_notifier_mm *=
mmn_mm)
 	 * The inv_end incorporates a deferred mechanism like rtnl_unlock().
 	 * Adds and removes are queued until the final inv_end happens then
 	 * they are progressed. This arrangement for tree updates is used to
-	 * avoid using a blocking lock during invalidate_range_start.
+	 * avoid using a blocking lock while walking the interval tree.
 	 */
+	INIT_HLIST_HEAD(&removed_list);
 	hlist_for_each_entry_safe(mni, next, &mmn_mm->deferred_list,
 				  deferred_item) {
+		hlist_del(&mni->deferred_item);
 		if (RB_EMPTY_NODE(&mni->interval_tree.rb))
 			interval_tree_insert(&mni->interval_tree,
 					     &mmn_mm->itree);
-		else
+		else {
 			interval_tree_remove(&mni->interval_tree,
 					     &mmn_mm->itree);
-		hlist_del(&mni->deferred_item);
+			if (mni->deferred_last) {
+				mni->interval_tree.start =3D mni->deferred_start;
+				mni->interval_tree.last =3D mni->deferred_last;
+				mni->deferred_last =3D 0;
+				interval_tree_insert(&mni->interval_tree,
+						     &mmn_mm->itree);
+			} else if (mni->ops->release)
+				hlist_add_head(&mni->deferred_item,
+					       &removed_list);
+		}
 	}
 	spin_unlock(&mmn_mm->lock);
=20
 	wake_up_all(&mmn_mm->wq);
+
+	/*
+	 * Interval notifiers with a release() operation expect a callback
+	 * instead of mmu_interval_notifier_remove() waiting for the
+	 * wake up above.
+	 */
+	hlist_for_each_entry_safe(mni, next, &removed_list, deferred_item) {
+		struct mm_struct *mm =3D mni->mm;
+
+		hlist_del(&mni->deferred_item);
+		mni->ops->release(mni);
+
+		/* pairs with mmgrab() in mmu_interval_notifier_insert() */
+		mmdrop(mm);
+	}
 }
=20
 /**
@@ -856,6 +883,7 @@ static int __mmu_interval_notifier_insert(
 	mni->ops =3D ops;
 	RB_CLEAR_NODE(&mni->interval_tree.rb);
 	mni->interval_tree.start =3D start;
+	mni->deferred_last =3D 0;
 	/*
 	 * Note that the representation of the intervals in the interval tree
 	 * considers the ending point as contained in the interval.
@@ -913,16 +941,17 @@ static int __mmu_interval_notifier_insert(
 /**
  * mmu_interval_notifier_insert - Insert an interval notifier
  * @mni: Interval notifier to register
+ * @mm : mm_struct to attach to
  * @start: Starting virtual address to monitor
  * @length: Length of the range to monitor
- * @mm : mm_struct to attach to
+ * @ops: Interval notifier callback operations
  *
  * This function subscribes the interval notifier for notifications from t=
he
- * mm.  Upon return the ops related to mmu_interval_notifier will be calle=
d
+ * mm.  Upon return, the ops related to mmu_interval_notifier will be call=
ed
  * whenever an event that intersects with the given range occurs.
  *
- * Upon return the range_notifier may not be present in the interval tree =
yet.
- * The caller must use the normal interval notifier read flow via
+ * Upon return, the mmu_interval_notifier may not be present in the interv=
al
+ * tree yet.  The caller must use the normal interval notifier read flow v=
ia
  * mmu_interval_read_begin() to establish SPTEs for this range.
  */
 int mmu_interval_notifier_insert(struct mmu_interval_notifier *mni,
@@ -970,14 +999,52 @@ int mmu_interval_notifier_insert_locked(
 EXPORT_SYMBOL_GPL(mmu_interval_notifier_insert_locked);
=20
 /**
- * mmu_interval_notifier_remove - Remove a interval notifier
- * @mni: Interval notifier to unregister
+ * mmu_interval_notifier_insert_safe - Insert an interval notifier
+ * @mni: Interval notifier to register
+ * @mm : mm_struct to attach to
+ * @start: Starting virtual address to monitor
+ * @length: Length of the range to monitor
+ * @ops: Interval notifier callback operations
  *
- * This function must be paired with mmu_interval_notifier_insert(). It ca=
nnot
- * be called from any ops callback.
+ * Return: -EINVAL if @mm hasn't been initialized for interval notifiers
+ *	by calling mmu_notifier_register(NULL, mm) or
+ *	__mmu_notifier_register(NULL, mm).
  *
- * Once this returns ops callbacks are no longer running on other CPUs and
- * will not be called in future.
+ * This function subscribes the interval notifier for notifications from t=
he
+ * mm.  Upon return, the ops related to mmu_interval_notifier will be call=
ed
+ * whenever an event that intersects with the given range occurs.
+ *
+ * This function is safe to call from the ops->invalidate() function.
+ * Upon return, the mmu_interval_notifier may not be present in the interv=
al
+ * tree yet.  The caller must use the normal interval notifier read flow v=
ia
+ * mmu_interval_read_begin() to establish SPTEs for this range.
+ */
+int mmu_interval_notifier_insert_safe(
+	struct mmu_interval_notifier *mni, struct mm_struct *mm,
+	unsigned long start, unsigned long length,
+	const struct mmu_interval_notifier_ops *ops)
+{
+	struct mmu_notifier_mm *mmn_mm;
+
+	mmn_mm =3D mm->mmu_notifier_mm;
+	if (!mmn_mm || !mmn_mm->has_itree)
+		return -EINVAL;
+	return __mmu_interval_notifier_insert(mni, mm, mmn_mm, start, length,
+					      ops);
+}
+EXPORT_SYMBOL_GPL(mmu_interval_notifier_insert_safe);
+
+/**
+ * mmu_interval_notifier_remove - Remove an interval notifier
+ * @mni: Interval notifier to unregister
+ *
+ * This function must be paired with mmu_interval_notifier_insert().
+ * If a mmu_interval_notifier_ops.release() function is defined,
+ * mmu_interval_notifier_remove() is safe to call from the invalidate()
+ * callback and the release() function will be called once all CPUs
+ * are finished using the notifier. Otherwise, mmu_interval_notifier_remov=
e()
+ * cannot be called from any ops callback and will block waiting for
+ * invalidation callbacks to finish before returning.
  */
 void mmu_interval_notifier_remove(struct mmu_interval_notifier *mni)
 {
@@ -996,8 +1063,11 @@ void mmu_interval_notifier_remove(struct mmu_interval=
_notifier *mni)
 		if (RB_EMPTY_NODE(&mni->interval_tree.rb)) {
 			hlist_del(&mni->deferred_item);
 		} else {
-			hlist_add_head(&mni->deferred_item,
-				       &mmn_mm->deferred_list);
+			if (mni->deferred_last)
+				mni->deferred_last =3D 0;
+			else
+				hlist_add_head(&mni->deferred_item,
+					       &mmn_mm->deferred_list);
 			seq =3D mmn_mm->invalidate_seq;
 		}
 	} else {
@@ -1006,20 +1076,96 @@ void mmu_interval_notifier_remove(struct mmu_interv=
al_notifier *mni)
 	}
 	spin_unlock(&mmn_mm->lock);
=20
-	/*
-	 * The possible sleep on progress in the invalidation requires the
-	 * caller not hold any locks held by invalidation callbacks.
-	 */
-	lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
-	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
-	if (seq)
+	if (mni->ops->release) {
+		if (!seq) {
+			mni->ops->release(mni);
+
+			/*
+			 * Pairs with mmgrab() in
+			 * mmu_interval_notifier_insert().
+			 */
+			mmdrop(mm);
+		}
+	} else {
+		/*
+		 * The possible sleep on progress in the invalidation requires
+		 * the caller not hold any locks held by invalidation
+		 * callbacks.
+		 */
+		lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
+		lock_map_release(&__mmu_notifier_invalidate_range_start_map);
+		if (seq)
+			wait_event(mmn_mm->wq,
+				   READ_ONCE(mmn_mm->invalidate_seq) !=3D seq);
+
+		/* pairs with mmgrab in mmu_interval_notifier_insert() */
+		mmdrop(mm);
+	}
+}
+EXPORT_SYMBOL_GPL(mmu_interval_notifier_remove);
+
+/**
+ * mmu_interval_notifier_update - Update interval notifier end
+ * @mni: Interval notifier to update
+ * @start: New starting virtual address to monitor
+ * @length: New length of the range to monitor
+ *
+ * This function updates the range being monitored.
+ * If there is no release() function defined, the call will wait for the
+ * update to finish before returning.
+ */
+int mmu_interval_notifier_update(struct mmu_interval_notifier *mni,
+				 unsigned long start, unsigned long length)
+{
+	struct mm_struct *mm =3D mni->mm;
+	struct mmu_notifier_mm *mmn_mm =3D mm->mmu_notifier_mm;
+	unsigned long seq =3D 0;
+	unsigned long last;
+
+	if (length =3D=3D 0 || check_add_overflow(start, length - 1, &last))
+		return -EOVERFLOW;
+
+	spin_lock(&mmn_mm->lock);
+	if (mn_itree_is_invalidating(mmn_mm)) {
+		/*
+		 * Update is being called after insert put this on the
+		 * deferred list, but before the deferred list was processed.
+		 */
+		if (RB_EMPTY_NODE(&mni->interval_tree.rb)) {
+			mni->interval_tree.start =3D start;
+			mni->interval_tree.last =3D last;
+		} else {
+			if (!mni->deferred_last)
+				hlist_add_head(&mni->deferred_item,
+					       &mmn_mm->deferred_list);
+			mni->deferred_start =3D start;
+			mni->deferred_last =3D last;
+		}
+		seq =3D mmn_mm->invalidate_seq;
+	} else {
+		WARN_ON(RB_EMPTY_NODE(&mni->interval_tree.rb));
+		interval_tree_remove(&mni->interval_tree, &mmn_mm->itree);
+		mni->interval_tree.start =3D start;
+		mni->interval_tree.last =3D last;
+		interval_tree_insert(&mni->interval_tree, &mmn_mm->itree);
+	}
+	spin_unlock(&mmn_mm->lock);
+
+	if (!mni->ops->release && seq) {
+		/*
+		 * The possible sleep on progress in the invalidation requires
+		 * the caller not hold any locks held by invalidation
+		 * callbacks.
+		 */
+		lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
+		lock_map_release(&__mmu_notifier_invalidate_range_start_map);
 		wait_event(mmn_mm->wq,
 			   READ_ONCE(mmn_mm->invalidate_seq) !=3D seq);
+	}
=20
-	/* pairs with mmgrab in mmu_interval_notifier_insert() */
-	mmdrop(mm);
+	return 0;
 }
-EXPORT_SYMBOL_GPL(mmu_interval_notifier_remove);
+EXPORT_SYMBOL_GPL(mmu_interval_notifier_update);
=20
 /**
  * mmu_notifier_synchronize - Ensure all mmu_notifiers are freed
--=20
2.20.1

