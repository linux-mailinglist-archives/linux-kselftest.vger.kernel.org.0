Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579582AF9F6
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Nov 2020 21:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgKKUqE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Nov 2020 15:46:04 -0500
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:38003 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726899AbgKKUqC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Nov 2020 15:46:02 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 51EADB2F;
        Wed, 11 Nov 2020 15:40:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 11 Nov 2020 15:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:reply-to:mime-version
        :content-transfer-encoding; s=fm2; bh=2sl0hzEO2/NiJTtpzxt0U3pBP+
        C9s4dcDTT4dzafDPo=; b=ArZDMod3L9ZYYUSziIS9vaKt50TESpps3cLmeg9cG0
        7RFLLYc2uxpPVSsLuqytAhBjqsOqMHo0zjS3HmWwrlUy7MwPnpNJcQFdyEyW52MR
        hh0XmwvBSkPL8t/aqGulika0uVtWECwx6tuWexYIoEVxk0WblYzRqPWdN+SMqVBb
        CN6BfJ53OXdFQFZt46/9v7XC5T+8AThGu18Xla/wVC2D0a45FCjnnW2sdGjkfBaP
        Ve5jqXi2xFvU2236mGX4gDDYjzW9zgh7ll3eVu9DXr3Q/86AxZ/DAwWE2SjUm5C9
        JiDCGA6qTudBRb2503yPvVwodkeseg1O0O1rWZbxQx8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:reply-to:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=2sl0hz
        EO2/NiJTtpzxt0U3pBP+C9s4dcDTT4dzafDPo=; b=fO5NrhfvxbYIOoJbO3uzLL
        2TfDImSoUqelLhT5J1WOHlHKi20wwXm1klVWQLaZgw25t+5et257/iTS9wVNdJeW
        tIVvvAtvaylEI5ht5QrTrGwxkrDCjlD4RxE1c6SnUTg3cKlpqCtS/t8OYkF//TQx
        9OPBj44o9hIUr/2oGimltmbOt69MWxpYIvDTNgRmI4lJ3tY7Twda1yJSltRbidv1
        f3RRupFNhhgok/q6i2lVyPkEw7kCq/2ieMFf4CcFt/EKAurez3jB0ipzQj0+X7Uf
        vxejILPZtBqsOMK+yKrGtfG/LujfSzS/JMNn2nA9hYIN9PaD64MqkmAYTBbHP3NA
        ==
X-ME-Sender: <xms:R0ysX62azZ03rJ0LDEQi_3o_MZMVvZipVPvLhKY5H3JL0kvdRKFOnQ>
    <xme:R0ysX9Fl9M7DVKDsWN-lgrkQFbBcxCTTfL_Dq3T-utCm4Jg5VxmMFiJjMnk6mjxVk
    9QPi1lG-D1TklMbqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvtddgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkfforhgggfestdhqredtredttdenucfhrhhomhepkghiucgjrghn
    uceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepgeegieehgf
    effeffleefgeevueegvdffteffhefhkeevvddtjedvudeljeetvdegnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghdpihhnfhhrrgguvggrugdrohhrghenucfkphepuddvrdegie
    druddtiedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:R0ysXy54lcMwo_U0_3FLuD4fDau2haZm8RaKOSBbLfO-oGcLbitDfw>
    <xmx:R0ysX73r6IPU5Bu8p718QtwSSrPIQ_W3-Mas5VEEYbp5_d5-5ZGVng>
    <xmx:R0ysX9Hxd-LGVCu8_5yo2NTiPK8bjAw3p8oJ3AoXp3GFOyxmlVNP1A>
    <xmx:SEysX1-acvPmjEts6HIFY_2A-63p8PQFRYP_SqpPieLMtufC6imkdnDr810>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 833F3328006A;
        Wed, 11 Nov 2020 15:40:39 -0500 (EST)
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
Subject: [RFC PATCH 0/6] Split huge pages to any lower order pages.
Date:   Wed, 11 Nov 2020 15:40:02 -0500
Message-Id: <20201111204008.21332-1-zi.yan@sent.com>
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

The patchset is on top of Matthew's pagecache/next tree[3].

To ease the tests of split_huge_page functions, I added a new debugfs inter=
face
at <debugfs>/split_huge_pages_in_range_pid, so developers can split THPs in=
 a
given range from a process with the given pid by writing
"<pid>,<vaddr_start>,<vaddr_end>,<to_order>" to the interface. I also added=
 a
new test program to test 1) split PMD THPs, 2) split pagecache THPs to any =
lower
order, and 3) truncating a pagecache THP to a page with a lower order.

Suggestions and comments are welcome. Thanks.


[1] https://lore.kernel.org/linux-mm/20201029193405.29125-1-willy@infradead=
.org/
[2] https://lore.kernel.org/linux-mm/20200928175428.4110504-1-zi.yan@sent.c=
om/
[3] https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads=
/next

Zi Yan (6):
  mm: huge_memory: add new debugfs interface to trigger split huge page
    on any page range.
  mm: memcg: make memcg huge page split support any order split.
  mm: page_owner: add support for splitting to any order in split
    page_owner.
  mm: thp: add support for split huge page to any lower order pages.
  mm: truncate: split thp to a non-zero order if possible.
  mm: huge_memory: enable debugfs to split huge pages to any order.

 include/linux/huge_mm.h                       |   8 +
 include/linux/memcontrol.h                    |   5 +-
 include/linux/page_owner.h                    |   7 +-
 mm/huge_memory.c                              | 177 ++++++++++--
 mm/internal.h                                 |   1 +
 mm/memcontrol.c                               |   4 +-
 mm/migrate.c                                  |   2 +-
 mm/page_alloc.c                               |   2 +-
 mm/page_owner.c                               |   6 +-
 mm/swap.c                                     |   1 -
 mm/truncate.c                                 |  22 +-
 tools/testing/selftests/vm/Makefile           |   1 +
 .../selftests/vm/split_huge_page_test.c       | 255 ++++++++++++++++++
 13 files changed, 453 insertions(+), 38 deletions(-)
 create mode 100644 tools/testing/selftests/vm/split_huge_page_test.c

--
2.28.0

