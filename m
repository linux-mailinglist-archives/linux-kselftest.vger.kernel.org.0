Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2022AFA0A
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Nov 2020 21:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgKKUu5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Nov 2020 15:50:57 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:35843 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725900AbgKKUu4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Nov 2020 15:50:56 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 5A4B4B40;
        Wed, 11 Nov 2020 15:40:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 11 Nov 2020 15:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=C1UmKosirAS8x
        RBgjcrsjxki5ADf6IPDpymKmd+0TMI=; b=Ir3b4tGVCsZhn5bMAVwbtio4VFv/D
        uvFcXmsU+FgU/MWp6ywhrcvjUy810sDC+0EMgLzlWYK9ffWlLljuGMBCCGM44IRk
        P+TigjnK8WgpvVD19UDiSOYE1ou8Lp7hJCZ/7UeX7qcZDDo+cuxdxSDem2ft7RoG
        PuwXGGzZLbzdDMCza1lb9Go3E2I0qunqYbv3kMaLMgmiPfE6cXDeKXRMAGB9m4hZ
        E5xUC1dJavxz9tifS4M+2uzJnCMsSFx2jNAHV545RNGMXNaqSGv6ZLHoA2SG8Po1
        gpdNWPzpPpBlb3iIgE6YTfdobD5YwFoo9vA3355/CW7WgGkBAqVJOr1bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=C1UmKosirAS8xRBgjcrsjxki5ADf6IPDpymKmd+0TMI=; b=fwIe3Zwi
        /hTa3Z5fKz8I7PeJm7uSJJICOcBJvxIP9yuRqJoiczmUYpqmsdH7XK5PZ4XGIPmS
        T9S8fZmz6uH/UGu12BXR3jkogZDl/EBejFY9FIQ+uIEi0Bsvp6CEDEkQT5AwTxr4
        h8lgPjYr+qYrVj6oObzC9hwT28PwpPXqrDHnql825AEpBZhiQW+aa3WEvlyMi7mr
        LhKF9/2LAuugMNROu5EXDqfw2geQ/FkST+Njwl/ZUPtTCUtJB8a+DKB7JBPt9Tx1
        G9qxsgleSYagSMpgT9Xo9aMDb8lYlBW55nfl02T2YFkymLp6viVlv9plDhvciRGc
        dV5YHsCunzI87g==
X-ME-Sender: <xms:SEysX5XlCZBK_ZjGlIk_wWW_RDx-TcIlosZergUfiSoTwAITej7rcw>
    <xme:SEysX5m6zFtylql9yGWXGBHj5W-4g2IsUQY15IdxvvD6EchhN-WBOpuUHr4sWGZzY
    4qEBCopw-901U2CAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvtddgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecukfhppedu
    vddrgeeirddutdeirdduieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:SEysX1ZBPbDq8X-viBuVlCN7ZBSMGv69dwNbzezGbcT72y9vuKEISA>
    <xmx:SEysX8WB8yZzK0iP2uKTbdIgG_HTciq7yxB6HG0axDoe3GCVF6nMfg>
    <xmx:SEysXzkDJRCbkSVt05QTA8C2Xqh-DSG1A97XynL8gPPYMZJw86U3jQ>
    <xmx:SEysX8fVpsnPCbFa8DyiHfqN7D5Tyah-MQvdd09aDCLirlkTvP-oS2BMTrk>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1C5A3328006D;
        Wed, 11 Nov 2020 15:40:40 -0500 (EST)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Nellans <dnellans@nvidia.com>, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 2/6] mm: memcg: make memcg huge page split support any order split.
Date:   Wed, 11 Nov 2020 15:40:04 -0500
Message-Id: <20201111204008.21332-3-zi.yan@sent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201111204008.21332-1-zi.yan@sent.com>
References: <20201111204008.21332-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

It reads thp_nr_pages and splits to provided new_nr. It prepares for
upcoming changes to support split huge page to any lower order.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/memcontrol.h | 5 +++--
 mm/huge_memory.c           | 2 +-
 mm/memcontrol.c            | 4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0f4dd7829fb2..b3bac79ceed6 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1105,7 +1105,7 @@ static inline void memcg_memory_event_mm(struct mm_st=
ruct *mm,
 }
=20
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-void mem_cgroup_split_huge_fixup(struct page *head);
+void mem_cgroup_split_huge_fixup(struct page *head, unsigned int new_nr);
 #endif
=20
 #else /* CONFIG_MEMCG */
@@ -1451,7 +1451,8 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t=
 *pgdat, int order,
 	return 0;
 }
=20
-static inline void mem_cgroup_split_huge_fixup(struct page *head)
+static inline void mem_cgroup_split_huge_fixup(struct page *head,
+					       unsigned int new_nr)
 {
 }
=20
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c4fead5ead31..f599f5b9bf7f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2429,7 +2429,7 @@ static void __split_huge_page(struct page *page, stru=
ct list_head *list,
 	lruvec =3D mem_cgroup_page_lruvec(head, pgdat);
=20
 	/* complete memcg works before add pages to LRU */
-	mem_cgroup_split_huge_fixup(head);
+	mem_cgroup_split_huge_fixup(head, 1);
=20
 	if (PageAnon(head) && PageSwapCache(head)) {
 		swp_entry_t entry =3D { .val =3D page_private(head) };
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 33f632689cee..e9705ba6bbcc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3247,7 +3247,7 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, si=
ze_t size)
  * Because tail pages are not marked as "used", set it. We're under
  * pgdat->lru_lock and migration entries setup in all page mappings.
  */
-void mem_cgroup_split_huge_fixup(struct page *head)
+void mem_cgroup_split_huge_fixup(struct page *head, unsigned int new_nr)
 {
 	struct mem_cgroup *memcg =3D page_memcg(head);
 	int i;
@@ -3255,7 +3255,7 @@ void mem_cgroup_split_huge_fixup(struct page *head)
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

