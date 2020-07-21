Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC9A228B66
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jul 2020 23:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731239AbgGUVbd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jul 2020 17:31:33 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16107 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730974AbgGUVbc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jul 2020 17:31:32 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f175e750002>; Tue, 21 Jul 2020 14:30:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 21 Jul 2020 14:31:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 21 Jul 2020 14:31:31 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 Jul
 2020 21:31:25 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 21 Jul 2020 21:31:25 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f175ead0001>; Tue, 21 Jul 2020 14:31:25 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <nouveau@lists.freedesktop.org>, <kvm-ppc@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Ben Skeggs" <bskeggs@redhat.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        "Ralph Campbell" <rcampbell@nvidia.com>
Subject: [PATCH v3 0/5] mm/migrate: avoid device private invalidations
Date:   Tue, 21 Jul 2020 14:31:14 -0700
Message-ID: <20200721213119.32344-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595367029; bh=S6TSnAaZe1yneC9qg+vali1aI4hicYt4hljXvpfEYPc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=DnuBVmb4eDYGee/BzoLo3pnjgjneMSU/TSTsQmcQ9DAbiNQQpPFtY+zbjGwdGx2FF
         wQ6Uie5n1usLkpeq4/h6ifVK6vhZghGtFt7gzWin8SCeBODjKeAvShGk2vXYxUCVOe
         YPy7FXSBzYywTFkmYRzY/Mf2A+pRCCSw28133BMQTAYMJufABqRMzUNyGM+QA4MadI
         3lrbbggcvIW9549w/6LetDLr5CS0Y/oxcvSS+Xw6f+zXsjvkvv7hn5hg4ry/LAzEst
         lBF6Vstb7mTJefMpdEj61ilm2pL9jwuK6fgV8W22Nomolyn3Eh2Tuokdxb4C7/b5lL
         1PhIiZU+SarUg==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The goal for this series is to avoid device private memory TLB
invalidations when migrating a range of addresses from system
memory to device private memory and some of those pages have already
been migrated. The approach taken is to introduce a new mmu notifier
invalidation event type and use that in the device driver to skip
invalidation callbacks from migrate_vma_setup(). The device driver is
also then expected to handle device MMU invalidations as part of the
migrate_vma_setup(), migrate_vma_pages(), migrate_vma_finalize() process.
Note that this is opt-in. A device driver can simply invalidate its MMU
in the mmu notifier callback and not handle MMU invalidations in the
migration sequence.

This series is based on Jason Gunthorpe's HMM tree (linux-5.8.0-rc4).

Also, this replaces the need for the following two patches I sent:
("mm: fix migrate_vma_setup() src_owner and normal pages")
https://lore.kernel.org/linux-mm/20200622222008.9971-1-rcampbell@nvidia.com
("nouveau: fix mixed normal and device private page migration")
https://lore.kernel.org/lkml/20200622233854.10889-3-rcampbell@nvidia.com

Bharata Rao, let me know if I can add your reviewed-by back since
I made a fair number of changes to this version of the series.

Changes in v3:
Changed the direction field "dir" to a "flags" field and renamed
  src_owner to pgmap_owner.
Fixed a locking issue in nouveau for the migration invalidation.
Added a HMM selftest test case to exercise the HMM test driver
  invalidation changes.
Removed reviewed-by Bharata B Rao since this version is moderately
  changed.

Changes in v2:
Rebase to Jason Gunthorpe's HMM tree.
Added reviewed-by from Bharata B Rao.
Rename the mmu_notifier_range::data field to migrate_pgmap_owner as
  suggested by Jason Gunthorpe.

Ralph Campbell (5):
  nouveau: fix storing invalid ptes
  mm/migrate: add a flags parameter to migrate_vma
  mm/notifier: add migration invalidation type
  nouveau/svm: use the new migration invalidation
  mm/hmm/test: use the new migration invalidation

 arch/powerpc/kvm/book3s_hv_uvmem.c            |  4 ++-
 drivers/gpu/drm/nouveau/nouveau_dmem.c        | 19 ++++++++---
 drivers/gpu/drm/nouveau/nouveau_svm.c         | 21 +++++-------
 drivers/gpu/drm/nouveau/nouveau_svm.h         | 13 ++++++-
 .../drm/nouveau/nvkm/subdev/mmu/vmmgp100.c    | 13 ++++---
 include/linux/migrate.h                       | 16 ++++++---
 include/linux/mmu_notifier.h                  |  7 ++++
 lib/test_hmm.c                                | 34 +++++++++++--------
 mm/migrate.c                                  | 14 ++++++--
 tools/testing/selftests/vm/hmm-tests.c        | 18 +++++++---
 10 files changed, 112 insertions(+), 47 deletions(-)

--=20
2.20.1

