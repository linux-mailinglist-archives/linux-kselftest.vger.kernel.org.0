Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A04D15131F
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2020 00:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgBCXXX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Feb 2020 18:23:23 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:41104 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbgBCXXX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Feb 2020 18:23:23 -0500
Received: by mail-qk1-f202.google.com with SMTP id r145so10601435qke.8
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Feb 2020 15:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gTAQ6DpOvbk9aFAmz/RHl3R2aBxncgiEKbaGpA5frS0=;
        b=lawWGfNg3coqzUxzW5tdwnM7JzKsxWVWyd9ZXeZ6oVEfozYZYeEfuerRe1iAJjbD3B
         nFZ22Sr44cgnTCoY2qCi8yFTrjm5FUtbXALgxMYmqHg5mrNGujJPgYVENxnn010VAOdz
         ajYKoq1V3qmlRxmoKlcyAB99zGipHVX3cVZ29iRJ8hRAPI5gz8qn1RA8u1YKfpxUJXHf
         y6bdAw5mzejzeuWC7XPEFxucoppFAm+GhlSUmtBSVtXgmSIX9fQasyqBikW8UNtiazuG
         eQcX3OuLuEv4OH19GaD7s/KkHqIpbuTaMm0pzHTn/9uVPCR6qtK3hWmd748N4Vtj1Z+Z
         ozJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gTAQ6DpOvbk9aFAmz/RHl3R2aBxncgiEKbaGpA5frS0=;
        b=lTR3HTFLlJLTKDdtzBlwybK399a1dc1jQOvfcawK2brHqC/amC3McIRXa2cwy6JEe5
         5DJ1jWloZ+ItqJWoHBprYf3t8fgbADNZMi2NbWCa8wHxwtYnASfWlXEX/DFOcJSm3Qu6
         2CpyRP0jGxmG1mVCchuqUFiCB71oeE0oJ3uEdd9Y3Gw2T+2QSanBL/F8+kCJqEpjVq3S
         5kv3tH7wZ4Zlac3y0xpyOZfdzfjk1pSfdiv0FHl6yr4MKEokGHTopZ37eo6zn6qYpLKN
         vC7KzK3A/E9aqaQCGhf3PxWGzwjHfn81Ks2vCnukivlv4GsSFji4/x0RMn+kIC0LKIKO
         ehAw==
X-Gm-Message-State: APjAAAWJ3FFO1FyevgJTmMRCUXTCPpAAlbimhXquRW6C1dpKWMsQFbqA
        HJ8nISRhfMFudPbjnfWfFynWLz8n9GpaUc8jIg==
X-Google-Smtp-Source: APXvYqyZFRK2nwPrxgIM0lMsOI9GD3u259sj/EVTiSp7XQoeYTs2EoceYp2yKqu7UzsKjbmj74yv/rUcqDITUWzAXA==
X-Received: by 2002:a37:4d85:: with SMTP id a127mr7298741qkb.267.1580772200586;
 Mon, 03 Feb 2020 15:23:20 -0800 (PST)
Date:   Mon,  3 Feb 2020 15:22:45 -0800
In-Reply-To: <20200203232248.104733-1-almasrymina@google.com>
Message-Id: <20200203232248.104733-6-almasrymina@google.com>
Mime-Version: 1.0
References: <20200203232248.104733-1-almasrymina@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v11 6/9] hugetlb_cgroup: support noreserve mappings
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
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

Changes in v10:
- Refactored deferred_reserve check.

---
 mm/hugetlb.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 33818ccaf7e89..ec0b55ea1506e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1339,6 +1339,9 @@ static void __free_huge_page(struct page *page)
 	clear_page_huge_active(page);
 	hugetlb_cgroup_uncharge_page(hstate_index(h), pages_per_huge_page(h),
 				     page, false);
+	hugetlb_cgroup_uncharge_page(hstate_index(h), pages_per_huge_page(h),
+				     page, true);
+
 	if (restore_reserve)
 		h->resv_huge_pages++;

@@ -2172,6 +2175,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	long gbl_chg;
 	int ret, idx;
 	struct hugetlb_cgroup *h_cg;
+	bool deferred_reserve;

 	idx = hstate_index(h);
 	/*
@@ -2209,10 +2213,20 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 			gbl_chg = 1;
 	}

+	/* If this allocation is not consuming a reservation, charge it now.
+	 */
+	deferred_reserve = map_chg || avoid_reserve || !vma_resv_map(vma);
+	if (deferred_reserve) {
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
@@ -2236,6 +2250,14 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	}
 	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page,
 				     false);
+	/* If allocation is not consuming a reservation, also store the
+	 * hugetlb_cgroup pointer on the page.
+	 */
+	if (deferred_reserve) {
+		hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg,
+					     page, true);
+	}
+
 	spin_unlock(&hugetlb_lock);

 	set_page_private(page, (unsigned long)spool);
@@ -2261,6 +2283,10 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 out_uncharge_cgroup:
 	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg,
 				       false);
+out_uncharge_cgroup_reservation:
+	if (deferred_reserve)
+		hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h),
+					       h_cg, true);
 out_subpool_put:
 	if (map_chg || avoid_reserve)
 		hugepage_subpool_put_pages(spool, 1);
--
2.25.0.341.g760bfbb309-goog
