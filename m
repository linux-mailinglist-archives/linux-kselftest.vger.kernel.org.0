Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D0621A54A
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jul 2020 18:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgGIQ52 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Jul 2020 12:57:28 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15837 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgGIQ51 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Jul 2020 12:57:27 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f074c0b0000>; Thu, 09 Jul 2020 09:55:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 09 Jul 2020 09:57:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 09 Jul 2020 09:57:27 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 9 Jul
 2020 16:57:20 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 9 Jul 2020 16:57:20 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f074c6f0003>; Thu, 09 Jul 2020 09:57:19 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>, <kvm-ppc@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Bharata B Rao" <bharata@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH 0/2] mm/migrate: optimize migrate_vma_setup() for holes
Date:   Thu, 9 Jul 2020 09:57:09 -0700
Message-ID: <20200709165711.26584-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594313739; bh=i+kQ+/i3+/govscI85yHcDQ8wFI7urSeZJJ0wPs2+ws=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=BqvhdRPL5naYpwzVsljFKYXb/DcKRGo1fUt59K1gl9EBI1TuuieBoGDj+VnHD8C6H
         IrVgWJPZyZ7qMbME5S7Sbb1tNacmBKLROwefLPrtkTEZNo35+VsFjTRpO98d/j1I2p
         LFzkCpFEMRvgv4zof2AMRegN8SWER5zdpMkM82hSDqd5p+2FSP658mdTId5xlPOt8p
         UDGaCmqveH+R96sQT+FO5h7fXZA/5DNhrSjR9UNUpSjzZ7hWQ0a2FQl0z/apPA9P4s
         Qy/4napfJo04QM7d3OHnj+g1r+xLDFulmmg6nCAb9uVlsLSJl9tACThIztC1cIbLG8
         /LVgLBLddXsaQ==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A simple optimization for migrate_vma_*() when the source vma is not an
anonymous vma and a new test case to exercise it.
This is based on linux-mm and is for Andrew Morton's tree.

Ralph Campbell (2):
  mm/migrate: optimize migrate_vma_setup() for holes
  mm/migrate: add migrate-shared test for migrate_vma_*()

 mm/migrate.c                           |  6 ++++-
 tools/testing/selftests/vm/hmm-tests.c | 35 ++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

--=20
2.20.1

