Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7432B9758
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Nov 2020 17:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgKSQGj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Nov 2020 11:06:39 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:55839 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727981AbgKSQGj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Nov 2020 11:06:39 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 48A33EB3;
        Thu, 19 Nov 2020 11:06:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 19 Nov 2020 11:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:reply-to:mime-version
        :content-transfer-encoding; s=fm2; bh=dLIW2nC3tgzPsBDCQkc84OS0Xh
        6vYPtftB1fXGqMVrI=; b=CpLtsr98SAgyFocJmYPq07EdmM+nUV6FzPJYWWJgge
        uiXti30M5OSRaoBzKg8GnTsPYzK7g/gAggENapK7Qv6HB+BWTPTLtAuZdjv1qj4R
        U4uqWKKTPBpxzWpdrNznwrWVmIINwble7/Li2stsRfMGyeFJRyPFkde874AzqLxy
        jHFDMKnrtdRniFI+2m0BZ/D/zjzDPn/46mkcROetBbhhmW02fGSSpKaMkxj37Ik0
        skRr5u+cobycP44DTQnm4RZ5XYdCRBcPSLAiTg+FGPxT0lwXn+jFjUmpxcYS1S78
        VQIHWK2m/qAzD6eAsynV/gUt6tUlNoNcLPyG2ihElECg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:reply-to:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=dLIW2n
        C3tgzPsBDCQkc84OS0Xh6vYPtftB1fXGqMVrI=; b=Wqb5mKKBMz+CgrkhqAIS+c
        6n0qS28piVAUuYE/2lAlkXyh/V7AEJpkYp1T3T72GQwP6Aud1J4dB3SG5IacDL3m
        Xo6Rr4iXB4citonkIzWgxRtadEbZXAv7kxZ4zhV12XCUikTtngRdTaomCOx2af3m
        AZkCShsQ2rC26YZNlunpo+WrtwgCVdbexfwaA3xDFjtQ2P5rlYHkpgzW/WynQW/e
        1vnI/Onl9XyuDHVcjBTGgGqvnKSv2MDfkYE9d1JTDS7bJKpQ3lytRinmgR6JumCm
        vpyGgWR8gEzK5aOpOX6Q8QIR9AXOsURux6MMmx028q5GuEkWzM7EhmIYjWGemufg
        ==
X-ME-Sender: <xms:C5i2X0zmamBJSAekduwBv9SinzZpoaqMtswL5WknwyRh-WpVlfEnZA>
    <xme:C5i2X4RycpY8PZkcWHRScVWFODpMy5eeD4v2gSLlkAxwtOQ952ML48TLp1ABC2NcM
    FT5JfajMlizIo4YmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefjedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkfforhgggfestdhqredtredttdenucfhrhhomhepkghiucgjrghn
    uceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepgeegieehgf
    effeffleefgeevueegvdffteffhefhkeevvddtjedvudeljeetvdegnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghdpihhnfhhrrgguvggrugdrohhrghenucfkphepuddvrdegie
    druddtiedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:DJi2X2WyreJFWfI3VxQtDtVzQOIUer0OyDF3Z7JvagrlVaeZ34GH_w>
    <xmx:DJi2XygfO-LDIdRkAHQVNnZuk09AUGN_ThLnH0zhkmqsQ4Bvi1RzdA>
    <xmx:DJi2X2D4TRYUvpakkdlsy_dxyuwMcYcKnQ0CXJFh9J_INxml-tNRnw>
    <xmx:DJi2X65io2HLwE5IljfqP7WMFnzQIewA_9oxPjxNWaWE_S3Rvv2G4dgNX-g>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8953D3064AAA;
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
Subject: [PATCH 0/7] Split huge pages to any lower order pages and selftests.
Date:   Thu, 19 Nov 2020 11:05:58 -0500
Message-Id: <20201119160605.1272425-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.28.0
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Hi all,

With Matthew's THP in pagecache patches[1], we will be able to handle any s=
ize
pagecache THPs, but currently split_huge_page can only split a THP to order=
-0
pages. This can easily erase the benefit of having pagecache THPs, when
operations like truncate might want to keep pages larger than order-0. In
response, here is the patches to add support for splitting a THP to any low=
er
order pages. In addition, this patchset prepares for my PUD THP patchset[2],
since splitting a PUD THP to multiple PMD THPs can be handled by
split_huge_page_to_list_to_order function added by this patchset, which red=
uces
a lot of redundant code without just replicating split_huge_page for PUD TH=
P.

To help the tests of splitting huge pages, I added a new debugfs interface
at <debugfs>/split_huge_pages_in_range_pid, so developers can split THPs in=
 a
given range from a process with the given pid by writing
"<pid>,<vaddr_start>,<vaddr_end>,<to_order>" to the interface. I also added=
 a
new test program to test 1) splitting PMD THPs, 2) splitting PTE-mapped THP=
s,
3) splitting pagecache THPs to any lower order, 4) truncating a pagecache
THP to a page with a lower order, and 5) punching holes in a pagecache THP =
to
cause splitting THPs to lower order THPs.

The patchset is on top of Matthew's pagecache/next tree[3].

* Patch 1 is cherry-picked from Matthew's recent xarray fix [4] just to mak=
e sure
  Patch 3 to 7 can run without problem. I let Matthew decide how it should =
get
  picked up.
* Patch 2 is self-contained and can be merged if it looks OK.

Comments and/or suggestions are welcome.

ChangeLog
=3D=3D=3D
From RFC:
1. Fixed debugfs to handle splitting PTE-mapped THPs properly and added sta=
ts
   for split THPs.
2. Added a new test case for splitting PTE-mapped THPs. Each of the four PT=
Es
   points to a different subpage from four THPs and used kpageflags to check
   whether a PTE points to a THP or not (AnonHugePages from smap does not s=
how
   PTE-mapped THPs).
3. mem_cgroup_split_huge_fixup() takes order instead of nr.
4. split_page_owner takes old_order and new_order instead of nr and new_ord=
er.
5. Corrected __split_page_owner declaration and fixed its implementation wh=
en
   splitting a THP to a new order.
6. Renamed left to remaining in truncate_inode_partial_page().
7. Use VM_BUG_ON instead of WARN_ONCE when splitting a THP to the unsupport=
ed
   order-0 and splitting anonymous THPs to non-zero orders.
8. Added punching holes in a file as a new pagecache THP split test case, w=
hich
   uncovered an xarray bug.


[1] https://lore.kernel.org/linux-mm/20201029193405.29125-1-willy@infradead=
.org/
[2] https://lore.kernel.org/linux-mm/20200928175428.4110504-1-zi.yan@sent.c=
om/
[3] https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads=
/next
[4] https://git.infradead.org/users/willy/xarray.git


Matthew Wilcox (Oracle) (1):
  XArray: Fix splitting to non-zero orders

Zi Yan (6):
  mm: huge_memory: add new debugfs interface to trigger split huge page
    on any page range.
  mm: memcg: make memcg huge page split support any order split.
  mm: page_owner: add support for splitting to any order in split
    page_owner.
  mm: thp: split huge page to any lower order pages.
  mm: truncate: split thp to a non-zero order if possible.
  mm: huge_memory: enable debugfs to split huge pages to any order.

 include/linux/huge_mm.h                       |   8 +
 include/linux/memcontrol.h                    |   5 +-
 include/linux/page_owner.h                    |  10 +-
 lib/test_xarray.c                             |  26 +-
 lib/xarray.c                                  |   4 +-
 mm/huge_memory.c                              | 219 ++++++--
 mm/internal.h                                 |   1 +
 mm/memcontrol.c                               |   6 +-
 mm/migrate.c                                  |   2 +-
 mm/page_alloc.c                               |   2 +-
 mm/page_owner.c                               |  13 +-
 mm/swap.c                                     |   1 -
 mm/truncate.c                                 |  29 +-
 tools/testing/selftests/vm/.gitignore         |   1 +
 tools/testing/selftests/vm/Makefile           |   1 +
 .../selftests/vm/split_huge_page_test.c       | 479 ++++++++++++++++++
 16 files changed, 742 insertions(+), 65 deletions(-)
 create mode 100644 tools/testing/selftests/vm/split_huge_page_test.c

--
2.28.0

