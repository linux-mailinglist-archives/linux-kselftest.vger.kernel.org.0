Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA251B4DAA
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Apr 2020 21:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgDVTur (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Apr 2020 15:50:47 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18200 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgDVTuq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Apr 2020 15:50:46 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ea09fa10000>; Wed, 22 Apr 2020 12:48:49 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 22 Apr 2020 12:50:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 22 Apr 2020 12:50:45 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 22 Apr
 2020 19:50:42 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 22 Apr 2020 19:50:42 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ea0a0110005>; Wed, 22 Apr 2020 12:50:41 -0700
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
Subject: [PATCH v10 0/3] mm/hmm/test: add self tests for HMM
Date:   Wed, 22 Apr 2020 12:50:25 -0700
Message-ID: <20200422195028.3684-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587584929; bh=tQslaTxOwr/1HMEaEgJ5onqwCDIFWBtI9FSraeL17vE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type:Content-Transfer-Encoding;
        b=CrwTNWk1dZywtqSd01Bo2vOEtMf3n/uUsh1ixYuiEWppZn3keB2tB/VQEPVoUpA5v
         KUiXQn4GrXWDydsaGiakqTXFIIoR+jp9aj3tyBGUT39mQux/CC03+C8USTw0WXK2zY
         0O9AFfNlnRhW4VOHPfDPCTvSeinFEsGuWcQA/xDx4wLV+leIcTi4GoGAadIovezCoA
         wH03q0sJCUwewqvItWB6VXXm7AbtlIFXeOqzK7rfbwKYNeXsys1/tJnw2mBAbc5zbK
         q6LxnN787j7EB2NVneac6uy4bdiKvzTGXkTgDXOCIP9yoqtArI6305jqhyqdI8O7O0
         J39dQuuPpNAfg==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series adds basic self tests for HMM and are intended for Jason
Gunthorpe's rdma tree since he is making some HMM related changes that
this can help test.

Changes v9 -> v10:
Patches 1 & 2 include Jason's changes from his cover letter:
https://lkml.org/lkml/2020/4/21/1320
Patch 3 now adds the files alphbetically and removed the outdated
reference to include/uapi/linux.

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

 MAINTAINERS                            |    2 +
 lib/Kconfig.debug                      |   13 +
 lib/Makefile                           |    1 +
 lib/test_hmm.c                         | 1149 ++++++++++++++++++++
 lib/test_hmm_uapi.h                    |   59 +
 tools/testing/selftests/vm/.gitignore  |    1 +
 tools/testing/selftests/vm/Makefile    |    3 +
 tools/testing/selftests/vm/config      |    2 +
 tools/testing/selftests/vm/hmm-tests.c | 1359 ++++++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests |   16 +
 tools/testing/selftests/vm/test_hmm.sh |   97 ++
 11 files changed, 2702 insertions(+)
 create mode 100644 lib/test_hmm.c
 create mode 100644 lib/test_hmm_uapi.h
 create mode 100644 tools/testing/selftests/vm/hmm-tests.c
 create mode 100755 tools/testing/selftests/vm/test_hmm.sh

--=20
2.25.2

