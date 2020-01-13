Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEC0A139CC7
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2020 23:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgAMWrP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jan 2020 17:47:15 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:16374 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgAMWrO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jan 2020 17:47:14 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1cf33b0001>; Mon, 13 Jan 2020 14:46:19 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 Jan 2020 14:47:13 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 Jan 2020 14:47:13 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Jan
 2020 22:47:13 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Jan
 2020 22:47:12 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 13 Jan 2020 22:47:11 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e1cf36f0000>; Mon, 13 Jan 2020 14:47:11 -0800
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
Subject: [PATCH v6 4/6] mm/mmu_notifier: add mmu_interval_notifier_find()
Date:   Mon, 13 Jan 2020 14:47:01 -0800
Message-ID: <20200113224703.5917-5-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200113224703.5917-1-rcampbell@nvidia.com>
References: <20200113224703.5917-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578955579; bh=4zTuXc0CKU6YrnV6uf1EmOy7Oy/UdZiLxLw4iGtjyrQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=fd++jT+OQXFtmpIHOl28C4037Q8VrPBBYOvqiQTwadzERzw4EKdg+nAz+mC4N9LM4
         lrFeMU4uXG/szra8U6tiXaQkOOko/3Smh75yv6UxW9uwOV/b4PgL6zFSknd+NKIGnK
         8d97NTOlQtzf2P5fjm+wao0+3Twclmttc7SipQeFpg5sZH41rmCsNqn+3bqHkY+Ncj
         DmlOdaMcwa+2FEjXlqYtPD1M6+db3wwZRHdWtnskgBneyaz2rDhRevnVxIG8RlZVyF
         qJLTpWYS+0oH8RiNBl+JJ4EEgWLrZsq5T/a8/Cb+YBbnKEErt4W9MlJNcZN/hBufig
         tWwfAygjWiYGw==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Device drivers may or may not have a convenient range based data structure
to look up and find intervals that are registered with the mmu interval
notifiers. Rather than forcing drivers to duplicate the interval tree,
provide an API to look up intervals that are registered and accessor
functions to return the start and last address of the interval.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 include/linux/mmu_notifier.h | 15 +++++++++++++++
 mm/mmu_notifier.c            | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 0ce59b4f22c2..cdbbad13b278 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -314,6 +314,21 @@ void mmu_interval_notifier_remove(struct mmu_interval_=
notifier *mni);
 void mmu_interval_notifier_put(struct mmu_interval_notifier *mni);
 void mmu_interval_notifier_update(struct mmu_interval_notifier *mni,
 				  unsigned long start, unsigned long last);
+struct mmu_interval_notifier *mmu_interval_notifier_find(struct mm_struct =
*mm,
+				const struct mmu_interval_notifier_ops *ops,
+				unsigned long start, unsigned long last);
+
+static inline unsigned long mmu_interval_notifier_start(
+				struct mmu_interval_notifier *mni)
+{
+	return mni->interval_tree.start;
+}
+
+static inline unsigned long mmu_interval_notifier_last(
+				struct mmu_interval_notifier *mni)
+{
+	return mni->interval_tree.last;
+}
=20
 /**
  * mmu_interval_set_seq - Save the invalidation sequence
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 47ad9cc89aab..4efecc0f13cb 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -1171,6 +1171,39 @@ void mmu_interval_notifier_update(struct mmu_interva=
l_notifier *mni,
 }
 EXPORT_SYMBOL_GPL(mmu_interval_notifier_update);
=20
+struct mmu_interval_notifier *mmu_interval_notifier_find(struct mm_struct =
*mm,
+				const struct mmu_interval_notifier_ops *ops,
+				unsigned long start, unsigned long last)
+{
+	struct mmu_notifier_mm *mmn_mm =3D mm->mmu_notifier_mm;
+	struct interval_tree_node *node;
+	struct mmu_interval_notifier *mni;
+	struct mmu_interval_notifier *res =3D NULL;
+
+	spin_lock(&mmn_mm->lock);
+	node =3D interval_tree_iter_first(&mmn_mm->itree, start, last);
+	if (node) {
+		mni =3D container_of(node, struct mmu_interval_notifier,
+				   interval_tree);
+		while (true) {
+			if (mni->ops =3D=3D ops) {
+				res =3D mni;
+				break;
+			}
+			node =3D interval_tree_iter_next(&mni->interval_tree,
+						       start, last);
+			if (!node)
+				break;
+			mni =3D container_of(node, struct mmu_interval_notifier,
+					   interval_tree);
+		}
+	}
+	spin_unlock(&mmn_mm->lock);
+
+	return res;
+}
+EXPORT_SYMBOL_GPL(mmu_interval_notifier_find);
+
 /**
  * mmu_notifier_synchronize - Ensure all mmu_notifiers are freed
  *
--=20
2.20.1

