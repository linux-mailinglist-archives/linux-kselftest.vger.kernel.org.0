Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA19FAF351
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2019 01:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfIJXcG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Sep 2019 19:32:06 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:39016 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfIJXcF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Sep 2019 19:32:05 -0400
Received: by mail-pf1-f201.google.com with SMTP id n186so14240799pfn.6
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2019 16:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Vuvev8Yzxd1RQX7GlTnFg8u8KyDaWAzEg+D+vv41AFA=;
        b=RhQSqz9Gow9lf3iCQJh2cOagmx6FazRfMH4sEChocwKkK/jGnMsp1AZ1niK495fZrk
         sRn6d4YWN5J1bh6nFGxjKVP6G70zs3olWAaKHpNaedsb8FuwOty0ywehJVRiG/7DofuX
         uybmLEFmUYZJPwpF8twlZl/gSn9fMdKVTRsNU2DY5f5Z7PJW2tnVVgvxa0y6o8jkZ7NH
         vIPd/YYOZ5iS9r3YloHvde/PPsjmoWSn60tdpD3/VYzKfrgcSL93m01RYogrTr6HiyuK
         m+iM8PVusjQYRgOXRPxj3Y66nWWhVOkQhQFehH/jJ0Ro7yxbajdQz+YsKWWPpBRb5CZi
         gQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Vuvev8Yzxd1RQX7GlTnFg8u8KyDaWAzEg+D+vv41AFA=;
        b=jWcHW1384N/6e5QtUgoejHKhpDM3isku9gMziHJ7e8kFFq5vovfb9BmrnXt1MW6y2U
         SzVvpuH2E8WsM6xtXggCquOx4M0DW8oHzUuhY4gDSMVXytv+Xg/JnFAyp8WFn24COVCk
         XdJI8i619qqtuTcnRxgLPV1+u5J8tsv4Vg8h7j28dekMiuLvTENvG6xrtxZOg1GC8yLS
         gay8oLNNEf5/zOvgj13UJvuXlGO3aZoIhU4WxBpD7U2YC7IwqmVYjpmMPbJxeh4kBg34
         Q4xo6JxFT/c/O5B/JteppnFYe5VkW9XQ7Xq8k7zoD2yJPm5uOIDL9tSvhNjVRvrMc4Ek
         WdBQ==
X-Gm-Message-State: APjAAAVSLb0h8Vu0a1gZTCgCNrbcbjjU/v9Y3pizEuYXNfdq0vrQbigV
        DhGyGmln3IO/NAL08c9VBecjc2v9jnFis+9Oig==
X-Google-Smtp-Source: APXvYqyXGgdGxEdLLOLogNOyiNYauXGQNpF8G1qrcyLi9ZKsCxGrBA4ZsS4UbIa1HhG6T+/TP2q13PknIdsiZKtDLg==
X-Received: by 2002:a65:60d3:: with SMTP id r19mr30472526pgv.91.1568158323822;
 Tue, 10 Sep 2019 16:32:03 -0700 (PDT)
Date:   Tue, 10 Sep 2019 16:31:42 -0700
In-Reply-To: <20190910233146.206080-1-almasrymina@google.com>
Message-Id: <20190910233146.206080-6-almasrymina@google.com>
Mime-Version: 1.0
References: <20190910233146.206080-1-almasrymina@google.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
Subject: [PATCH v4 5/9] hugetlb: remove duplicated code
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

Remove duplicated code between region_chg and region_add, and refactor it into
a common function, add_reservation_in_range. This is mostly done because
there is a follow up change in this series that disables region
coalescing in region_add, and I want to make that change in one place
only. It should improve maintainability anyway on its own.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 mm/hugetlb.c | 116 ++++++++++++++++++++++++---------------------------
 1 file changed, 54 insertions(+), 62 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bea51ae422f63..ce5ed1056fefd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -244,6 +244,57 @@ struct file_region {
 	long to;
 };

+static long add_reservation_in_range(
+		struct resv_map *resv, long f, long t, bool count_only)
+{
+
+	long chg = 0;
+	struct list_head *head = &resv->regions;
+	struct file_region *rg = NULL, *trg = NULL, *nrg = NULL;
+
+	/* Locate the region we are before or in. */
+	list_for_each_entry(rg, head, link)
+		if (f <= rg->to)
+			break;
+
+	/* Round our left edge to the current segment if it encloses us. */
+	if (f > rg->from)
+		f = rg->from;
+
+	chg = t - f;
+
+	/* Check for and consume any regions we now overlap with. */
+	nrg = rg;
+	list_for_each_entry_safe(rg, trg, rg->link.prev, link) {
+		if (&rg->link == head)
+			break;
+		if (rg->from > t)
+			break;
+
+		/* We overlap with this area, if it extends further than
+		 * us then we must extend ourselves.  Account for its
+		 * existing reservation.
+		 */
+		if (rg->to > t) {
+			chg += rg->to - t;
+			t = rg->to;
+		}
+		chg -= rg->to - rg->from;
+
+		if (!count_only && rg != nrg) {
+			list_del(&rg->link);
+			kfree(rg);
+		}
+	}
+
+	if (!count_only) {
+		nrg->from = f;
+		nrg->to = t;
+	}
+
+	return chg;
+}
+
 /*
  * Add the huge page range represented by [f, t) to the reserve
  * map.  Existing regions will be expanded to accommodate the specified
@@ -257,7 +308,7 @@ struct file_region {
 static long region_add(struct resv_map *resv, long f, long t)
 {
 	struct list_head *head = &resv->regions;
-	struct file_region *rg, *nrg, *trg;
+	struct file_region *rg, *nrg;
 	long add = 0;

 	spin_lock(&resv->lock);
@@ -287,38 +338,7 @@ static long region_add(struct resv_map *resv, long f, long t)
 		goto out_locked;
 	}

-	/* Round our left edge to the current segment if it encloses us. */
-	if (f > rg->from)
-		f = rg->from;
-
-	/* Check for and consume any regions we now overlap with. */
-	nrg = rg;
-	list_for_each_entry_safe(rg, trg, rg->link.prev, link) {
-		if (&rg->link == head)
-			break;
-		if (rg->from > t)
-			break;
-
-		/* If this area reaches higher then extend our area to
-		 * include it completely.  If this is not the first area
-		 * which we intend to reuse, free it. */
-		if (rg->to > t)
-			t = rg->to;
-		if (rg != nrg) {
-			/* Decrement return value by the deleted range.
-			 * Another range will span this area so that by
-			 * end of routine add will be >= zero
-			 */
-			add -= (rg->to - rg->from);
-			list_del(&rg->link);
-			kfree(rg);
-		}
-	}
-
-	add += (nrg->from - f);		/* Added to beginning of region */
-	nrg->from = f;
-	add += t - nrg->to;		/* Added to end of region */
-	nrg->to = t;
+	add = add_reservation_in_range(resv, f, t, false);

 out_locked:
 	resv->adds_in_progress--;
@@ -345,8 +365,6 @@ static long region_add(struct resv_map *resv, long f, long t)
  */
 static long region_chg(struct resv_map *resv, long f, long t)
 {
-	struct list_head *head = &resv->regions;
-	struct file_region *rg;
 	long chg = 0;

 	spin_lock(&resv->lock);
@@ -375,34 +393,8 @@ static long region_chg(struct resv_map *resv, long f, long t)
 		goto retry_locked;
 	}

-	/* Locate the region we are before or in. */
-	list_for_each_entry(rg, head, link)
-		if (f <= rg->to)
-			break;
-
-	/* Round our left edge to the current segment if it encloses us. */
-	if (f > rg->from)
-		f = rg->from;
-	chg = t - f;
-
-	/* Check for and consume any regions we now overlap with. */
-	list_for_each_entry(rg, rg->link.prev, link) {
-		if (&rg->link == head)
-			break;
-		if (rg->from > t)
-			goto out;
+	chg = add_reservation_in_range(resv, f, t, true);

-		/* We overlap with this area, if it extends further than
-		 * us then we must extend ourselves.  Account for its
-		 * existing reservation. */
-		if (rg->to > t) {
-			chg += rg->to - t;
-			t = rg->to;
-		}
-		chg -= rg->to - rg->from;
-	}
-
-out:
 	spin_unlock(&resv->lock);
 	return chg;
 }
--
2.23.0.162.g0b9fbb3734-goog
