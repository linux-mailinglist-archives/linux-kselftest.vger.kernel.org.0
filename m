Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E19D139CD7
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2020 23:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgAMWrP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jan 2020 17:47:15 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8371 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728994AbgAMWrP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jan 2020 17:47:15 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1cf35d0000>; Mon, 13 Jan 2020 14:46:53 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 13 Jan 2020 14:47:13 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 13 Jan 2020 14:47:13 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Jan
 2020 22:47:10 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 13 Jan 2020 22:47:10 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e1cf36e0000>; Mon, 13 Jan 2020 14:47:10 -0800
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
        <linux-kselftest@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH v6 2/6] mm/mmu_notifier: add mmu_interval_notifier_put()
Date:   Mon, 13 Jan 2020 14:46:59 -0800
Message-ID: <20200113224703.5917-3-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200113224703.5917-1-rcampbell@nvidia.com>
References: <20200113224703.5917-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578955614; bh=SFOHAESIv9tXjesCFOs4ndM/OwOZqhr4ej7VPHTD1e4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=dqY0jK7e8sxIFDIAcf8rRj7kcgBLXqVMIUAEvSaIz0mg7UItoNwrSqEWxTfs274AO
         LeS/Ug1yElj2TO7ygasIoV8XEmDl6qUeYz0MY4ll8VJOU0Rmudafx6myR7LlDP31X3
         nN90TdfTBD3J7xWHe7qnQibmd11+FQiUoiBdN9Vrl56/09I+rFjtxR/m8qpS4VBOqh
         hFZz5KioalPlWoDz7j+xqVdL2DIVxLFROKatzcE5rk0ixo0pa0wzeAjSt4dI186xVD
         1RcwKHgqTfLvRF6tOP/sf6w+bP7mqGDDVImapU61NV01+NXd+MpBpxBKXt8tDi94VX
         oMtSRAYRX+1UQ==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

mmu_interval_notifier_remove() can't be called safely from inside the
invalidate() callback because it sleeps waiting for invalidate callbacks
to finish. Removals might be needed when the invalidate() callback is
for munmap() (i.e., the event type MMU_NOTIFY_UNMAP), and the interval
being tracked is no longer needed.

Add a new function mmu_interval_notifier_put() which is safe to call from
the invalidate() callback. The ops->release() function will be called when
all callbacks are finished and no CPUs are accessing the
mmu_interval_notifier.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 include/linux/mmu_notifier.h |  6 +++
 mm/mmu_notifier.c            | 86 ++++++++++++++++++++++++++++--------
 2 files changed, 74 insertions(+), 18 deletions(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 027c9c8f3a69..6dcaa632eef7 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -233,11 +233,16 @@ struct mmu_notifier {
  * @invalidate: Upon return the caller must stop using any SPTEs within th=
is
  *              range. This function can sleep. Return false only if sleep=
ing
  *              was required but mmu_notifier_range_blockable(range) is fa=
lse.
+ * @release:	This function should be defined when using
+ *		mmu_interval_notifier_put(). It will be called when the
+ *		mmu_interval_notifier is removed from the interval tree.
+ *		No other callbacks will be generated after this returns.
  */
 struct mmu_interval_notifier_ops {
 	bool (*invalidate)(struct mmu_interval_notifier *mni,
 			   const struct mmu_notifier_range *range,
 			   unsigned long cur_seq);
+	void (*release)(struct mmu_interval_notifier *mni);
 };
=20
 struct mmu_interval_notifier {
@@ -304,6 +309,7 @@ int mmu_interval_notifier_insert_safe(
 	unsigned long start, unsigned long length,
 	const struct mmu_interval_notifier_ops *ops);
 void mmu_interval_notifier_remove(struct mmu_interval_notifier *mni);
+void mmu_interval_notifier_put(struct mmu_interval_notifier *mni);
=20
 /**
  * mmu_interval_set_seq - Save the invalidation sequence
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index a5ff19cd1bc5..40c837ae8d90 100644
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
@@ -144,20 +145,35 @@ static void mn_itree_inv_end(struct mmu_notifier_mm *=
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
+			if (mni->ops->release)
+				hlist_add_head(&mni->deferred_item,
+					       &removed_list);
+		}
 	}
 	spin_unlock(&mmn_mm->lock);
=20
+	hlist_for_each_entry_safe(mni, next, &removed_list, deferred_item) {
+		struct mm_struct *mm =3D mni->mm;
+
+		hlist_del(&mni->deferred_item);
+		mni->ops->release(mni);
+
+		/* pairs with mmgrab() in __mmu_interval_notifier_insert() */
+		mmdrop(mm);
+	}
+
 	wake_up_all(&mmn_mm->wq);
 }
=20
@@ -1006,24 +1022,13 @@ int mmu_interval_notifier_insert_safe(
 }
 EXPORT_SYMBOL_GPL(mmu_interval_notifier_insert_safe);
=20
-/**
- * mmu_interval_notifier_remove - Remove a interval notifier
- * @mni: Interval notifier to unregister
- *
- * This function must be paired with mmu_interval_notifier_insert(). It ca=
nnot
- * be called from any ops callback.
- *
- * Once this returns ops callbacks are no longer running on other CPUs and
- * will not be called in future.
- */
-void mmu_interval_notifier_remove(struct mmu_interval_notifier *mni)
+static unsigned long __mmu_interval_notifier_put(
+					struct mmu_interval_notifier *mni)
 {
 	struct mm_struct *mm =3D mni->mm;
 	struct mmu_notifier_mm *mmn_mm =3D mm->mmu_notifier_mm;
 	unsigned long seq =3D 0;
=20
-	might_sleep();
-
 	spin_lock(&mmn_mm->lock);
 	if (mn_itree_is_invalidating(mmn_mm)) {
 		/*
@@ -1043,6 +1048,28 @@ void mmu_interval_notifier_remove(struct mmu_interva=
l_notifier *mni)
 	}
 	spin_unlock(&mmn_mm->lock);
=20
+	return seq;
+}
+
+/**
+ * mmu_interval_notifier_remove - Remove an interval notifier
+ * @mni: Interval notifier to unregister
+ *
+ * This function must be paired with one of the mmu_interval_notifier_inse=
rt()
+ * functions. It cannot be called from any ops callback.
+ * Once this returns, ops callbacks are no longer running on other CPUs an=
d
+ * will not be called in future.
+ */
+void mmu_interval_notifier_remove(struct mmu_interval_notifier *mni)
+{
+	struct mm_struct *mm =3D mni->mm;
+	struct mmu_notifier_mm *mmn_mm =3D mm->mmu_notifier_mm;
+	unsigned long seq;
+
+	might_sleep();
+
+	seq =3D __mmu_interval_notifier_put(mni);
+
 	/*
 	 * The possible sleep on progress in the invalidation requires the
 	 * caller not hold any locks held by invalidation callbacks.
@@ -1053,11 +1080,34 @@ void mmu_interval_notifier_remove(struct mmu_interv=
al_notifier *mni)
 		wait_event(mmn_mm->wq,
 			   READ_ONCE(mmn_mm->invalidate_seq) !=3D seq);
=20
-	/* pairs with mmgrab in mmu_interval_notifier_insert() */
-	mmdrop(mm);
+	/* pairs with mmgrab() in __mmu_interval_notifier_insert() */
+	if (!mni->ops->release)
+		mmdrop(mm);
 }
 EXPORT_SYMBOL_GPL(mmu_interval_notifier_remove);
=20
+/**
+ * mmu_interval_notifier_put - Unregister an interval notifier
+ * @mni: Interval notifier to unregister
+ *
+ * This function must be paired with one of the mmu_interval_notifier_inse=
rt()
+ * functions. It is safe to call from the invalidate() callback.
+ * Once this returns, ops callbacks may still be running on other CPUs and
+ * the release() callback will be called when they finish.
+ */
+void mmu_interval_notifier_put(struct mmu_interval_notifier *mni)
+{
+	struct mm_struct *mm =3D mni->mm;
+
+	if (!__mmu_interval_notifier_put(mni)) {
+		mni->ops->release(mni);
+
+		/* pairs with mmgrab() in __mmu_interval_notifier_insert() */
+		mmdrop(mm);
+	}
+}
+EXPORT_SYMBOL_GPL(mmu_interval_notifier_put);
+
 /**
  * mmu_notifier_synchronize - Ensure all mmu_notifiers are freed
  *
--=20
2.20.1

