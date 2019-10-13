Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD9FD5382
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Oct 2019 02:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbfJMAaq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Oct 2019 20:30:46 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:33604 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbfJMAap (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Oct 2019 20:30:45 -0400
Received: by mail-pg1-f201.google.com with SMTP id f10so9897496pgj.0
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Oct 2019 17:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xekgIg4dN3m1HVyQSgfrAu003H3IqqF6Q7QAQZd3RT0=;
        b=aQR29j5FYNJohLbfcXRNwkGUhbOnF+f07QgP1hMkNy7kiKn1f5mnO8EVdG7aw01ly5
         TtSY91Przz2c/ZSOK8uEKQiaIgFMSiIpENtHoQuJxMWLTgn4tGCqj+65kukDeTvuPZ+6
         e0aIFU+zJxpx8cSGSTanyam9LjcbAm5+M063GirvgsUNTDcfagTWeRYCTtHzVqnwLLM7
         69ewHkcoHtOzQ0btNWcjLRJURH9G3Y0Bhzo7A+/nE7v0y300AxR4DbiKcLJHGloN4RHm
         ctuwoCBT++gTQxKoneYGym6bnDCYtc6ZwSEYHmKmL+Fa0JZy8Lz3Qh4pnmBaTp7cQ0RP
         3+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xekgIg4dN3m1HVyQSgfrAu003H3IqqF6Q7QAQZd3RT0=;
        b=j4CNlsw2qw8/BafJAqr8OptSCuhfMq+2VZ7z5qDA/aUvf8RaaHoe+SPzpLXBBjcwCU
         btAatuGiCzhqkl2FqQl06uZrQrK5ktQ6g03vdYlDlhbe8SHMPR7HoLWaDSMbFtmHNTbD
         kvA408gKcEcEJ/+yW94fp+UGhORSXSDXZQL7oXV5xTJMgt+3Kmcm2SjdsGAOZ8UYDgCK
         f3kxmUjbm+kZp0dOzWlkMs4dw//p6FP7L4qk0t/UygE4+xgagbCQrCH+3P6NgPHXwjZC
         uD4dfeovD9Uxjd5gzslKjHUBBBRVQ8h1QVy0HuABRrEKoF+u1BM95j+hI7+a6BUdCshZ
         16Cw==
X-Gm-Message-State: APjAAAWGssCej/rKNj6Xuuu1AmN+Wek96TBvKzdWrgJYVnIx+TJBdR2T
        xsVouqZiWjVOygpCpMJfDJRKUFES46KJErpUsw==
X-Google-Smtp-Source: APXvYqwO1B/rBxyR8P/t+7Sb94rTCepgrVxZzgfjaNGhv1GAZuM8kwDVsFDuBpAPLFO8daUod0KAKRyTnJXMKu9s9g==
X-Received: by 2002:a63:e853:: with SMTP id a19mr24813620pgk.192.1570926644257;
 Sat, 12 Oct 2019 17:30:44 -0700 (PDT)
Date:   Sat, 12 Oct 2019 17:30:22 -0700
In-Reply-To: <20191013003024.215429-1-almasrymina@google.com>
Message-Id: <20191013003024.215429-7-almasrymina@google.com>
Mime-Version: 1.0
References: <20191013003024.215429-1-almasrymina@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH v6 7/9] hugetlb_cgroup: support noreserve mappings
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com,
        mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Support MAP_NORESERVE accounting as part of the new counter.

For each hugepage allocation, at allocation time we check if there is
a reservation for this allocation or not. If there is a reservation for
this allocation, then this allocation was charged at reservation time,
and we don't re-account it. If there is no reserevation for this
allocation, we charge the appropriate hugetlb_cgroup.

The hugetlb_cgroup to uncharge for this allocation is stored in
page[3].private. We use new APIs added in an earlier patch to set this
pointer.

---
 mm/hugetlb.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index af336bf227fb6..79b99878ce6f9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1217,6 +1217,7 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 				1 << PG_writeback);
 	}
 	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page, false), page);
+	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page, true), page);
 	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
 	set_page_refcounted(page);
 	if (hstate_is_gigantic(h)) {
@@ -1328,6 +1329,9 @@ void free_huge_page(struct page *page)
 	clear_page_huge_active(page);
 	hugetlb_cgroup_uncharge_page(hstate_index(h), pages_per_huge_page(h),
 				     page, false);
+	hugetlb_cgroup_uncharge_page(hstate_index(h), pages_per_huge_page(h),
+				     page, true);
+
 	if (restore_reserve)
 		h->resv_huge_pages++;

@@ -1354,6 +1358,7 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
 	spin_lock(&hugetlb_lock);
 	set_hugetlb_cgroup(page, NULL, false);
+	set_hugetlb_cgroup(page, NULL, true);
 	h->nr_huge_pages++;
 	h->nr_huge_pages_node[nid]++;
 	spin_unlock(&hugetlb_lock);
@@ -2155,10 +2160,19 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 			gbl_chg = 1;
 	}

+	/* If this allocation is not consuming a reservation, charge it now.
+	 */
+	if (map_chg || avoid_reserve || !vma_resv_map(vma)) {
+		ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h),
+						   &h_cg, true);
+		if (ret)
+			goto out_subpool_put;
+	}
+
 	ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h), &h_cg,
 					   false);
 	if (ret)
-		goto out_subpool_put;
+		goto out_uncharge_cgroup_reservation;

 	spin_lock(&hugetlb_lock);
 	/*
@@ -2182,6 +2196,11 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	}
 	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page,
 				     false);
+	if (!vma_resv_map(vma) || map_chg || avoid_reserve) {
+		hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg,
+					     page, true);
+	}
+
 	spin_unlock(&hugetlb_lock);

 	set_page_private(page, (unsigned long)spool);
@@ -2207,6 +2226,10 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 out_uncharge_cgroup:
 	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg,
 				       false);
+out_uncharge_cgroup_reservation:
+	if (map_chg || avoid_reserve || !vma_resv_map(vma))
+		hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h),
+					       h_cg, true);
 out_subpool_put:
 	if (map_chg || avoid_reserve)
 		hugepage_subpool_put_pages(spool, 1);
--
2.23.0.700.g56cf767bdb-goog
