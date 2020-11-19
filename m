Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD322B9765
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Nov 2020 17:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgKSQG5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Nov 2020 11:06:57 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:43701 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727991AbgKSQGj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Nov 2020 11:06:39 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id BDCADE96;
        Thu, 19 Nov 2020 11:06:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 19 Nov 2020 11:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=mH0cmjCFFHawR
        fu2fp7V1aZ23JKakX1bmunG/jk3ld4=; b=A09NhnlLth9AQs85DScDDR2MgWzXd
        prjq6bmdlLKZn0ZEFWuts6n4+bz/y47V2XPGS3Vk9H9j3ulvm8a05iqHjewAF+Ba
        ApGMO9A9xRDrPuJPLRb5r1WzBKuZNVdg8iE9d+OA2sQIbEgJees7HvU2kdS7X/VC
        DPGdXnZqIB6qCL+GDOGDshFfj6jgh8lUxxg7vFA/659eEaDsol3Bl1qHAQ/KUePe
        1kWch0bJYbkAy3YyF+n12VsmPEVr2SH8udGr4u/E0KFMDvJ8p2NbFnjAtPgFdDTK
        mk0gwLGNYxz6btwntr5pFxbwEks136YS+6jRMcMdZgugNceXnXRcMwhTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=mH0cmjCFFHawRfu2fp7V1aZ23JKakX1bmunG/jk3ld4=; b=QRnzrNRm
        Rw+rqQrua0o+q4j5TfPTmPFEX1Zstcx3I14GeMFTvIj/F/5Xxf7bsGvb9w4GYN28
        WXre3l7UJkoosap2LDoy6Mz6yDjtwzy9po60oxlGqKWZv9GbHPRdgZ7u7ZbUdZHo
        1IVYWYxcAixjzs1hyaQFuVN0jwpjRZxSlAxL4+oGVibPFSS+ed1P0LlrbywS+EG3
        xg2JJmTC/iErijvaDl3Sm4CPyErAtpv7V8wuz3KplTdkGnDGksllyDmISe+UimCg
        193rI8sLPGNLJaSnRJq7jpuzW8JqLfnEEqC1Yxtdotwde4+s/YaRLdZT9fIToWwu
        xr6S4Qdr5JXHjA==
X-ME-Sender: <xms:DZi2X8NHZa9d3yL3s8khUouKYLBBhtK3pQrfzOLwz7m5n2xkI5fm1g>
    <xme:DZi2Xy_cUjaQhC2ynAYag4-LZadPVp8kIMi1y6Ios3Q1tWhqrnLZmK2A1M2Ja-mrf
    jMJTenYVfREKb3Itw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefjedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecukfhppedu
    vddrgeeirddutdeirdduieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:DZi2XzRSzke9wQVsWjpTufixSZT-MSwVXkQWCEhnQXPpX2heuq9ODg>
    <xmx:DZi2X0skhxWsizIfYWMp7qE7KYi6LM5-fMvAJSh3nt_sbvBOKjNngA>
    <xmx:DZi2X0eajVCCOMtXXbeXVtWrTQ6liv6iZojYMerqNexArecFHKPZag>
    <xmx:DZi2X1VMu6dYUHHOXmmTzQrXnnXPXXe51xVTlg8CxsCtRH8xUMbssbeTd0w>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id AD9AB3064AB5;
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
Subject: [PATCH 4/7] mm: page_owner: add support for splitting to any order in split page_owner.
Date:   Thu, 19 Nov 2020 11:06:02 -0500
Message-Id: <20201119160605.1272425-5-zi.yan@sent.com>
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

It adds a new_order parameter to set new page order in page owner and
uses old_order instead of nr to make the parameters look consistent.
It prepares for upcoming changes to support split huge page to any
lower order.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/page_owner.h | 10 ++++++----
 mm/huge_memory.c           |  3 ++-
 mm/page_alloc.c            |  2 +-
 mm/page_owner.c            | 13 +++++++------
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
index 3468794f83d2..9caaed51403c 100644
--- a/include/linux/page_owner.h
+++ b/include/linux/page_owner.h
@@ -11,7 +11,8 @@ extern struct page_ext_operations page_owner_ops;
 extern void __reset_page_owner(struct page *page, unsigned int order);
 extern void __set_page_owner(struct page *page,
 			unsigned int order, gfp_t gfp_mask);
-extern void __split_page_owner(struct page *page, unsigned int nr);
+extern void __split_page_owner(struct page *page, unsigned int old_order,
+			unsigned int new_order);
 extern void __copy_page_owner(struct page *oldpage, struct page *newpage);
 extern void __set_page_owner_migrate_reason(struct page *page, int reason);
 extern void __dump_page_owner(struct page *page);
@@ -31,10 +32,11 @@ static inline void set_page_owner(struct page *page,
 		__set_page_owner(page, order, gfp_mask);
 }
=20
-static inline void split_page_owner(struct page *page, unsigned int nr)
+static inline void split_page_owner(struct page *page, unsigned int old_or=
der,
+			unsigned int new_order)
 {
 	if (static_branch_unlikely(&page_owner_inited))
-		__split_page_owner(page, nr);
+		__split_page_owner(page, old_order, new_order);
 }
 static inline void copy_page_owner(struct page *oldpage, struct page *newp=
age)
 {
@@ -60,7 +62,7 @@ static inline void set_page_owner(struct page *page,
 {
 }
 static inline void split_page_owner(struct page *page,
-			unsigned int order)
+			unsigned int old_order, unsigned int new_order)
 {
 }
 static inline void copy_page_owner(struct page *oldpage, struct page *newp=
age)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d7ab5cac5851..aae7405a0989 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2422,6 +2422,7 @@ static void __split_huge_page(struct page *page, stru=
ct list_head *list,
 	struct lruvec *lruvec;
 	struct address_space *swap_cache =3D NULL;
 	unsigned long offset =3D 0;
+	unsigned int order =3D thp_order(head);
 	unsigned int nr =3D thp_nr_pages(head);
 	int i;
=20
@@ -2458,7 +2459,7 @@ static void __split_huge_page(struct page *page, stru=
ct list_head *list,
=20
 	ClearPageCompound(head);
=20
-	split_page_owner(head, nr);
+	split_page_owner(head, order, 0);
=20
 	/* See comment in __split_huge_page_tail() */
 	if (PageAnon(head)) {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 63d8d8b72c10..414f26950190 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3297,7 +3297,7 @@ void split_page(struct page *page, unsigned int order)
=20
 	for (i =3D 1; i < (1 << order); i++)
 		set_page_refcounted(page + i);
-	split_page_owner(page, 1 << order);
+	split_page_owner(page, order, 0);
 }
 EXPORT_SYMBOL_GPL(split_page);
=20
diff --git a/mm/page_owner.c b/mm/page_owner.c
index b735a8eafcdb..00a679a1230b 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -204,19 +204,20 @@ void __set_page_owner_migrate_reason(struct page *pag=
e, int reason)
 	page_owner->last_migrate_reason =3D reason;
 }
=20
-void __split_page_owner(struct page *page, unsigned int nr)
+void __split_page_owner(struct page *page, unsigned int old_order,
+			unsigned int new_order)
 {
-	int i;
-	struct page_ext *page_ext =3D lookup_page_ext(page);
+	int i, old_nr =3D 1 << old_order, new_nr =3D 1 << new_order;
+	struct page_ext *page_ext;
 	struct page_owner *page_owner;
=20
 	if (unlikely(!page_ext))
 		return;
=20
-	for (i =3D 0; i < nr; i++) {
+	for (i =3D 0; i < old_nr; i +=3D new_nr) {
+		page_ext =3D lookup_page_ext(page + i);
 		page_owner =3D get_page_owner(page_ext);
-		page_owner->order =3D 0;
-		page_ext =3D page_ext_next(page_ext);
+		page_owner->order =3D new_order;
 	}
 }
=20
--=20
2.28.0

