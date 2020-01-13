Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0CA0139CDA
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2020 23:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgAMWrQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jan 2020 17:47:16 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2241 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbgAMWrO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jan 2020 17:47:14 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1cf35d0000>; Mon, 13 Jan 2020 14:46:53 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 Jan 2020 14:47:13 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 Jan 2020 14:47:13 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Jan
 2020 22:47:13 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Jan
 2020 22:47:08 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 13 Jan 2020 22:47:08 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e1cf36c0000>; Mon, 13 Jan 2020 14:47:08 -0800
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
        <linux-kselftest@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH v6 0/6] mm/hmm/test: add self tests for HMM
Date:   Mon, 13 Jan 2020 14:46:57 -0800
Message-ID: <20200113224703.5917-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578955613; bh=GtpVYgdrH9GxiIGh9Ju0Oa4D1/CloNN687n7bW51geE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Type:
         Content-Transfer-Encoding;
        b=G2bgbXRrumJ9A88wz6mE4JJ7Gzk1rL3W8o+1IzpRatJMghAXqlQAcjYG4GoZXLTUY
         Zl1Z/PkXEA/ZDikV03KCxAiGNMf73l1Hnw+JW6gkpNLgtMmW6aeyWVvEMGb6FKscU1
         frNn5LL0g0jEG/lNnbAwhn8BynbC/L6ozsEY741EuJdx5IoxP8IuTez3doFSGslby0
         zrX4HtGtIsW95XUSsLHHr8w8Xeh/+nV+NELgdEYU764cSL7A8NgZjZm3csFElmca0G
         IOCi+LRa6Eek1trM6R72m6YhG+HUN0ozgZoeOiaI2NwNb1lSVSkwj8CEe4HTWhv9uk
         CcNaroREM9Zqw==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series adds new functions to the mmu interval notifier API to
allow device drivers with MMUs to dynamically mirror a process' page
tables based on device faults and invalidation callbacks. The Nouveau
driver is updated to use the extended API and a set of stand alone self
tests is added to help validate and maintain correctness.

The patches are based on linux-5.5.0-rc6 and are for Jason's rdma/hmm tree
since I believe he is planning some interval notifier changes.

Changes v5 -> v6:
Rebase to linux-5.5.0-rc6
Refactored mmu interval notifier patches
Converted nouveau to use the new mmu interval notifier API

Changes v4 -> v5:
Added mmu interval notifier insert/remove/update callable from the
  invalidate() callback
Updated HMM tests to use the new core interval notifier API

Changes v1 -> v4:
https://lore.kernel.org/linux-mm/20191104222141.5173-1-rcampbell@nvidia.com

Ralph Campbell (6):
  mm/mmu_notifier: add mmu_interval_notifier_insert_safe()
  mm/mmu_notifier: add mmu_interval_notifier_put()
  mm/notifier: add mmu_interval_notifier_update()
  mm/mmu_notifier: add mmu_interval_notifier_find()
  nouveau: use new mmu interval notifiers
  mm/hmm/test: add self tests for HMM

 MAINTAINERS                            |    3 +
 drivers/gpu/drm/nouveau/nouveau_svm.c  |  313 ++++--
 include/linux/mmu_notifier.h           |   29 +
 lib/Kconfig.debug                      |   11 +
 lib/Makefile                           |    1 +
 lib/test_hmm.c                         | 1368 ++++++++++++++++++++++++
 mm/mmu_notifier.c                      |  223 +++-
 tools/testing/selftests/vm/.gitignore  |    1 +
 tools/testing/selftests/vm/Makefile    |    3 +
 tools/testing/selftests/vm/config      |    2 +
 tools/testing/selftests/vm/hmm-tests.c | 1354 +++++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests |   16 +
 tools/testing/selftests/vm/test_hmm.sh |   97 ++
 13 files changed, 3289 insertions(+), 132 deletions(-)
 create mode 100644 lib/test_hmm.c
 create mode 100644 tools/testing/selftests/vm/hmm-tests.c
 create mode 100755 tools/testing/selftests/vm/test_hmm.sh

--=20
2.20.1

