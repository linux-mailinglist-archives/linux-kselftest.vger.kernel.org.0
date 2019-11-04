Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA9BEEF7C
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2019 23:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389194AbfKDWVr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Nov 2019 17:21:47 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8454 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388679AbfKDWVq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Nov 2019 17:21:46 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dc0a4800002>; Mon, 04 Nov 2019 14:21:52 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 04 Nov 2019 14:21:46 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 04 Nov 2019 14:21:46 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 Nov
 2019 22:21:43 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 4 Nov 2019 22:21:43 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dc0a4770001>; Mon, 04 Nov 2019 14:21:43 -0800
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Shuah Khan" <shuah@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        "Ralph Campbell" <rcampbell@nvidia.com>
Subject: [PATCH v4 0/2] HMM tests and minor fixes
Date:   Mon, 4 Nov 2019 14:21:39 -0800
Message-ID: <20191104222141.5173-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1572906112; bh=G+Ekoe8mXGHR3C2DvduazW+151IOXJUz9ALxPQbuuy4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Type:
         Content-Transfer-Encoding;
        b=ROUZwCJbG6A0ph9k3PlpXG9qReSnA5cIEuRxCBfJsG+4ChPC0pYQUinR2OyIf8Hf0
         Sard2c0b6cv1sGm1WoSiAxvK8McW27/SPh8gSo8N2CkyA6EfUmqcm1MfgwJe4ORABp
         pt3DFmQey6vGCVVvam9l11rU/a5c5koyjFyK1Oyhu4uKrsaV83zelb0MSLmAb3wy9r
         5X0Yvc61FG/kfnq7J7RzSKp6zhQ3UkbenfVb5YzkdgFX2slVvL5wY7yztihULyZ/v9
         cV6GBOsr9FmnP7YJLBlLgIUfYdNDw8cl6GKCn8u++ZvMrkrpI+movNiN54LWQNug6M
         /NUnPxKnm5e+w==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These changes are based on Jason's rdma/hmm branch (5.4.0-rc5).
Patch 1 was previously posted here [1] but was dropped from that orginal
series. Hopefully, the tests will reduce concerns about edge conditions.
I'm sure more tests could be usefully added but I thought this was a good
starting point.

Changes since v3:
patch 1:
Unchanged except rebased on Jason's latest hmm (bbe3329e354d3ab5dc18).
patch 2:
Is now part of Jason's tree.
patch 3 (now 2):
Major changes to incorporate Jason's review feedback.
  * drivers/char/hmm_dmirror.c driver moved to lib/test_hmm.c
  * XArray used instead of "page tables".
  * platform device driver removed.
  * remove redundant copyright.

Changes since v2:
patch 1:
Removed hmm_range_needs_fault() and just use hmm_range_need_fault().
Updated the change log to include that it fixes a bug where
hmm_range_fault() incorrectly returned an error when no fault is requested.
patch 2:
Removed the confusing change log wording about DMA.
Changed hmm_range_fault() to return the PFN of the zero page like any other
page.
patch 3:
Adjusted the test code to match the new zero page behavior.

Changes since v1:
Rebased to Jason's rdma/hmm branch (5.4.0-rc1).
Cleaned up locking for the test driver's page tables.
Incorporated Christoph Hellwig's comments.

[1] https://lore.kernel.org/linux-mm/20190726005650.2566-6-rcampbell@nvidia=
.com/


Ralph Campbell (2):
  mm/hmm: make full use of walk_page_range()
  mm/hmm/test: add self tests for HMM

 MAINTAINERS                            |    3 +
 include/uapi/linux/test_hmm.h          |   59 ++
 lib/Kconfig.debug                      |   11 +
 lib/Makefile                           |    1 +
 lib/test_hmm.c                         | 1306 ++++++++++++++++++++++++
 mm/hmm.c                               |  121 ++-
 tools/testing/selftests/vm/.gitignore  |    1 +
 tools/testing/selftests/vm/Makefile    |    3 +
 tools/testing/selftests/vm/config      |    2 +
 tools/testing/selftests/vm/hmm-tests.c | 1295 +++++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests |   16 +
 tools/testing/selftests/vm/test_hmm.sh |   97 ++
 12 files changed, 2852 insertions(+), 63 deletions(-)
 create mode 100644 include/uapi/linux/test_hmm.h
 create mode 100644 lib/test_hmm.c
 create mode 100644 tools/testing/selftests/vm/hmm-tests.c
 create mode 100755 tools/testing/selftests/vm/test_hmm.sh

--=20
2.20.1

