Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD9B22B97F
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jul 2020 00:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgGWWbK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jul 2020 18:31:10 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13879 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbgGWWav (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jul 2020 18:30:51 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f1a0f200002>; Thu, 23 Jul 2020 15:28:48 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 23 Jul 2020 15:30:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 23 Jul 2020 15:30:50 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 23 Jul
 2020 22:30:40 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 23 Jul 2020 22:30:40 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f1a0f8f0005>; Thu, 23 Jul 2020 15:30:40 -0700
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
Subject: [PATCH v4 0/6] mm/migrate: avoid device private invalidations
Date:   Thu, 23 Jul 2020 15:29:58 -0700
Message-ID: <20200723223004.9586-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595543328; bh=ZwXB9DTR4tPS7zaUfLV/qJCI/BkZe94g9qf7+cwfua0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=TVbFTQ16TWQJrMKOy3aejSRVgaoLbc4Vkm8uJUav1IGnV8UCNIxlcUNaIljT32lLT
         IFUkxKku3oiwD/s0KJPRD2Z5P92RzMfRlTNzyvob2p19ZeLstAi5XHAFOBPxyRoqHT
         XBNFeLeeyRWkhXkXYByL4G9XWOc7aVCZRw3V1jZnUEOyUtW4VjCR2X/5I3mN05w0Na
         7Hb+FGjZFJyT5e5+vPs3gJ8zif2PIR0pJ9PLBihz71appn3YYQeHz8jk2u5NBb1/Qg
         paTD0aiMmUhZsUuOny88asPXliyd2ClVGLWx7CS4R7UJwX67oKy4GfaMplRxnjuLZk
         rkNZaL4BWZv2Q==
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

Changes in v4:
Added reviewed-by from Bharata B Rao.
Removed dead code checking for source device private page in lib/test_hmm.c
  dmirror_migrate_alloc_and_copy() since the source filter flag guarantees
  that.
Added patch 6 to remove a redundant invalidation in migrate_vma_pages().

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

Ralph Campbell (6):
  nouveau: fix storing invalid ptes
  mm/migrate: add a flags parameter to migrate_vma
  mm/notifier: add migration invalidation type
  nouveau/svm: use the new migration invalidation
  mm/hmm/test: use the new migration invalidation
  mm/migrate: remove range invalidation in migrate_vma_pages()

 arch/powerpc/kvm/book3s_hv_uvmem.c            |  4 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c        | 19 ++++++--
 drivers/gpu/drm/nouveau/nouveau_svm.c         | 21 ++++-----
 drivers/gpu/drm/nouveau/nouveau_svm.h         | 13 +++++-
 .../drm/nouveau/nvkm/subdev/mmu/vmmgp100.c    | 13 ++++--
 include/linux/migrate.h                       | 16 +++++--
 include/linux/mmu_notifier.h                  |  7 +++
 lib/test_hmm.c                                | 43 +++++++++----------
 mm/migrate.c                                  | 34 +++++----------
 tools/testing/selftests/vm/hmm-tests.c        | 18 ++++++--
 10 files changed, 112 insertions(+), 76 deletions(-)

--=20
2.20.1

