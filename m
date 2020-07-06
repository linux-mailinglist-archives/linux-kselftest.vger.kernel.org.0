Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5E521617A
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jul 2020 00:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgGFWYE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Jul 2020 18:24:04 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17948 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgGFWYE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Jul 2020 18:24:04 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f03a41a0001>; Mon, 06 Jul 2020 15:22:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 06 Jul 2020 15:24:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 06 Jul 2020 15:24:03 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Jul
 2020 22:23:58 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 6 Jul 2020 22:23:58 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f03a47e0000>; Mon, 06 Jul 2020 15:23:58 -0700
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
Subject: [PATCH 0/5] mm/migrate: avoid device private invalidations
Date:   Mon, 6 Jul 2020 15:23:42 -0700
Message-ID: <20200706222347.32290-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594074138; bh=L1q+tY8XtVCJVAfZQvRMNXjLijJuUT/RKi3sLXZmr28=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=gkERmIj7sPNRqUTDSXWmzecTz0WtFK0U3kvh9q3hMeDHLm/Owv8u5sQcfDjbbRTz/
         +TgRzZRSMSZwtWLEi6CRcKCkUSasti32p/o8/XZ0mZzXiV34vDAdpZx/le+SAO8x0Q
         QLY/XEOfpmLryYdmMy62yrhZWa2bouIBs6hkQ/GsQZ7UlzXM1MR60Dt/TXPH3tUwV4
         OkmmZLR01IbgEZbiFd7QwnQl70JEualApo09S4soxZBIhCPDS8u02MIFDANsmL6Qx4
         8oVXc2Pps8U4J/YR2/KnPSmUqjfOXI5qq9o7B1Zu8N8mCMvGGrbsu1QshOx8Y/iaZi
         ZMd1XohWj+O7w==
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

This series is based on linux-5.8.0-rc4 and the patches I sent for
("mm/hmm/nouveau: add PMD system memory mapping")
https://lore.kernel.org/linux-mm/20200701225352.9649-1-rcampbell@nvidia.com
There are no logical dependencies, but there would be merge conflicts
which could be resolved if this were to be applied before the other
series.

Also, this replaces the need for the following two patches I sent:
("mm: fix migrate_vma_setup() src_owner and normal pages")
https://lore.kernel.org/linux-mm/20200622222008.9971-1-rcampbell@nvidia.com
("nouveau: fix mixed normal and device private page migration")
https://lore.kernel.org/lkml/20200622233854.10889-3-rcampbell@nvidia.com

Ralph Campbell (5):
  nouveau: fix storing invalid ptes
  mm/migrate: add a direction parameter to migrate_vma
  mm/notifier: add migration invalidation type
  nouveau/svm: use the new migration invalidation
  mm/hmm/test: use the new migration invalidation

 arch/powerpc/kvm/book3s_hv_uvmem.c            |  2 ++
 drivers/gpu/drm/nouveau/nouveau_dmem.c        | 13 ++++++--
 drivers/gpu/drm/nouveau/nouveau_svm.c         | 10 +++++-
 drivers/gpu/drm/nouveau/nouveau_svm.h         |  1 +
 .../drm/nouveau/nvkm/subdev/mmu/vmmgp100.c    | 13 +++++---
 include/linux/migrate.h                       | 12 +++++--
 include/linux/mmu_notifier.h                  |  7 ++++
 lib/test_hmm.c                                | 33 +++++++++++--------
 mm/migrate.c                                  | 13 ++++++--
 9 files changed, 77 insertions(+), 27 deletions(-)

--=20
2.20.1

