Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8C79123AAA
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2019 00:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfLQXQq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Dec 2019 18:16:46 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:39854 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfLQXQc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Dec 2019 18:16:32 -0500
Received: by mail-pl1-f202.google.com with SMTP id p11so51218plo.6
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Dec 2019 15:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LHDNmvrc03db/XEfSOqoyXXNGP5IsSpxrj4BzR3DnFo=;
        b=P7ONF3bSi1FcEgzi06X5WCLKiiqJSe8dB1TLNvBuQJUGgAxF/cTHl3USj8SWYkK7CU
         RiIULrsrZzRQocm+xiOsv+X+B350gtTIq6mHJXIAu2pu2yV3cC7lM7t0ngoOfhrX2odq
         vWzPlPPWzONXKqSbb5wAFSrWehqaQtf9ElhAzgNItRhaqkPSRoXARql+KU4mQxqUjAYH
         9flccmhgzpS613FCmu2ORYmtPsopWY13qVTTdlB5eItp8bQP9nfWoTEkstg0SEa+QqVT
         uRsku5nKBqGAbBT17asr8gYJDMAQhFvIIwA1p5Kjm77M4EqP/2TNYvxEsvMVpNjg1w/m
         trXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LHDNmvrc03db/XEfSOqoyXXNGP5IsSpxrj4BzR3DnFo=;
        b=BuSeuWTMDoKwjA8NUr98FSGDe93NA+UNHrZrl6SyHVQH13T7VqDA6hEbIwNQdTJTmz
         rDGxi4TlUeZURRtGC5tZj6gxWlI1/DC78ZZHUs+gagW+4PXmd/3yfayNUFhZ33qhHY+Z
         FN95Dmty7b7879pWbtfraaoEuBaZdPcOV4hhHvl1/q/mis3dd3Bj62G3j4P3bz+mI+d8
         qMr4MBad9UJSKnwoSuv8BlfLgwiKFgAq5Jslbvv0hbjbWX6+cyl8JhOEDY4H6ZGjjFIk
         z75VR9Pjscu4aWwzjLPnC+noe/ATY5iZpR/yIPFZ6g8gCtmZas4Q5+7BnSjX4NzeQB9O
         684A==
X-Gm-Message-State: APjAAAXcJ83d2lo7NBjFPGBvk5MsUfhdJ1TS8yNNOfC/+X11nciO6M3D
        mVKH823M6EwDFOsXM6Ptz0DyoOO9KKVuxjCIyg==
X-Google-Smtp-Source: APXvYqzQi/hTceVwH7B1vYFKo1hz5bRcGyNSFOmySOjm1oxr360S5O4JugN1EbS/KgVOxO0UVcreeR63ykX4ksyJag==
X-Received: by 2002:a63:646:: with SMTP id 67mr435341pgg.150.1576624591531;
 Tue, 17 Dec 2019 15:16:31 -0800 (PST)
Date:   Tue, 17 Dec 2019 15:16:13 -0800
In-Reply-To: <20191217231615.164161-1-almasrymina@google.com>
Message-Id: <20191217231615.164161-6-almasrymina@google.com>
Mime-Version: 1.0
References: <20191217231615.164161-1-almasrymina@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v9 6/8] hugetlb_cgroup: support noreserve mappings
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com, mkoutny@suse.com
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

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 mm/hugetlb.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 39eb2fa53a420..3e94f5c2d7cd4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1367,6 +1367,9 @@ void free_huge_page(struct page *page)
 	clear_page_huge_active(page);
 	hugetlb_cgroup_uncharge_page(hstate_index(h), pages_per_huge_page(h),
 				     page, false);
+	hugetlb_cgroup_uncharge_page(hstate_index(h), pages_per_huge_page(h),
+				     page, true);
+
 	if (restore_reserve)
 		h->resv_huge_pages++;

@@ -2189,10 +2192,19 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
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
@@ -2216,6 +2228,14 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	}
 	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page,
 				     false);
+	/* If allocation is not consuming a reservation, also store the
+	 * hugetlb_cgroup pointer on the page.
+	 */
+	if (!vma_resv_map(vma) || map_chg || avoid_reserve) {
+		hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg,
+					     page, true);
+	}
+
 	spin_unlock(&hugetlb_lock);

 	set_page_private(page, (unsigned long)spool);
@@ -2241,6 +2261,10 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
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
2.24.1.735.g03f4e72817-goog
