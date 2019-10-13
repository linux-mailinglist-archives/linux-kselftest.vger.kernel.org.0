Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75652D537C
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Oct 2019 02:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfJMAai (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Oct 2019 20:30:38 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:53079 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728821AbfJMAai (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Oct 2019 20:30:38 -0400
Received: by mail-pl1-f202.google.com with SMTP id y2so8173207plk.19
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Oct 2019 17:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DNmFl79SZe74kl3sGGlwsB9W8EFU1e3Qwq2m7y71jZQ=;
        b=rsKto33XZsfu8ildwaPOw/0gg0MyCumRNSgfg8agZCrCKwhrpbfgbXArysBvCH8RWJ
         S4w3ty1cdw6yfoQVfhoI5mfaA5G9DzgwPcr9E/cwyhWdVMkiNzN2JBCl9Ncxgs4sIef5
         IGt3fDk0URExoSiC9lsxi4TedA7aUvd+8NcrwRdhTj8wTCCiWuwh+tmqyx+TcRUskei+
         xaY3FZJ8djFEVaJdhPVWNg1M0LFZ7biEYdYIIjMoNuqpq0R+K9ml29534Yq6SpHFmAXG
         aqJvkvaLKEYSKDLoIriRYvLwV5CjEoKvtCtzqr9AFbsr0Y+CbLUS0gOUeapbBF44ZQVJ
         DUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DNmFl79SZe74kl3sGGlwsB9W8EFU1e3Qwq2m7y71jZQ=;
        b=qOxscM1+4vFLvbdNH4o48kQs/vg3CWhKJOsR6A+GlXE58SgnaUIb0ojN6sQyB1U82h
         6kYYLxbvJcIVv+6eDPl9qMWiw9+J9OwlR4cmGOlutsiX4QmC8Yq2uc114bRqt1YmsFJd
         /s7LR0J+aFCoUfdKrwT8A5tIaAIRPMRs2G9bHDjNIs6FVA5qFmSBNNdg5tr10WfdKnMp
         1NsV7IsBvoldcv1pxIVaeEPdpEocpVOvcwUwSjHDzT++aT+01C1+XvKLLpzb0VVEFk5d
         ZTjPEkOdzhg5SyMkBpfsBvJb0LG0fBc8j08cKDY74fjsDiMmd23aIPNxb3z/b2fISrlf
         1xoA==
X-Gm-Message-State: APjAAAWIDh8jLgszEPx5JyKv3dY/q3L7wE/TjAtKMhR+SZ8p+rTqOyxG
        kJUWK9GKjQJ1YQ0VxJ3uJ1WTf82brBZZSc291Q==
X-Google-Smtp-Source: APXvYqzS97v+e+/yu8NhhsB/OmnV+/MyJiVaOD2YZq9TyA0TrmZpPjq6jNDN1fAoDHa84UmAfAPlVJ7aYfqryc/aBg==
X-Received: by 2002:a63:1b10:: with SMTP id b16mr5141195pgb.235.1570926636855;
 Sat, 12 Oct 2019 17:30:36 -0700 (PDT)
Date:   Sat, 12 Oct 2019 17:30:19 -0700
In-Reply-To: <20191013003024.215429-1-almasrymina@google.com>
Message-Id: <20191013003024.215429-4-almasrymina@google.com>
Mime-Version: 1.0
References: <20191013003024.215429-1-almasrymina@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH v6 4/9] hugetlb_cgroup: add reservation accounting for private mappings
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com,
        mkoutny@suse.com, Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Normally the pointer to the cgroup to uncharge hangs off the struct
page, and gets queried when it's time to free the page. With
hugetlb_cgroup reservations, this is not possible. Because it's possible
for a page to be reserved by one task and actually faulted in by another
task.

The best place to put the hugetlb_cgroup pointer to uncharge for
reservations is in the resv_map. But, because the resv_map has different
semantics for private and shared mappings, the code patch to
charge/uncharge shared and private mappings is different. This patch
implements charging and uncharging for private mappings.

For private mappings, the counter to uncharge is in
resv_map->reservation_counter. On initializing the resv_map this is set
to NULL. On reservation of a region in private mapping, the tasks
hugetlb_cgroup is charged and the hugetlb_cgroup is placed is
resv_map->reservation_counter.

On hugetlb_vm_op_close, we uncharge resv_map->reservation_counter.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Hillf Danton <hdanton@sina.com>

---
 include/linux/hugetlb.h        |  8 +++++++
 include/linux/hugetlb_cgroup.h | 11 +++++++++
 mm/hugetlb.c                   | 44 +++++++++++++++++++++++++++++++++-
 mm/hugetlb_cgroup.c            | 12 ----------
 4 files changed, 62 insertions(+), 13 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 9c49a0ba894d3..36dcda7be4b0e 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -46,6 +46,14 @@ struct resv_map {
 	long adds_in_progress;
 	struct list_head region_cache;
 	long region_cache_count;
+#ifdef CONFIG_CGROUP_HUGETLB
+	/*
+	 * On private mappings, the counter to uncharge reservations is stored
+	 * here. If these fields are 0, then the mapping is shared.
+	 */
+	struct page_counter *reservation_counter;
+	unsigned long pages_per_hpage;
+#endif
 };
 extern struct resv_map *resv_map_alloc(void);
 void resv_map_release(struct kref *ref);
diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index 1bb58a63af586..f6e3d74a02536 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -25,6 +25,17 @@ struct hugetlb_cgroup;
 #define HUGETLB_CGROUP_MIN_ORDER 3

 #ifdef CONFIG_CGROUP_HUGETLB
+struct hugetlb_cgroup {
+	struct cgroup_subsys_state css;
+	/*
+	 * the counter to account for hugepages from hugetlb.
+	 */
+	struct page_counter hugepage[HUGE_MAX_HSTATE];
+	/*
+	 * the counter to account for hugepage reservations from hugetlb.
+	 */
+	struct page_counter reserved_hugepage[HUGE_MAX_HSTATE];
+};

 static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page,
 							      bool reserved)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 324859170463b..4a60d7d44b4c3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -665,6 +665,16 @@ struct resv_map *resv_map_alloc(void)
 	INIT_LIST_HEAD(&resv_map->regions);

 	resv_map->adds_in_progress = 0;
+#ifdef CONFIG_CGROUP_HUGETLB
+	/*
+	 * Initialize these to 0. On shared mappings, 0's here indicate these
+	 * fields don't do cgroup accounting. On private mappings, these will be
+	 * re-initialized to the proper values, to indicate that hugetlb cgroup
+	 * reservations are to be un-charged from here.
+	 */
+	resv_map->reservation_counter = NULL;
+	resv_map->pages_per_hpage = 0;
+#endif

 	INIT_LIST_HEAD(&resv_map->region_cache);
 	list_add(&rg->link, &resv_map->region_cache);
@@ -3217,7 +3227,18 @@ static void hugetlb_vm_op_close(struct vm_area_struct *vma)

 	reserve = (end - start) - region_count(resv, start, end);

-	kref_put(&resv->refs, resv_map_release);
+#ifdef CONFIG_CGROUP_HUGETLB
+	/*
+	 * Since we check for HPAGE_RESV_OWNER above, this must a private
+	 * mapping, and these values should be none-zero, and should point to
+	 * the hugetlb_cgroup counter to uncharge for this reservation.
+	 */
+	WARN_ON(!resv->reservation_counter);
+	WARN_ON(!resv->pages_per_hpage);
+
+	hugetlb_cgroup_uncharge_counter(resv->reservation_counter,
+					(end - start) * resv->pages_per_hpage);
+#endif

 	if (reserve) {
 		/*
@@ -3227,6 +3248,8 @@ static void hugetlb_vm_op_close(struct vm_area_struct *vma)
 		gbl_reserve = hugepage_subpool_put_pages(spool, reserve);
 		hugetlb_acct_memory(h, -gbl_reserve);
 	}
+
+	kref_put(&resv->refs, resv_map_release);
 }

 static int hugetlb_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
@@ -4560,6 +4583,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	struct hstate *h = hstate_inode(inode);
 	struct hugepage_subpool *spool = subpool_inode(inode);
 	struct resv_map *resv_map;
+	struct hugetlb_cgroup *h_cg;
 	long gbl_reserve;

 	/* This should never happen */
@@ -4593,12 +4617,30 @@ int hugetlb_reserve_pages(struct inode *inode,
 		chg = region_chg(resv_map, from, to);

 	} else {
+		/* Private mapping. */
 		resv_map = resv_map_alloc();
 		if (!resv_map)
 			return -ENOMEM;

 		chg = to - from;

+		if (hugetlb_cgroup_charge_cgroup(hstate_index(h),
+						 chg * pages_per_huge_page(h),
+						 &h_cg, true)) {
+			kref_put(&resv_map->refs, resv_map_release);
+			return -ENOMEM;
+		}
+
+#ifdef CONFIG_CGROUP_HUGETLB
+		/*
+		 * Since this branch handles private mappings, we attach the
+		 * counter to uncharge for this reservation off resv_map.
+		 */
+		resv_map->reservation_counter =
+			&h_cg->reserved_hugepage[hstate_index(h)];
+		resv_map->pages_per_hpage = pages_per_huge_page(h);
+#endif
+
 		set_vma_resv_map(vma, resv_map);
 		set_vma_resv_flags(vma, HPAGE_RESV_OWNER);
 	}
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index ac1500205faf7..a0ca4024888e1 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -19,18 +19,6 @@
 #include <linux/hugetlb.h>
 #include <linux/hugetlb_cgroup.h>

-struct hugetlb_cgroup {
-	struct cgroup_subsys_state css;
-	/*
-	 * the counter to account for hugepages from hugetlb.
-	 */
-	struct page_counter hugepage[HUGE_MAX_HSTATE];
-	/*
-	 * the counter to account for hugepage reservations from hugetlb.
-	 */
-	struct page_counter reserved_hugepage[HUGE_MAX_HSTATE];
-};
-
 #define MEMFILE_PRIVATE(x, val)	(((x) << 16) | (val))
 #define MEMFILE_IDX(val)	(((val) >> 16) & 0xffff)
 #define MEMFILE_ATTR(val)	((val) & 0xffff)
--
2.23.0.700.g56cf767bdb-goog
