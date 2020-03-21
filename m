Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45D9918DC7E
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Mar 2020 01:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgCUAbP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Mar 2020 20:31:15 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2735 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgCUAbP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Mar 2020 20:31:15 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e7560450000>; Fri, 20 Mar 2020 17:31:01 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 20 Mar 2020 17:31:14 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 20 Mar 2020 17:31:14 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 21 Mar
 2020 00:31:13 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 21 Mar 2020 00:31:13 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e7560500001>; Fri, 20 Mar 2020 17:31:12 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        "Ralph Campbell" <rcampbell@nvidia.com>
Subject: [PATCH v8 0/3] mm/hmm/test: add self tests for HMM
Date:   Fri, 20 Mar 2020 17:31:05 -0700
Message-ID: <20200321003108.22941-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1584750661; bh=zYpRQ3kz35hjqDNLoNXpaNAgVIUKR+CRIyvN3RxU/8s=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Type:
         Content-Transfer-Encoding;
        b=ErrK7/OyuloQtImP831nTRcCemaDcTU5ejkOUV45jmN+v5nCuIUe+mA9FPdcRJD+4
         a/UcP3z/tBG/cUFSzn6K403LNF5wk3jqunNhYpdT/ljNMESq+G9z/xNFqlBDCpGW0i
         QcOg0knQkbteuo4Lz1Nr39JxBYoV1tYWrrZPZroJJXlZFmv+jT/+kVyNlNkUZveh3x
         iT1R9kbEpM4e86yxN4PDjvSPil+K06SWGlB/7ETAvFaLJxeeYZu7nVm+ZyxdJ9PqoM
         3nbinTCcrRyM1USmvYwZqFE5rS21BulAhbd2U2kyrCBbvOy0b68h6CMPnWwGm807Pp
         cgztSQUyL3RPA==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series adds basic self tests for HMM and are intended for Jason
Gunthorpe's rdma tree which has a number of HMM patches applied.

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
 include/uapi/linux/test_hmm.h          |   59 ++
 lib/Kconfig.debug                      |   12 +
 lib/Makefile                           |    1 +
 lib/test_hmm.c                         | 1177 +++++++++++++++++++++
 tools/testing/selftests/vm/.gitignore  |    1 +
 tools/testing/selftests/vm/Makefile    |    3 +
 tools/testing/selftests/vm/config      |    2 +
 tools/testing/selftests/vm/hmm-tests.c | 1353 ++++++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests |   16 +
 tools/testing/selftests/vm/test_hmm.sh |   97 ++
 11 files changed, 2724 insertions(+)
 create mode 100644 include/uapi/linux/test_hmm.h
 create mode 100644 lib/test_hmm.c
 create mode 100644 tools/testing/selftests/vm/hmm-tests.c
 create mode 100755 tools/testing/selftests/vm/test_hmm.sh

--=20
2.20.1

