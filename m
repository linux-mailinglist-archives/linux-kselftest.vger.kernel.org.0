Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7FC4E2AA7
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Mar 2022 15:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349100AbiCUO3G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Mar 2022 10:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349266AbiCUO1x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Mar 2022 10:27:53 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E38C1EC64;
        Mon, 21 Mar 2022 07:21:38 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 158285C00D8;
        Mon, 21 Mar 2022 10:21:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 21 Mar 2022 10:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=pSy3YPBu+/Cd5RMyqASVwEfmerfJzG0+Vw1/6k
        t87sA=; b=q6QxiZEU+ohV+10FvyUKIjGnTSRoSHlpvgwfEjwGOEAoXLK4/5BGA8
        m5isDzhoavsFa5mTRfFhuqpiaK0YU2MEap8p+gijWkWV5gZPsackzZxZrNqYQN0u
        WrOusrwDGmnpIyYT5bH4G5B1mJcIdnLuVOfj2FgFezdTazAc/ybeah5MOZoCxMUa
        OqYSjAMVUlWz0xA76X07Dnyytc1bJoi4BEcnuATbU2qcb665cPKm8ZwplkCjwh2/
        fwCfScohXyloR60UCfhWwhhDflV2Lln3XbnbrPGPkLTjrUnU6S9aqMrt/zhf/1nd
        RV/Q7cGtRIzVELUCYqnPo15SqGHIDhdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
        :sender:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=pSy3YPBu+/Cd5RMyqASVwEfmerfJz
        G0+Vw1/6kt87sA=; b=LC8/kYesZQOQYQx9X9RDewurhSgCk8hOaVNhxzXVC+nSO
        7IViV8GgubEILjRSAD0WpdYGrzQCq0oyaY8C58B4jZfabDntJ3Bgkur8ivD/SW+X
        g0IzzdzcUMnYYfdRQPqNiWJo9uHfK0i3dl8uy7mxIw3Hj56kh7wqGh9h1nYpaKri
        izkSqQyLhFoq4yt9z0dCrC7rCKLHLDA1G+MZpAPBlXppyrG17MeeUIQcrRAFJq/u
        fVXfQtTWLlMPRXhktgY4w9BJKqimG2jL8Ax35dHwW78GaScamlP39Rgu3XNGGyCs
        Y6kxwK6DC5tpeT9xyrrbszqJKPZy/vVyB0wY+BTnQ==
X-ME-Sender: <xms:74k4YmOs5kcvvsumISPb4PXxlgvnUrjOETRnM1SKOTnJEiLgZuQ9Jg>
    <xme:74k4Yk90Uul-Mq9nWqk8cpt-wDIHP78el9vmNmA4yeYpAJARQtxwvpsIIyP-rluyU
    sHwPF9S22ieve4GAg>
X-ME-Received: <xmr:74k4YtTXzh69-91kmcVwpTrsrOGAx5aDbPzi1QZvNR2ex8QWJ79O8__j_kt06l1h3xqcMRazilgvrSsylA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegfedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkfforhgggfestdhqredtredttdenucfhrhhomhepkghiucgjrghn
    uceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepleetvddtvd
    dttdetffdvkeehffdtjefhkedtheffjeehvdejueektedukedufeffnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvghnth
    drtghomh
X-ME-Proxy: <xmx:74k4YmvJTQhjWY4XgDxgH8_LoSoSxiPwg5Ix_ErkrMcTzVLshSjwuw>
    <xmx:74k4Yueo_CDuci9zK4yYNrzZvt5e87G8o1Xcw0GruJVVlX8WRGQ1Rw>
    <xmx:74k4Yq0QLpO_tR0zmoxSkuJStzuU58SucSM3dR2IR_aX7pmY75qvfA>
    <xmx:8Ik4YvVCixI7snTcY0DJRrx_WuEK400ytexsm9MOHmfPTT5A6-0o9g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Mar 2022 10:21:35 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Shuah Khan <shuah@kernel.org>, Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 0/5] Split a huge page to any lower order pages
Date:   Mon, 21 Mar 2022 10:21:23 -0400
Message-Id: <20220321142128.2471199-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
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

Hi all,

With Matthew's huge pagecache page patches merged, we are able to handle any
size pagecache pages, but currently split_huge_page can only split a huge p=
age
to order-0 pages. This can easily erase the benefit of having huge pagecache
pages, when operations like truncate might want to keep pages larger than
order-0. In response, here is the patches to add support for splitting a hu=
ge
page to any lower order pages.

The patchset is on top of mmotm-2022-03-16-17-42.

* Patch 1 and 2 add new_order parameter split_page_memcg() and
  split_page_owner() and prepare for upcoming changes.
* Patch 3 adds split_huge_page_to_list_to_order() to split a huge page
  to any lower order. The original split_huge_page_to_list() calls
  split_huge_page_to_list_to_order() with new_order =3D 0.
* Patch 4 uses split_huge_page_to_list_to_order() in huge pagecache page
  truncation instead of split the huge page all the way down to order-0.
* Patch 5 adds a test API to debugfs and test cases in
  split_huge_page_test selftests.

Comments and/or suggestions are welcome.

Zi Yan (5):
  mm: memcg: make memcg huge page split support any order split.
  mm: page_owner: add support for splitting to any order in split
    page_owner.
  mm: thp: split huge page to any lower order pages.
  mm: truncate: split huge page cache page to a non-zero order if
    possible.
  mm: huge_memory: enable debugfs to split huge pages to any order.

 include/linux/huge_mm.h                       |   8 +
 include/linux/memcontrol.h                    |   2 +-
 include/linux/page_owner.h                    |  12 +-
 mm/huge_memory.c                              | 139 +++++++----
 mm/memcontrol.c                               |  10 +-
 mm/page_alloc.c                               |   4 +-
 mm/page_owner.c                               |  13 +-
 mm/truncate.c                                 |  33 ++-
 .../selftests/vm/split_huge_page_test.c       | 219 +++++++++++++++---
 9 files changed, 347 insertions(+), 93 deletions(-)

--=20
2.35.1

