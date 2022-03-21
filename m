Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E295A4E2AAE
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Mar 2022 15:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243911AbiCUOaC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Mar 2022 10:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349265AbiCUO1x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Mar 2022 10:27:53 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF471F618;
        Mon, 21 Mar 2022 07:21:38 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 005715C0192;
        Mon, 21 Mar 2022 10:21:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 21 Mar 2022 10:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=tXqvAixMw5LH0Y
        fUtbzaonW6xe08jm3VyFZaFA2A5hg=; b=VoXtG0rUj89HL8a9t9XSClLnA8qdst
        867J3UhDpvuwxZH1/qCkd+tC36HHVUp9+psR0m5rLxjQnCsl11s0X3oEIZn5Ujzu
        8P7ytscIn/61BrN5V0bSaOZoJ5ghBW6G58wME90QPfXVz7Zb5hVceQf8L5ifDwuX
        TFlUEtSJSbguZFydh1JSTHXBo0X57SzRxGnzb5DeH5GbTM18KPl7dexgLXlrPyQl
        i2gbubj0ViTAng/8kTUazkVDGDIrQoWiXWPU7Ns3JWmRr9018v8bf9Fx7FRYM5XN
        fLIW1E77O8zl0GtkXJzleXw1xKF/4EgTJaSNPRocdaffgl2l7TpTWhIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=tXqvAixMw5LH0YfUtbzaonW6xe08jm3VyFZaFA2A5hg=; b=jGBvfn8p
        94GYrztj2DXLXLso38ehz7889cnUZ/x9YmTqksFcoL7VPRu7EQmAqJcHmJJ1KVn4
        xgSpaUyPZ+rb8hdcJH3j0d8+SZJfB1i3cE4Mya3KhGHS8jcLTJ0oxZ3Xq4AvLnfX
        gG1skxrFc3nYWSfQ7TtJlS858djSMdpZR0bXd/kpyRfka1sLmfM/hVGEnombtuyZ
        nT6phmcZVc2ftCk8VdI0w1Y9F2QkOioVmOjUGEoSuR0I5MbXK296E6n935TUIu+X
        eKPKpbCj2pVaJTZGcnhsGfZoS78/jX1ntxu7MDxy+7o+s6+RRAEhvHLg2By6UJIw
        lih5zEh3K0T5mQ==
X-ME-Sender: <xms:8Ik4YmPBKSPY7AB1_Km7Dg_uyfGd7jPI17OlJIDrJoHHLA1bPn01wA>
    <xme:8Ik4Yk9lwOVISvGMFJANGCNLbaNzorGd-YZZ-hOb9Mf7yDBRjg2SS1KlJ52du695V
    e62S91zEemMtPZ7sQ>
X-ME-Received: <xmr:8Ik4YtR0JIwfDe22eBgomB30znqaUTRgojBUy5J5Se8x4F7f838vz5iOOnVGUPSFR41ft3iKQl7WLWqQWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegfedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
    hnthdrtghomh
X-ME-Proxy: <xmx:8Ik4YmuizzwOduHgio7tljaN4WZUOFXjs4RS3Xg0jqbicgWlEKRJSQ>
    <xmx:8Ik4YucNPDFasSjbe-CEfIgZ-dhPZQRP6ZN-ZEOA-YSReEkF5lz7EA>
    <xmx:8Ik4Yq0R6o7HPkTREFv8bgI93s5EtfIB2CdiNUrrza0tXn89ucJn-Q>
    <xmx:8Ik4YvXnbXVgH7fIqUXMWo_g1FmJULbucyFJmXX-dMzapq1bef7xEA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Mar 2022 10:21:36 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Shuah Khan <shuah@kernel.org>, Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 1/5] mm: memcg: make memcg huge page split support any order split.
Date:   Mon, 21 Mar 2022 10:21:24 -0400
Message-Id: <20220321142128.2471199-2-zi.yan@sent.com>
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

It sets memcg information for the pages after the split. A new parameter
new_order is added to tell the new page order, always 0 for now. It
prepares for upcoming changes to support split huge page to any lower
order.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/memcontrol.h |  2 +-
 mm/huge_memory.c           |  2 +-
 mm/memcontrol.c            | 10 +++++-----
 mm/page_alloc.c            |  2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 89b14729d59f..e71189454bf0 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1116,7 +1116,7 @@ static inline void memcg_memory_event_mm(struct mm_st=
ruct *mm,
 	rcu_read_unlock();
 }
=20
-void split_page_memcg(struct page *head, unsigned int nr);
+void split_page_memcg(struct page *head, unsigned int nr, unsigned int new=
_order);
=20
 unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 						gfp_t gfp_mask,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2fe38212e07c..640040c386f0 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2371,7 +2371,7 @@ static void __split_huge_page(struct page *page, stru=
ct list_head *list,
 	int i;
=20
 	/* complete memcg works before add pages to LRU */
-	split_page_memcg(head, nr);
+	split_page_memcg(head, nr, 0);
=20
 	if (PageAnon(head) && PageSwapCache(head)) {
 		swp_entry_t entry =3D { .val =3D page_private(head) };
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 43b2a22ce812..e7da413ac174 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3262,22 +3262,22 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, =
size_t size)
 /*
  * Because page_memcg(head) is not set on tails, set it now.
  */
-void split_page_memcg(struct page *head, unsigned int nr)
+void split_page_memcg(struct page *head, unsigned int nr, unsigned int new=
_order)
 {
 	struct folio *folio =3D page_folio(head);
 	struct mem_cgroup *memcg =3D folio_memcg(folio);
-	int i;
+	int i, new_nr =3D 1 << new_order;
=20
 	if (mem_cgroup_disabled() || !memcg)
 		return;
=20
-	for (i =3D 1; i < nr; i++)
+	for (i =3D new_nr; i < nr; i +=3D new_nr)
 		folio_page(folio, i)->memcg_data =3D folio->memcg_data;
=20
 	if (folio_memcg_kmem(folio))
-		obj_cgroup_get_many(__folio_objcg(folio), nr - 1);
+		obj_cgroup_get_many(__folio_objcg(folio), nr / new_nr - 1);
 	else
-		css_get_many(&memcg->css, nr - 1);
+		css_get_many(&memcg->css, nr / new_nr - 1);
 }
=20
 #ifdef CONFIG_MEMCG_SWAP
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f648decfe39d..d982919b9e51 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3515,7 +3515,7 @@ void split_page(struct page *page, unsigned int order)
 	for (i =3D 1; i < (1 << order); i++)
 		set_page_refcounted(page + i);
 	split_page_owner(page, 1 << order);
-	split_page_memcg(page, 1 << order);
+	split_page_memcg(page, 1 << order, 0);
 }
 EXPORT_SYMBOL_GPL(split_page);
=20
--=20
2.35.1

