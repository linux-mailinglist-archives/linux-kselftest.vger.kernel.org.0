Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67FA42B9759
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Nov 2020 17:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgKSQGj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Nov 2020 11:06:39 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:59533 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727677AbgKSQGj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Nov 2020 11:06:39 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 45ADFE24;
        Thu, 19 Nov 2020 11:06:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 19 Nov 2020 11:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=BRsajNq/mgBRP
        PZp1kutKtKmDBoBjDe/+SYMX/W0D0U=; b=FDLz6gJ+dO7knnH13FpyK8TQaxf+W
        EYqy2fEmmEG/IteDYR+ZIaWGci0rTPS7vM/oetlWgX+QVU0g41WT/Ou2ffqfgZds
        ExXBpCw6ptAB1Mv4f5aF2OSAUMj81CsSoglgZ0T20E3lklRHuCYdLCq0NkrFRvZp
        OdS9XqWyKCz7c5NavdDtXD3/6k7dUVUgj7vkV2U/fbIKkKtzlMyULtYV2ZlEyOFJ
        Sb+XcLsvN1GgHCf3lBhPst9rcYvLSCENpVfjqQTPcRYsevrcwAkqUTxopNNGhIUd
        Ohx+5HQW3nR2lTGKpBnP43IGtby7KqJEybOujQ8++9bI9+r42SA4Y502w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=BRsajNq/mgBRPPZp1kutKtKmDBoBjDe/+SYMX/W0D0U=; b=A1v6B0Ra
        SEHovgQKtdi3lWD/XaTW6wvMauUHvKQBSs8n2sQSI/HszBpuYS5deYD2sE0oQWGn
        KhBTR2Dqw3hysWRElAx0QaGKqlUXZCO84PXqauI3oqyLZ0XBhhOsbzDz3qJie+QY
        efBDx6pv1qWH3qgZMlR8EwUFjwwQpBDOZ1fLXi60k2UtzwUfAAIqKO8KvbFv3eUR
        b5Hrvn8TctVtEfHd510qV1b+7ZMhXlpfgVSYsot+zeId0txzHerLBR6HS0bwL6Yz
        uxByuDuCMR67r0e+lqMJfobqelQf8PtazJRoJIjQ0wRRKbdLcTVKwCLl4uOIXr4c
        65Avdcmq85GcpA==
X-ME-Sender: <xms:DJi2X0zN7U2C28TdcWbBCCS_GanCZNFjEpGFQtF2ASF_W0ZBjlCugg>
    <xme:DJi2X4TNuEZlAx31A5FzaoV2Bska0i8prF6Ao3VLQAQDhb9CZP3hwNW2fVak5n-fI
    3l_8hO5HTz19Gv58w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefjedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecukfhppedu
    vddrgeeirddutdeirdduieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:DJi2X2VxZArE5mCYUqNioVTdYR7A7duAXqQOdzS8P4BNTOg_fmohAg>
    <xmx:DJi2XyhypA5-9Zd235FTOR7mculfMPqaPrHyJT7yQpzSfVq5mu-3aw>
    <xmx:DJi2X2BPuCPtlL4tZtfjYe3tA1q4FSyvpdMuDdbEfEduHEz4YEUYVg>
    <xmx:DJi2X655UQquyb_1b7JBd9BZaEtz8-88lcSQP_4-dl7tA2MyOHYdh5tQ6nE>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id D12EE3064AAE;
        Thu, 19 Nov 2020 11:06:35 -0500 (EST)
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
Subject: [PATCH 1/7] XArray: Fix splitting to non-zero orders
Date:   Thu, 19 Nov 2020 11:05:59 -0500
Message-Id: <20201119160605.1272425-2-zi.yan@sent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201119160605.1272425-1-zi.yan@sent.com>
References: <20201119160605.1272425-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Splitting an order-4 entry into order-2 entries would leave the array
containing pointers to 000040008000c000 instead of 000044448888cccc.
This is a one-character fix, but enhance the test suite to check this
case.

Reported-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 lib/test_xarray.c | 26 ++++++++++++++------------
 lib/xarray.c      |  4 ++--
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 8294f43f4981..8b1c318189ce 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -1530,24 +1530,24 @@ static noinline void check_store_range(struct xarra=
y *xa)
=20
 #ifdef CONFIG_XARRAY_MULTI
 static void check_split_1(struct xarray *xa, unsigned long index,
-							unsigned int order)
+				unsigned int order, unsigned int new_order)
 {
-	XA_STATE(xas, xa, index);
-	void *entry;
-	unsigned int i =3D 0;
+	XA_STATE_ORDER(xas, xa, index, new_order);
+	unsigned int i;
=20
 	xa_store_order(xa, index, order, xa, GFP_KERNEL);
=20
 	xas_split_alloc(&xas, xa, order, GFP_KERNEL);
 	xas_lock(&xas);
 	xas_split(&xas, xa, order);
+	for (i =3D 0; i < (1 << order); i +=3D (1 << new_order))
+		__xa_store(xa, index + i, xa_mk_index(index + i), 0);
 	xas_unlock(&xas);
=20
-	xa_for_each(xa, index, entry) {
-		XA_BUG_ON(xa, entry !=3D xa);
-		i++;
+	for (i =3D 0; i < (1 << order); i++) {
+		unsigned int val =3D index + (i & ~((1 << new_order) - 1));
+		XA_BUG_ON(xa, xa_load(xa, index + i) !=3D xa_mk_index(val));
 	}
-	XA_BUG_ON(xa, i !=3D 1 << order);
=20
 	xa_set_mark(xa, index, XA_MARK_0);
 	XA_BUG_ON(xa, !xa_get_mark(xa, index, XA_MARK_0));
@@ -1557,14 +1557,16 @@ static void check_split_1(struct xarray *xa, unsign=
ed long index,
=20
 static noinline void check_split(struct xarray *xa)
 {
-	unsigned int order;
+	unsigned int order, new_order;
=20
 	XA_BUG_ON(xa, !xa_empty(xa));
=20
 	for (order =3D 1; order < 2 * XA_CHUNK_SHIFT; order++) {
-		check_split_1(xa, 0, order);
-		check_split_1(xa, 1UL << order, order);
-		check_split_1(xa, 3UL << order, order);
+		for (new_order =3D 0; new_order < order; new_order++) {
+			check_split_1(xa, 0, order, new_order);
+			check_split_1(xa, 1UL << order, order, new_order);
+			check_split_1(xa, 3UL << order, order, new_order);
+		}
 	}
 }
 #else
diff --git a/lib/xarray.c b/lib/xarray.c
index fc70e37c4c17..74915ba018c4 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1012,7 +1012,7 @@ void xas_split_alloc(struct xa_state *xas, void *entr=
y, unsigned int order,
=20
 	do {
 		unsigned int i;
-		void *sibling;
+		void *sibling =3D NULL;
 		struct xa_node *node;
=20
 		node =3D kmem_cache_alloc(radix_tree_node_cachep, gfp);
@@ -1022,7 +1022,7 @@ void xas_split_alloc(struct xa_state *xas, void *entr=
y, unsigned int order,
 		for (i =3D 0; i < XA_CHUNK_SIZE; i++) {
 			if ((i & mask) =3D=3D 0) {
 				RCU_INIT_POINTER(node->slots[i], entry);
-				sibling =3D xa_mk_sibling(0);
+				sibling =3D xa_mk_sibling(i);
 			} else {
 				RCU_INIT_POINTER(node->slots[i], sibling);
 			}
--=20
2.28.0

