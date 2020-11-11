Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E3A2AF9F3
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Nov 2020 21:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgKKUqC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Nov 2020 15:46:02 -0500
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:41459 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726884AbgKKUqC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Nov 2020 15:46:02 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 5B022B43;
        Wed, 11 Nov 2020 15:40:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 11 Nov 2020 15:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=e2DmXMYHMkbqy
        Lg+bqDlVe/Knfvv9mMQFeJGw1T5RTk=; b=VDFMUHUegXKz8lI5ggnc/LZRtDOoo
        4EcN06pcjMGbGGmm2696Z3q8HyQugMw4H/NEnKhaL4GN67y2E9LTsDm0LEmdFJF1
        bHGSDFaUsA6uiEtw/ELZf3dagGtnuYV4+k3uoXLje7aHXJB7uLRQDVoe4xNWT4id
        NWYv7+Fl7qMpixcMBqSWvSkz1o/8yxD5hOyskNn2+budKYAWQq5Yftmfu/LYSqyK
        6SxHNW7CvHIJD+t/679n/pF/zXdDDDwxl0hE7xx80x4G6L2gUOPkmIN338tOiJY7
        omH1Ag95o9zssQHhVO6s/0I1+Y+oa1GJCL7AvwcQU1qa8llp5Nbz6u7Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=e2DmXMYHMkbqyLg+bqDlVe/Knfvv9mMQFeJGw1T5RTk=; b=WO7cVfVL
        Kf6OID8EvuIBRLlxwacD0XiqRBnjxV6zyv4sxMRsLI4AnFVWf/pXSod5W4b0tM46
        ZPXCg2m23QPJrGhTmfp55myfP2ldMRBNq8SiAEjCr+OuksZxowHnZ1AqnwePGS47
        G4TOJdyo7KTuFuV44vncUpgIy0RtE33UPbuv+fAbaMSAxna49v7WOJqPfGzKUMv0
        l2zHUSng02djviihm+p7RPsY9UsssAxq3kRP3dMFC6caLQVwZUTvVUFX5kUBIJAn
        oe8bMIfD0lsJgf0nV9dDcGrPGEP/ef77fhgMrx3LyBiQw8tZl8/llh+6P/z2tk8U
        07xK3sXkd2UzgQ==
X-ME-Sender: <xms:SEysX7lWCIPue_t_fhWUa--DJPOX75IwGmOYtXhTvBE4v1raGXzTvw>
    <xme:SEysX-0--fBgax_pGJti0NHm-Nszc5uq71_Ew2NUqndZgx2zT5mDtD6oWmMZx8MYr
    9W29Z1_YQ0EfOqofQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvtddgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecukfhppedu
    vddrgeeirddutdeirdduieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:SEysXxoRhQhEAHnR7kdxLogkrQHpQZw2BkxWthMBTUmL4y6ow6Qbng>
    <xmx:SEysXzkQ4cLl5swJhSQeIJijPTqDeOP2F_dPmCNnJq3W5yOthO1OSw>
    <xmx:SEysX53iNs38QEi1nw9vEqm3fc5z9px2Im19koZfczrumgDY7pzeZw>
    <xmx:SEysXytWP6jSaQM24QOLUNcEUxCO4z_GPWbPLnLB4uZ8IXN0JmUB9rnjjQ4>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 61CD43280067;
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
Subject: [RFC PATCH 3/6] mm: page_owner: add support for splitting to any order in split page_owner.
Date:   Wed, 11 Nov 2020 15:40:05 -0500
Message-Id: <20201111204008.21332-4-zi.yan@sent.com>
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

It adds a new_order parameter to set new page order in page owner.
It prepares for upcoming changes to support split huge page to any lower
order.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/page_owner.h | 7 ++++---
 mm/huge_memory.c           | 2 +-
 mm/page_alloc.c            | 2 +-
 mm/page_owner.c            | 6 +++---
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
index 3468794f83d2..215cbb159568 100644
--- a/include/linux/page_owner.h
+++ b/include/linux/page_owner.h
@@ -31,10 +31,11 @@ static inline void set_page_owner(struct page *page,
 		__set_page_owner(page, order, gfp_mask);
 }
=20
-static inline void split_page_owner(struct page *page, unsigned int nr)
+static inline void split_page_owner(struct page *page, unsigned int nr,
+			unsigned int new_order)
 {
 	if (static_branch_unlikely(&page_owner_inited))
-		__split_page_owner(page, nr);
+		__split_page_owner(page, nr, new_order);
 }
 static inline void copy_page_owner(struct page *oldpage, struct page *newp=
age)
 {
@@ -60,7 +61,7 @@ static inline void set_page_owner(struct page *page,
 {
 }
 static inline void split_page_owner(struct page *page,
-			unsigned int order)
+			unsigned int nr, unsigned int new_order)
 {
 }
 static inline void copy_page_owner(struct page *oldpage, struct page *newp=
age)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f599f5b9bf7f..8b7d771ee962 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2459,7 +2459,7 @@ static void __split_huge_page(struct page *page, stru=
ct list_head *list,
=20
 	ClearPageCompound(head);
=20
-	split_page_owner(head, nr);
+	split_page_owner(head, nr, 1);
=20
 	/* See comment in __split_huge_page_tail() */
 	if (PageAnon(head)) {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d77220615fd5..a9eead0e091a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3284,7 +3284,7 @@ void split_page(struct page *page, unsigned int order)
=20
 	for (i =3D 1; i < (1 << order); i++)
 		set_page_refcounted(page + i);
-	split_page_owner(page, 1 << order);
+	split_page_owner(page, 1 << order, 1);
 }
 EXPORT_SYMBOL_GPL(split_page);
=20
diff --git a/mm/page_owner.c b/mm/page_owner.c
index b735a8eafcdb..2b7f7e9056dc 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -204,7 +204,7 @@ void __set_page_owner_migrate_reason(struct page *page,=
 int reason)
 	page_owner->last_migrate_reason =3D reason;
 }
=20
-void __split_page_owner(struct page *page, unsigned int nr)
+void __split_page_owner(struct page *page, unsigned int nr, unsigned int n=
ew_order)
 {
 	int i;
 	struct page_ext *page_ext =3D lookup_page_ext(page);
@@ -213,9 +213,9 @@ void __split_page_owner(struct page *page, unsigned int=
 nr)
 	if (unlikely(!page_ext))
 		return;
=20
-	for (i =3D 0; i < nr; i++) {
+	for (i =3D 0; i < nr; i +=3D (1 << new_order)) {
 		page_owner =3D get_page_owner(page_ext);
-		page_owner->order =3D 0;
+		page_owner->order =3D new_order;
 		page_ext =3D page_ext_next(page_ext);
 	}
 }
--=20
2.28.0

