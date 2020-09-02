Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F07A25B282
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Sep 2020 19:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgIBRA5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Sep 2020 13:00:57 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12892 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728417AbgIBQ6j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Sep 2020 12:58:39 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4fcf2e0002>; Wed, 02 Sep 2020 09:58:22 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 02 Sep 2020 09:58:36 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 02 Sep 2020 09:58:36 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep
 2020 16:58:35 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 2 Sep 2020 16:58:35 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f4fcf3b0002>; Wed, 02 Sep 2020 09:58:35 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Ben Skeggs <bskeggs@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH v2 0/7] mm/hmm/nouveau: add THP migration to migrate_vma_*
Date:   Wed, 2 Sep 2020 09:58:23 -0700
Message-ID: <20200902165830.5367-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599065902; bh=HDNx0TwwmJgLSW/5j1pExKoabH4DVWo6AyNeqn5NpEE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=HfWuo8NNo43M+Qt3U1+x2Shdo1HAwCPr4mdA97/9p7wzzLRhkXGR+X+dsYWCVMCib
         PVKnHWYjEo5Adqg7iAZB27IOiw+7CGxxNeiXNyQcR/PYwiB7GiO66mYj0XPpHiefaM
         bp0X5oVbS71mSis4jKxlFXL+roxm1hzyKnxxEzGyq5jDiVxleaM+uRVnFqmkYoX8B2
         fIMG2z279kugbOd/p5x/8sqMWszGPbJ0zpGnE/1ON5Na3A7O4d5+C4q/jdhnpOzens
         C83Qaw3fVIiG34eTsPxbkPGRUIfem81nClo5mQ+uzfyLWXj957Lp5GX7K7fQCMTZIm
         /5BjxW5uKraZA==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series adds support for transparent huge page migration to
migrate_vma_*() and adds nouveau SVM and HMM selftests as consumers.
An earlier version was posted previously [1]. This version now
supports splitting a THP midway in the migration process which
led to a number of changes.

The patches apply cleanly to the current linux-mm tree. Since there
are a couple of patches in linux-mm from Dan Williams that modify
lib/test_hmm.c and drivers/gpu/drm/nouveau/nouveau_dmem.c, it might
be easiest if Andrew could take these through the linux-mm tree
assuming that's OK with other maintainers like Ben Skeggs.

[1] https://lore.kernel.org/linux-mm/20200619215649.32297-1-rcampbell@nvidi=
a.com

Ralph Campbell (7):
  mm/thp: fix __split_huge_pmd_locked() for migration PMD
  mm/migrate: move migrate_vma_collect_skip()
  mm: support THP migration to device private memory
  mm/thp: add prep_transhuge_device_private_page()
  mm/thp: add THP allocation helper
  mm/hmm/test: add self tests for THP migration
  nouveau: support THP migration to private memory

 drivers/gpu/drm/nouveau/nouveau_dmem.c | 289 +++++++++++-----
 drivers/gpu/drm/nouveau/nouveau_svm.c  |  11 +-
 drivers/gpu/drm/nouveau/nouveau_svm.h  |   3 +-
 include/linux/gfp.h                    |  10 +
 include/linux/huge_mm.h                |  12 +
 include/linux/memremap.h               |   9 +
 include/linux/migrate.h                |   2 +
 lib/test_hmm.c                         | 439 +++++++++++++++++++++----
 lib/test_hmm_uapi.h                    |   3 +
 mm/huge_memory.c                       | 177 +++++++---
 mm/memory.c                            |  10 +-
 mm/migrate.c                           | 429 +++++++++++++++++++-----
 mm/rmap.c                              |   2 +-
 tools/testing/selftests/vm/hmm-tests.c | 404 +++++++++++++++++++++++
 14 files changed, 1519 insertions(+), 281 deletions(-)

--=20
2.20.1

