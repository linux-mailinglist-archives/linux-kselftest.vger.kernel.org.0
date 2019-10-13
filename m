Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30B0DD5888
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2019 00:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbfJMWMC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 13 Oct 2019 18:12:02 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19219 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbfJMWL6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 13 Oct 2019 18:11:58 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5da3a1370000>; Sun, 13 Oct 2019 15:12:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 13 Oct 2019 15:11:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 13 Oct 2019 15:11:57 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 13 Oct
 2019 22:11:57 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 13 Oct 2019 22:11:56 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5da3a12c0004>; Sun, 13 Oct 2019 15:11:56 -0700
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
Subject: [PATCH 1/2] mm/gup_benchmark: add a missing "w" to getopt string
Date:   Sun, 13 Oct 2019 15:11:54 -0700
Message-ID: <20191013221155.382378-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191013221155.382378-1-jhubbard@nvidia.com>
References: <20191013221155.382378-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571004728; bh=8nrl7wpYPJmrVL9Qp/C48yDRPovixPIIHdvNCxdMXYA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=q4BdHyVMJBMat7n/GAFTYWE70JkRsjVwa6QoM6CwTNJENUHIw8yCS9ImzAtOkXV83
         CJuiAMTICsIN3KEE+YlX5gnwVhoSP9tS/2QvXaQ2GbZJHUg4NEDFkDjV049FJFhsM7
         MouYg1gyFhcu2anlFjjwZQla1Yvn3vLjh90nsjjg0i/3E3OqWhz9iRwVDoK5sPFT9/
         UASG+qWRPlY0tpd5qSsCdppUlkPpUxa/e9o7400wuY9YYMFYEDEXzNE6xEBjCN2FGT
         6zgAi+rPKmD5dBwVF4bygwNGmbeJaByJEYX1M9ZUg4Jxvri4ngImlMHqYgur3uI+6o
         a6lT02rcZnbvw==
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

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
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

