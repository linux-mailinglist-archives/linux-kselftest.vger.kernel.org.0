Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2D42A8B91
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Nov 2020 01:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730895AbgKFAv4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Nov 2020 19:51:56 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2066 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729784AbgKFAvz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Nov 2020 19:51:55 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa49e2f0000>; Thu, 05 Nov 2020 16:51:59 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov
 2020 00:51:51 +0000
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 6 Nov 2020 00:51:51 +0000
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Zi Yan <ziy@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Ralph Campbell" <rcampbell@nvidia.com>
Subject: [PATCH v3 0/6] mm/hmm/nouveau: add THP migration to migrate_vma_*
Date:   Thu, 5 Nov 2020 16:51:41 -0800
Message-ID: <20201106005147.20113-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604623919; bh=yd2V0Bj7e0BljktQG2A8aEh2H8lDRzFocecZDywzuvo=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         X-NVConfidentiality:Content-Transfer-Encoding:Content-Type;
        b=l1GP2MqkXumBnOLdZPkkI/rhR7a4QkhrOLUzQZ07kAYQ/Co7WXfjmo46mueuuYvZq
         Br4aCN5s2HI1+/JMzxHxzk9kadPHc2pQPf3Rtj77uLEYEZzaxYsF5HJtLu7+RBGYln
         kmNW1dk9VrCVI8cp6tvg2EiI4aEyYOfCHItqRY+fTSmi7KzwNWmS44k3KW56sW+MzW
         o2huLaZevX2k/szf3mkftTbe/zpAKP3yluAPe9gWgMq1+UQwEo9MYmPmH9pM0Ish3f
         NBf69WgnEPE5Plno3uUZkGtiOrkYQmWQEKVUyZjSs3433S3bzfsqF/n/H07IOMgK7k
         vZ64sh9YOSrBA==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series adds support for transparent huge page migration to
migrate_vma_*() and adds nouveau SVM and HMM selftests as consumers.
Earlier versions were posted previously [1] and [2].

The patches apply cleanly to the linux-mm 5.10.0-rc2 tree. There are a
lot of other THP patches being posted. I don't think there are any
semantic conflicts but there may be some merge conflicts depending on
the order Andrew applies these.

Changes in v3:
Sent the patch ("mm/thp: fix __split_huge_pmd_locked() for migration PMD")
as a separate patch from this series.

Rebased to linux-mm 5.10.0-rc2.

Changes in v2:
Added splitting a THP midway in the migration process:
i.e., in migrate_vma_pages().

[1] https://lore.kernel.org/linux-mm/20200619215649.32297-1-rcampbell@nvidi=
a.com
[2] https://lore.kernel.org/linux-mm/20200902165830.5367-1-rcampbell@nvidia=
.com

Ralph Campbell (6):
  mm/thp: add prep_transhuge_device_private_page()
  mm/migrate: move migrate_vma_collect_skip()
  mm: support THP migration to device private memory
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
 lib/test_hmm.c                         | 437 +++++++++++++++++++++----
 lib/test_hmm_uapi.h                    |   3 +
 mm/huge_memory.c                       | 147 +++++++--
 mm/memcontrol.c                        |  25 +-
 mm/memory.c                            |  10 +-
 mm/memremap.c                          |   4 +-
 mm/migrate.c                           | 429 +++++++++++++++++++-----
 mm/rmap.c                              |   2 +-
 tools/testing/selftests/vm/hmm-tests.c | 404 +++++++++++++++++++++++
 16 files changed, 1522 insertions(+), 275 deletions(-)

--=20
2.20.1

