Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C981CB80E
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 May 2020 21:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgEHTUW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 May 2020 15:20:22 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17039 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgEHTUW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 May 2020 15:20:22 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eb5b0e90000>; Fri, 08 May 2020 12:20:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 08 May 2020 12:20:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 08 May 2020 12:20:22 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 8 May
 2020 19:20:20 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 8 May 2020 19:20:20 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5eb5b0f3000a>; Fri, 08 May 2020 12:20:20 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <nouveau@lists.freedesktop.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Ben Skeggs" <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@linuxfoundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH 0/6] nouveau/hmm: add support for mapping large pages
Date:   Fri, 8 May 2020 12:20:03 -0700
Message-ID: <20200508192009.15302-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1588965609; bh=jFq2mixtkzI32ozqz5hLHkzp0Ygs10xUW1B28WBNaLs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Type:
         Content-Transfer-Encoding;
        b=f1uSc3ROHwcanB7L/tnLl4h20hmLEQD3keM9GdJxSJn+hErrBRjoEQ9pNFoFKAS3y
         KXQ272lLCVcvsmn3Xh+CZ8PGvmLztkdvTO9AW7DTZ8K26htGWFfd4Z3lL/AsL0Gqmk
         a2fyv9afMBkOOvcCPRVcP6FGdddhhrTMTn57sAbBgvBbXHlMkrCpzSzLoZNADRGtOO
         T2pwhT2QsojXnT8v9nFgKvI91dK5M0SVdfBW0Oflirjs3is2qdNCUgrI1BH++cbcyW
         YRWzjzSYUGCu/H/jdIfvhJ/DeCELi/J6Udl7WwSWZelaLryvmfp4l417C4xxGZ98PL
         aKtDXj0RDipAw==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

hmm_range_fault() returns an array of page frame numbers and flags for
how the pages are mapped in the requested process' page tables. The PFN
can be used to get the struct page with hmm_pfn_to_page() and the page size
order can be determined with compound_order(page) but if the page is larger
than order 0 (PAGE_SIZE), there is no indication that the page is mapped
using a larger page size. To be fully general, hmm_range_fault() would need
to return the mapping size to handle cases like a 1GB compound page being
mapped with 2MB PMD entries. However, the most common case is the mapping
size the same as the underlying compound page size.
This series adds a new output flag to indicate this so that callers know it
is safe to use a large device page table mapping if one is available.
Nouveau and the HMM tests are updated to use the new flag.

Note that this series depends on a patch queued in Ben Skeggs' nouveau
tree ("nouveau/hmm: map pages after migration") and the patches queued
in Jason's HMM tree.
There is also a patch outstanding ("nouveau/hmm: fix nouveau_dmem_chunk
allocations") that is independent of the above and could be applied
before or after.


Ralph Campbell (6):
  nouveau/hmm: map pages after migration
  nouveau: make nvkm_vmm_ctor() and nvkm_mmu_ptp_get() static
  nouveau/hmm: fault one page at a time
  mm/hmm: add output flag for compound page mapping
  nouveau/hmm: support mapping large sysmem pages
  hmm: add tests for HMM_PFN_COMPOUND flag

 drivers/gpu/drm/nouveau/nouveau_dmem.c        |  46 ++-
 drivers/gpu/drm/nouveau/nouveau_dmem.h        |   2 +
 drivers/gpu/drm/nouveau/nouveau_svm.c         | 288 +++++++++---------
 drivers/gpu/drm/nouveau/nouveau_svm.h         |   5 +
 .../gpu/drm/nouveau/nvkm/subdev/mmu/base.c    |   6 +-
 .../gpu/drm/nouveau/nvkm/subdev/mmu/priv.h    |   2 +
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c |  12 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.h |   3 -
 .../drm/nouveau/nvkm/subdev/mmu/vmmgp100.c    |  29 +-
 include/linux/hmm.h                           |   4 +-
 lib/test_hmm.c                                |   2 +
 lib/test_hmm_uapi.h                           |   2 +
 mm/hmm.c                                      |  10 +-
 tools/testing/selftests/vm/hmm-tests.c        |  76 +++++
 14 files changed, 311 insertions(+), 176 deletions(-)

--=20
2.20.1

