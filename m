Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA672D69AE
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2019 20:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732386AbfJNSqn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Oct 2019 14:46:43 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14371 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731007AbfJNSql (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Oct 2019 14:46:41 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5da4c29b0000>; Mon, 14 Oct 2019 11:46:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 14 Oct 2019 11:46:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 14 Oct 2019 11:46:41 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Oct
 2019 18:46:40 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 14 Oct 2019 18:46:40 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5da4c2900001>; Mon, 14 Oct 2019 11:46:40 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        <linux-kselftest@vger.kernel.org>
Subject: [PATCH v2 1/2] mm/gup_benchmark: add a missing "w" to getopt string
Date:   Mon, 14 Oct 2019 11:46:38 -0700
Message-ID: <20191014184639.1512873-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191014184639.1512873-1-jhubbard@nvidia.com>
References: <20191014184639.1512873-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571078812; bh=5hKzjpJ7hSymwD+fnlyUM1PRMpQBY6h8z/VrTk1YOhY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=Y6d1pU4QVkfR8c9VkZXMGDQnnOY+swROfYBkhaijQdhbwnELag/LF0A6xEqzhObzw
         UbWR+M1aIy+28ryAaHiZSRwh15dYpQGaaZdoZglf/2v9ZcONrupGl7TGm5yq/5LBD0
         UaI6vIKzOt1VQ+prtisy8Ocm3kbs6Ky+Q+kypFH9denbWOid1cvGI7cFUaabIbCxsL
         rc1r798NSguwitOGWG7ysijZazXrhGd+ux9x6WhRXsxSE6NDLpay3GugeG94c2RVym
         4Hl8svSHbiMEzC6QRcBbdu9wUtQmd0YtC0vWC7T3UGRP2CpC9cDDdjprfawFEV41aV
         w6pGf/nyZE05g==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Even though gup_benchmark.c has code to handle the -w
command-line option, the "w" is not part of the getopt
string. It looks as if it has been missing the whole time.

On my machine, this leads naturally to the following
predictable result:

$ sudo ./gup_benchmark -w
./gup_benchmark: invalid option -- 'w'

...which is fixed, with this commit.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/vm/gup_benchmark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/gup_benchmark.c b/tools/testing/sel=
ftests/vm/gup_benchmark.c
index c0534e298b51..cb3fc09645c4 100644
--- a/tools/testing/selftests/vm/gup_benchmark.c
+++ b/tools/testing/selftests/vm/gup_benchmark.c
@@ -37,7 +37,7 @@ int main(int argc, char **argv)
 	char *file =3D "/dev/zero";
 	char *p;
=20
-	while ((opt =3D getopt(argc, argv, "m:r:n:f:tTLUSH")) !=3D -1) {
+	while ((opt =3D getopt(argc, argv, "m:r:n:f:tTLUwSH")) !=3D -1) {
 		switch (opt) {
 		case 'm':
 			size =3D atoi(optarg) * MB;
--=20
2.23.0

