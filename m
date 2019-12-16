Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2A8F121A48
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2019 21:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfLPT5u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Dec 2019 14:57:50 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2973 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfLPT5u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Dec 2019 14:57:50 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5df7e1a10000>; Mon, 16 Dec 2019 11:57:22 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 16 Dec 2019 11:57:49 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 16 Dec 2019 11:57:49 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Dec
 2019 19:57:47 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 16 Dec 2019 19:57:46 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5df7e1ba0001>; Mon, 16 Dec 2019 11:57:46 -0800
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Ralph Campbell" <rcampbell@nvidia.com>
Subject: [PATCH v5 0/2] mm/hmm/test: add self tests for HMM
Date:   Mon, 16 Dec 2019 11:57:31 -0800
Message-ID: <20191216195733.28353-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576526242; bh=c+0LXJAAa4iRvvJNP9qW63zka2XWJ3Ad+NBLnq3STuE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Type:
         Content-Transfer-Encoding;
        b=NkfeIT/CqWvjl9YCstxoAo/Cp2YpQXzJ6AmaYmvVM/lGETvUvAMSy8JPXNMsFbPYv
         BtUoyxmNG62NEOngT+mnmbWQr7hXpVOE3eC9otPZXDY9UgQm6vhuwNH71XneyqYWwN
         3g38pUhvIUCRmKkTDMNxf3EJ1tYmFdSrVQCUripY34UC0ku28MfYOifsmESGXA4vNb
         lN2q9coCR+Dy9pUdxZqIq8lC5yDRu/fa1ryEBua9HSk5FZ70TrLqAogrCF2DqHKUK/
         4lu5UipdSVUQI7zSclCiO5Svep2aeby/yjwvj6vpReFgocU/+GoBrmIAswdDWU998r
         P+TWVIoDuosQQ==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series adds basic self tests for HMM and mmu interval notifiers so
that changes can be validated. It is based on linux-5.5.0-rc1 and is for
Jason's rdma/hmm tree since I believe he is planning some interval
notifier changes.  Patch 2 was last posted as part of [1] but the other
patches in that series have been merged and this version of the HMM tests
is modified to address Jason's concern over using both process wide MMU
notifiers in combination with MMU interval notifiers. Therefore, patch 1
adds some core functionality to allow intervals to be updated from within
the invalidation() callback so that MMU_NOTIFY_UNMAP events can update
the range being tracked.

[1] https://lore.kernel.org/linux-mm/20191104222141.5173-1-rcampbell@nvidia=
.com

Ralph Campbell (2):
  mm/mmu_notifier: make interval notifier updates safe
  mm/hmm/test: add self tests for HMM

 MAINTAINERS                            |    3 +
 include/linux/mmu_notifier.h           |   15 +
 lib/Kconfig.debug                      |   11 +
 lib/Makefile                           |    1 +
 lib/test_hmm.c                         | 1367 ++++++++++++++++++++++++
 mm/mmu_notifier.c                      |  196 +++-
 tools/testing/selftests/vm/.gitignore  |    1 +
 tools/testing/selftests/vm/Makefile    |    3 +
 tools/testing/selftests/vm/config      |    2 +
 tools/testing/selftests/vm/hmm-tests.c | 1360 +++++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests |   16 +
 tools/testing/selftests/vm/test_hmm.sh |   97 ++
 12 files changed, 3047 insertions(+), 25 deletions(-)
 create mode 100644 lib/test_hmm.c
 create mode 100644 tools/testing/selftests/vm/hmm-tests.c
 create mode 100755 tools/testing/selftests/vm/test_hmm.sh

--=20
2.20.1

