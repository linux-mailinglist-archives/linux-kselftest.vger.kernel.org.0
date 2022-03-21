Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869694E2AB1
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Mar 2022 15:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349350AbiCUOaF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Mar 2022 10:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349264AbiCUO1x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Mar 2022 10:27:53 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9C81EAE4;
        Mon, 21 Mar 2022 07:21:38 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id A92A15C01C7;
        Mon, 21 Mar 2022 10:21:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 21 Mar 2022 10:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=+/Wp7/w8DInb8D
        6QqZ6ciS73TAw3rM4RvE2nNIS9rTw=; b=nJwqj/l0JgzTMam8BnG9lxPaM1+x+A
        7+BLwRD6YpZFX/4SGSM+zGhlBll/868j4rmMy4wHqx6S/Mhbm7N4MK9SIMk07/Sv
        lyV+mK7PvJPSi1ceMe7ksQxi1gAqjbX2F6kwzIqpktkQ097Urt1FGrX6qyRmQFrb
        Z0WWiVBSIEKHUEFI+zxb2+jVSYMR63BVvIgP+hRfHbUbih+D4S49xQfOrtvmg0lG
        jrFkgswGEkYcymBxevlpmm5BnAbwNvr4/FGF3as2cIL1LiusHSWPeYd9wYbYMiVh
        QSe0r8SltxpC4q3F4ZwVLFEBH2mUZrEyMVH1EGfftoTNrIr/UP+qIccQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=+/Wp7/w8DInb8D6QqZ6ciS73TAw3rM4RvE2nNIS9rTw=; b=o1C99GeY
        L7HpALqGAWJawa5uOAHc04OvriLZIsh8ZFIgj1UAYmVMs+7Hb062PRIlyk1gSdH2
        De5V7tZVHYQ9VhlQzoBzbMk1A0qyRk8pZG1Vc91b6Rp5vrdGwVAiEnX/U5siTzco
        iQwRe0WmSn1VmRcjQ6AdmrktO7DtR/V01OWycm0Usw22pj8SbSh/OEkEZHn4UlXJ
        0W4zDMwokwtIEgvEaUwU9PzDQ5AAoaSCqi4PSG7MvOuuMWhvj3ni+DXFNfrbId3x
        0t9+SjJ6a3yBxWwAzeuHBijO12paNSSff/whVfOHeuRtl80fluF8lC7CWV10ba0A
        bSP98/ubPnwGlA==
X-ME-Sender: <xms:8Yk4Yizihs70i_OOJtPJb9nx4J7ENXdk-o1JQMda9Q46Drs-W2_4xw>
    <xme:8Yk4YuTwJw8YuIf8Yi66c2AHaEHXhvfLg9jhTE_gEi2z_FzVQVi7tV-S5GitmXdaI
    kKZJquoVr9JSHhsXw>
X-ME-Received: <xmr:8Yk4YkXB_hey1jJUvRNv2HGWuRXK0gyK23lmeemTwkMZUfcdKXLld8IbNv0LESeRPUnhxNM7-EDJEeQrJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegfedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
    hnthdrtghomh
X-ME-Proxy: <xmx:8Yk4Yoi0m19ed8CcmBV9F6R3TUzgGxMXhs7zw3YF7ImTS9Cb4pZtxQ>
    <xmx:8Yk4YkDSITO_vOR143MNbJhnXKnzWlG_Jc10ZpKq8ua9b6GAFatWdw>
    <xmx:8Yk4YpKhMvz_9tK6vZSntTetGMbmJ1cTdhsBaykx-FF_EN-4baEUYg>
    <xmx:8Yk4Yo50oRTv9HG4OfYTiMxw0dlSyrXw2KQyWz753GvmPj9YIAw9-w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Mar 2022 10:21:37 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Shuah Khan <shuah@kernel.org>, Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 2/5] mm: page_owner: add support for splitting to any order in split page_owner.
Date:   Mon, 21 Mar 2022 10:21:25 -0400
Message-Id: <20220321142128.2471199-3-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321142128.2471199-1-zi.yan@sent.com>
References: <20220321142128.2471199-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 include/linux/page_owner.h | 12 +++++++-----
 mm/huge_memory.c           |  3 ++-
 mm/page_alloc.c            |  2 +-
 mm/page_owner.c            | 13 +++++++------
 4 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
index 119a0c9d2a8b..16050cc89274 100644
--- a/include/linux/page_owner.h
+++ b/include/linux/page_owner.h
@@ -11,7 +11,8 @@ extern struct page_ext_operations page_owner_ops;
 extern void __reset_page_owner(struct page *page, unsigned short order);
 extern void __set_page_owner(struct page *page,
 			unsigned short order, gfp_t gfp_mask);
-extern void __split_page_owner(struct page *page, unsigned int nr);
+extern void __split_page_owner(struct page *page, unsigned short old_order,
+			unsigned short new_order);
 extern void __folio_copy_owner(struct folio *newfolio, struct folio *old);
 extern void __set_page_owner_migrate_reason(struct page *page, int reason);
 extern void __dump_page_owner(const struct page *page);
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
 static inline void folio_copy_owner(struct folio *newfolio, struct folio *=
old)
 {
@@ -56,11 +58,11 @@ static inline void reset_page_owner(struct page *page, =
unsigned short order)
 {
 }
 static inline void set_page_owner(struct page *page,
-			unsigned int order, gfp_t gfp_mask)
+			unsigned short order, gfp_t gfp_mask)
 {
 }
 static inline void split_page_owner(struct page *page,
-			unsigned short order)
+			unsigned short old_order, unsigned short new_order)
 {
 }
 static inline void folio_copy_owner(struct folio *newfolio, struct folio *=
folio)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 640040c386f0..fcfa46af6c4c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2367,6 +2367,7 @@ static void __split_huge_page(struct page *page, stru=
ct list_head *list,
 	struct lruvec *lruvec;
 	struct address_space *swap_cache =3D NULL;
 	unsigned long offset =3D 0;
+	unsigned int order =3D thp_order(head);
 	unsigned int nr =3D thp_nr_pages(head);
 	int i;
=20
@@ -2408,7 +2409,7 @@ static void __split_huge_page(struct page *page, stru=
ct list_head *list,
 	unlock_page_lruvec(lruvec);
 	/* Caller disabled irqs, so they are still disabled here */
=20
-	split_page_owner(head, nr);
+	split_page_owner(head, order, 0);
=20
 	/* See comment in __split_huge_page_tail() */
 	if (PageAnon(head)) {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d982919b9e51..9cac40c26c58 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3514,7 +3514,7 @@ void split_page(struct page *page, unsigned int order)
=20
 	for (i =3D 1; i < (1 << order); i++)
 		set_page_refcounted(page + i);
-	split_page_owner(page, 1 << order);
+	split_page_owner(page, order, 0);
 	split_page_memcg(page, 1 << order, 0);
 }
 EXPORT_SYMBOL_GPL(split_page);
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 0a9588506571..52013c846d19 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -202,19 +202,20 @@ void __set_page_owner_migrate_reason(struct page *pag=
e, int reason)
 	page_owner->last_migrate_reason =3D reason;
 }
=20
-void __split_page_owner(struct page *page, unsigned int nr)
+void __split_page_owner(struct page *page, unsigned short old_order,
+			unsigned short new_order)
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
2.35.1

