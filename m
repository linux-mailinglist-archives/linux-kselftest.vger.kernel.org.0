Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C2961F8E8
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 17:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbiKGQTA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 11:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbiKGQS5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 11:18:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F57365E3
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Nov 2022 08:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667837880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9cods/w8rqgeUJG27hSpYwAK3kmd3FHu+oLejBSIpOc=;
        b=Hg8cyVb3uxvbJNcP7k4UuVat7nENIzHXn/ARZ0iCLQTMFUJ3rl3IavmEq2ujqO+ngHizlX
        DJy9+61cxpHVG73M8v9W/nQz+USbnILpH4ShjZrAq+URNGYXoj4RpPIt6UpJD4+c4rzLHq
        sjw/8gUlTeCGQLWQPzSTqW8Rwfd++IQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-izDZkPSsPkGvihn_mMeNNw-1; Mon, 07 Nov 2022 11:17:49 -0500
X-MC-Unique: izDZkPSsPkGvihn_mMeNNw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A911185A59D;
        Mon,  7 Nov 2022 16:17:47 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.195.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E6FEE4B3FC8;
        Mon,  7 Nov 2022 16:17:41 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH RFC 00/19] mm/gup: remove FOLL_FORCE usage from drivers (reliable R/O long-term pinning)
Date:   Mon,  7 Nov 2022 17:17:21 +0100
Message-Id: <20221107161740.144456-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For now, we did not support reliable R/O long-term pinning in COW mappings.
That means, if we would trigger R/O long-term pinning in MAP_PRIVATE
mapping, we could end up pinning the (R/O-mapped) shared zeropage or a
pagecache page.

The next write access would trigger a write fault and replace the pinned
page by an exclusive anonymous page in the process page table; whatever the
process would write to that private page copy would not be visible by the
owner of the previous page pin: for example, RDMA could read stale data.
The end result is essentially an unexpected and hard-to-debug memory
corruption.

Some drivers tried working around that limitation by using
"FOLL_FORCE|FOLL_WRITE|FOLL_LONGTERM" for R/O long-term pinning for now.
FOLL_WRITE would trigger a write fault, if required, and break COW before
pinning the page. FOLL_FORCE is required because the VMA might lack write
permissions, and drivers wanted to make that working as well, just like
one would expect (no write access, but still triggering a write access to
break COW).

However, that is not a practical solution, because
(1) Drivers that don't stick to that undocumented and debatable pattern
    would still run into that issue. For example, VFIO only uses
    FOLL_LONGTERM for R/O long-term pinning.
(2) Using FOLL_WRITE just to work around a COW mapping + page pinning
    limitation is unintuitive. FOLL_WRITE would, for example, mark the
    page softdirty or trigger uffd-wp, even though, there actually isn't
    going to be any write access.
(3) The purpose of FOLL_FORCE is debug access, not access without lack of
    VMA permissions by arbitrarty drivers.

So instead, make R/O long-term pinning work as expected, by breaking COW
in a COW mapping early, such that we can remove any FOLL_FORCE usage from
drivers. More details in patch #8.

Patches #1--#3 add COW tests for non-anonymous pages.
Patches #4--#7 prepare core MM for extended FAULT_FLAG_UNSHARE support in
COW mappings.
Patch #8 implements reliable R/O long-term pinning in COW mappings
Patches #9--#19 remove any FOLL_FORCE usage from drivers.

I'm refraining from CCing all driver maintainers on the whole patch set.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Nadav Amit <namit@vmware.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: Shuah Khan <shuah@kernel.org
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Oded Gabbay <ogabbay@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>

David Hildenbrand (19):
  selftests/vm: anon_cow: prepare for non-anonymous COW tests
  selftests/vm: cow: basic COW tests for non-anonymous pages
  selftests/vm: cow: R/O long-term pinning reliability tests for
    non-anon pages
  mm: add early FAULT_FLAG_UNSHARE consistency checks
  mm: add early FAULT_FLAG_WRITE consistency checks
  mm: rework handling in do_wp_page() based on private vs. shared
    mappings
  mm: don't call vm_ops->huge_fault() in wp_huge_pmd()/wp_huge_pud() for
    private mappings
  mm: extend FAULT_FLAG_UNSHARE support to anything in a COW mapping
  mm/gup: reliable R/O long-term pinning in COW mappings
  RDMA/umem: remove FOLL_FORCE usage
  RDMA/usnic: remove FOLL_FORCE usage
  RDMA/siw: remove FOLL_FORCE usage
  media: videobuf-dma-sg: remove FOLL_FORCE usage
  drm/etnaviv: remove FOLL_FORCE usage
  media: pci/ivtv: remove FOLL_FORCE usage
  mm/frame-vector: remove FOLL_FORCE usage
  drm/exynos: remove FOLL_FORCE usage
  RDMA/hw/qib/qib_user_pages: remove FOLL_FORCE usage
  habanalabs: remove FOLL_FORCE usage

 drivers/gpu/drm/etnaviv/etnaviv_gem.c         |   8 +-
 drivers/gpu/drm/exynos/exynos_drm_g2d.c       |   2 +-
 drivers/infiniband/core/umem.c                |   8 +-
 drivers/infiniband/hw/qib/qib_user_pages.c    |   2 +-
 drivers/infiniband/hw/usnic/usnic_uiom.c      |   9 +-
 drivers/infiniband/sw/siw/siw_mem.c           |   9 +-
 drivers/media/common/videobuf2/frame_vector.c |   2 +-
 drivers/media/pci/ivtv/ivtv-udma.c            |   2 +-
 drivers/media/pci/ivtv/ivtv-yuv.c             |   5 +-
 drivers/media/v4l2-core/videobuf-dma-sg.c     |  14 +-
 drivers/misc/habanalabs/common/memory.c       |   3 +-
 include/linux/mm.h                            |  27 +-
 include/linux/mm_types.h                      |   8 +-
 mm/gup.c                                      |  10 +-
 mm/huge_memory.c                              |   5 +-
 mm/hugetlb.c                                  |  12 +-
 mm/memory.c                                   |  97 +++--
 tools/testing/selftests/vm/.gitignore         |   2 +-
 tools/testing/selftests/vm/Makefile           |  10 +-
 tools/testing/selftests/vm/check_config.sh    |   4 +-
 .../selftests/vm/{anon_cow.c => cow.c}        | 387 +++++++++++++++++-
 tools/testing/selftests/vm/run_vmtests.sh     |   8 +-
 22 files changed, 516 insertions(+), 118 deletions(-)
 rename tools/testing/selftests/vm/{anon_cow.c => cow.c} (74%)

-- 
2.38.1

