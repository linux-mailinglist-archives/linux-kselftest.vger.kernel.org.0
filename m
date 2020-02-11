Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59432159B2F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2020 22:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgBKVcD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Feb 2020 16:32:03 -0500
Received: from mail-vs1-f74.google.com ([209.85.217.74]:56507 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgBKVcC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Feb 2020 16:32:02 -0500
Received: by mail-vs1-f74.google.com with SMTP id c5so856138vsh.23
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2020 13:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Tp5wdAmRLkIevDsyGX8qw1zslE9kUlou69d6UeVm2JQ=;
        b=aOJZdPwXw5wDTC3lATyY8iHo6uNIabYE+R+1hpqOTNUV7xPYKnEljA6r2lXxhXF+ET
         gMyKne2fG04+d0phULyLgNp3tQZ1Zsztub/Tj4vA0LOAExk1NEJWwReKKhFMLvi4vvsS
         O3Zi+gFBvHO1WI5t4DSK2++PO2mSdB/sfBX1awbnNXbFEk+OClvwtD7j5aWw2YHYsGz9
         sFlb44ignKhPiYtOKV4+Elq5/tbAHlOqm7r4rp08fXDAuZ0OvPYNCwajkGCRrKw4vx5d
         k81UCcoy0azk05btXS6wyVocfWBNidVLTCwOZM9nL8tyDmp0ZQHerhSSsYqeinZYTgWO
         pg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Tp5wdAmRLkIevDsyGX8qw1zslE9kUlou69d6UeVm2JQ=;
        b=VRLw+Fb1O9F9k9rwTCAmDaStwhKiGe6OpDE/akXp6lnr7K2KCAGOOkhWsn1p4NI258
         3idBLZhFTGk8pWNTgwSh5pFpm332OBXlhojc8PUeNVYZdmavJhfjap6PSPbXP04vUAxk
         Wj2gOia5WK4Ku8O8AnGbU3wJuCXNdqpvalSRNHF4XjwwQoAA25lkF3OybHA3/sqbW+d6
         OUKpMdZ0ratP7HR/XH3IAyf0v+o/iTQAdOnEcc7wKqToUadkwCcMtIBjdz2E/ZBe0LQg
         BwIKwoRx0lm/93QzxhfQ0iSiB9VASnhepirD5Sko+3Vk0Va4R8xiWofLMSOE+Cjsb4A8
         d45A==
X-Gm-Message-State: APjAAAXpRKjkyTDBwdLi+ZKTwNo/xVsm88+bTepuf+hn/Y7yGiXapHzT
        7MReAqHsqa+YiEtTQa08JIui7S1vIew9UGnBig==
X-Google-Smtp-Source: APXvYqyz3nDr4N7U7KZZ53+YJmKSb+zlQMvDxMWbZrelDQ7p8ZqmlAstRX+tAzxWKdvF/eGuKkfAGp2PmxzHLwknig==
X-Received: by 2002:ac5:c950:: with SMTP id s16mr5869367vkm.27.1581456721196;
 Tue, 11 Feb 2020 13:32:01 -0800 (PST)
Date:   Tue, 11 Feb 2020 13:31:26 -0800
In-Reply-To: <20200211213128.73302-1-almasrymina@google.com>
Message-Id: <20200211213128.73302-7-almasrymina@google.com>
Mime-Version: 1.0
References: <20200211213128.73302-1-almasrymina@google.com>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: [PATCH v12 7/9] hugetlb: support file_region coalescing again
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

An earlier patch in this series disabled file_region coalescing in order
to hang the hugetlb_cgroup uncharge info on the file_region entries.

This patch re-adds support for coalescing of file_region entries.
Essentially everytime we add an entry, we call a recursive function that
tries to coalesce the added region with the regions next to it. The
worst case call depth for this function is 3: one to coalesce with the
region next to it, one to coalesce to the region prev, and one to reach
the base case.

This is an important performance optimization as private mappings add
their entries page by page, and we could incur big performance costs for
large mappings with lots of file_region entries in their resv_map.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

Changes in v12:
- Changed logic for coalescing. Instead of checking inline to coalesce
with only the region on next or prev, we now have a recursive function
that takes care of coalescing in both directions.
- For testing this code I added a bunch of debug code that checks that
the entries in the resv_map are coalesced appropriately. This passes
with libhugetlbfs tests.

---
 mm/hugetlb.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2d62dd35399db..45219cb58ac71 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -276,6 +276,86 @@ static void record_hugetlb_cgroup_uncharge_info(struct hugetlb_cgroup *h_cg,
 #endif
 }

+static bool has_same_uncharge_info(struct file_region *rg,
+				   struct file_region *org)
+{
+#ifdef CONFIG_CGROUP_HUGETLB
+	return rg && org &&
+	       rg->reservation_counter == org->reservation_counter &&
+	       rg->css == org->css;
+
+#else
+	return true;
+#endif
+}
+
+#ifdef CONFIG_DEBUG_VM
+static void dump_resv_map(struct resv_map *resv)
+{
+	struct list_head *head = &resv->regions;
+	struct file_region *rg = NULL;
+
+	pr_err("--------- start print resv_map ---------\n");
+	list_for_each_entry(rg, head, link) {
+		pr_err("rg->from=%ld, rg->to=%ld, rg->reservation_counter=%px, rg->css=%px\n",
+		       rg->from, rg->to, rg->reservation_counter, rg->css);
+	}
+	pr_err("--------- end print resv_map ---------\n");
+}
+
+/* Debug function to loop over the resv_map and make sure that coalescing is
+ * working.
+ */
+static void check_coalesce_bug(struct resv_map *resv)
+{
+	struct list_head *head = &resv->regions;
+	struct file_region *rg = NULL, *nrg = NULL;
+
+	list_for_each_entry(rg, head, link) {
+		nrg = list_next_entry(rg, link);
+
+		if (&nrg->link == head)
+			break;
+
+		if (nrg->reservation_counter && nrg->from == rg->to &&
+		    nrg->reservation_counter == rg->reservation_counter &&
+		    nrg->css == rg->css) {
+			dump_resv_map(resv);
+			VM_BUG_ON(true);
+		}
+	}
+}
+#endif
+
+static void coalesce_file_region(struct resv_map *resv, struct file_region *rg)
+{
+	struct file_region *nrg = NULL, *prg = NULL;
+
+	prg = list_prev_entry(rg, link);
+	if (&prg->link != &resv->regions && prg->to == rg->from &&
+	    has_same_uncharge_info(prg, rg)) {
+		prg->to = rg->to;
+
+		list_del(&rg->link);
+		kfree(rg);
+
+		coalesce_file_region(resv, prg);
+		return;
+	}
+
+	nrg = list_next_entry(rg, link);
+	if (&nrg->link != &resv->regions && nrg->from == rg->to &&
+	    has_same_uncharge_info(nrg, rg)) {
+		nrg->from = rg->from;
+
+		list_del(&rg->link);
+		kfree(rg);
+
+		coalesce_file_region(resv, nrg);
+		return;
+	}
+}
+
 /* Must be called with resv->lock held. Calling this with count_only == true
  * will count the number of pages to be added but will not modify the linked
  * list. If regions_needed != NULL and count_only == true, then regions_needed
@@ -327,6 +407,7 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
 				record_hugetlb_cgroup_uncharge_info(h_cg, h,
 								    resv, nrg);
 				list_add(&nrg->link, rg->link.prev);
+				coalesce_file_region(resv, nrg);
 			} else if (regions_needed)
 				*regions_needed += 1;
 		}
@@ -344,11 +425,15 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
 				resv, last_accounted_offset, t);
 			record_hugetlb_cgroup_uncharge_info(h_cg, h, resv, nrg);
 			list_add(&nrg->link, rg->link.prev);
+			coalesce_file_region(resv, nrg);
 		} else if (regions_needed)
 			*regions_needed += 1;
 	}

 	VM_BUG_ON(add < 0);
+#ifdef CONFIG_DEBUG_VM
+	check_coalesce_bug(resv);
+#endif
 	return add;
 }

--
2.25.0.225.g125e21ebc7-goog
