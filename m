Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8909921BE1B
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jul 2020 21:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgGJTs5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Jul 2020 15:48:57 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11372 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbgGJTsy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Jul 2020 15:48:54 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f08c6190000>; Fri, 10 Jul 2020 12:48:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 10 Jul 2020 12:48:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 10 Jul 2020 12:48:54 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Jul
 2020 19:48:44 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 10 Jul 2020 19:48:44 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f08c61c0000>; Fri, 10 Jul 2020 12:48:44 -0700
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
Subject: [PATCH v2 2/2] mm/migrate: add migrate-shared test for migrate_vma_*()
Date:   Fri, 10 Jul 2020 12:48:40 -0700
Message-ID: <20200710194840.7602-3-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200710194840.7602-1-rcampbell@nvidia.com>
References: <20200710194840.7602-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594410521; bh=7bNg4+W9LUQA56P48nlUXj5006Ok1vcN7L9AinD3FBk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=GdZuurl2c1vcX7Bo7E3MmL+tKh8sqjTCxeafBVEKNXdGhoxRKXCs1zUSd2WjHIZ4M
         2jEMhfQZ/rohsR75Pra4m19ZfrtVRCxfYRbv1wS7EVFNHlD1zLi4P92swbjK3hC1Ms
         iIKd4DCEUvHiLqing5Ff6sf9ftQM1Yf6H8j7UR1pdg50BzKa28K7JZmwnwp2vxjiyb
         kH8k6nf8dF/woJlVBnOoVbZTGBrbx6J1rAevOrBa/Kh1qnaAdy3J873BCSq03Anzt+
         UTyxOIMzUooHtJCea1d5bIDFZVPuBjUHUwkExANruA10lT8gxU83QCfOehKeAgoAqt
         LMJZmrSYwfd2A==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a migrate_vma_*() self test for mmap(MAP_SHARED) to verify that
!vma_anonymous() ranges won't be migrated.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 tools/testing/selftests/vm/hmm-tests.c | 35 ++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/vm/hmm-tests.c b/tools/testing/selftes=
ts/vm/hmm-tests.c
index 79db22604019..e83d3ab37697 100644
--- a/tools/testing/selftests/vm/hmm-tests.c
+++ b/tools/testing/selftests/vm/hmm-tests.c
@@ -931,6 +931,41 @@ TEST_F(hmm, migrate_fault)
 	hmm_buffer_free(buffer);
 }
=20
+/*
+ * Migrate anonymous shared memory to device private memory.
+ */
+TEST_F(hmm, migrate_shared)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	int ret;
+
+	npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
+	ASSERT_NE(npages, 0);
+	size =3D npages << self->page_shift;
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd =3D -1;
+	buffer->size =3D size;
+	buffer->mirror =3D malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	buffer->ptr =3D mmap(NULL, size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_SHARED | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	/* Migrate memory to device. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_MIGRATE, buffer, npages);
+	ASSERT_EQ(ret, -ENOENT);
+
+	hmm_buffer_free(buffer);
+}
+
 /*
  * Try to migrate various memory types to device private memory.
  */
--=20
2.20.1

