Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B9C1CB824
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 May 2020 21:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgEHTUc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 May 2020 15:20:32 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17065 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgEHTUa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 May 2020 15:20:30 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eb5b0f10000>; Fri, 08 May 2020 12:20:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 08 May 2020 12:20:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 08 May 2020 12:20:29 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 8 May
 2020 19:20:28 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 8 May 2020 19:20:28 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5eb5b0fb0007>; Fri, 08 May 2020 12:20:28 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <nouveau@lists.freedesktop.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Ben Skeggs" <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Shuah Khan" <shuah@linuxfoundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH 6/6] hmm: add tests for HMM_PFN_COMPOUND flag
Date:   Fri, 8 May 2020 12:20:09 -0700
Message-ID: <20200508192009.15302-7-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508192009.15302-1-rcampbell@nvidia.com>
References: <20200508192009.15302-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1588965617; bh=HRUw/bu4Btut299L3QeBB9VBXDFxLZRSbK0wDcgFRCs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=A7BnT3lqP7rWfLeriVSpAopb4ejYrNpag43q351DqKO+Q4m/OxcW6ff67L6eA836W
         N4otqDMgc2tYQVWPynhfwemwdWoZUEcr4FW0j9wGESDxxRReyvWBoREQoyf36pC6yj
         gzG3XG69GMxnnRBVJ9d2svEI5tvSEmAW2h/xklNL9Qq5ZTZyN892fskfOPnG9wFt6c
         Zsyu5LPu5E0X8GQ6lRYoESiEfcd192n3+WWLQxgOpaDaVRABXTRFQxBnMQFr0LN1cG
         +wNUxgPCCUcub2Jhz1jp26Kg01iQl0YJevMMJzFOuof/ZMeZWFNpuaXKYfasQgWPex
         Jc19NW+mP3HRg==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add some sanity tests for hmm_range_fault() returning the HMM_PFN_COMPOUND
flag.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 lib/test_hmm.c                         |  2 +
 lib/test_hmm_uapi.h                    |  2 +
 tools/testing/selftests/vm/hmm-tests.c | 76 ++++++++++++++++++++++++++
 3 files changed, 80 insertions(+)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 00bca6116f93..8448921e6d33 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -757,6 +757,8 @@ static void dmirror_mkentry(struct dmirror *dmirror, st=
ruct hmm_range *range,
 		*perm |=3D HMM_DMIRROR_PROT_WRITE;
 	else
 		*perm |=3D HMM_DMIRROR_PROT_READ;
+	if (entry & HMM_PFN_COMPOUND)
+		*perm |=3D HMM_DMIRROR_PROT_COMPOUND;
 }
=20
 static bool dmirror_snapshot_invalidate(struct mmu_interval_notifier *mni,
diff --git a/lib/test_hmm_uapi.h b/lib/test_hmm_uapi.h
index 67b3b2e6ff5d..21cf4da6f020 100644
--- a/lib/test_hmm_uapi.h
+++ b/lib/test_hmm_uapi.h
@@ -40,6 +40,7 @@ struct hmm_dmirror_cmd {
  * HMM_DMIRROR_PROT_NONE: unpopulated PTE or PTE with no access
  * HMM_DMIRROR_PROT_READ: read-only PTE
  * HMM_DMIRROR_PROT_WRITE: read/write PTE
+ * HMM_DMIRROR_PROT_COMPOUND: compound page is fully mapped by same permis=
sions
  * HMM_DMIRROR_PROT_ZERO: special read-only zero page
  * HMM_DMIRROR_PROT_DEV_PRIVATE_LOCAL: Migrated device private page on the
  *					device the ioctl() is made
@@ -51,6 +52,7 @@ enum {
 	HMM_DMIRROR_PROT_NONE			=3D 0x00,
 	HMM_DMIRROR_PROT_READ			=3D 0x01,
 	HMM_DMIRROR_PROT_WRITE			=3D 0x02,
+	HMM_DMIRROR_PROT_COMPOUND		=3D 0x04,
 	HMM_DMIRROR_PROT_ZERO			=3D 0x10,
 	HMM_DMIRROR_PROT_DEV_PRIVATE_LOCAL	=3D 0x20,
 	HMM_DMIRROR_PROT_DEV_PRIVATE_REMOTE	=3D 0x30,
diff --git a/tools/testing/selftests/vm/hmm-tests.c b/tools/testing/selftes=
ts/vm/hmm-tests.c
index 79db22604019..e9576d9802c7 100644
--- a/tools/testing/selftests/vm/hmm-tests.c
+++ b/tools/testing/selftests/vm/hmm-tests.c
@@ -1291,6 +1291,82 @@ TEST_F(hmm2, snapshot)
 	hmm_buffer_free(buffer);
 }
=20
+/*
+ * Test the hmm_range_fault() HMM_PFN_COMPOUND flag for large pages that
+ * should be mapped by a large page table entry.
+ */
+TEST_F(hmm, compound)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	int *ptr;
+	unsigned char *m;
+	int ret;
+	long pagesizes[4];
+	int n, idx;
+	unsigned long i;
+
+	/* Skip test if we can't allocate a hugetlbfs page. */
+
+	n =3D gethugepagesizes(pagesizes, 4);
+	if (n <=3D 0)
+		return;
+	for (idx =3D 0; --n > 0; ) {
+		if (pagesizes[n] < pagesizes[idx])
+			idx =3D n;
+	}
+	size =3D ALIGN(TWOMEG, pagesizes[idx]);
+	npages =3D size >> self->page_shift;
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->ptr =3D get_hugepage_region(size, GHR_STRICT);
+	if (buffer->ptr =3D=3D NULL) {
+		free(buffer);
+		return;
+	}
+
+	buffer->size =3D size;
+	buffer->mirror =3D malloc(npages);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	/* Initialize the pages the device will snapshot in buffer->ptr. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D i;
+
+	/* Simulate a device snapshotting CPU pagetables. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_SNAPSHOT, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/* Check what the device saw. */
+	m =3D buffer->mirror;
+	for (i =3D 0; i < npages; ++i)
+		ASSERT_EQ(m[i], HMM_DMIRROR_PROT_WRITE |
+				HMM_DMIRROR_PROT_COMPOUND);
+
+	/* Make the region read-only. */
+	ret =3D mprotect(buffer->ptr, size, PROT_READ);
+	ASSERT_EQ(ret, 0);
+
+	/* Simulate a device snapshotting CPU pagetables. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_SNAPSHOT, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/* Check what the device saw. */
+	m =3D buffer->mirror;
+	for (i =3D 0; i < npages; ++i)
+		ASSERT_EQ(m[i], HMM_DMIRROR_PROT_READ |
+				HMM_DMIRROR_PROT_COMPOUND);
+
+	free_hugepage_region(buffer->ptr);
+	buffer->ptr =3D NULL;
+	hmm_buffer_free(buffer);
+}
+
 /*
  * Test two devices reading the same memory (double mapped).
  */
--=20
2.20.1

