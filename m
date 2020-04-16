Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7CB1AB4BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Apr 2020 02:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391657AbgDPA0k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Apr 2020 20:26:40 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8924 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729382AbgDPA0i (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Apr 2020 20:26:38 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e97a5cf0000>; Wed, 15 Apr 2020 17:24:47 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 15 Apr 2020 17:26:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 15 Apr 2020 17:26:37 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Apr
 2020 00:26:37 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 16 Apr 2020 00:26:36 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e97a63c0004>; Wed, 15 Apr 2020 17:26:36 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-kselftest@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Mina Almasry <almasrymina@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH] hugetlb_cgroup: remove unused variable 'i'
Date:   Wed, 15 Apr 2020 17:26:16 -0700
Message-ID: <20200416002616.1456-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586996687; bh=9UZSapsojgfRmmTfw+tENe0Xr/PLjL9zE3AQIRo5sNA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type:Content-Transfer-Encoding;
        b=gt7M8eyEcd1zQnqT6ReYNOKqm4WamYPdBKlW+lIccYRu/R1nfADBrdupYeXgYSkP+
         cjRu7CZafcYFS6HQ0lh5GPzXT+getlgb3i42UOSp20AX6eAgEvWg0AwJfHYZNhx72d
         g2RkoIPRI3T2bTMP4uPMBHuEkb52oYyxpgbdpRN5De1shm3279q0LXObn3vd3qqpQD
         bkxxRquLKGSOjRwCDqHQCi5KxO2hOO6wOuYznnJ1+i08xoOrNxK0nCtYt0hVyhLdMd
         heFlF+CjjlQysaPEzZorTyndf3O0uC7PGSplrPSCgQO2Wt4j4qPxFtFcPAuUYU4b88
         uN9qmKSsp0pjg==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Compiling tests in tools/testing/selftests/vm/ results in a C compiler
warning:

write_to_hugetlbfs.c: In function =E2=80=98main=E2=80=99:
write_to_hugetlbfs.c:77:16: warning: unused variable =E2=80=98i=E2=80=99
   77 |  unsigned long i;

Delete the unused variable.

Fixes: 29750f71a9b4 ("hugetlb_cgroup: add hugetlb_cgroup reservation tests"=
)
Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 tools/testing/selftests/vm/write_to_hugetlbfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/vm/write_to_hugetlbfs.c b/tools/testin=
g/selftests/vm/write_to_hugetlbfs.c
index 110bc4e4015d..6a2caba19ee1 100644
--- a/tools/testing/selftests/vm/write_to_hugetlbfs.c
+++ b/tools/testing/selftests/vm/write_to_hugetlbfs.c
@@ -74,8 +74,6 @@ int main(int argc, char **argv)
 	int write =3D 0;
 	int reserve =3D 1;
=20
-	unsigned long i;
-
 	if (signal(SIGINT, sig_handler) =3D=3D SIG_ERR)
 		err(1, "\ncan't catch SIGINT\n");
=20
--=20
2.25.2

