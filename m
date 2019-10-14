Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37B3DD69AD
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2019 20:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732284AbfJNSql (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Oct 2019 14:46:41 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3511 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfJNSql (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Oct 2019 14:46:41 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5da4c2950000>; Mon, 14 Oct 2019 11:46:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 14 Oct 2019 11:46:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 14 Oct 2019 11:46:40 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Oct
 2019 18:46:40 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 14 Oct 2019 18:46:40 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5da4c2900000>; Mon, 14 Oct 2019 11:46:40 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        <linux-kselftest@vger.kernel.org>
Subject: [PATCH v2 0/2] gup.c, gup_benchmark.c trivial fixes before the storm
Date:   Mon, 14 Oct 2019 11:46:37 -0700
Message-ID: <20191014184639.1512873-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571078805; bh=qk0npK+pn+bfxjHAA4vLiMmmSsmYH4obfm3nBaVQ5P0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=a+3wPUZ4Ni7vxCbt/44gYy7aOaiZolY9gjyUl+D3s62xe2b7ospotvUaGAih73ftt
         XNDFPkBMWgRPpAuavxKVquDQ5vgj2IH3xh1ENlXCdbgzapy1WRDU5uwyoGThaFlG1X
         Rjj+BtPHmxCJ+pD+c+yLbDf1rBaMQL+LCGnkVkctPqDffEkMNI7x3Z3ewprCc4WXAE
         XKvkTbFhaPq4pnGI7tYnGmfeSJ9U47P5e4NAhhjEJUYqbNMKDbYkNemShzh4dJhhPc
         9l/g/A2/CBZ+qiE+cVHPiLskW9Za7kBGgEuYgTQTV3ub2N9VjGTYQrokaB++MtUQEM
         IhyvIF/M8BGjw==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

Changes since v1:

1) Fixed a krobot-reported mistake, which also uncovered a pre-existing
bug. Thanks to Kirill for recommending the fix.

2) Added another small fix: changed the data type to unsigned int, as
pointed out by Ira.

2) Added a "Fixes:" line, thanks to Kirill and Aneesh for pinpointing the
commit.

3) Collected Acked-by and Suggested-by's.

Original cover letter, edited slightly
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

These trivial fixes apply to today's linux.git (5.4-rc3).

I found these while polishing up the Next And Final get_user_pages()+dma
tracking patchset (which is in final testing and passing nicely...so far).

Anyway, as these two patches apply cleanly both before and after the larger
gup/dma upcoming patchset, I thought it best to send this out separately,
in order to avoid muddying the waters more than usual.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org

John Hubbard (2):
  mm/gup_benchmark: add a missing "w" to getopt string
  mm/gup: fix a misnamed "write" argument, and a related bug

 mm/gup.c                                   | 14 ++++++++------
 tools/testing/selftests/vm/gup_benchmark.c |  2 +-
 2 files changed, 9 insertions(+), 7 deletions(-)

--=20
2.23.0

