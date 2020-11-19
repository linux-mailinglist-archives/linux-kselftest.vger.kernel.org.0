Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D632B975F
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Nov 2020 17:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgKSQGs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Nov 2020 11:06:48 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:42993 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728011AbgKSQGk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Nov 2020 11:06:40 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 4C3739A7;
        Thu, 19 Nov 2020 11:06:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 19 Nov 2020 11:06:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=2kAA7JKtM0LAG
        LniO91Baa3+LL5SEw62I50GNU8Qx8M=; b=O+FbeQZVoV7W8KIaKkXLaGiTMIsop
        DmnkQYD+8L+63x7o6MyZgIuTLRxGqFNEr8dODmcXkV1ouvJWGsfRmwz39u9dz3bR
        lTxE5vuI8AP4hX8r50ZicCwB9OIOszq2VeKz9E6u59iGUUHy2+jzkkGD0k+GrL7a
        yQskYbF0+Zv/VOWFW0UAEKkx0zNTmKTxMbu7z/MnHsgYDMJd/tRyN6BuybBQ4rz/
        q2Sf+K3YNtLKr1+oacLZTCFnX9yNjbxpYkT1d6DHzDq7JiCo5462PO26bYHrbuOx
        Y1b55JN+MZzyVSwQStXSDoHWZfqhzBkvPui8OsIF48d/lJiiIAR61NEhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=2kAA7JKtM0LAGLniO91Baa3+LL5SEw62I50GNU8Qx8M=; b=QxKk4jGi
        +Ux36MDxnvR1hin/0kHifq4oqgG2YX70h8w0x68zowUSvCTqjms9t3Es8pHr/tZl
        UTE/gOgoh/qrNRK2aRNWPJV5Zd0ey0Mji7PhviLWDeP2CMLRNCANnmPYH0vdiRii
        kzclPTuemaTRjPWlcTVD2GTq6BKptncn0s/E2RmJ8Xe61v1lOY6tS9VwoZee1BRs
        DZysnvCxDH49ktYecBjMSI2OL/WYpUSJe+JXlf5+no9ulzi3hgglT9e/DLJuAh9r
        Rcpl7sbMyYoyy2OMAQN8jKapVAMNyE1BV23FtpmetMsgI9xH8N8wb1rHgoQN6wG7
        fPYRQVbi3AOzRg==
X-ME-Sender: <xms:DZi2X6ZVkVNRr7ClONEnZKmrjoz9QuAS7oBqf5zu9LxTMUN7ndWZ5g>
    <xme:DZi2X9a30lhLMmHFz2v1_uBdKcPSSQadKfcAZZKplK5mzL-ne0kHSP7mkfSqklZAb
    LDsAWMpuqQPIzAoJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefjedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecukfhppedu
    vddrgeeirddutdeirdduieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:DZi2X0_iiie-_ur1IFm8punfMxr3eaONjKAGYjEJwolwzSg5rU0cWg>
    <xmx:DZi2X8rBLAUblV6uX-10E9-6gf7WxwD9IVfIGCEx3wp2Is_dXPQQ5Q>
    <xmx:DZi2X1rDpXi1sdMtQrN5fI56VkiYE1rdXTx-pDmXGa8V96L0y-DD2Q>
    <xmx:DZi2Xyjgy8LyoZoGaT3i0hcVu_YJfkvNxggDlS7avr0HOul58kluLsafKgA>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4652D3064AB9;
        Thu, 19 Nov 2020 11:06:37 -0500 (EST)
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
Subject: [PATCH 6/7] mm: truncate: split thp to a non-zero order if possible.
Date:   Thu, 19 Nov 2020 11:06:04 -0500
Message-Id: <20201119160605.1272425-7-zi.yan@sent.com>
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

To minimize the number of pages after a truncation, when truncating a
THP, we do not need to split it all the way down to order-0. The THP has
at most three parts, the part before offset, the part to be truncated,
the part left at the end. Use the non-zero minimum of them to decide
what order we split the THP to.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/truncate.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 20bd17538ec2..2e93d702f2c6 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -237,7 +237,9 @@ int truncate_inode_page(struct address_space *mapping, =
struct page *page)
 bool truncate_inode_partial_page(struct page *page, loff_t start, loff_t e=
nd)
 {
 	loff_t pos =3D page_offset(page);
-	unsigned int offset, length;
+	unsigned int offset, length, remaining, min_subpage_size =3D PAGE_SIZE;
+	unsigned int new_order;
+
=20
 	if (pos < start)
 		offset =3D start - pos;
@@ -248,6 +250,7 @@ bool truncate_inode_partial_page(struct page *page, lof=
f_t start, loff_t end)
 		length =3D length - offset;
 	else
 		length =3D end + 1 - pos - offset;
+	remaining =3D thp_size(page) - offset - length;
=20
 	wait_on_page_writeback(page);
 	if (length =3D=3D thp_size(page)) {
@@ -267,7 +270,29 @@ bool truncate_inode_partial_page(struct page *page, lo=
ff_t start, loff_t end)
 		do_invalidatepage(page, offset, length);
 	if (!PageTransHuge(page))
 		return true;
-	return split_huge_page(page) =3D=3D 0;
+
+	/*
+	 * find the non-zero minimum of offset, length, and remaining and use it
+	 * to decide the new order of the page after split
+	 */
+	if (offset && remaining)
+		min_subpage_size =3D min_t(unsigned int,
+					 min_t(unsigned int, offset, length),
+					 remaining);
+	else if (!offset)
+		min_subpage_size =3D min_t(unsigned int, length, remaining);
+	else /* remaining =3D=3D 0 */
+		min_subpage_size =3D min_t(unsigned int, length, offset);
+
+	min_subpage_size =3D max_t(unsigned int, PAGE_SIZE, min_subpage_size);
+
+	new_order =3D ilog2(min_subpage_size/PAGE_SIZE);
+
+	/* order-1 THP not supported, downgrade to order-0 */
+	if (new_order =3D=3D 1)
+		new_order =3D 0;
+
+	return split_huge_page_to_list_to_order(page, NULL, new_order) =3D=3D 0;
 }
=20
 /*
--=20
2.28.0

