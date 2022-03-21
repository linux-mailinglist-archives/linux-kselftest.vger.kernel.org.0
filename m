Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4519F4E2AAC
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Mar 2022 15:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349471AbiCUOaA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Mar 2022 10:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349269AbiCUO1x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Mar 2022 10:27:53 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6621FCDE;
        Mon, 21 Mar 2022 07:21:39 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id EA8175C01CE;
        Mon, 21 Mar 2022 10:21:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 21 Mar 2022 10:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=kIpuEveA7/YbA0
        pSxKdFASwEtWdRLdBg+ont8QAUBuo=; b=CibfHPfPc9bJSaTTlmtIw04wVD3Dd8
        3VqLqKQ5Qj071muc/kNIs2STVuogk3JFo13FuAM03CbTtbgDmccuFLrp16kcWIFO
        d8hl8FQdMKdjmKXPCk8wtZrl7DxcvoIkEU6WPV5hxZfDz6lMpV6fIMjLkx/76nna
        EiQGdMJQ4AHaL7eEaHpuGV9NSE8Jz4Uyw4k7ck2Xv9E4nyia9/ltn8+f8P4NCO4S
        pWq2hAlxRldvFm0hWFywi+rVo9wSbo+fCZjdR9azvHjTXQYxlq5iIoHuX4RkIEVm
        FQSLn+aFimBxOseDQcxdLoDoRcSy19BnL6Vr8ZjP8+p6fihROf/0XYog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=kIpuEveA7/YbA0pSxKdFASwEtWdRLdBg+ont8QAUBuo=; b=E/noCP1M
        yVMAjJAqn0BOQsC1e5+7xwiXuijpihKmellqXIdOMkNlCUVSAxhx4Kd+SpYbrHZC
        859nDk2ffs3FaMVJ2H8nYHlyBwQfulEJt82/xmqBk35GfQl17pHlh+LsRT5amo9F
        9fHbMugbzGkL1bUPv04Em/0LCmEuKSST9ks7BXA+EtCtAejx77G71LwjzTDABnRk
        QC+4FeO+2n45rW13BcrSz+Rb+rhR+ykehSmSEa2+UEGc/q3br86XTzp0kPBFcpjg
        NGv2FBJh9ZEVa9hqzEd15pOAjSLI0fyr4n8FHDlffeWtOwjp5cEWta7I5OOKO5aj
        5TsOJLkr5wx+Vw==
X-ME-Sender: <xms:8ok4Yvyx2Y4rmB8vgpSk5Vd0JKiiiLfd5odGgubX4dlbbebC9emlOg>
    <xme:8ok4YnRM30xJZG464CJt47IYCmB_sZNdakuCc6K3TGvGLb9mM1GWtf7dLCGxbUbS-
    DtSw_S9nbc2eHKkaA>
X-ME-Received: <xmr:8ok4YpUdFGQUuglGUBVCAsmRvSenu9vuZgxCRVNJ0ystdMzYKq7fDgPzrOkRYKy4TrHs7UJaYM5AWN2kYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegfedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
    hnthdrtghomh
X-ME-Proxy: <xmx:8ok4YpjiY29Vk8-sYJe-nTeUq10NlwFylfI6VyNd9tcYN7rcSoKmFw>
    <xmx:8ok4YhDPfxttA_FU7L43RXpXQYecnzVPQ8FWvljY8K_BpzwjvVAreA>
    <xmx:8ok4YiImGs2_VFNWuF2UiDtHjVAMPc96Eb5klJSjSR75TLTLdfyynQ>
    <xmx:8ok4Yl5FuF6JNAsuQZZsYVd0VmeEJpeYh9mFj6AR-Hy9vSYPOROj6g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Mar 2022 10:21:38 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Shuah Khan <shuah@kernel.org>, Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 4/5] mm: truncate: split huge page cache page to a non-zero order if possible.
Date:   Mon, 21 Mar 2022 10:21:27 -0400
Message-Id: <20220321142128.2471199-5-zi.yan@sent.com>
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

To minimize the number of pages after a huge page truncation, we do not
need to split it all the way down to order-0. The huge page has at most
three parts, the part before offset, the part to be truncated, the part
remaining at the end. Find the greatest common power of two multiplier of
the non-zero values of them as the new order, so we can split the huge
page to this order and keep the remaining pages as large and as few as
possible.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c |  1 +
 mm/truncate.c    | 33 +++++++++++++++++++++++++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3617aa3ad0b1..76db0092a1e2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2349,6 +2349,7 @@ static void __split_huge_page_tail(struct page *head,=
 int tail,
 		prep_compound_page(page_tail, new_order);
 		prep_transhuge_page(page_tail);
 	}
+	VM_BUG_ON_PAGE(PageTail(page_tail), page_tail);
=20
 	/* Finally unfreeze refcount. Additional reference from page cache. */
 	page_ref_unfreeze(page_tail, 1 + ((!PageAnon(head) ||
diff --git a/mm/truncate.c b/mm/truncate.c
index ab50d0d59a2a..4f71e67dec09 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -197,6 +197,14 @@ int truncate_inode_folio(struct address_space *mapping=
, struct folio *folio)
 	return 0;
 }
=20
+static unsigned int greatest_pow_of_two_multiplier(unsigned int num)
+{
+	if (num & 1)
+		return 0;
+	return min_t(unsigned int, ilog2(num),
+		ilog2(num - rounddown_pow_of_two(num)));
+}
+
 /*
  * Handle partial folios.  The folio may be entirely within the
  * range if a split has raced with us.  If not, we zero the part of the
@@ -211,7 +219,8 @@ int truncate_inode_folio(struct address_space *mapping,=
 struct folio *folio)
 bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_=
t end)
 {
 	loff_t pos =3D folio_pos(folio);
-	unsigned int offset, length;
+	unsigned int offset, length, remaining;
+	unsigned int new_order =3D folio_order(folio);
=20
 	if (pos < start)
 		offset =3D start - pos;
@@ -222,6 +231,7 @@ bool truncate_inode_partial_folio(struct folio *folio, =
loff_t start, loff_t end)
 		length =3D length - offset;
 	else
 		length =3D end + 1 - pos - offset;
+	remaining =3D folio_size(folio) - offset - length;
=20
 	folio_wait_writeback(folio);
 	if (length =3D=3D folio_size(folio)) {
@@ -236,11 +246,30 @@ bool truncate_inode_partial_folio(struct folio *folio=
, loff_t start, loff_t end)
 	 */
 	folio_zero_range(folio, offset, length);
=20
+	/*
+	 * Find the greatest common power of two multiplier of the non-zero
+	 * offset, length, and remaining as the new order. So we can truncate
+	 * a subpage as large as possible.
+	 */
+	if (offset)
+		new_order =3D greatest_pow_of_two_multiplier(offset / PAGE_SIZE);
+	if (length)
+		new_order =3D min_t(unsigned int, new_order,
+			greatest_pow_of_two_multiplier(length / PAGE_SIZE));
+	if (remaining)
+		new_order =3D min_t(unsigned int, new_order,
+			greatest_pow_of_two_multiplier(remaining / PAGE_SIZE));
+
+	/* order-1 THP not supported, downgrade to order-0 */
+	if (new_order =3D=3D 1)
+		new_order =3D 0;
+
+
 	if (folio_has_private(folio))
 		folio_invalidate(folio, offset, length);
 	if (!folio_test_large(folio))
 		return true;
-	if (split_huge_page(&folio->page) =3D=3D 0)
+	if (split_huge_page_to_list_to_order(&folio->page, NULL, new_order) =3D=
=3D 0)
 		return true;
 	if (folio_test_dirty(folio))
 		return false;
--=20
2.35.1

