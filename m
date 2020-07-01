Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9881211665
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jul 2020 00:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgGAWy3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Jul 2020 18:54:29 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19501 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgGAWyN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Jul 2020 18:54:13 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efd13e20000>; Wed, 01 Jul 2020 15:53:22 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 01 Jul 2020 15:54:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 01 Jul 2020 15:54:12 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 Jul
 2020 22:54:04 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 1 Jul 2020 22:54:03 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5efd140b0002>; Wed, 01 Jul 2020 15:54:03 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <nouveau@lists.freedesktop.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Ben Skeggs" <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH v3 0/5] mm/hmm/nouveau: add PMD system memory mapping
Date:   Wed, 1 Jul 2020 15:53:47 -0700
Message-ID: <20200701225352.9649-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593644002; bh=MJfr/HRLE6OMXyolgR7JmbdNUj2YCkglGntcmeExnQQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=sCvs0+5aWDEOa98ScHYnH1kou2nuKpIArM70MeHNN0z0Lr2no8sM2jlI5eFdengEi
         E+EDwBZoNE23w6xILrPPhA7UnQef8+TszwrfBGodCUpC9KY/0jTaS2ESZ8FGYMGJOc
         ZzhDvtIDp/v45zSQg8e7TdlJg4gwJJmf2Vme3SJ8Uf3hBwc13UsxccJxTpCXK8J551
         RR/eLZBrmiSGQdHD1T/LjRsWVOvVcYUEvQ1Hnie2f73rD3baTsk0WOT4DyEnu479CW
         Gvu/PHs94sF/7QBbqZDK8kMjXvmZtHIQk1SeYxLbpF8jNVRMfDiSwgYwaG8jEq3bla
         OA1t1ZY+Q64uA==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The goal for this series is to introduce the hmm_pfn_to_map_order()
function. This allows a device driver to know that a given 4K PFN is
actually mapped by the CPU using a larger sized CPU page table entry and
therefore the device driver can safely map system memory using larger
device MMU PTEs.
The series is based on 5.8.0-rc3 and is intended for Jason Gunthorpe's
hmm tree. These were originally part of a larger series:
https://lore.kernel.org/linux-mm/20200619215649.32297-1-rcampbell@nvidia.co=
m/

Changes in v3:
Replaced the HMM_PFN_P[MU]D flags with hmm_pfn_to_map_order() to
indicate the size of the CPU mapping.

Changes in v2:
Make the hmm_range_fault() API changes into a separate series and add
  two output flags for PMD/PUD instead of a single compund page flag as
  suggested by Jason Gunthorpe.
Make the nouveau page table changes a separate patch as suggested by
  Ben Skeggs.
Only add support for 2MB nouveau mappings initially since changing the
1:1 CPU/GPU page table size assumptions requires a bigger set of changes.
Rebase to 5.8.0-rc3.

Ralph Campbell (5):
  nouveau/hmm: fault one page at a time
  mm/hmm: add hmm_mapping order
  nouveau: fix mapping 2MB sysmem pages
  nouveau/hmm: support mapping large sysmem pages
  hmm: add tests for HMM_PFN_PMD flag

 drivers/gpu/drm/nouveau/nouveau_svm.c         | 236 ++++++++----------
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c |   5 +-
 .../drm/nouveau/nvkm/subdev/mmu/vmmgp100.c    |  82 ++++++
 include/linux/hmm.h                           |  24 +-
 lib/test_hmm.c                                |   4 +
 lib/test_hmm_uapi.h                           |   4 +
 mm/hmm.c                                      |  14 +-
 tools/testing/selftests/vm/hmm-tests.c        |  76 ++++++
 8 files changed, 299 insertions(+), 146 deletions(-)

--=20
2.20.1

