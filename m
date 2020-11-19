Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159102B9756
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Nov 2020 17:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgKSQGj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Nov 2020 11:06:39 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:41859 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727990AbgKSQGj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Nov 2020 11:06:39 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 5E12FED5;
        Thu, 19 Nov 2020 11:06:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 19 Nov 2020 11:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=jekI5tMSgt2QD
        NEmEebnlTl09MgC4oLm1jXTahZK9g8=; b=xCI3YILoNwMJ1q3mpREI968HKniUl
        KJDnSdZzmgVVnjECKpH0wPvIbLnmzCkMphzUtMR+5cfiqfcM3tdtcgpeXb65wCiM
        +urbVtIAJgLnh4DAo36h/KT2nPVhjyCmXMfW94sVucMb6gq14hB5feX/s1fV55IL
        HvNWnWw9k8l/6oBlGLyAvt/RHInv5y8QDxe425V5nAVfsS6sTaaM0NGuYA/K4lm1
        X5EIOb3NC+6B27XbyjE5qlwsVYSj/LwU18Z7V+ZwVGDSGUEoEgOmBXKUe0lzX2qY
        IigGXIu4vHfIauHTQw1qnIsy/XsFbEr22aPH9sgE5nlh63K+48ca/462Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=jekI5tMSgt2QDNEmEebnlTl09MgC4oLm1jXTahZK9g8=; b=dWEJemL6
        go/dlyGtVNcvQPCyNYEQ4yAE6bfsE+reEGbEUhp6yeoM5z3kgyGSEtZxebUWNw2n
        oS0zkUppYyq+pWeh0WOmuhUSi+o5U4L6DNanYirO56FTtCLQKqteopJ9FMV0e8Mq
        xYOqKCiqs26cw/s+nyawd38+64QErA6NQ2SYm61oV7ZFeN7VByBtLdu1iaHZ8h46
        g1hfFE7el4ri55sbEkTcBip04TxyiMexaaLMZknsz2NzL2adjVRmufxJWpUfdxEO
        ur5tYdjoPSiKb1SILXp5X8gLdP87QKduHxw2IeYOy8aH73SxKFI0hx+Gf+BhyZXA
        ulQJHYSJPPSQzg==
X-ME-Sender: <xms:DJi2X3hdRGEwMBbNlMIA8iBE6IzdKPog_la8q013Ru-Tb9Uke3j9ag>
    <xme:DJi2X0C4q1gk_2_gKiKS617ps4Cv8WtgrkU1hfNTdzOOeQBMRusK0cP-XLju2wd9r
    87rywqUxK3zqt5GVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefjedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecukfhppedu
    vddrgeeirddutdeirdduieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:DJi2X3FLB1siYoJDsYQW6l1O09NdjCiHPkHywzyEXyh0Hp7FET2yuw>
    <xmx:DJi2X0QR8h6fOwHaKM2rpomuxqy5C0Q01f6NZINe8Ph0J6w0kMIJWQ>
    <xmx:DJi2X0w2iMf4pwxoZXqG9N1rSJ-UYFzp1IcqCEhtWEp6Jph33Wymag>
    <xmx:DJi2X5rz2GSuLNuioUrdp35uaYBXtLhBQ4L9OWE0_9TQpLDRp8niL9NjDPA>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 686B03064AB4;
        Thu, 19 Nov 2020 11:06:36 -0500 (EST)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Nellans <dnellans@nvidia.com>, Zi Yan <ziy@nvidia.com>
Subject: [PATCH 3/7] mm: memcg: make memcg huge page split support any order split.
Date:   Thu, 19 Nov 2020 11:06:01 -0500
Message-Id: <20201119160605.1272425-4-zi.yan@sent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201119160605.1272425-1-zi.yan@sent.com>
References: <20201119160605.1272425-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

It sets memcg information for the pages after the split. A new parameter
new_order is added to tell the new page order, always 0 for now. It
prepares for upcoming changes to support split huge page to any lower order.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
Acked-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h | 5 +++--
 mm/huge_memory.c           | 2 +-
 mm/memcontrol.c            | 6 +++---
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index a8d5daf95988..39707feae505 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1062,7 +1062,7 @@ static inline void memcg_memory_event_mm(struct mm_st=
ruct *mm,
 }
=20
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-void mem_cgroup_split_huge_fixup(struct page *head);
+void mem_cgroup_split_huge_fixup(struct page *head, unsigned int new_order=
);
 #endif
=20
 #else /* CONFIG_MEMCG */
@@ -1396,7 +1396,8 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t=
 *pgdat, int order,
 	return 0;
 }
=20
-static inline void mem_cgroup_split_huge_fixup(struct page *head)
+static inline void mem_cgroup_split_huge_fixup(struct page *head,
+					       unsigned int new_order)
 {
 }
=20
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 88d8b7fce5d7..d7ab5cac5851 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2428,7 +2428,7 @@ static void __split_huge_page(struct page *page, stru=
ct list_head *list,
 	lruvec =3D mem_cgroup_page_lruvec(head, pgdat);
=20
 	/* complete memcg works before add pages to LRU */
-	mem_cgroup_split_huge_fixup(head);
+	mem_cgroup_split_huge_fixup(head, 0);
=20
 	if (PageAnon(head) && PageSwapCache(head)) {
 		swp_entry_t entry =3D { .val =3D page_private(head) };
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index de5869dd354d..4521ed3a51b7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3223,15 +3223,15 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, =
size_t size)
  * Because tail pages are not marked as "used", set it. We're under
  * pgdat->lru_lock and migration entries setup in all page mappings.
  */
-void mem_cgroup_split_huge_fixup(struct page *head)
+void mem_cgroup_split_huge_fixup(struct page *head, unsigned int new_order)
 {
 	struct mem_cgroup *memcg =3D page_memcg(head);
-	int i;
+	int i, new_nr =3D 1 << new_order;
=20
 	if (mem_cgroup_disabled())
 		return;
=20
-	for (i =3D 1; i < thp_nr_pages(head); i++) {
+	for (i =3D new_nr; i < thp_nr_pages(head); i +=3D new_nr) {
 		css_get(&memcg->css);
 		head[i].memcg_data =3D (unsigned long)memcg;
 	}
--=20
2.28.0

