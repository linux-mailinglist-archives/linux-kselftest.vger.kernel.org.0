Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017641D5D88
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 May 2020 03:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgEPBFS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 May 2020 21:05:18 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8222 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgEPBFS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 May 2020 21:05:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ebf3c010002>; Fri, 15 May 2020 18:04:01 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 15 May 2020 18:05:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 15 May 2020 18:05:18 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 16 May
 2020 01:05:16 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 16 May 2020 01:05:16 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ebf3c4c0002>; Fri, 15 May 2020 18:05:16 -0700
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
Subject: [PATCH v2] mm/hmm/test: use xa_for_each_range instead of looping
Date:   Fri, 15 May 2020 18:04:24 -0700
Message-ID: <20200516010424.2013-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589591041; bh=7PcaR+TkSMajawj1BN/KhyGBRigaOiTCyx/xApoMQEE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=lrzPXkDm5Nc+RSeJ1NcHqmSBqCfGYKdfdZiHrVkAkh4EukEWOhthbjVAGuteN4Ehh
         KxTsEaXMgW0mKu2+j/MmNqmP4uLECGnoUbfDhxAMJ/mVcsYNg+4mqtudXigxhFdHKp
         WBdRZKoQE7UjxLlJSSI9LE5NX2sZoQDHZ247KJyS+UjJ3BwOn2eSe+Yu51xHqAfxZV
         H9LQmYizeKK1ltQ+UV3+GEYYb68xy3jabI9OSW3/9LUW5k6QVH58CCyFqnhyZJLyir
         YI7vz9aIkj4sh7dez1lcKlDcfDtNSMmmTYVmtWq6JrqnSoiWqzhDmGn4n4IuilyoWM
         JA2liVlTUtagA==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The test driver uses an xa_array to store virtual to physical address
translations for a simulated hardware device. The MMU notifier
invalidation callback is used to keep the table consistent with the CPU
page table and is frequently called only for a page or two. However, if
the test process exits unexpectedly or is killed, the range can be
[0..ULONG_MAX] in which case calling xa_erase() for every possible PFN
results in CPU timeouts.
Use xa_for_each_range() to efficiently erase entries in the range.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---

This patch is based on Jason Gunthorpe's hmm tree and should be folded
into the ("mm/hmm/test: add selftest driver for HMM") patch once this
patch is reviewed, etc.

v1 -> v2:
Use xa_for_each_range() instead of special casing [0..ULONG_MAX].

 lib/test_hmm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 8b36c26b717b..5c1858e325ba 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -196,13 +196,15 @@ static void dmirror_do_update(struct dmirror *dmirror=
, unsigned long start,
 			      unsigned long end)
 {
 	unsigned long pfn;
+	void *entry;
=20
 	/*
 	 * The XArray doesn't hold references to pages since it relies on
 	 * the mmu notifier to clear page pointers when they become stale.
 	 * Therefore, it is OK to just clear the entry.
 	 */
-	for (pfn =3D start >> PAGE_SHIFT; pfn < (end >> PAGE_SHIFT); pfn++)
+	xa_for_each_range(&dmirror->pt, pfn, entry, start >> PAGE_SHIFT,
+			  end >> PAGE_SHIFT)
 		xa_erase(&dmirror->pt, pfn);
 }
=20
--=20
2.20.1

