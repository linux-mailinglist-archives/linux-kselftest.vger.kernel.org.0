Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140D020FD3C
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jun 2020 21:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgF3T6Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Jun 2020 15:58:16 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19054 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbgF3T6Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Jun 2020 15:58:16 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efb994a0001>; Tue, 30 Jun 2020 12:58:02 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 30 Jun 2020 12:58:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 30 Jun 2020 12:58:15 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 19:58:07 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 30 Jun 2020 19:58:07 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5efb994f0001>; Tue, 30 Jun 2020 12:58:07 -0700
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
Subject: [PATCH v2 0/5] mm/hmm/nouveau: add PMD system memory mapping
Date:   Tue, 30 Jun 2020 12:57:32 -0700
Message-ID: <20200630195737.8667-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593547082; bh=98oQk6P7sljyBfLagdhiCZSymARD8p0G5MvhlqPtOuI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=hrPV+ZVB0MZZj74Ygk9F8iCc0v3Ioc8Uq7yJvHmvkGMSxfeHrott/ebMNWV4E7Klo
         nLVevppXcSr0gOa5ghpgHjZ8BJU4dDL3JwmCywTJnxCxOMybTJGN0SeL8TgySRz8ul
         nehOkehgeVx8Vuk9OiHHmgSVrnjZAMyAtj22W2kYZqu5vs3MD5ul5+gjpsOzhsSsP2
         gEATZDFV1CIoaMm4QkC+mpxV7nJ8AfWtL7W4ZvPMzIxL5erMUDv7XSpU3DjbKz8MaI
         UGOphT1of9WD75YdGWOGdl7PvAelFIGQULYku2dA5/navSm3JyRTpJqQydqajcILqm
         3HihpKmAGLvdw==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The goal for this series is to introduce the hmm_range_fault() output
array flags HMM_PFN_PMD and HMM_PFN_PUD. This allows a device driver to
know that a given 4K PFN is actually mapped by the CPU using either a
PMD sized or PUD sized CPU page table entry and therefore the device
driver can safely map system memory using larger device MMU PTEs.
The series is based on 5.8.0-rc3 and is intended for Jason Gunthorpe's
hmm tree. These were originally part of a larger series:
https://lore.kernel.org/linux-mm/20200619215649.32297-1-rcampbell@nvidia.co=
m/

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
  mm/hmm: add output flags for PMD/PUD page mapping
  nouveau: fix mapping 2MB sysmem pages
  nouveau/hmm: support mapping large sysmem pages
  hmm: add tests for HMM_PFN_PMD flag

 drivers/gpu/drm/nouveau/nouveau_svm.c         | 238 ++++++++----------
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c |   5 +-
 .../drm/nouveau/nvkm/subdev/mmu/vmmgp100.c    |  82 ++++++
 include/linux/hmm.h                           |  11 +-
 lib/test_hmm.c                                |   4 +
 lib/test_hmm_uapi.h                           |   4 +
 mm/hmm.c                                      |  13 +-
 tools/testing/selftests/vm/hmm-tests.c        |  76 ++++++
 8 files changed, 290 insertions(+), 143 deletions(-)

--=20
2.20.1

