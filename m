Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F98A1AE8C4
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Apr 2020 01:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgDQXzO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Apr 2020 19:55:14 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15693 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbgDQXzL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Apr 2020 19:55:11 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e9a41a40000>; Fri, 17 Apr 2020 16:54:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 17 Apr 2020 16:55:11 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 17 Apr 2020 16:55:11 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 Apr
 2020 23:55:06 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 17 Apr 2020 23:55:06 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e9a41d90001>; Fri, 17 Apr 2020 16:55:06 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Ralph Campbell" <rcampbell@nvidia.com>
Subject: [PATCH v9 0/3] mm/hmm/test: add self tests for HMM
Date:   Fri, 17 Apr 2020 16:54:55 -0700
Message-ID: <20200417235458.13462-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587167652; bh=jXe1h9wiaq7PvwMYbpcxTu8towIVS5zrK8zscgA10h0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type:Content-Transfer-Encoding;
        b=Cc1JzmWDg1VMol1croxpnpCYVltbXWmaVHTaQe7iQemi04JchWJEZxKwGmPQehagY
         kwbJdINTtwsl79S99RKAu/LDb8frNI1B1uCIfR8DSeupYTi443T7S/FMGmm/2O//A2
         PnDLj4wcUh6EJKG+eAYiEBfB6QKLh+Wj1iK4E8sbTN4cUms/KQCvA2q8m/9V4CWCKa
         j+lKCfEH5l4Rd3x1ZMj/ednjz5SCidswcVioKDZd/iaVbM2YvFCH1K5KyM2+WOt3aN
         OB0THU1FdknQmeArErLxKQRAQO6K1EX69/3tnwD8bf8R1Gwpk67LgK6aMjySZfvaTT
         aww+gJkFd9Viw==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series adds basic self tests for HMM and are intended for Jason
Gunthorpe's rdma tree since I believe he is planning to make some HMM
related changes that this can help test.

Changes v8 -> v9:
Rebased to linux-5.7.0-rc1.
Moved include/uapi/linux/test_hmm.h to lib/test_hmm_uapi.h
Added calls to release_mem_region() to free device private addresses
Applied Jason's suggested changes for v8.
Added a check for no VMA read access before migrating to device private
  memory.

Changes v7 -> v8:
Rebased to Jason's rdma/hmm tree, plus Jason's 6 patch series
  "Small hmm_range_fault() cleanups".
Applied a number of changes from Jason's comments.

Changes v6 -> v7:
Rebased to linux-5.6.0-rc6
Reverted back to just using mmu_interval_notifier_insert() and making
  this series only introduce HMM self tests.

Changes v5 -> v6:
Rebased to linux-5.5.0-rc6
Refactored mmu interval notifier patches
Converted nouveau to use the new mmu interval notifier API

Changes v4 -> v5:
Added mmu interval notifier insert/remove/update callable from the
  invalidate() callback
Updated HMM tests to use the new core interval notifier API

Changes v1 -> v4:
https://lore.kernel.org/linux-mm/20191104222141.5173-1-rcampbell@nvidia.com

Ralph Campbell (3):
  mm/hmm/test: add selftest driver for HMM
  mm/hmm/test: add selftests for HMM
  MAINTAINERS: add HMM selftests

 MAINTAINERS                            |    3 +
 lib/Kconfig.debug                      |   13 +
 lib/Makefile                           |    1 +
 lib/test_hmm.c                         | 1175 ++++++++++++++++++++
 lib/test_hmm_uapi.h                    |   59 +
 tools/testing/selftests/vm/.gitignore  |    1 +
 tools/testing/selftests/vm/Makefile    |    3 +
 tools/testing/selftests/vm/config      |    2 +
 tools/testing/selftests/vm/hmm-tests.c | 1359 ++++++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests |   16 +
 tools/testing/selftests/vm/test_hmm.sh |   97 ++
 11 files changed, 2729 insertions(+)
 create mode 100644 lib/test_hmm.c
 create mode 100644 lib/test_hmm_uapi.h
 create mode 100644 tools/testing/selftests/vm/hmm-tests.c
 create mode 100755 tools/testing/selftests/vm/test_hmm.sh

--=20
2.25.2

